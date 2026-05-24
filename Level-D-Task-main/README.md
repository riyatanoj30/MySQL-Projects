# 📅 Date Dimension Generator – Stored Procedure (Level D Task)

This repository contains a SQL **Stored Procedure** that dynamically populates a **date dimension table** with rich calendar and fiscal attributes for an entire year, based on a single input date.

---

## 🧠 Objective

Given a date like `2020-07-14`, the stored procedure will:
- Determine the **year** from the input
- Generate rows for **each day of that year**
- Populate important **date attributes**
- Use only **one INSERT statement** (as per constraint)

---

## 📥 Input Parameter

| Parameter     | Type | Description                           |
|---------------|------|---------------------------------------|
| `input_date`  | DATE | Any valid date within the target year |

---

## 📤 Output

A populated `date_dimension` table with columns like:
- `CalendarDay`, `CalendarMonth`, `CalendarQuarter`, `CalendarYear`
- `DayNameLong`, `DayNameShort`, `DayNumberOfWeek`, `DayNumberOfYear`, `DaySuffix`
- `FiscalWeek`, `FiscalPeriod`, `FiscalQuarter`, `FiscalYear`, `FiscalYearPeriod`

---

## 🛠 How to Use

### 1. 📂 Create the Table

sql
`CREATE TABLE date_dimension (`
`  Date DATE PRIMARY KEY,`
`  CalendarDay INT,`
`  CalendarMonth INT,`
`  CalendarQuarter INT,`
`  CalendarYear INT,`
`  DayNameLong VARCHAR(10),`
`  DayNameShort VARCHAR(3),`
`  DayNumberOfWeek INT,`
`  DayNumberOfYear INT,`
`  DaySuffix VARCHAR(5),`
`  FiscalWeek INT,`
`  FiscalPeriod INT,`
`  FiscalQuarter INT,`
`  FiscalYear INT,`
`  FiscalYearPeriod VARCHAR(6)`
`);`



#⚙️ Create the Stored Procedure
```DELIMITER $$

CREATE PROCEDURE populate_date_dimension(IN input_date DATE)
BEGIN
  DECLARE start_date DATE;
  DECLARE end_date DATE;

  SET start_date = MAKEDATE(YEAR(input_date), 1);
  SET end_date = MAKEDATE(YEAR(input_date) + 1, 1) - INTERVAL 1 DAY;

  WITH RECURSIVE date_series AS (
    SELECT start_date AS d
    UNION ALL
    SELECT d + INTERVAL 1 DAY FROM date_series WHERE d + INTERVAL 1 DAY <= end_date
  )
  INSERT INTO date_dimension (
    Date,
    CalendarDay,
    CalendarMonth,
    CalendarQuarter,
    CalendarYear,
    DayNameLong,
    DayNameShort,
    DayNumberOfWeek,
    DayNumberOfYear,
    DaySuffix,
    FiscalWeek,
    FiscalPeriod,
    FiscalQuarter,
    FiscalYear,
    FiscalYearPeriod
  )
  SELECT
    d AS Date,
    DAY(d) AS CalendarDay,
    MONTH(d) AS CalendarMonth,
    QUARTER(d) AS CalendarQuarter,
    YEAR(d) AS CalendarYear,
    DAYNAME(d) AS DayNameLong,
    LEFT(DAYNAME(d), 3) AS DayNameShort,
    WEEKDAY(d) + 1 AS DayNumberOfWeek,
    DAYOFYEAR(d) AS DayNumberOfYear,
    CONCAT(DAY(d), CASE
                    WHEN DAY(d) IN (1, 21, 31) THEN 'st'
                    WHEN DAY(d) IN (2, 22) THEN 'nd'
                    WHEN DAY(d) IN (3, 23) THEN 'rd'
                    ELSE 'th'
                  END) AS DaySuffix,
    WEEK(d, 3) + 1 AS FiscalWeek,
    MONTH(d) AS FiscalPeriod,
    QUARTER(d) AS FiscalQuarter,
    YEAR(d) AS FiscalYear,
    CONCAT(YEAR(d), LPAD(MONTH(d), 2, '0')) AS FiscalYearPeriod
  FROM date_series;

END$$

DELIMITER ;
```

# 🧪 Run It
`CALL populate_date_dimension('2020-07-14');`
✅ This will populate the date_dimension table for the entire year 2020.


#✅ Features
📅 Full year generation from any valid date
🧮 Custom day suffix logic (1st, 2nd, 3rd, etc.)
🧾 Single INSERT via recursive CTE (no multiple inserts)
🗓️ Useful in Data Warehousing for building date/time dimensions

#🧪 Example
`CALL populate_date_dimension('2023-01-01');`
Will insert 365 or 366 rows into the date_dimension table for year 2023.

#🔧 Tech Stack
SQL (MySQL 8+ with Recursive CTE)
Compatible with most RDBMS with minor syntax changes

#📃 License
This project is licensed under the MIT License.

#👤 Author
Riya Tanoj
💬 Feel free to fork the repo or raise issues for improvements.
