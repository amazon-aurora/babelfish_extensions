CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName NVARCHAR(50),
 LastName NVARCHAR(50),
 HireDate DATETIME,
 Salary MONEY
);
GO

-- Insert some sample data
INSERT INTO Employee (EmployeeID, FirstName, LastName, HireDate, Salary)
VALUES (1, 'John', 'Doe', '2020-01-01', 50000),
 (2, 'Jane', 'Smith', '2020-02-01', 60000),
 (3, 'Bob', 'Johnson', '2020-03-01', 70000);
GO


CREATE VIEW EmployeeDatabaseView1
AS
SELECT PARSENAME('tempdb.dbo.Employee', 3) AS [Database Name]
GO

CREATE PROCEDURE GetEmployeeDatabaseName1
AS
BEGIN
 SELECT PARSENAME('tempdb.dbo.Employee', 3) AS [Database Name]
END
GO


CREATE VIEW EmployeeDatabaseView2
AS
SELECT PARSENAME('tempdb.dbo.Employee', 2) AS [Schema Name]
GO

CREATE PROCEDURE GetEmployeeDatabaseName2
AS
BEGIN
 SELECT PARSENAME('tempdb.dbo.Employee', 2) AS [Schema Name]
END
GO


CREATE VIEW EmployeeDatabaseView3
AS
SELECT PARSENAME('tempdb.dbo.Employee', 1) AS [Table Name]
GO

CREATE PROCEDURE GetEmployeeDatabaseName3
AS
BEGIN
 SELECT PARSENAME('tempdb.dbo.Employee', 1) AS [Table Name]
END
GO