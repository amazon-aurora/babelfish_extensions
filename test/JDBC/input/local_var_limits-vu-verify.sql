-- Tests for UPDATE statement using local variables
-- Case 1: Simple variable update: @var1 = @var2
DECLARE @var1 INT, @var2 INT = 0;
UPDATE test_update_t SET id = id, @var1 = @var2;
SELECT @var1;
GO

-- Case 2: Updating a local variable with an expression that depends on another local variable
-- should throw error
DECLARE @var1 INT, @var2 INT;
UPDATE test_update_t SET id = id, @var1 = 1, @var2 = @var1 + 1;
SELECT @var1;
GO

-- Case 3: Updating a column value with an expression that depends on a local variable
-- should throw error
DECLARE @var1 INT;
UPDATE test_update_t SET id = @var1 * 2, @var1 = 100;
GO

-- Case 4: Multiple local variables and expressions
-- should throw error
DECLARE @var1 INT, @var2 INT, @var3 INT;
UPDATE test_update_t SET id = id, @var1 = 1, @var2 = @var1 + 2, @var3 = @var2 * 3;
SELECT @var1, @var2, @var3;
GO

-- Case 5: Complex expressions with functions
-- should throw error
DECLARE @var1 INT, @var2 INT;
UPDATE test_update_t SET id = id, @var1 = ABS(-10), @var2 = LEN(CAST(@var1 AS VARCHAR(10))) + 5;
SELECT @var1, @var2;
GO

-- Case 6: Expressions with subqueries
-- should throw error
DECLARE @var1 INT, @var2 INT;
UPDATE test_update_t SET id = id, @var1 = (SELECT COUNT(*) FROM t), @var2 = @var1 + 10;
SELECT @var1, @var2;
GO

-- Case 8: Nested expressions
-- should throw error
DECLARE @var1 INT, @var2 INT, @var3 INT;
UPDATE test_update_t SET id = id, @var1 = 1, @var2 = (@var1 + 2) * 3, @var3 = (@var2 / 2) + 5;
SELECT @var1, @var2, @var3;
GO

-- Tests for SELECT statement using local variables
-- Case 1: Simple variable assignment (@var1 = @var2)
DECLARE @var1 INT, @var2 INT = 10;
SELECT @var1 = @var2;
SELECT @var1, @var2;
GO

-- Case 2: Assignment with an expression involving other local variables (@var1 = @var2 + expr)
DECLARE @var1 INT, @var2 INT = 5, @var3 INT = 3;
SELECT @var1 = @var2 + @var3;
SELECT @var1;
GO

-- Case 3: Assignment with an operator and an expression (@var1 += expr)
DECLARE @var1 INT = 10, @var2 INT = 5;
SELECT @var1 += @var2;
SELECT @var1;
GO

-- Case 4: Multiple variable assignments with expressions
DECLARE @var1 INT, @var2 INT = 10, @var3 INT = 20;
SELECT @var1 = @var2, @var2 = @var3 + 5, @var3 = @var1 + @var2;
SELECT @var1, @var2, @var3;
GO

-- Case 5: Variable assignment with subquery
DECLARE @var1 INT;
SELECT @var1 = (SELECT COUNT(*) FROM test_update_t);
SELECT @var1;
GO

-- Case 6: Assigning a local variable a value using subqueries
DECLARE @var1 INT;
SELECT @var1 = (SELECT COUNT(*) FROM test_update_t) FROM test_update_t;
SELECT @var1;
GO

-- Case 7: Assigning a local variable with an expression that depends on another local variable
-- should throw error
DECLARE @var1 INT, @var2 INT;
SELECT @var1 = 1, @var2 = @var1 + 1 FROM test_update_t;
GO

-- Case 8: Assigning a local variable a value using assignment operators
-- should throw error
DECLARE @var1 INT = 1;
SELECT @var1 *= a FROM test_update_t;
GO

-- should throw error
DECLARE @var1 INT = 1, @var2 INT = 2;
SELECT @var1 *= var2 FROM test_update_t;
GO

-- should throw error
DECLARE @var1 INT = 1, @var2 INT = 2;
SELECT @var1 += @var2 + a FROM test_update_t;
GO
