--SELECT: retrieve 
--WHERE: filter
--Order BY: sort
--JOIN: 

--Aggregation functions: perform a calculation on a set of values and return a single aggregated value
--1. COUNT(): returns the number of rows
SELECT COUNT(OrderID) AS TotalNumOfOrders
FROM Orders

SELECT COUNT(*) AS TotalNumOfOrders
FROM Orders

--COUNT(*) vs. COUNT(colName): 
--COUNT(*) Will include null values, but count(colname) will not
SELECT Region
FROM Employees

SELECT COUNT(Region), COUNT(*)
FROM Employees

--use w/ GROUP BY: group rows that have the same values into summary rows
--find total number of orders placed by each customers
SELECT c.CustomerID, c.ContactName, c.Country, COUNT(o.OrderID) AS NumOfOrders
FROM Orders o INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName, c.Country
ORDER BY NumOfOrders DESC

--a more complex template: 
--only retreive total order numbers where customers located in USA or Canada, and order number should be greater than or equal to 10
SELECT c.ContactName, c.Country, COUNT(o.OrderID) AS NumOfOrders
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country IN ('USA', 'Canada')
GROUP BY c.ContactName, c.Country
HAVING COUNT(o.OrderID) >= 10
ORDER BY NumOfOrders DESC

--SELECT fields, aggregate(fields)
--FROM table JOIN table2 ON...
--WHERE criteria -- optional
--GROUP BY fields
--HAVING criteria -- optional
--ORDER BY field --optional

--WHERE vs. HAVING
--1) both are used as filters. having applies only to groups as a whole, and only filters on aggregation functions. but where applies to individual rows
--2) WHERE goes before aggregation but HAVING goes after aggregations
	--FROM/JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY 
	--            |___________________________|
	--             cannot use alias in SELECT

--only retreive total order numbers where customers located in USA or Canada, and order number should be greater than or equal to 10
SELECT c.ContactName, c.Country AS cty, COUNT(o.OrderID) AS NumOfOrders
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE cty IN ('USA', 'Canada')
GROUP BY c.ContactName, cty
HAVING NumOfOrders >= 10
ORDER BY NumOfOrders DESC
--3) WHERE can be used with SELECT, UPDATE and DELETE, but HAVING can be used only with SELECT statement
--UPDATE WITH WHERE
SELECT *
FROM Products

UPDATE Products
SET UnitPrice = 19
WHERE ProductId = 1

--COUNT DISTINCT: only count unique values
SELECT City
FROM Customers

SELECT COUNT(City) AS IncludeDupe, COUNT(DISTINCT City) AS CntUnique
FROM Customers

--2. AVG(): return the average value of a numeric column
--list average revenue for each customer
SELECT c.ContactName, AVG(od.UnitPrice * od.Quantity) AS AvgTotalRevenue
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY AvgTotalRevenue DESC

--3. SUM(): 
--list sum of revenue for each customer
SELECT c.ContactName, SUM(od.UnitPrice * od.Quantity) AS SumTotalRevenue
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY SumTotalRevenue DESC

--4. MAX(): 
--list maxinum revenue from each customer
SELECT c.ContactName, MAX(od.UnitPrice * od.Quantity) AS MaxTotalRevenue
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY MaxTotalRevenue DESC


--5.MIN(): 
--list the cheapeast product bought by each customer
SELECT c.ContactName, MIN(od.UnitPrice) AS CheapestProduct
FROM [Order Details] od JOIN Orders o ON o.OrderId = od.OrderID JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY CheapestProduct


--TOP predicate:select a spefic number or a certain percentage of records
--retrieve top 5 most expensive products
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

SELECT TOP 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--retrieve top 10 percent most expensive products
SELECT TOP 10 PERCENT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--list top 5 customers who created the most total revenue
SELECT TOP 5 c.ContactName, SUM(od.UnitPrice * od.Quantity) AS SumTotalRevenue
FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY SumTotalRevenue DESC

--Subquery: a select statement that is embedded in another sql statement

