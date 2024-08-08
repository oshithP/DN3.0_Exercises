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
    DepartmentID INT,
    HireDate DATE
);

-- Create ErrorLogs table for logging errors
CREATE TABLE ErrorLogs (
    ErrorID INT PRIMARY KEY,
    ErrorMessage VARCHAR2(255),
    ErrorDate DATE
);

-- Scripts for Sample Data Insertion

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1963-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);

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

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 2, 10000, 5, SYSDATE, SYSDATE+25);

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

-- SCENARIO - 1
-- Procedure to Process Monthly Interest for All Savings Accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
    -- Variable to store the number of rows updated
    v_rows_updated NUMBER;
BEGIN

    -- Update balance for all savings accounts by applying an interest rate of 1%
    UPDATE Accounts
    SET Balance = Balance * 1.01
    WHERE AccountType = 'Savings';

    -- Get the number of rows updated
    v_rows_updated := SQL%ROWCOUNT;

    -- Display the number of rows updated
    DBMS_OUTPUT.PUT_LINE('Number of accounts updated: ' || v_rows_updated);
END ProcessMonthlyInterest;
/

-- SCENARIO - 2
-- Procedure to Update Employee Bonus Based on Performance
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    deptID IN INT,
    bonusPct IN DECIMAL
) IS
BEGIN
    -- Update the salary of employees in the specified department by adding the bonus percentage
    UPDATE Employees
    SET Salary = Salary + (Salary * (bonusPct / 100))
    WHERE DepartmentID = deptID;
END UpdateEmployeeBonus;
/

-- SCENARIO - 3
-- Procedure to Transfer Funds Between Accounts
CREATE OR REPLACE PROCEDURE TransferFunds(
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
                RAISE insufficientFunds;
            END IF;
        END;

        -- Deduct amount from the source account
        UPDATE Accounts
        SET Balance = Balance - transferAmount
        WHERE AccountID = srcAccountID;

        -- Add amount to the destination account
        UPDATE Accounts
        SET Balance = Balance + transferAmount
        WHERE AccountID = destAccountID;

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
END TransferFunds;
/

-- Example calls for the procedures
BEGIN
    ProcessMonthlyInterest;
END;
/

BEGIN
    UpdateEmployeeBonus(deptID => 1, bonusPct => 10.00);
END;
/

BEGIN
    TransferFunds(srcAccountID => 1, destAccountID => 2, transferAmount => 100.00);
END;
/
