-- =============================================================================
-- SCHEMA.SQL
-- E-Commerce Database Schema Creation Script
-- =============================================================================

-- Create the database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- =============================================================================
-- TABLE: Customers
-- =============================================================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    CompanyName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50),
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    RegistrationDate DATE
);

-- =============================================================================
-- TABLE: Employees
-- =============================================================================
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Title VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- =============================================================================
-- TABLE: Suppliers
-- =============================================================================
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL,
    CompanyName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50),
    ContactName VARCHAR(100),
    Phone VARCHAR(20)
);

-- =============================================================================
-- TABLE: Categories
-- =============================================================================
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL,
    Description TEXT
);

-- =============================================================================
-- TABLE: Products
-- =============================================================================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    SupplierID INT,
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- =============================================================================
-- TABLE: Orders
-- =============================================================================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia VARCHAR(50),
    Freight DECIMAL(10,2),
    ShipName VARCHAR(100),
    ShipAddress VARCHAR(200),
    ShipCity VARCHAR(50),
    ShipRegion VARCHAR(50),
    ShipPostalCode VARCHAR(20),
    ShipCountry VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- =============================================================================
-- TABLE: OrderDetails
-- =============================================================================
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(4,2) DEFAULT 0.00,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- =============================================================================
-- END OF SCHEMA
-- =============================================================================
