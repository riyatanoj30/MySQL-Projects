-- =============================================================================
-- SQL QUERIES ASSIGNMENT: E-COMMERCE DATABASE SYSTEM
-- FILE: queries_1_to_42.sql
-- =============================================================================

-- 1. List of all customers
SELECT * FROM Customers;

-- 2. List of all customers where company name ends in 'N'
SELECT * FROM Customers WHERE CompanyName LIKE '%N';

-- 3. List of all customers who live in Berlin or London
SELECT * FROM Customers WHERE City IN ('Berlin', 'London');

-- 4. List of all customers who live in UK or USA
SELECT * FROM Customers WHERE Country IN ('UK', 'USA');

-- 5. List of all products sorted by product name
SELECT * FROM Products ORDER BY ProductName;

-- 6. List of all products where product name starts with 'A'
SELECT * FROM Products WHERE ProductName LIKE 'A%';

-- 7. List of customers who ever placed an order
SELECT DISTINCT c.* 
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 8. List of Customers who live in London and have bought chai
SELECT DISTINCT c.* 
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE c.City = 'London' AND p.ProductName = 'Chai';

-- 9. List of customers who never placed an order
SELECT c.* 
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.CustomerID IS NULL;

-- 10. List of customers who ordered Tofu
SELECT DISTINCT c.* 
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Tofu';

-- 11. Details of the first order of the system
SELECT o.*, od.*, p.ProductName 
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate = (SELECT MIN(OrderDate) FROM Orders);

-- 12. Details of the most expensive order date
SELECT o.*, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as OrderTotal
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
HAVING OrderTotal = (
    SELECT MAX(OrderTotal) FROM (
        SELECT SUM(od2.UnitPrice * od2.Quantity * (1 - od2.Discount)) as OrderTotal
        FROM Orders o2
        INNER JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
        GROUP BY o2.OrderID
    ) as OrderTotals
);

-- 13. For each order, get the OrderID and average quantity
SELECT o.OrderID, AVG(od.Quantity) as AverageQuantity
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID;

-- 14. For each order, get OrderID, min and max quantity
SELECT o.OrderID, MIN(od.Quantity) as MinQuantity, MAX(od.Quantity) as MaxQuantity
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID;

-- 15. Managers and number of direct reports
SELECT m.EmployeeName as ManagerName, COUNT(e.EmployeeID) as NumberOfReports
FROM Employees m
INNER JOIN Employees e ON m.EmployeeID = e.ManagerID
GROUP BY m.EmployeeID;

-- 16. Orders with total quantity > 300
SELECT o.OrderID, SUM(od.Quantity) as TotalQuantity
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
HAVING TotalQuantity > 300;

-- 17. Orders placed on or after 1996-12-31
SELECT * FROM Orders WHERE OrderDate >= '1996-12-31';

-- 18. Orders shipped to Canada
SELECT * FROM Orders WHERE ShipCountry = 'Canada';

-- 19. Orders with total > 200
SELECT o.OrderID, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS OrderTotal
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
HAVING OrderTotal > 200;

-- 20. Sales by country
SELECT o.ShipCountry, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalSales
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry
ORDER BY TotalSales DESC;

-- 21. Customer ContactName and number of orders
SELECT c.ContactName, COUNT(o.OrderID) as NumberOfOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

-- 22. Customers with more than 3 orders
SELECT c.ContactName, COUNT(o.OrderID) as NumberOfOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING NumberOfOrders > 3;

-- 23. Discontinued products ordered between 1997-01-01 and 1998-01-01
SELECT DISTINCT p.*
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE p.Discontinued = TRUE 
AND o.OrderDate BETWEEN '1997-01-01' AND '1998-01-01';

-- 24. Employees and their managers
SELECT e.FirstName, e.LastName, m.FirstName AS ManagerFirstName, m.LastName AS ManagerLastName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- 25. Employees and their total sales
SELECT e.EmployeeID, e.EmployeeName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID;

-- 26. Employees with 'a' in their FirstName
SELECT * FROM Employees WHERE FirstName LIKE '%a%';

-- 27. Managers with more than 4 reports
SELECT m.EmployeeID, m.EmployeeName, COUNT(e.EmployeeID) as NumberOfReports
FROM Employees m
INNER JOIN Employees e ON m.EmployeeID = e.ManagerID
GROUP BY m.EmployeeID
HAVING NumberOfReports > 4;

-- 28. Orders and product names
SELECT o.OrderID, o.OrderDate, p.ProductName, od.Quantity
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderID;

-- 29. Orders by the best customer
SELECT o.*
FROM Orders o
WHERE o.CustomerID = (
    SELECT CustomerID
    FROM Orders o2
    INNER JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
    GROUP BY o2.CustomerID
    ORDER BY SUM(od2.UnitPrice * od2.Quantity * (1 - od2.Discount)) DESC
    LIMIT 1
);

-- 30. Orders placed by customers with no phone number
SELECT o.*
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Phone IS NULL OR c.Phone = '';

-- 31. Postal codes where 'Tofu' was shipped
SELECT DISTINCT o.ShipPostalCode
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Tofu';

-- 32. Product names shipped to France
SELECT DISTINCT p.ProductName
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.ShipCountry = 'France';

-- 33. Product names and categories for supplier 'Specialty Biscuits Ltd.'
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Specialty Biscuits Ltd.';

-- 34. Products never ordered
SELECT p.*
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL;

-- 35. Products with low stock and no units on order
SELECT * FROM Products 
WHERE UnitsInStock < 10 AND UnitsOnOrder = 0;

-- 36. Top 10 countries by sales
SELECT o.ShipCountry, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalSales
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry
ORDER BY TotalSales DESC
LIMIT 10;

-- 37. Orders for customers with ID between 1 and 5
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) as NumberOfOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.CustomerID BETWEEN 1 AND 5
GROUP BY c.CustomerID;

-- 38. Order date of most expensive order
SELECT o.OrderDate, o.OrderID, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as OrderTotal
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
HAVING OrderTotal = (
    SELECT MAX(OrderTotal) FROM (
        SELECT SUM(od2.UnitPrice * od2.Quantity * (1 - od2.Discount)) as OrderTotal
        FROM Orders o2
        INNER JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
        GROUP BY o2.OrderID
    ) as OrderTotals
);

-- 39. Product name and total revenue
SELECT p.ProductName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalRevenue
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID
ORDER BY TotalRevenue DESC;

-- 40. SupplierID and number of products offered
SELECT s.SupplierID, s.SupplierName, COUNT(p.ProductID) as NumberOfProducts
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID;

-- 41. Top 10 customers by total business
SELECT c.CustomerID, c.CustomerName, c.CompanyName,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalBusiness
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
ORDER BY TotalBusiness DESC
LIMIT 10;

-- 42. Total revenue of the company
SELECT SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalCompanyRevenue
FROM OrderDetails od;

-- =============================================================================
-- END OF FILE
-- =============================================================================
