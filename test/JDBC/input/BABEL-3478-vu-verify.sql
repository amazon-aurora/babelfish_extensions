-- Inserting data into the babel_3478_vu_prepare_t table
INSERT INTO babel_3478_vu_prepare_t(FirstName, LastName, Salary)
VALUES ('John', 'Doe', 50000), ('Jane', 'Doe', 60000), ('Jim', 'Smith', 55000);
GO
-- Checking the number of inserted rows
SELECT ROWCOUNT_BIG();
GO


-- Updating the salary of babel_3478_vu_prepare_t with last name 'Doe'
UPDATE babel_3478_vu_prepare_t SET Salary = 65000 WHERE LastName = 'Doe';
GO
-- Checking the number of updated rows
SELECT ROWCOUNT_BIG();
GO


-- Deleting babel_3478_vu_prepare_t with last name 'Smith'
DELETE FROM babel_3478_vu_prepare_t WHERE LastName = 'Smith';
GO
-- Checking the number of deleted rows
SELECT ROWCOUNT_BIG();
GO