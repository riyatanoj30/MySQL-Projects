CREATE TABLE date_dimension (
  Date DATE PRIMARY KEY,
  CalendarDay INT,
  CalendarMonth INT,
  CalendarQuarter INT,
  CalendarYear INT,
  DayNameLong VARCHAR(10),
  DayNameShort VARCHAR(3),
  DayNumberOfWeek INT,
  DayNumberOfYear INT,
  DaySuffix VARCHAR(5),
  FiscalWeek INT,
  FiscalPeriod INT,
  FiscalQuarter INT,
  FiscalYear INT,
  FiscalYearPeriod VARCHAR(6)
);
