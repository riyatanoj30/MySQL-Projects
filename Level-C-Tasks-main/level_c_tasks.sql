CREATE DATABASE Company;

USE Company;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT
);

INSERT INTO employees (id, name, department, salary, hire_date, manager_id) VALUES
(1, 'Alice', 'HR', 60000, '2023-01-10', NULL),
(2, 'Bob', 'Sales', 55000, '2023-02-15', 1),
(3, 'Charlie', 'Sales', 52000, '2023-03-12', 1),
(4, 'David', 'Engineering', 75000, '2023-01-25', NULL),
(5, 'Eva', 'Engineering', 72000, '2023-04-01', 4),
(6, 'Frank', 'Interns', 30000, '2023-05-01', 2),
(7, 'Grace', 'HR', 65000, '2023-06-20', 1),
(8, 'Hannah', 'Sales', 58000, '2023-07-05', 2),
(9, 'Ivy', 'Interns', 31000, '2023-08-10', 3),
(10, 'Jack', 'Engineering', 70000, '2023-09-15', 4);

-- Task 1: Display all employees 
SELECT * FROM employees;

-- Task 2: Display employee names and salaries
SELECT name, salary FROM employees;

-- Task 3: Display distinct department names
SELECT DISTINCT department FROM employees;

-- Task 4: Display employees earning salary more than 50000
SELECT * FROM employees
WHERE salary > 50000;

-- Task 5: Sort employees by name in ascending order
SELECT * FROM employees
ORDER BY name ASC;

-- Task 6: Count number of employees in each department
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

-- Task 7: Display average salary of employees
SELECT AVG(salary) AS avg_salary
FROM employees;

-- Task 8: Display employee with the highest salary
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 1;

-- Task 9: Display employee names starting with 'A'
SELECT * FROM employees
WHERE name LIKE 'A%';

-- Task 10: Display employees hired between two dates
SELECT * FROM employees
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Task 11: Display employees with NULL manager ID
SELECT * FROM employees
WHERE manager_id IS NULL;

-- Task 12: Increase salary of employees in HR by 10%
UPDATE employees
SET salary = salary * 1.10
WHERE department = 'HR';

-- Task 13: Delete employees from 'Interns' department
DELETE FROM employees
WHERE department = 'Interns';

-- Task 14: Add a new column 'bonus' to the employees table
ALTER TABLE employees
ADD COLUMN bonus DECIMAL(10,2);

-- Task 15: Set bonus as 5000 for all employees in 'Sales'
UPDATE employees
SET bonus = 5000
WHERE department = 'Sales';

-- Task 16: Display total compensation (salary + bonus)
SELECT name, salary, bonus, (salary + bonus) AS total_compensation
FROM employees;

-- Task 17: Display top 3 highest paid employees
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Task 18: Display department-wise average salary
SELECT department, AVG(salary) AS avg_dept_salary
FROM employees
GROUP BY department;

-- Task 19: Display employees and their manager names
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- Task 20: Rank employees based on salary
SELECT name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
