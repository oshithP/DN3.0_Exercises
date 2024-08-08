-- Enable server output
SET SERVEROUTPUT ON;

-- Create tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance INT,
    LastModified DATE,
    IsVIP CHAR(1)
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR2(20),
    Balance INT,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    Amount INT,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount INT,
    InterestRate INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary INT,
    Department VARCHAR2(50),
    HireDate DATE
);

-- Create ErrorLogs table for logging errors
CREATE TABLE ErrorLogs (
    ErrorID INT PRIMARY KEY,
    ErrorMessage VARCHAR2(255),
    ErrorDate DATE
);

-- Insert data
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 200, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

-- Procedure to Apply Interest Discount to Customers Above 60 Years Old
CREATE OR REPLACE PROCEDURE ApplyInterestDiscount IS
    CURSOR customer_cursor IS
        SELECT CustomerID, DOB FROM Customers;
    
    customer_id Customers.CustomerID%TYPE;
    customer_dob Customers.DOB%TYPE;
    today_date DATE := SYSDATE;
BEGIN
    FOR customer_rec IN customer_cursor LOOP
        IF MONTHS_BETWEEN(today_date, customer_rec.DOB) / 12 > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate * 0.99
            WHERE CustomerID = customer_rec.CustomerID;
        END IF;
    END LOOP;
END ApplyInterestDiscount;
/

-- Procedure to Promote Customers to VIP Status Based on Balance
CREATE OR REPLACE PROCEDURE PromoteToVIP IS
    CURSOR account_cursor IS
        SELECT CustomerID, Balance FROM Accounts;
    
    acc_customer_id Accounts.CustomerID%TYPE;
    acc_balance Accounts.Balance%TYPE;
BEGIN
    FOR account_rec IN account_cursor LOOP
        IF account_rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'Y'
            WHERE CustomerID = account_rec.CustomerID;
        ELSE
            UPDATE Customers
            SET IsVIP = 'N'
            WHERE CustomerID = account_rec.CustomerID;
        END IF;
    END LOOP;
END PromoteToVIP;
/

-- Procedure to Send Loan Reminders for Loans Due Within the Next 30 Days
CREATE OR REPLACE PROCEDURE SendLoanReminders IS
    CURSOR loan_cursor IS
        SELECT CustomerID, EndDate 
        FROM Loans 
        WHERE EndDate BETWEEN SYSDATE AND SYSDATE + 30;
    
    loan_customer_id Loans.CustomerID%TYPE;
    loan_end_date Loans.EndDate%TYPE;
BEGIN
    FOR loan_rec IN loan_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan due on ' || TO_CHAR(loan_rec.EndDate, 'YYYY-MM-DD') || ' for CustomerID: ' || loan_rec.CustomerID);
    END LOOP;
END SendLoanReminders;
/

-- Procedure to Handle Exceptions During Fund Transfers Between Accounts
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    srcAccountID IN INT,
    destAccountID IN INT,
    transferAmount IN DECIMAL
) IS
BEGIN
    DECLARE
        insufficientFunds EXCEPTION;
        PRAGMA EXCEPTION_INIT(insufficientFunds, -20001);

    BEGIN
        -- Start transaction
        SAVEPOINT start_trans;

        -- Check if the source account has enough balance
        DECLARE
            src_balance INT;
        BEGIN
            SELECT Balance INTO src_balance
            FROM Accounts
            WHERE AccountID = srcAccountID;
            
            IF src_balance < transferAmount THEN
                DBMS_OUTPUT.PUT_LINE('Insufficient Funds');
                RAISE insufficientFunds;
            END IF;
        END;

        -- Deduct amount from source account
        UPDATE Accounts
        SET Balance = Balance - transferAmount
        WHERE AccountID = srcAccountID;

        -- Add amount to destination account
        UPDATE Accounts
        SET Balance = Balance + transferAmount
        WHERE AccountID = destAccountID;
        DBMS_OUTPUT.PUT_LINE('Funds transferred safely...');
        -- Commit transaction
        COMMIT;
    EXCEPTION
        WHEN insufficientFunds THEN
            INSERT INTO ErrorLogs (ErrorMessage, ErrorDate)
            VALUES ('Insufficient funds for transfer from AccountID: ' || srcAccountID, SYSDATE);
            ROLLBACK TO start_trans;
        WHEN OTHERS THEN
            INSERT INTO ErrorLogs (ErrorMessage, ErrorDate)
            VALUES ('SQL Error during transfer from AccountID: ' || srcAccountID || ' to AccountID: ' || destAccountID, SYSDATE);
            ROLLBACK TO start_trans;
    END;
