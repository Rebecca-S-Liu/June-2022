use Northwind
GO
--SELECT statement: identify which columns we want to retrieve

--1. SELECT all columns and rows
SELECT *
FROM Employees

--2. SELECT a list of columns
SELECT EmployeeID, LastName, FirstName, Title, ReportsTo
FROM Employees

SELECT E.EmployeeID, E.LastName, E.FirstName, E.Title, E.ReportsTo
FROM Employees AS E
--avoid using SELECT *
--1) Unecessary data
--2) Name conflict
SELECT *
FROM Employees

SELECT *
FROM Customers

SELECT *
FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON o.CustomerID = c.CustomerID



--3. SELECT DISTINCT Value: list all the cities that employees located at
SELECT City
FROM Employees

SELECT DISTINCT City
FROM Employees

--4. SELECT combined with plain text: retrieve the full name of employees
SELECT FirstName + ' ' + LastName FullName
FROM Employees



--identifiers: name that we give to db, tables, columns, views..
--1) regular identifiers: 
--a. first character: a-z, A-Z, @, #
	--use @ for declaring local variables
	declare @today datetime
	select @today = GETDATE()
	print @today

	print @today

	--use # for creating temp tables
--b. subsequent char: a-z, 0-9, @, $, #, _
--c. identifier must not be a sql server resered word, both uppercase and lowercase
	SELECT MAX, AVG
	FROM TABLE
--d. embedded spaces are not allowed

--2) delimited identifiers: [] ""
SELECT FirstName + ' ' + LastName [Full Name]
FROM Employees

SELECT FirstName + ' ' + LastName "Full Name"
FROM Employees

SELECT *
FROM [Order Details]

--WHERE statement: filter records
--1. equal =
--Customers who are from Germany
SELECT ContactName, Country
FROM Customers
WHERE Country = 'Germany'

--Product which price is $18
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice = 18

--2. Customers who are not from UK
SELECT ContactName, Country
FROM Customers
WHERE Country != 'UK'

SELECT ContactName, Country
FROM Customers
WHERE Country <> 'UK'

--IN Operator:retrieve among a list of values
--E.g: Orders that ship to USA AND Canada
SELECT OrderId, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry = 'USA' OR ShipCountry = 'Canada'

SELECT OrderId, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry IN ('USA', 'Canada')


--BETWEEN Operator: retreive in a consecutive range ; inclusive
--1. retreive products whose price is between 20 and 30.
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice >= 20 and UnitPrice <= 30

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30


--NOT Operator: display a record if the condition is NOT TRUE
-- list orders that does not ship to USA or Canada
SELECT OrderId, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry NOT IN ('USA', 'Canada')

SELECT OrderId, CustomerID, ShipCountry
FROM Orders
WHERE NOT ShipCountry IN ('USA', 'Canada')

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 20 AND 30

SELECT ProductName, UnitPrice
FROM Products
WHERE NOT UnitPrice BETWEEN 20 AND 30

--NULL Value: a field with no value
--check which employees' region information is empty
SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS NULL

--exclude the employees whose region is null
SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS NOT NULL

--Null in numerical operation
CREATE TABLE TestSalary(EId int primary key identity(1,1), Salary money, Comm money)
INSERT INTO TestSalary VALUES(2000, 500), (2000, NULL),(1500, 500),(2000, 0),(NULL, 500),(NULL,NULL)

select *
from TestSalary

SELECT eID, ISNULL(Salary, 0) as Salary, Comm, ISNULL(Salary, 0) + ISNULL(Comm,0) AS Total
FROM TestSalary


--LIKE Operator: create a search expression
--1. Work with % wildcard character: % substitute to 0 or more chars
--retrieve all the employees whose last name starts with D
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE 'D%'

--2. Work with [] and % to search in ranges: find customers whose postal code starts with number between 0 and 3
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[0-3]%'

--3. Work with NOT: 
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode NOT LIKE '[0-3]%'

--4. Work with ^: any characters not in the brackets
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[^0-3]%'


--Custermer name starting from letter A but not followed by l-n
SELECT ContactName, City
FROM Customers
WHERE ContactName LIKE 'A[^l-n]%'


