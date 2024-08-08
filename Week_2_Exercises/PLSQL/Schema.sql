-- Creating Tables
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE Customers (
            CustomerID INT PRIMARY KEY,
            Name VARCHAR(100),
            DOB DATE,
            Balance INT,
            LastModified DATE
        )';
        DBMS_OUTPUT.PUT_LINE('Customers table created.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Customers table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE Accounts (
            AccountID INT PRIMARY KEY,
            CustomerID INT,
            AccountType VARCHAR(20),
            Balance INT,
            LastModified DATE,
            FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        )';
        DBMS_OUTPUT.PUT_LINE('Accounts table created.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Accounts table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE Transactions (
            TransactionID INT PRIMARY KEY,
            AccountID INT,
            TransactionDate DATE,
            Amount INT,
            TransactionType VARCHAR(10),
            FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
        )';
        DBMS_OUTPUT.PUT_LINE('Transactions table created.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Transactions table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE Loans (
            LoanID INT PRIMARY KEY,
            CustomerID INT,
            LoanAmount INT,
            InterestRate INT,
            StartDate DATE,
            EndDate DATE,
            FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        )';
        DBMS_OUTPUT.PUT_LINE('Loans table created.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Loans table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE Employees (
            EmployeeID INT PRIMARY KEY,
            Name VARCHAR(100),
            Position VARCHAR(50),
            Salary INT,
            Department VARCHAR(50),
            HireDate DATE
        )';
        DBMS_OUTPUT.PUT_LINE('Employees table created.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Employees table: ' || SQLERRM);
    END;
END;
/

-- Inserting Data into Tables
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified) 
            VALUES (1, ''John Doe'', TO_DATE(''1985-05-15'', ''YYYY-MM-DD''), 1000, SYSDATE)';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Customers table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Customers table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified) 
            VALUES (2, ''Jane Smith'', TO_DATE(''1990-07-20'', ''YYYY-MM-DD''), 1500, SYSDATE)';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Customers table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Customers table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) 
            VALUES (1, 1, ''Savings'', 1000, SYSDATE)';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Accounts table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Accounts table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) 
            VALUES (2, 2, ''Checking'', 1500, SYSDATE)';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Accounts table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Accounts table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType) 
            VALUES (1, 1, SYSDATE, 200, ''Deposit'')';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Transactions table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Transactions table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType) 
            VALUES (2, 2, SYSDATE, 300, ''Withdrawal'')';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Transactions table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Transactions table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) 
            VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60))';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Loans table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Loans table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate) 
            VALUES (1, ''Alice Johnson'', ''Manager'', 70000, ''HR'', TO_DATE(''2015-06-15'', ''YYYY-MM-DD''))';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Employees table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Employees table: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate) 
            VALUES (2, ''Bob Brown'', ''Developer'', 60000, ''IT'', TO_DATE(''2017-03-20'', ''YYYY-MM-DD''))';
        DBMS_OUTPUT.PUT_LINE('Inserted data into Employees table.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting data into Employees table: ' || SQLERRM);
    END;
END;
/

-- Enable DBMS_OUTPUT
BEGIN
    DBMS_OUTPUT.ENABLE;
END;
/