END SafeTransferFunds;
/

-- Procedure to Manage Errors When Updating Employee Salaries
CREATE OR REPLACE PROCEDURE UpdateSalary(
    empID IN INT,
    salaryIncreasePercentage IN DECIMAL
) IS
BEGIN
    DECLARE
        empNotFound EXCEPTION;
        PRAGMA EXCEPTION_INIT(empNotFound, -20001);

    BEGIN
        -- Start transaction
        SAVEPOINT start_trans;

        -- Update salary
        UPDATE Employees 
        SET Salary = Salary + (Salary * (salaryIncreasePercentage / 100))
        WHERE EmployeeID = empID;
        DBMS_OUTPUT.PUT_LINE('Employee salary increased by ' || salaryIncreasePercentage || ' percentage');
        -- Check if the update affected any row
        IF SQL%ROWCOUNT = 0 THEN
            RAISE empNotFound;
        END IF;
        
        -- Commit transaction
        COMMIT;
    EXCEPTION
        WHEN empNotFound THEN
            INSERT INTO ErrorLogs (ErrorMessage, ErrorDate)
            VALUES ('Employee ID does not exist: ' || empID, SYSDATE);
            DBMS_OUTPUT.PUT_LINE('Employee ID does not exist!!');
            ROLLBACK TO start_trans;
        WHEN OTHERS THEN
            INSERT INTO ErrorLogs (ErrorMessage, ErrorDate)
            VALUES ('Error updating salary for EmployeeID: ' || empID, SYSDATE);
            ROLLBACK TO start_trans;
    END;
END UpdateSalary;
/

-- Procedure to Ensure Data Integrity When Adding a New Customer
CREATE OR REPLACE PROCEDURE AddNewCustomer(
    newCusID IN NUMBER,
    newCusName IN VARCHAR2,
    newCusDOB IN DATE,
    newCusBalance IN NUMBER,
    newCusLastModified IN DATE
)
IS
  IDAlreadyExists EXCEPTION;
  existingCustomerCount NUMBER;
BEGIN
  SELECT count(*) INTO existingCustomerCount FROM Customers WHERE CustomerID = newCusID;
  
  IF existingCustomerCount > 0 THEN
    RAISE IDAlreadyExists;
  END IF;
  
  INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
  VALUES (newCusID, newCusName, newCusDOB, newCusBalance, newCusLastModified);
  
  DBMS_OUTPUT.PUT_LINE('Customer registered successfully');
  
EXCEPTION
  WHEN IDAlreadyExists THEN
    DBMS_OUTPUT.PUT_LINE('Customer ID already exists');
END;
/



-- Call the procedures
BEGIN
    ApplyInterestDiscount;
END;
/

BEGIN
    PromoteToVIP;
END;
/

BEGIN
    SendLoanReminders;
END;
/

-- Example calls for SafeTransferFunds, UpdateSalary, and AddNewCustomer
BEGIN
    SafeTransferFunds(srcAccountID => 1, destAccountID => 2, transferAmount => 100.00);
END;
/

BEGIN
    UpdateSalary(empID => 1, salaryIncreasePercentage => 10.00);
END;
/

BEGIN
    AddNewCustomer(newCusID => 3, newCusName => 'Oshith', newCusDOB => SYSDATE, newCusBalance => 5000, newCusLastModified => SYSDATE);
END;
/
