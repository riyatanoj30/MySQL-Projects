-- =============================================================================
-- SAMPLE DATA INSERTION FOR E-COMMERCE DATABASE
-- =============================================================================

-- Insert Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
('Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
('Dairy Products', 'Cheeses'),
('Grains/Cereals', 'Breads, crackers, pasta, and cereal'),
('Meat/Poultry', 'Prepared meats'),
('Produce', 'Dried fruit and bean curd'),
('Seafood', 'Seaweed and fish'),
('Confections', 'Desserts, candies, and sweet breads');

-- Insert Suppliers
INSERT INTO Suppliers (SupplierName, CompanyName, City, Country, ContactName, Phone) VALUES
('Exotic Liquids', 'Exotic Liquids Ltd.', 'London', 'UK', 'Charlotte Cooper', '(171) 555-2222'),
('New Orleans Cajun Delights', 'New Orleans Cajun Delights Inc.', 'New Orleans', 'USA', 'Shelley Burke', '(100) 555-4822'),
('Grandma Kellys Homestead', 'Grandma Kellys Homestead LLC', 'Ann Arbor', 'USA', 'Regina Murphy', '(313) 555-5735'),
('Tokyo Traders', 'Tokyo Traders Co.', 'Tokyo', 'Japan', 'Yoshi Nagase', '(03) 3555-5011'),
('Cooperativa de Quesos Las Cabras', 'Cooperativa de Quesos Las Cabras', 'Oviedo', 'Spain', 'Antonio del Valle Saavedra', '(98) 598 76 54'),
('Mayumis', 'Mayumis Co. Ltd.', 'Osaka', 'Japan', 'Mayumi Ohno', '(06) 431-7877'),
('Pavlova Ltd.', 'Pavlova Ltd.', 'Melbourne', 'Australia', 'Ian Devling', '(03) 444-2343'),
('Specialty Biscuits Ltd.', 'Specialty Biscuits Ltd.', 'Manchester', 'UK', 'Peter Wilson', '(161) 555-4448');

-- Insert Employees
INSERT INTO Employees (EmployeeName, FirstName, LastName, Title, City, Country, HireDate, Salary, ManagerID) VALUES
('Nancy Davolio', 'Nancy', 'Davolio', 'Sales Representative', 'Seattle', 'USA', '1992-05-01', 45000.00, NULL),
('Andrew Fuller', 'Andrew', 'Fuller', 'Vice President Sales', 'Tacoma', 'USA', '1992-08-14', 75000.00, NULL),
('Janet Leverling', 'Janet', 'Leverling', 'Sales Representative', 'Kirkland', 'USA', '1992-04-01', 48000.00, 2),
('Margaret Peacock', 'Margaret', 'Peacock', 'Sales Representative', 'Redmond', 'USA', '1993-05-03', 42000.00, 2),
('Steven Buchanan', 'Steven', 'Buchanan', 'Sales Manager', 'London', 'UK', '1993-10-17', 55000.00, 2),
('Michael Suyama', 'Michael', 'Suyama', 'Sales Representative', 'London', 'UK', '1993-10-17', 44000.00, 5),
('Robert King', 'Robert', 'King', 'Sales Representative', 'London', 'UK', '1994-01-02', 46000.00, 5),
('Laura Callahan', 'Laura', 'Callahan', 'Inside Sales Coordinator', 'Seattle', 'USA', '1994-03-05', 38000.00, 2),
('Anne Dodsworth', 'Anne', 'Dodsworth', 'Sales Representative', 'London', 'UK', '1994-11-15', 41000.00, 5);

-- Insert Customers
INSERT INTO Customers (CustomerName, CompanyName, City, Country, ContactName, Phone, Email, RegistrationDate) VALUES
('Alfreds Futterkiste', 'Alfreds Futterkiste GmbH', 'Berlin', 'Germany', 'Maria Anders', '030-0074321', 'maria@alfreds.com', '1996-01-15'),
('Ana Trujillo Emparedados y helados', 'Ana Trujillo Emparedados y helados', 'México D.F.', 'Mexico', 'Ana Trujillo', '(5) 555-4729', 'ana@trujillo.com', '1996-02-10'),
('Antonio Moreno Taquería', 'Antonio Moreno Taquería', 'México D.F.', 'Mexico', 'Antonio Moreno', '(5) 555-3932', 'antonio@moreno.com', '1996-03-05'),
('Around the Horn', 'Around the Horn Ltd.', 'London', 'UK', 'Thomas Hardy', '(171) 555-7788', 'thomas@aroundthehorn.com', '1996-01-20'),
('Berglunds snabbköp', 'Berglunds snabbköp AB', 'Luleå', 'Sweden', 'Christina Berglund', '0921-12 34 65', 'christina@berglunds.com', '1996-04-12'),
('Blauer See Delikatessen', 'Blauer See Delikatessen GmbH', 'Mannheim', 'Germany', 'Hanna Moos', '0621-08460', 'hanna@blauersee.com', '1996-05-18'),
('Blondesddsl père et fils', 'Blondesddsl père et fils SARL', 'Strasbourg', 'France', 'Frédérique Citeaux', '88.60.15.31', 'frederique@blondesddsl.com', '1996-06-25'),
('Bólido Comidas preparadas', 'Bólido Comidas preparadas S.A.', 'Madrid', 'Spain', 'Martín Sommer', '(91) 555 22 82', 'martin@bolido.com', '1996-07-30'),
('Bon app', 'Bon app S.A.R.L.', 'Marseille', 'France', 'Laurence Lebihan', '91.24.45.40', 'laurence@bonapp.com', '1996-08-15'),
('Bottom-Dollar Markets', 'Bottom-Dollar Markets LLC', 'Tsawassen', 'Canada', 'Elizabeth Lincoln', '(604) 555-4729', 'elizabeth@bottomdollar.com', '1996-09-20');

-- Insert Products
INSERT INTO Products (ProductName, CategoryID, SupplierID, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued) VALUES
('Chai', 1, 1, 18.00, 39, 0, 10, FALSE),
('Chang', 1, 1, 19.00, 17, 40, 25, FALSE),
('Aniseed Syrup', 2, 1, 10.00, 13, 70, 25, FALSE),
('Chef Antons Cajun Seasoning', 2, 2, 22.00, 53, 0, 0, FALSE),
('Chef Antons Gumbo Mix', 2, 2, 21.35, 0, 0, 0, TRUE),
('Grandmas Boysenberry Spread', 2, 3, 25.00, 120, 0, 25, FALSE),
('Uncle Bobs Organic Dried Pears', 6, 3, 30.00, 15, 0, 10, FALSE),
('Northwoods Cranberry Sauce', 2, 3, 40.00, 6, 0, 0, FALSE),
('Mishi Kobe Niku', 5, 4, 97.00, 29, 0, 0, FALSE),
('Ikura', 7, 4, 31.00, 31, 0, 0, FALSE),
('Queso Cabrales', 3, 5, 21.00, 22, 30, 30, FALSE),
('Queso Manchego La Pastora', 3, 5, 38.00, 86, 0, 0, FALSE),
('Konbu', 7, 6, 6.00, 24, 0, 5, FALSE),
('Tofu', 6, 6, 23.25, 35, 0, 0, FALSE),
('Genen Shouyu', 2, 6, 15.50, 39, 0, 5, FALSE),
('Pavlova', 8, 7, 17.45, 29, 0, 10, FALSE),
('Alice Mutton', 5, 7, 39.00, 0, 0, 0, TRUE),
('Carnarvon Tigers', 7, 7, 62.50, 42, 0, 0, FALSE),
('Teatime Chocolate Biscuits', 8, 8, 9.20, 25, 0, 5, FALSE),
('Sir Rodneys Marmalade', 8, 8, 81.00, 40, 0, 0, FALSE);

-- Insert Orders
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry) VALUES
(1, 5, '1996-07-04', '1996-08-01', '1996-07-16', 'Speedy Express', 32.38, 'Vins et alcools Chevalier', '59 rue de lAbbaye', 'Reims', NULL, '51100', 'France'),
(2, 6, '1996-07-05', '1996-08-16', '1996-07-10', 'United Package', 11.61, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
(3, 4, '1996-07-08', '1996-08-05', '1996-07-12', 'Speedy Express', 65.83, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(4, 3, '1996-07-08', '1996-08-05', '1996-07-15', 'United Package', 41.34, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
(5, 4, '1996-07-09', '1996-08-06', '1996-07-11', 'Speedy Express', 51.30, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
(6, 3, '1996-07-10', '1996-08-07', '1996-07-16', 'United Package', 58.17, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(1, 5, '1996-07-11', '1996-08-08', '1996-07-23', 'Speedy Express', 22.98, 'Vins et alcools Chevalier', '59 rue de lAbbaye', 'Reims', NULL, '51100', 'France'),
(2, 1, '1996-07-12', '1996-08-09', '1996-07-15', 'United Package', 148.33, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
(7, 2, '1996-07-15', '1996-08-12', '1996-07-17', 'Speedy Express', 13.97, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(8, 4, '1996-12-31', '1997-01-28', '1997-01-05', 'United Package', 81.91, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(9, 6, '1997-01-01', '1997-01-29', '1997-01-04', 'Speedy Express', 140.51, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10, 3, '1997-01-02', '1997-01-30', '1997-01-09', 'United Package', 3.25, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
(1, 4, '1998-05-06', '1998-06-03', NULL, 'Speedy Express', 12.75, 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
(2, 1, '1998-05-07', '1998-06-04', NULL, 'United Package', 89.16, 'Ana Trujillo Emparedados', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico'),
(3, 2, '1998-05-08', '1998-06-05', NULL, 'Speedy Express', 29.83, 'Antonio Moreno Taquería', 'Mataderos 2312', 'México D.F.', NULL, '05023', 'Mexico');

-- Insert Order Details
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
(1, 11, 14.00, 12, 0.00),
(1, 42, 9.80, 10, 0.00),
(1, 72, 34.80, 5, 0.00),
(2, 14, 18.60, 9, 0.00),
(2, 51, 42.40, 40, 0.00),
(3, 41, 7.70, 10, 0.00),
(3, 51, 42.40, 35, 0.15),
(3, 65, 16.80, 15, 0.15),
(4, 22, 16.80, 6, 0.00),
(4, 57, 15.60, 15, 0.00),
(4, 65, 16.80, 20, 0.00),
(5, 20, 64.80, 40, 0.05),
(5, 33, 2.00, 25, 0.05),
(5, 60, 27.20, 40, 0.05),
(6, 31, 10.00, 20, 0.10),
(6, 32, 25.60, 15, 0.10),
(6, 36, 15.20, 16, 0.10),
(7, 10, 24.80, 50, 0.00),
(7, 64, 26.60, 15, 0.00),
(7, 75, 6.20, 10, 0.00),
(8, 17, 31.20, 30, 0.00),
(8, 70, 12.00, 20, 0.00),
(9, 12, 30.40, 25, 0.05),
(9, 40, 14.70, 40, 0.05),
(10, 21, 8.00, 20, 0.00),
(10, 61, 22.80, 18, 0.00),
(11, 28, 36.40, 15, 0.00),
(11, 44, 15.50, 100, 0.05),
(12, 48, 10.20, 15, 0.00),
(12, 70, 12.00, 25, 0.00),
(13, 16, 13.90, 10, 0.00),
(13, 62, 39.40, 10, 0.00),
(13, 76, 14.40, 20, 0.00),
(14, 19, 7.30, 12, 0.00),
(14, 33, 2.00, 40, 0.00),
(15, 17, 31.20, 12, 0.00),
(15, 75, 6.20, 12, 0.00);
