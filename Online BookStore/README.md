# 📚 Online Bookstore Database
This project simulates an Online Bookstore Management System using SQL and CSV datasets.
It demonstrates database creation, data import, and data analysis queries using PostgreSQL.

## 📁 Project Structure
Online_Bookstore/
│
├── Books.csv
├── Customers.csv
├── Orders.csv
└── Online_Bookstore.sql

## 🧩 Files Description
File	Description
Books.csv	Contains book details such as title, author, genre, price, stock, and published year.
Customers.csv	Contains customer information including name, email, phone, city, and country.
Orders.csv	Contains order transaction details linking customers and books, along with order date, quantity, and total amount.
Online_Bookstore.sql	SQL script that creates the database, imports data from CSV files, and runs multiple analytical queries.

## ⚙️ Database Setup
1. Create and Connect to Database
CREATE DATABASE OnlineBookstore;
\c OnlineBookstore;
2. Create Tables
The script defines three main tables:
    - Books
    - Customers
    - Orders (linked to both Books and Customers via foreign keys)
Each table includes proper data types, constraints, and primary keys.

## 📤 Data Import
After table creation, load data from the provided CSV files:

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:\\Course Updates\\30 Day Series\\SQL\\CSV\\Books.csv'
CSV HEADER;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'D:\\Course Updates\\30 Day Series\\SQL\\CSV\\Customers.csv'
CSV HEADER;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'D:\\Course Updates\\30 Day Series\\SQL\\CSV\\Orders.csv'
CSV HEADER;

⚠️ Note:
Update the file paths according to your local directory before running these commands.
Example (Linux/macOS):
/home/user/Online_Bookstore/Books.csv

## 🔍 Query Overview
The script includes 15+ queries, divided into two sections:

📘 Basic Queries
Query	Purpose
1	Books by genre = 'Fiction'	Filter books by genre
2	Books published after 1950	Apply date-based condition
3	Customers from Canada	Geographic filter
4	Orders in Nov 2023	Date range filter
5	Total stock of all books	Aggregate using SUM()
6	Most expensive book	Sorting + LIMIT 1
7	Orders with quantity > 1	Conditional filtering
8	Orders > $20	Conditional filtering
9	Distinct genres	Use of DISTINCT
10	Book with lowest stock	Identify low inventory
11	Total revenue	Aggregate total sales

🚀 Advanced Analytical Queries
Query	Insight
1	Total books sold per genre	JOIN + GROUP BY
2	Average price of Fantasy books	AVG()
3	Customers with ≥2 orders	HAVING COUNT()
4	Most frequently ordered book	Find top-selling title
5	Top 3 most expensive Fantasy books	ORDER BY + LIMIT
6	Total quantity sold per author	Author-level aggregation
7	Cities of customers spending > $30	Join filter by total amount
8	Customer with highest spending	Top spender analysis
9	Remaining stock after sales	Stock vs sold quantity

## 🧠 Concepts Demonstrated
Database normalization & relationships (1-to-many)
Use of JOIN, GROUP BY, HAVING, and aggregate functions
Query optimization via filtering and ordering
Handling CSV imports using PostgreSQL COPY command

## 🧪 Recommended Tools
PostgreSQL ≥ 13
pgAdmin (optional GUI)
Text editor: VS Code / Sublime / Notepad++
CSV viewer: Excel / Google Sheets

## ✅ Expected Output Examples
Example: Retrieve all Fiction books
SELECT * FROM Books WHERE Genre = 'Fiction';

Example: Total revenue
SELECT SUM(Total_Amount) AS Revenue FROM Orders;

Example: Remaining stock after fulfilling all orders
SELECT 
    b.Book_ID, b.Title, b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Ordered,
    b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID
ORDER BY b.Book_ID;

## 📄 Author & Usage
- Author: Riya Mhatre
- Purpose: Academic/learning project demonstrating relational database design, SQL querying, and analytics.
- License: Free for educational use.