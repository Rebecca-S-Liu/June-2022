--Aggregations and GROUP BY
--Subquery
--Union and UNION ALL 
--Window function
--cte

--temporary table: are a special type of table so that we can store data temporarily
--# -> local temp table: 
CREATE TABLE #LocalTemp
(
Number INT
)

DECLARE @Variable INT = 1
WHILE (@Variable <= 10)
BEGIN
INSERT INTO #LocalTemp(Number) VALUES(@Variable)
SET @Variable = @Variable  + 1
END

SELECT *
FROM #LocalTemp
--## -> global temp objects
CREATE TABLE ##GlobalTemp
(
Number Int
)

DECLARE @Num INT = 1
WHILE (@Num <= 10)
BEGIN
INSERT INTO ##GlobalTemp(Number) VALUES(@Num)
SET @Num = @Num  + 1
END

SELECT *
FROM ##GlobalTemp

declare @today datetime
select @today = GETDATE()
print @today
--table variable:
DECLARE @WeekDays TABLE (DayNum int, DayAbb varchar(10), WeekName varchar(10))
INSERT INTO @WeekDays
VALUES
(1,'Mon','Monday')  ,
(2,'Tue','Tuesday') ,
(3,'Wed','Wednesday') ,
(4,'Thu','Thursday'),
(5,'Fri','Friday'),
(6,'Sat','Saturday'),
(7,'Sun','Sunday')	
SELECT * FROM @WeekDays
SELECT * FROM tempdb.sys.tables

--1. both temp tables and table variables will be stored in temp db
--2. scope: local/global; current batch
--3. size: > 100 rows; < 100 rows
--4. usage: do not use temp tables in sp, user defined funcitons, but we can use table variables in sp and functions


--view
SELECT *
FROM Employee

INSERT INTO Employee
VALUES(1, 'Fred', 5000),(2, 'Laura', 7000), (3,'Amy', 6000)

CREATE VIEW vwEmp
AS
SELECT Id, EName, Salary FROM Employee

SELECT *
FROM vwEmp

--stored procedure: a prepared sql query that we can save in our db and reuse whenever we need
BEGIN
PRINT 'Hello anonymous block'
END

CREATE PROC spHello
AS
BEGIN
PRINT 'Hello stored procedure'
END

EXEC spHello
--ALter

--sql injection: some hackers inject some malicious code to our db, thus destroying our db
SELECT Id, UserName
FROM Users
WHERE id = 1 UNION SELECT ID, Passwords FROM Users

--parameters in sp
--input
CREATE PROC spAddNumbers
@a int,
@b int
AS
BEGIN
print @a + @b
END

exec spAddNumbers 10,20

--output
CREATE PROC spGetEmpName
@id int,
@ename varchar(20) out
AS
BEGIN
SELECT @ename = Ename FROM Employee WHERE id = @id
END

BEGIN
DECLARE @en varchar(20)
exec spGetEmpName 2, @en out
select @en
END

SELECT *
FROM Employee

CREATE PROC spGetAllEmp
AS
BEGIN
SELECT Id, EName, Salary
FROM Employee
END

EXEC spGetAllEmp

--trigger
--DML trigger
--DDL trigger
--Logon tirgger

--function
CREATE FUNCTION GetTotalRevenue(@price money, @discount real, @quantity smallint)
returns money
AS
BEGIN
DECLARE @revenue money
SET @revenue = @price * (1 - @discount) * @quantity
RETURN @revenue
END

SELECT UnitPrice, Discount, Quantity, dbo.GetTotalRevenue(UnitPrice, Discount, Quantity) AS TotalRevenue
FROM [Order Details]

CREATE FUNCTION expensiveProduct(@threshold money)
RETURNS TABLE
as
return 
	select *
	from Products
	where UnitPrice > @threshold

select *
from dbo.expensiveProduct(10)

--sp vs. function
--usage: sp for dml, function mainly for calculations
--how to call: sp will be called by its name, not in DML statemetns, but functions must be called in a sql statements
--input/out: sp may or may not have input/output parameters, but functions may or maynot have input, but it must have output
--sp can call functions, but functions cannot call sp


--Pagination
--OFFSET -> skip
--FETCH NEXT ROW -> select
SELECT CustomerID, ContactName, City
FROM Customers
ORDER BY CustomerID

SELECT CustomerID, ContactName, City
FROM Customers
ORDER BY CustomerID
OFFSET 92 ROWS


SELECT CustomerID, ContactName, City
FROM Customers
ORDER BY CustomerID
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--2nd page
--DECLARE @PageNum as int
--DECLARE @RowsOfPage as int
--SET @PageNum = 2
--SET @RowsOfPage = 10
--SELECT CustomerID, ContactName, City
--FROM Customers
--ORDER BY CustomerID
--OFFSET (@PageNum  - 1) * @RowsOfPage ROWS
--FETCH NEXT @RowsOfPage ROWS only

--pagination in a loop
DECLARE @PageNum as int
DECLARE @RowsOfPage as int
DECLARE @MaxTablePages as FLOAT
SET @PageNum = 1
SET @RowsOfPage = 10
SELECT @MaxTablePages = COUNT(*) FROM Customers -- 91.0
SET @MaxTablePages = CEILING(@MaxTablePages / @RowsOfPage)
WHILE @PageNum <= @MaxTablePages
BEGIN
SELECT CustomerID, ContactName, City
FROM Customers
ORDER BY CustomerID
OFFSET (@PageNum - 1) * @RowsOfPage ROWS
FETCH NEXT @RowsOfPage ROWS ONLY
SET @PageNum = @PageNum + 1
END

SELECT ceiling(91.0/10)



--constraints
DROP TABLE Employee

create table Employee
(
Id int,
EName varchar(20),
Age int
)
SELECT *
FROM Employee

insert into Employee VALUES(1, 'Sam', 53)
insert into Employee VALUES(null, null, null)

DROP TABLE Employee
CREATE TABLE Employee (
Id int NOT NULL,
Ename varchar(20) NOT NULL,
Age int
)

DROP TABLE Employee
CREATE TABLE Employee (
Id int unique,
Ename varchar(20) NOT NULL,
Age int
)
insert into Employee VALUES(2, 'Laura', 53)
insert into Employee VALUES(NULL, 'Amy', 53)

CREATE TABLE Employee (
Id int primary key,
EName varchar(20) NOT NULL,
Age int
)

SELECT *
FROM Employee

--student: sID, sname
--course: cId, cName
--enrollment: sID, cId

--Primary key vs. unique constraint
--1. unique constraint can accept one and only one null value but pk cannot accept any null value
--2.one table can have multiple unique keys, but only one pk
--3.pk will sort the data by defualt, but unique key will not
--4. pk will by default create a clustered index, but unique key will by default create a non-clustered index
DELETE Employee

INSERT INTO Employee
VALUES(4, 'Fred', 45)

INSERT INTO Employee
VALUES(1, 'Laura', 34)

INSERT INTO Employee
VALUES(3, 'Peter', 19)

INSERT INTO Employee
VALUES(2, 'Stella', 24)
