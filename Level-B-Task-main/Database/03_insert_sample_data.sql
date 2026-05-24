-- =====================================================
-- LEVEL B TASK - SAMPLE DATA INSERTION
-- =====================================================

USE levelb_task;

-- Insert Categories
INSERT INTO categories (name, description) VALUES 
('Electronics', 'Electronic devices and gadgets'),
('Clothing', 'Apparel and fashion items'),
('Books', 'Books and educational materials'),
('Home & Garden', 'Home improvement and garden items'),
('Sports', 'Sports equipment and accessories');

-- Insert Users
INSERT INTO users (username, email, password, first_name, last_name, phone, date_of_birth, gender) VALUES 
('john_doe', 'john@example.com', 'hashed_password_1', 'John', 'Doe', '1234567890', '1990-05-15', 'M'),
('jane_smith', 'jane@example.com', 'hashed_password_2', 'Jane', 'Smith', '0987654321', '1985-08-20', 'F'),
('bob_wilson', 'bob@example.com', 'hashed_password_3', 'Bob', 'Wilson', '5551234567', '1992-12-10', 'M'),
('alice_brown', 'alice@example.com', 'hashed_password_4', 'Alice', 'Brown', '5559876543', '1988-03-25', 'F'),
('admin_user', 'admin@example.com', 'admin_password', 'Admin', 'User', '1111111111', '1980-01-01', 'M');

-- Insert Products
INSERT INTO products (name, description, price, cost_price, category_id, brand, sku, stock_quantity) VALUES 
('Smartphone X1', 'Latest smartphone with advanced features', 699.99, 450.00, 1, 'TechBrand', 'PHONE-X1-001', 50),
('Laptop Pro 15', 'High-performance laptop for professionals', 1299.99, 900.00, 1, 'CompuBrand', 'LAPTOP-PRO-15', 25),
('Cotton T-Shirt', 'Comfortable cotton t-shirt', 19.99, 8.00, 2, 'FashionCorp', 'TSHIRT-COT-001', 100),
('Programming Book', 'Learn advanced programming concepts', 49.99, 25.00, 3, 'EduPublish', 'BOOK-PROG-001', 75),
('Garden Hose', '50ft flexible garden hose', 29.99, 15.00, 4, 'GardenTools', 'HOSE-50FT-001', 40);

-- Insert Orders
INSERT INTO orders (user_id, order_number, total_amount, tax_amount, shipping_amount, payment_status, order_status, shipping_address) VALUES 
(1, 'ORD-2024-001', 719.98, 57.60, 12.99, 'paid', 'delivered', '123 Main St, City, State 12345'),
(2, 'ORD-2024-002', 1319.98, 105.60, 19.99, 'paid', 'shipped', '456 Oak Ave, City, State 67890'),
(3, 'ORD-2024-003', 79.97, 6.40, 9.99, 'pending', 'processing', '789 Pine Rd, City, State 13579'),
(4, 'ORD-2024-004', 49.99, 4.00, 5.99, 'paid', 'delivered', '321 Elm St, City, State 24680');

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES 
(1, 1, 1, 699.99, 699.99),
(1, 3, 1, 19.99, 19.99),
(2, 2, 1, 1299.99, 1299.99),
(2, 3, 1, 19.99, 19.99),
(3, 3, 2, 19.99, 39.98),
(3, 4, 1, 49.99, 49.99),
(4, 4, 1, 49.99, 49.99);

-- Display confirmation
SELECT 'Sample data inserted successfully!' as Status;

-- Show data counts
SELECT 'Users' as TableName, COUNT(*) as RecordCount FROM users
UNION ALL
SELECT 'Categories', COUNT(*) FROM categories
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'Order Items', COUNT(*) FROM order_items;