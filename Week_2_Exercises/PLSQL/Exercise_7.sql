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
-- Package for Customer Management
CREATE OR REPLACE PROCEDURE AddCustomer(
    p_ID IN INT, 
    p_FullName IN VARCHAR2, 
    p_DateOfBirth IN DATE, 
    p_InitialBalance IN DECIMAL
) AS
BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance) 
    VALUES (p_ID, p_FullName, p_DateOfBirth, p_InitialBalance);
    
    INSERT INTO Accounts (CustomerID, Balance) 
    VALUES (p_ID, p_InitialBalance);
END;
/

CREATE OR REPLACE PROCEDURE UpdateCustomerDetails(
    p_ID IN INT, 
    p_FullName IN VARCHAR2, 
    p_DateOfBirth IN DATE
) AS
BEGIN
    UPDATE Customers
    SET Name = p_FullName, DOB = p_DateOfBirth
    WHERE CustomerID = p_ID;
END;
/

CREATE OR REPLACE FUNCTION GetCustomerBalance(
    p_ID IN INT
) 
RETURN DECIMAL IS
    v_Balance DECIMAL(10, 2);
BEGIN
    SELECT Balance INTO v_Balance
    FROM Accounts
    WHERE CustomerID = p_ID;

    RETURN v_Balance;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Return 0 if no balance found
END;
/

-- SCENARIO - 2
-- Package for Employee Management
CREATE OR REPLACE PROCEDURE HireEmployee(
    p_ID IN INT, 
    p_FullName IN VARCHAR2, 
    p_JobTitle IN VARCHAR2, 
    p_AnnualSalary IN DECIMAL
) AS
BEGIN
    INSERT INTO Employees (EmployeeID, Name, Position, Salary) 
    VALUES (p_ID, p_FullName, p_JobTitle, p_AnnualSalary);
END;
/

CREATE OR REPLACE PROCEDURE UpdateEmployeeDetails(
    p_ID IN INT, 
    p_FullName IN VARCHAR2, 
    p_JobTitle IN VARCHAR2, 
    p_AnnualSalary IN DECIMAL
) AS
BEGIN
    UPDATE Employees
    SET Name = p_FullName, Position = p_JobTitle, Salary = p_AnnualSalary
    WHERE EmployeeID = p_ID;
END;
/

CREATE OR REPLACE FUNCTION CalculateAnnualSalary(
    p_ID IN INT
) 
RETURN DECIMAL IS
    v_AnnualSalary DECIMAL(10, 2);
BEGIN
    SELECT Salary * 12 INTO v_AnnualSalary
    FROM Employees
    WHERE EmployeeID = p_ID;

    RETURN v_AnnualSalary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Return 0 if employee not found
END;
/

-- SCENARIO - 3
-- Package for Account Operations
CREATE OR REPLACE PROCEDURE OpenAccount(
    p_CustomerID IN INT, 
    p_InitialBalance IN DECIMAL
) AS
BEGIN
    INSERT INTO Accounts (CustomerID, Balance) 
    VALUES (p_CustomerID, p_InitialBalance);
END;
/

CREATE OR REPLACE PROCEDURE CloseAccount(
    p_CustomerID IN INT
) AS
BEGIN
    DELETE FROM Accounts
    WHERE CustomerID = p_CustomerID;
END;
/

CREATE OR REPLACE FUNCTION GetTotalBalance(
    p_CustomerID IN INT
) 
RETURN DECIMAL IS
    v_TotalBalance DECIMAL(10, 2);
BEGIN
    SELECT SUM(Balance) INTO v_TotalBalance
    FROM Accounts
    WHERE CustomerID = p_CustomerID;

    RETURN v_TotalBalance;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Return 0 if no accounts found
END;
/ 
