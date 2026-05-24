-- =====================================================
-- LEVEL B TASK - DATABASE SETUP
-- =====================================================

-- Create database
CREATE DATABASE IF NOT EXISTS levelb_task;
USE levelb_task;

-- Create user (optional)
CREATE USER IF NOT EXISTS 'levelb_user'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON levelb_task.* TO 'levelb_user'@'localhost';
FLUSH PRIVILEGES;

-- Display confirmation
SELECT 'Database levelb_task created successfully!' as Status;