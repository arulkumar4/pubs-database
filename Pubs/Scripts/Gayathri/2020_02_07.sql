
--CREATING NEW TABLE--
CREATE TABLE SchoolDatabase
(
StudentID INT IDENTITY(1001,1) CONSTRAINT pk_Studid PRIMARY KEY,
StudentName VARCHAR(MAX),
STD VARCHAR(MAX),
English INT,
Tamil INT,
Maths INT,
Physics INT,
Chemistry INT,
Biology INT,
Computer INT,
TotalMarks INT
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Creating UDT--
CREATE TYPE Students_Score_Details AS TABLE  
(
StudentName VARCHAR(MAX),
STD VARCHAR(MAX),
English INT,
Tamil INT,
Maths INT,
Physics INT,
Chemistry INT,
Biology INT,
Computer INT,
TotalMarks INT
) 

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Procedure to InsertInto SchoolDatabase--
CREATE PROCEDURE InsertingIntoUDT
(@Students_Score_Details Students_Score_Details READONLY )
AS  
BEGIN  
    INSERT INTO SchoolDatabase
    SELECT * FROM @Students_Score_Details 
END  

------------------------------------------------------------------------------------------------------------------------------------------------------------

--INSERTING VALUES Into SchoolDatabase Through UDT--
DECLARE @StudentsScore Students_Score_Details
INSERT INTO SchoolDatabase
	([StudentName],[STD],[English],[Tamil],[Maths],[Physics],[Chemistry],[Biology],[Computer],[TotalMarks]) 
	SELECT 'Karthik','10th','97','84','87','76','89','93','78','690' UNION ALL
	SELECT 'Gayathri','10th','86','78','71','96','84','86','90','680' UNION ALL
	SELECT 'Sowmeya','10th','90','79','70','80','71','77','89','678' UNION ALL
	SELECT 'Arav','10th','93','76','82','78','89','90','84','580' UNION ALL
	SELECT 'Vishnu','10th','80','94','70','75','85','88','76','580' UNION ALL
	SELECT 'Mounisha','10th','91','80','71','90','74','92','86','679' UNION ALL
	SELECT 'Mounika','10th','83','85','96','86','71','93','82','678' UNION ALL
	SELECT 'Dinesh','10th','95','79','99','82','93','78','99','690' UNION ALL
	SELECT 'Sangeetha','10th','82','73','93','91','74','95','87' ,'604'UNION ALL
	SELECT 'Aakash','10th','72','97','70','85','81','91','85' ,'650'

EXEC InsertingIntoUDT @StudentsScore

SELECT * FROM SchoolDatabase

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Procedure to CRUD StudentScores Into Students_Score--
CREATE PROCEDURE [10th_StudentDetails].[CrudWithUDT]
(
@StudentID INT=0,
@StudentName VARCHAR(MAX),
@STD VARCHAR(MAX),
@English INT,
@Tamil INT,
@Maths INT,
@Physics INT,
@Chemistry INT,
@Biology INT,
@Computer INT,
@TotalMarks INT,
@Choice VARCHAR(20)
)
AS 
BEGIN
	IF @Choice='Insert'
	 BEGIN
		INSERT INTO [11th_StudentDetails].[Students_Score]
		([StudentName],[STD],[English],[Tamil],[Maths],[Physics],[Chemistry],[Biology],[Computer],[TotalMarks]) 
		VALUES(@StudentName,@STD,@English,@Tamil,@Maths,@Physics,@Chemistry,@Biology,@Computer,@TotalMarks)
	 END

	IF @Choice = 'Update'
	 BEGIN
		UPDATE [11th_StudentDetails].[Students_Score] SET
		StudentName = @StudentName,
		STD = @STD,
		English = @English,
		Tamil = @Tamil,
		Maths = @Maths,
		Physics = @Physics,
		Chemistry = @Chemistry,
		Biology = @Biology,
		Computer = @Computer,
		TotalMarks = @TotalMarks
		WHERE StudentID=@StudentID
	 END

	IF @Choice = 'Delete'
	 BEGIN
		DELETE FROM [11th_StudentDetails].[Students_Score]
		WHERE StudentID = @StudentID
	END
END

EXEC [10th_StudentDetails].[CrudWithUDT] 'Karthik','10th','97','84','87','76','89','93','78','690','Insert'
----------------------------------------------------------------------------------------------------------------------------------------------------------
--Table Creation--
CREATE TABLE EmployeeDetails
(
EmpID INT IDENTITY(1,1),
Name NVARCHAR(MAX),
City INT
)
INSERT INTO EmployeeDetails([Name],[City]) 
SELECT 'Ram','Chennai' UNION ALL
SELECT 'Charan','Vellore'UNION ALL
SELECT 'Mani','Salem' UNION ALL
SELECT 'Karthik','Chennai'

--Table Creation--
CREATE TABLE EmployeeSalary
(
EmpID INT IDENTITY(2,1),
Name NVARCHAR(MAX),
Salary INT
)
INSERT INTO EmployeeSalary([Name],[Salary]) 
SELECT 'Ram','30000' UNION ALL
SELECT 'Charan','20000'UNION ALL
SELECT 'Mani','50000' UNION ALL
SELECT 'Karthik','40000'

--Table Creation--
CREATE TABLE EmployeeExperience
(
EmpID INT IDENTITY(3,1),
Name NVARCHAR(MAX),
Experience_In_Years INT
)
INSERT INTO EmployeeExperience([Name],[Experience_In_Years]) 
SELECT 'Ram','3' UNION ALL
SELECT 'Charan','4'UNION ALL
SELECT 'Mani','7' UNION ALL
SELECT 'Karthik','2'

--Display table details--

SELECT * FROM EmployeeDetails
SELECT * FROM EmployeeSalary
SELECT * FROM EmployeeExperience
----------------------------------------------------------------------------------------------------------------------------------------------------------
--Procedure To display Table Data By getting table name--

CREATE PROCEDURE GetTableData
(
@TblName   VARCHAR(50)
) 
AS
BEGIN
    IF(EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TblName))
        BEGIN
            DECLARE @SQL NVARCHAR(MAX) = N'
            SELECT * FROM ' + @TblName
        DECLARE @parameter NVARCHAR(MAX) = N'
            @TblName   VARCHAR(50) '

        PRINT @SQL

        EXEC sp_executesql @SQL, @parameter,
            @TblName
    END
ELSE
    PRINT 'No Such Table Exists'
END

--Executing Procedure GetTableData

EXEC GetTableData 'EmployeeDetails'