--find the customers from the same city whre Alejandra Camino lives 
SELECT ContactName, City
FROM Customers
WHERE City IN
(
SELECT City
FROM Customers
WHERE ContactName = 'Alejandra Camino'
)

--find customers who make any orders
--join
SELECT DISTINCT c.CustomerID, c.ContactName, c.City, c.Country
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID

--subquery
SELECT CustomerID, ContactName, City, Country
FROM Customers 
WHERE CustomerId in
(SELECT DISTINCT CustomerID
FROM Orders)

--subquery vs. join
--1) JOIN can only be used in FROM cluase, but Subquery can be used in SELECT, WHERE, HAVING ,FROM, ORDER BY
--list all the order data and the corresponding employee whose in charge of this order
--join
SELECT o.OrderDate, e.FirstName, e.LastName
FROM Orders o JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE e.City = 'London'
ORDER BY o.OrderDate, e.FirstName, e.LastName

--subqery
SELECT o.OrderDate, 
(SELECT FirstName FROM Employees e1 WHERE o.EmployeeID = e1.EmployeeID) AS FirstName,
(SELECT LastName FROM Employees e2 WHERE o.EmployeeID = e2.EmployeeID) AS LastName
FROM Orders o 
WHERE (
SELECT e3.City FROM Employees e3 WHERE o.EmployeeID = E3.EmployeeID
) = 'London'
ORDER BY o.OrderDate, (SELECT FirstName FROM Employees e1 WHERE o.EmployeeID = e1.EmployeeID), (SELECT LastName FROM Employees e2 WHERE o.EmployeeID = e2.EmployeeID)
--2) subquery is easy to understand and maintain
--find customers who never placed any order
--join
SELECT c.CustomerID, c.ContactName, c.City, C.Country
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL

--subquery
SELECT CustomerID, ContactName, City, Country
FROM Customers
WHERE CustomerID NOT IN (
SELECT CustomerID
FROM Orders
)
--3) usually join has a better performance


--Correlated Subquery: inner query is dependent on the outer query
--Customer name and total number of orders by customer
--join
SELECT c.ContactName, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerId
GROUP BY c.ContactName
ORDER BY NumOfOrders DESC

--corrlated subqury
SELECT c.ContactName,
(SELECT COUNT(o.OrderID)
FROM Orders o WHERE c.CustomerID = o.CustomerID) AS NumOfOrders
FROM Customers c 
ORDER BY NumOfOrders DESC


SELECT o.OrderDate, 
(SELECT FirstName FROM Employees e1 WHERE o.EmployeeID = e1.EmployeeID) AS FirstName, 
(SELECT LastName FROM Employees e2 WHERE o.EmployeeID = e2.EmployeeID) AS LastName	  
FROM Orders o
Order By FirstName, o.OrderDate

SELECT o.OrderDate, e.FirstName, e.LastName
FROM Orders o JOIN Employees e ON o.EmployeeID = e.EmployeeID
Order BY e.FirstName, o.OrderDate

--derived table: subquery in from clause
--syntax
SELECT CustomerId, ContactName
FROM 
(SELECT *
FROM Customers) dt

--customers and the number of orders they made
SELECT c.ContactName,c.CompanyName,c.City, c.Country, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName,c.CompanyName,c.City, c.Country
ORDER BY NumOfOrders DESC

SELECT c.ContactName, c.CompanyName, C.City, C.Country, ISNULL(DT.NumOrOrders, 0) AS NumOfOrders
FROM Customers c LEFT JOIN (
SELECT CustomerID, COUNT(OrderID) AS NumOrOrders
FROM Orders
GROUP BY CustomerID
) dt ON c.CustomerID = dt.CustomerID
ORDER BY NumOrOrders DESC

--Union vs. Union ALL: 
--common features:
--1. both are used to combine different result sets vertically
SELECT City, Country
FROM Customers

SELECT City, Country
FROM Employees

SELECT City, Country
FROM Customers
UNION ALL
SELECT City, Country
FROM Employees
ORDER BY City

