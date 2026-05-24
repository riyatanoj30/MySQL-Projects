-- =====================================================
-- LEVEL B TASK - FUNCTIONS
-- =====================================================

USE levelb_task;

-- Drop existing functions if they exist
DROP FUNCTION IF EXISTS FormatDateToDDMMYYYY;
DROP FUNCTION IF EXISTS FormatDateToMMDDYYYY;

-- 1. Function to format date as DD/MM/YYYY
DELIMITER //
CREATE FUNCTION FormatDateToDDMMYYYY(input_datetime DATETIME)
RETURNS VARCHAR(10)
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN DATE_FORMAT(input_datetime, '%d/%m/%Y');
END //
DELIMITER ;

-- 2. Function to format date as MM/DD/YYYY
DELIMITER //
CREATE FUNCTION FormatDateToMMDDYYYY(input_datetime DATETIME)
RETURNS VARCHAR(10)
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN DATE_FORMAT(input_datetime, '%m/%d/%Y');
END //
DELIMITER ;

-- Display confirmation
SELECT 'All functions created successfully!' as Status;
SHOW FUNCTION STATUS WHERE Db = 'levelb_task';

-- Test the functions
SELECT 
    NOW() as 'Current DateTime',
    FormatDateToDDMMYYYY(NOW()) as 'DD/MM/YYYY Format',
    FormatDateToMMDDYYYY(NOW()) as 'MM/DD/YYYY Format';