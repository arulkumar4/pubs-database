--Teachers Table for 10th_StudentDetails--

CREATE TABLE [10th_StudentDetails].[Teachers]
(
StudentID INT,
TeachersName VARCHAR(MAX),
City VARCHAR(100),
TeachersID VARCHAR(MAX)
)
DROP TABLE [10th_StudentDetails].[Teachers]
INSERT INTO [10th_StudentDetails].[Teachers]
	([StudentID],[TeachersName],[City],[TeachersID]) 
	SELECT '1001','Vaishali','Chennai','101' UNION ALL
	SELECT '1002','Lashmi','Vellore','102'UNION ALL
	SELECT '1003','Gandhi Raj','Madurai','103' UNION ALL
	SELECT '1004','Ramalingam','Covai','104' UNION ALL
	SELECT '1005','Padhmadevi','Chennai','105' UNION ALL
	SELECT '1006','Banumathi','Trichi','106' UNION ALL
	SELECT '1008','Ramamani','Chennai','107' UNION ALL
	SELECT '1009','Suresh','Salem','108'
	
--Store Procedure to get students who doesnot have Teachers

ALTER PROCEDURE [10th_StudentDetails].[StudentsNotAssignedTeachers]
AS
BEGIN
	SELECT s.StudentID,s.StudentName,t.TeachersID
	FROM [10th_StudentDetails].[Students_Score] s 
	LEFT JOIN [10th_StudentDetails].[Teachers] t
	ON s.StudentID=t.StudentID
	WHERE t.TeachersID is NULL
END

--Executing SP StudentsNotAssignedTeachers
EXEC [10th_StudentDetails].[StudentsNotAssignedTeachers]

--SP to Update Students Who have Total Marks greater than 900
--As Teachers Not Assigned
ALTER PROCEDURE [10th_StudentDetails].[UpdateTeachersNotAssigned]
AS
 BEGIN
	UPDATE [10th_StudentDetails].[Teachers] 
	SET TeachersID='NOT ASSIGNED'
	FROM [10th_StudentDetails].[Students_Score] s
		 JOIN [10th_StudentDetails].[Teachers] t
		 ON s.StudentID=t.StudentID
	WHERE TotalMarks>'900'
 END

 --EXECUTING UpdateTeachersNotAssigned
EXEC [10th_StudentDetails].[UpdateTeachersNotAssigned]

--Possible Combination of Teachers From Chennai--
--And Both EmpID Must Not Be Same-- 

CREATE TABLE Employee
(
EmpID INT IDENTITY(1,1),
Name NVARCHAR(MAX),
City NVARCHAR(MAX),
)
INSERT INTO Employee([Name],[City]) 
SELECT 'Ram','Chennai' UNION ALL
SELECT 'Charan','Vellore' UNION ALL
SELECT 'Mani','Salem' UNION ALL
SELECT 'Karthik','Chennai' 


SELECT a.EmpID,e.EmpID,a.City 
	   FROM Employee e
	   CROSS JOIN Employee a
	   WHERE a.City='Chennai'
	   AND e.EmpID!=a.EmpID
	
	
SELECT * FROM Employee
SELECT*FROM [10th_StudentDetails].[Teachers] 
SELECT*FROM [10th_StudentDetails].[Students_Score]
