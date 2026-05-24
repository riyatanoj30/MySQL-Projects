-- =====================================================
-- LEVEL B TASK - VIEWS
-- =====================================================

USE levelb_task;

-- Drop existing views if they exist
DROP VIEW IF EXISTS vwCustomerOrders;
DROP VIEW IF EXISTS vwActiveCustomers;
DROP VIEW IF EXISTS MyProducts;

-- 1. vwCustomerOrders View
CREATE VIEW vwCustomerOrders AS
SELECT 
    u.id AS CustomerID,
    CONCAT(u.first_name, ' ', u.last_name) AS CompanyName,
    o.id AS OrderID,
    o.order_number AS OrderNumber,
    o.total_amount AS OrderTotal,
    o.order_status AS OrderStatus,
    o.created_at AS OrderDate
FROM users u
JOIN orders o ON u.id = o.user_id;

-- 2. vwActiveCustomers View
CREATE VIEW vwActiveCustomers AS
SELECT DISTINCT
    u.id AS CustomerID,
    CONCAT(u.first_name, ' ', u.last_name) AS CompanyName,
    u.email AS Email,
    u.phone AS Phone,
    COUNT(o.id) AS TotalOrders,
    SUM(o.total_amount) AS TotalSpent
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.first_name, u.last_name, u.email, u.phone;

-- 3. MyProducts View
CREATE VIEW MyProducts AS
SELECT 
    p.id AS ProductID,
    p.name AS ProductName,
    p.price AS UnitPrice,
    c.name AS CategoryName,
    p.stock_quantity AS UnitsInStock,
    CASE 
        WHEN p.stock_quantity <= p.min_stock_level THEN 'Low Stock'
        WHEN p.stock_quantity >= p.max_stock_level THEN 'Overstocked'
        ELSE 'Normal'
    END AS StockStatus
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
WHERE p.status = 'active';

-- Display confirmation
SELECT 'All views created successfully!' as Status;

-- Show views
SELECT TABLE_NAME FROM information_schema.VIEWS WHERE TABLE_SCHEMA = 'levelb_task';

-- Test the views
SELECT * FROM vwCustomerOrders LIMIT 3;
SELECT * FROM vwActiveCustomers;
SELECT * FROM MyProducts;