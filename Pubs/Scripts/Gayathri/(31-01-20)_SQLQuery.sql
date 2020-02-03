--Query using CTE--

USE dbsql

CREATE TABLE SchoolDatabase
(
  StaffID int NOT NULL PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  ReportingStaffs INT NULL
)

INSERT INTO SchoolDatabase VALUES (1, 'Madhu', 'Lakshmi', NULL)
INSERT INTO SchoolDatabase VALUES (2, 'Srinivasan', 'Shanmugam', 1)
INSERT INTO SchoolDatabase VALUES (3, 'Suriya', 'Karnan', 1)
INSERT INTO SchoolDatabase VALUES (4, 'Bharath', 'Kumar', 2)
INSERT INTO SchoolDatabase VALUES (5, 'Partha', 'Sarathy', 2);


INSERT INTO SchoolDatabase (StaffID, FirstName, LastName, ReportingStaffs)
SELECT 1, 'Madhu', 'Lakshmi', NULL UNION ALL
SELECT 2, 'Srinivasan', 'Shanmugam', 1 UNION ALL
SELECT 3, 'Suriya', 'Karnan', 1 UNION ALL
SELECT 4, 'Bharath', 'Kumar', 2 UNION ALL
SELECT 5, 'Partha', 'Sarathy', 2;

WITH
  Reports (StaffID, FirstName, LastName, RepStaffID, StaffLevel)
  AS
  (
    SELECT StaffID, FirstName, LastName, ReportingStaffs, 1
    FROM SchoolDatabase
    WHERE ReportingStaffs IS NULL
    UNION ALL
    SELECT s.StaffID, s.FirstName, s.LastName, s.ReportingStaffs, 
      r.StaffLevel + 1
    FROM SchoolDatabase s
      INNER JOIN Reports r
        ON s.ReportingStaffs = r.StaffID
  )
SELECT
  CONCAT(FirstName, ' ', LastName) AS Staffs, 
  StaffLevel,
  (SELECT FirstName + ' ' + LastName FROM SchoolDatabase 
    WHERE StaffID = Reports.RepStaffID) AS ReportingStaffs
FROM Reports 
ORDER BY StaffLevel, ReportingStaffs 

--Window Functions--

CREATE TABLE #Duplicates(Numbers INT, Alphabets CHAR(1));
INSERT INTO #Duplicates(Numbers, Alphabets) 
VALUES(1,'A'),(8,'B'),(2,'B'),(2,'B'),
	(6,'C'),(4,'D'),(4,'D'),(5,'E'),(8,'D'),
	(5,'E'),(9,'E'),(6,'A');
SELECT * FROM #Duplicates

SELECT Numbers, Alphabets, 
   ROW_NUMBER() OVER(PARTITION BY Numbers, Alphabets ORDER BY Alphabets) AS RowNum
FROM #Duplicates;

WITH Dupes AS (
   SELECT Numbers, Alphabets, 
     ROW_NUMBER() OVER(PARTITION BY Numbers, Alphabets ORDER BY Alphabets) AS RowNum
   FROM #Duplicates)
DELETE Dupes 
WHERE RowNum < 1;
SELECT * FROM #Duplicates;