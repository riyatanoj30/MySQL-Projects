DELIMITER $$

CREATE PROCEDURE populate_date_dimension(IN input_date DATE)
BEGIN
  DECLARE start_date DATE;
  DECLARE end_date DATE;

  -- Define year boundaries
  SET start_date = MAKEDATE(YEAR(input_date), 1);
  SET end_date = MAKEDATE(YEAR(input_date) + 1, 1) - INTERVAL 1 DAY;

  -- Insert all attributes for every date in the year using a single INSERT + SELECT + recursive CTE
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
    WEEKDAY(d) + 1 AS DayNumberOfWeek, -- Monday=1, Sunday=7
    DAYOFYEAR(d) AS DayNumberOfYear,
    CONCAT(DAY(d), CASE
                    WHEN DAY(d) IN (1, 21, 31) THEN 'st'
                    WHEN DAY(d) IN (2, 22) THEN 'nd'
                    WHEN DAY(d) IN (3, 23) THEN 'rd'
                    ELSE 'th'
                  END) AS DaySuffix,
    WEEK(d, 3) + 1 AS FiscalWeek, -- Assuming Fiscal Week starts from Jan 1
    MONTH(d) AS FiscalPeriod,
    QUARTER(d) AS FiscalQuarter,
    YEAR(d) AS FiscalYear,
    CONCAT(YEAR(d), LPAD(MONTH(d), 2, '0')) AS FiscalYearPeriod
  FROM date_series;

END$$

DELIMITER ;
