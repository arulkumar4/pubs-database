--CREATING NEW SCHEMA--

CREATE SCHEMA [10th_StudentDetails]
GO
--CREATING NEW TABLE--

CREATE TABLE [10th_StudentDetails].[Students_Score]
(
StudentID INT IDENTITY(1001,1) CONSTRAINT pk_Sid PRIMARY KEY,
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
--INSERTING VALUES INTO THE TABLE--

	INSERT INTO [10th_StudentDetails].[Students_Score]
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

--INLINE TABLE VALUED FUCTION EXAMPLE--
CREATE FUNCTION [10th_StudentDetails].[StudentMathsMark] 
(
@Mark INT
)
RETURNS TABLE  
WITH SCHEMABINDING 
AS  
RETURN(
  SELECT StudentID,StudentName,Maths  
  FROM [10th_StudentDetails].[Students_Score] 
  WHERE Maths >=@Mark );   
  
--EXECUTING FUNCTION--
SELECT * FROM [10th_StudentDetails].[StudentMathsMark]('80')

--MULTI-STATEMENT TABLE VALUED FUNCTION--
CREATE FUNCTION [10th_StudentDetails].[StudentsList]
(
@StudentID VARCHAR(50),
@DOB Date
)
RETURNS @10thSTD Table 
(
StudentID INT ,
DOB DATE,
Age INT,
Eligibility VARCHAR(50)
)
AS
BEGIN
	DECLARE @Dateofbirth DATE
	DECLARE @CurrentDate DATE
	DECLARE @Age INT
	SET @Dateofbirth=@DOB
	SET @CurrentDate  = GETDATE() --Current Datetime  
	SET @Age = datediff(year,@Dateofbirth,@CurrentDate)  
	--select @Age + ' years,' AS Age  
	IF(@Age>=15)
		BEGIN
			INSERT INTO @10thSTD([StudentID],[DOB],[Age],[Eligibility])
			VALUES (@StudentID,@DOB,@Age,'Eligible')           
		END
    ELSE
        BEGIN
			INSERT INTO @10thSTD([StudentID],[DOB],[Age],[Eligibility])
			VALUES (@StudentID,@DOB,@Age,'Not-Eligible')			
        END
	RETURN;
END
SELECT * FROM [10th_StudentDetails].[StudentsList]('1002','09/18/2005')

--WITH(NO LOCK) EXAMPLE
ALTER PROCEDURE [10th_StudentDetails].[Updating_StudentDetails]
(
@StudentID INT
)
AS
BEGIN
 
	UPDATE [10th_StudentDetails].[Students_Score]
	SET TotalMarks=(SELECT SUM(English+Tamil+Maths+Physics+Chemistry+Biology+Computer)
					FROM [10th_StudentDetails].[Students_Score]
					WHERE @StudentID=StudentID)
	SELECT * FROM [10th_StudentDetails].[Students_Score]WITH (NOLOCK) 
	WHERE StudentID=@StudentID
	
END

--EXECUTION SP Updating_StudentDetails--
EXEC [10th_StudentDetails].[Updating_StudentDetails] '1001'

--EXAMPLE FOR executesql--

DECLARE @SQL NVARCHAR(2000)
SET @SQL = 'SELECT * FROM [10th_StudentDetails].[Students_Score]
			WHERE StudentID = @StudID'
EXEC sp_executesql @SQL, N'@StudID INT', @StudID='1001'