--ORDER BY statement: sort the result set in ascending or descending order
--1. retrieve all customers except those in Boston and sort by Name
SELECT ContactName, City
FROM Customers
WHERE City != 'Boston'
ORDER BY ContactName DESC


--2. retrieve product name and unit price, and sort by unit price in descending order
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice


--3. Order by multiple columns
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice desc, ProductName


--JOIN: combine rows from two or more tables, based on a related column between them

--1. INNER JOIN: return the records that have matching values in both tables
--find employees who have deal with any orders
SELECT e.EmployeeID, e.FirstName + ' ' + E.LastName as [Full Name], o.OrderDate
FROM Employees AS E INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID

SELECT e.EmployeeID, e.FirstName + ' ' + E.LastName as [Full Name], o.OrderDate
FROM Employees AS E JOIN Orders AS O ON E.EmployeeID = O.EmployeeID

SELECT e.EmployeeID, e.FirstName + ' ' + E.LastName as [Full Name], o.OrderDate
FROM Employees AS E, Orders O
WHERE e.EmployeeID = O.EmployeeID

--get cusotmers information and corresponding order date
SELECT c.ContactName, c.City, c.Country, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID

--join multiple tables:
--get customer name, the corresponding employee who is responsible for this order, and the order date
SELECT c.ContactName AS Customer, e.FirstName + ' ' + e.LastName AS Employee, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID

--add detailed information about quantity and price, join Order details
SELECT c.ContactName AS Customer, e.FirstName + ' ' + e.LastName AS Employee, o.OrderDate, OD.Quantity, OD.UnitPrice
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID INNER JOIN [Order Details] od ON o.OrderID = OD.OrderID

--2. OUTER JOIN
--1) LEFT OUTER JOIN: return all records from the left table, and the matching records from the right table. for the non-matching records in the right table, the result set will return us null values
--list all customers whether they have made any purchase or not
SELECT c.ContactName, o.OrderID
FROM Customers c LEFT JOIN Orders o ON C.CustomerID = o.CustomerID
ORDER BY O.OrderID

--JOIN with WHERE: find out customers who have never placed any order
SELECT c.ContactName, o.OrderID
FROM Customers c LEFT JOIN Orders o ON C.CustomerID = o.CustomerID
WHERE o.OrderID is null

--2) RIGHT OUTER JOIN: return all records from the right table, and the matching records from left table, if not matching, return null
SELECT c.ContactName, o.OrderID
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
ORDER BY O.OrderID

--3) FULL OUTER JOIN: Return all rows from left table and right table with null values where the join condition is not met
--Match all customers and suppliers by country.
SELECT C.ContactName, C.Country as CustomerCountry, s.Country AS SupplierCountry, s.ContactName
FROM Customers c FULL JOIN Suppliers s ON c.Country = s.Country
ORDER BY c.Country, s.Country

--3. CROSS JOIN: create the cartesian product of two tables
--table1: 10 rows, table2: 20 rows --> cross join --> 200 rows 
SELECT *
FROM Customers

SELECT *
FROM Orders

SELECT *
FROM Customers CROSS JOIN Orders o 

--FULL OUTER JOIN VS. CROSS JOIN
SELECT c.ContactName, o.OrderDate
FROM Customers c FULL JOIN Orders o ON 1 = 1 

SELECT c.ContactName, o.OrderDate
FROM Customers c CROSS JOIN Orders o

--* SELF JOIN： join a table with itself, either be inner join or outer join
SELECT EmployeeID, FirstName, LastName, ReportsTo
FROM Employees

--CEO: Andrew
--Manager: Nancy, Janet, Margaret, Steven, Laura
--Employee: Michael, Robert, Anne



--find emloyees with the their manager name
SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName + ' ' + m.LastName AS Manager 
FROM Employees e INNER JOIN Employees m ON e.ReportsTo = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS Employee, ISNULL(m.FirstName + ' ' + m.LastName,'N/A') AS Manager 
FROM Employees e LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID

--Batch Directives
CREATE DATABASE JuneBatch
GO
USE JuneBatch
GO
CREATE TABLE Employee(Id int, EName varchar(20), Salary money)

SELECT *
FROM Employee
--EXEC

