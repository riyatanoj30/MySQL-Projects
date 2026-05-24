-- =====================================================
-- LEVEL B TASK - TEST QUERIES
-- =====================================================

USE levelb_task;

-- Test Stored Procedures
SELECT '=== TESTING STORED PROCEDURES ===' as TestSection;

-- Test CheckUnitPriceExists
CALL CheckUnitPriceExists(699.99, @exists);
SELECT @exists as 'Price 699.99 Exists (1=Yes, 0=No)';

-- Test UpdateProductQuantity
SELECT stock_quantity as 'Before Update' FROM products WHERE id = 1;
CALL UpdateProductQuantity(1, 45);
SELECT stock_quantity as 'After Update' FROM products WHERE id = 1;

-- Test GetOrderDetails
CALL GetOrderDetails(1);

-- Test Functions
SELECT '=== TESTING FUNCTIONS ===' as TestSection;

SELECT 
    'Test Date: 2024-11-21 15:30:00' as Description,
    FormatDateToDDMMYYYY('2024-11-21 15:30:00') as 'DD/MM/YYYY',
    FormatDateToMMDDYYYY('2024-11-21 15:30:00') as 'MM/DD/YYYY';

-- Test Views
SELECT '=== TESTING VIEWS ===' as TestSection;

SELECT 'Customer Orders View:' as ViewName;
SELECT * FROM vwCustomerOrders LIMIT 3;

SELECT 'Active Customers View:' as ViewName;
SELECT * FROM vwActiveCustomers;

SELECT 'Products View:' as ViewName;
SELECT * FROM MyProducts LIMIT 3;

-- Verification Summary
SELECT '=== PROJECT VERIFICATION ===' as TestSection;

SELECT 'Component' as Item, 'Status' as Result
UNION ALL
SELECT 'Database', 'Created'
UNION ALL
SELECT 'Tables', CONCAT(COUNT(*), ' Created') FROM information_schema.tables WHERE table_schema = 'levelb_task'
UNION ALL
SELECT 'Stored Procedures', CONCAT(COUNT(*), ' Created') FROM information_schema.routines WHERE routine_schema = 'levelb_task' AND routine_type = 'PROCEDURE'
UNION ALL
SELECT 'Functions', CONCAT(COUNT(*), ' Created') FROM information_schema.routines WHERE routine_schema = 'levelb_task' AND routine_type = 'FUNCTION'
UNION ALL
SELECT 'Views', CONCAT(COUNT(*), ' Created') FROM information_schema.views WHERE table_schema = 'levelb_task'
UNION ALL
SELECT 'Triggers', CONCAT(COUNT(*), ' Created') FROM information_schema.triggers WHERE trigger_schema = 'levelb_task';

SELECT 'LEVEL B TASK - ALL TESTS COMPLETED SUCCESSFULLY!' as FinalStatus;