SELECT City, Country
FROM Customers
UNION
SELECT City, Country
FROM Employees
ORDER BY City
--2. criteria: 
--number of columns must be the same
SELECT City, Country, Region
FROM Customers
UNION ALL
SELECT City, Country
FROM Employees
ORDER BY City
--data types of each column must be identical
SELECT City, Country, Region
FROM Customers
UNION ALL
SELECT City, Country, EmployeeID
FROM Employees
ORDER BY City
--difference:
--1. UNION will remove duplicate records, UNION ALL will not
--2. UNION: the records from the first column will be sorted automatically
SELECT City, Country
FROM Customers
UNION ALL
SELECT City, Country
FROM Employees


SELECT City, Country
FROM Customers
UNION
SELECT City, Country
FROM Employees
--3. UNION cannot be used in a recursive CTE, but UNION ALL can

--Window Function: operate on a set of rows and return a single aggregated value for each row by adding extra columns
--RANK(): if there is a tie, then there will be value gap
--rank for product price
SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice) RNK
FROM Products

SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice desc) RNK
FROM Products

--product with the 2nd highest price
SELECT ProductName, UnitPrice, RNK
FROM
(SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice desc) RNK
FROM Products) dt
WHERE RNK = 2

--DENSE_RANK(): no value gap
SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice desc) RNK, DENSE_RANK() OVER(ORDER BY UnitPrice DESC) DenseRnk
FROM Products

--ROW_NUMBER(): return the row number of the sorted records starting from 1
SELECT ProductID, ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice desc) RNK, DENSE_RANK() OVER(ORDER BY UnitPrice DESC) DenseRnk, ROW_NUMBER() OVER(ORDER BY UnitPrice DESC) RowNum
FROM Products


--partition by: used to divide the result set into partitions and perform computation on each subset of partitioned data
--list customers from every country with the ranking for number of orders
SELECT c.ContactName, c.Country, COUNT(o.OrderID) AS NumOfOrders, RANK() OVER(PARTITION BY c.Country ORDER BY COUNT(o.OrderID) DESC) RNK
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, c.Country


--- find top 3 customers from every country with maximum orders
SELECT ContactName, Country, NumOfOrders, RNK
FROM (SELECT c.ContactName, c.Country, COUNT(o.OrderID) AS NumOfOrders, RANK() OVER(PARTITION BY c.Country ORDER BY COUNT(o.OrderID) DESC) RNK
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, c.Country) dt
WHERE RNK <= 3


--cte: common table expression
SELECT c.ContactName, c.City, dt.TotalCount
FROM Customers c 
LEFT JOIN 
(SELECT COUNT(OrderId) AS "TotalCount", CustomerID 
FROM Orders GROUP BY CustomerID) dt 
ON c.CustomerID = dt.CustomerID	

WITH OrderCountCTE
AS
(
SELECT COUNT(OrderId) AS "TotalCount", CustomerID 
FROM Orders GROUP BY CustomerID
)
SELECT c.ContactName, c.City, cte.TotalCount
FROM Customers c LEFT JOIN OrderCountCTE cte ON c.CustomerID = cte.CustomerID



--recursive CTE: 
--initialization: initial call to the cte wich passes in some values to get things started
--recursive rule
SELECT EmployeeID, FirstName, ReportsTo
FROM Employees

--get employee levels
-- level 1: Andrew
-- level 2: Nancy, Janet, Margaret, Steven, Laura
-- level 3: Michael, Robert, Anne

WITH empHierachyCTE
AS
(
SELECT EmployeeID, FirstName, ReportsTo, 1 lvl
FROM Employees 
WHERE ReportsTo is null
UNION ALL
SELECT e.EmployeeID, e.FirstName, e.ReportsTo, cte.lvl + 1
FROM Employees e INNER JOIN empHierachyCTE cte ON e.ReportsTo = cte.EmployeeID
)
SELECT * FROM empHierachyCTE

WITH updateProducts
AS
(
SELECT * FROM Products
)
UPDATE updateProducts
SET UnitPrice = 20
WHERE ProductID = 1

SELECT *
FROM Products