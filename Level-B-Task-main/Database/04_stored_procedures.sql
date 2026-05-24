-- =====================================================
-- LEVEL B TASK - STORED PROCEDURES
-- =====================================================

USE levelb_task;

-- Drop existing procedures if they exist
DROP PROCEDURE IF EXISTS CheckUnitPriceExists;
DROP PROCEDURE IF EXISTS UpdateProductQuantity;
DROP PROCEDURE IF EXISTS UpdateUnitPriceWithNullCheck;
DROP PROCEDURE IF EXISTS GetOrderDetails;
DROP PROCEDURE IF EXISTS DeleteOrderDetails;

-- 1. CheckUnitPriceExists Procedure
DELIMITER //
CREATE PROCEDURE CheckUnitPriceExists(
    IN input_unit_price DECIMAL(10,2),
    OUT price_exists BOOLEAN
)
BEGIN
    DECLARE price_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO price_count 
    FROM products 
    WHERE price = input_unit_price;
    
    IF price_count > 0 THEN
        SET price_exists = TRUE;
    ELSE
        SET price_exists = FALSE;
    END IF;
END //
DELIMITER ;

-- 2. UpdateProductQuantity Procedure
DELIMITER //
CREATE PROCEDURE UpdateProductQuantity(
    IN product_id INT,
    IN new_quantity INT
)
BEGIN
    DECLARE current_qty INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Get current quantity
    SELECT stock_quantity INTO current_qty 
    FROM products 
    WHERE id = product_id;
    
    -- Update quantity
    UPDATE products 
    SET stock_quantity = new_quantity,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = product_id;
    
    -- Log the inventory change
    INSERT INTO inventory_logs (product_id, change_type, quantity_change, previous_quantity, new_quantity, reason)
    VALUES (product_id, 'adjustment', (new_quantity - current_qty), current_qty, new_quantity, 'Manual quantity update');
    
    COMMIT;
END //
DELIMITER ;

-- 3. UpdateUnitPriceWithNullCheck Procedure
DELIMITER //
CREATE PROCEDURE UpdateUnitPriceWithNullCheck(
    IN product_id INT,
    IN new_price DECIMAL(10,2)
)
BEGIN
    DECLARE current_price DECIMAL(10,2);
    
    -- Check if new_price is NULL
    IF new_price IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unit price cannot be NULL';
    END IF;
    
    -- Get current price
    SELECT price INTO current_price FROM products WHERE id = product_id;
    
    -- Update price
    UPDATE products 
    SET price = new_price, updated_at = CURRENT_TIMESTAMP 
    WHERE id = product_id;
    
    SELECT CONCAT('Price updated from ', IFNULL(current_price, 'NULL'), ' to ', new_price) AS result;
END //
DELIMITER ;

-- 4. GetOrderDetails Procedure
DELIMITER //
CREATE PROCEDURE GetOrderDetails(IN order_id INT)
BEGIN
    SELECT 
        o.id AS OrderID,
        o.order_number AS OrderNumber,
        o.total_amount AS TotalAmount,
        u.first_name AS CustomerFirstName,
        u.last_name AS CustomerLastName,
        p.name AS ProductName,
        oi.quantity AS Quantity,
        oi.unit_price AS UnitPrice,
        oi.total_price AS LineTotal
    FROM orders o
    JOIN users u ON o.user_id = u.id
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id
    WHERE o.id = order_id;
END //
DELIMITER ;

-- 5. DeleteOrderDetails Procedure
DELIMITER //
CREATE PROCEDURE DeleteOrderDetails(
    IN order_id INT,
    IN product_id INT
)
BEGIN
    DECLARE order_exists INT DEFAULT 0;
    DECLARE item_exists INT DEFAULT 0;
    
    -- Check if order exists
    SELECT COUNT(*) INTO order_exists FROM orders WHERE id = order_id;
    
    -- Check if order item exists
    SELECT COUNT(*) INTO item_exists 
    FROM order_items 
    WHERE order_id = order_id AND product_id = product_id;
    
    IF order_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order not found';
    ELSEIF item_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order item not found';
    ELSE
        DELETE FROM order_items 
        WHERE order_id = order_id AND product_id = product_id;
        
        -- Update order total
        UPDATE orders o
        SET total_amount = (
            SELECT IFNULL(SUM(total_price), 0) 
            FROM order_items oi 
            WHERE oi.order_id = o.id
        )
        WHERE o.id = order_id;
        
        SELECT 'Order item deleted successfully' AS result;
    END IF;
END //
DELIMITER ;

-- Display confirmation
SELECT 'All stored procedures created successfully!' as Status;
SHOW PROCEDURE STATUS WHERE Db = 'levelb_task';