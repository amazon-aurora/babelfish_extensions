-- Create a table
CREATE TABLE Employee (
  ID INT PRIMARY KEY IDENTITY(1,1),
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Salary MONEY
);
GO

-- Insert some data
INSERT INTO Employee (FirstName, LastName, Salary)
VALUES ('John', 'Doe', 50000), ('Jane', 'Doe', 60000), ('Jim', 'Smith', 55000);
SELECT ROWCOUNT_BIG();
GO

-- Create a stored procedure that includes multiple SQL statements
CREATE PROCEDURE test_procedure
AS
BEGIN
  INSERT INTO Employee (FirstName, LastName, Salary) VALUES ('Jack', 'Johnson', 40000);
  SELECT 'Number of rows affected by first statement = ' + CAST(ROWCOUNT_BIG() AS VARCHAR);
  UPDATE Employee SET Salary = Salary * 1.05 WHERE Salary < 55000;
  SELECT 'Number of rows affected by second statement = ' + CAST(ROWCOUNT_BIG() AS VARCHAR);
END;
GO

-- Create a trigger that is executed as a result of an insert, update, or delete operation
CREATE TRIGGER test_trigger
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
  SELECT 'Number of rows affected = ' + CAST(ROWCOUNT_BIG() AS VARCHAR);
END;
GO