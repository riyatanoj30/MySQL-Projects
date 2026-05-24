-- =====================================================
-- LEVEL B TASK - TRIGGERS
-- =====================================================

USE levelb_task;

-- Drop existing triggers if they exist
DROP TRIGGER IF EXISTS PreventShippedOrderDeletion;
DROP TRIGGER IF EXISTS CheckProductAvailability;

-- 1. Trigger to prevent deletion of shipped orders
DELIMITER //
CREATE TRIGGER PreventShippedOrderDeletion
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    IF OLD.order_status IN ('shipped', 'delivered') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete shipped or delivered orders';
    END IF;
END //
DELIMITER ;

-- 2. Trigger to check product availability before order
DELIMITER //
CREATE TRIGGER CheckProductAvailability
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    DECLARE product_name VARCHAR(200);
    
    SELECT stock_quantity, name INTO available_stock, product_name
    FROM products 
    WHERE id = NEW.product_id;
    
    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = CONCAT('Insufficient stock for product: ', product_name, 
                                 '. Available: ', available_stock, ', Requested: ', NEW.quantity);
    END IF;
    
    -- Update stock quantity
    UPDATE products 
    SET stock_quantity = stock_quantity - NEW.quantity 
    WHERE id = NEW.product_id;
END //
DELIMITER ;

-- Display confirmation
SELECT 'All triggers created successfully!' as Status;

-- Show triggers
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE 
FROM information_schema.TRIGGERS 
WHERE TRIGGER_SCHEMA = 'levelb_task';