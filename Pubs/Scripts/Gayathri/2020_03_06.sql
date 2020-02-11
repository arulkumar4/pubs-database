-- Row_Number() Using Partition By--
SELECT *, ROW_NUMBER() 
	OVER (PARTITION BY TotalMarks 
	ORDER BY TotalMarks DESC)  AS RANKS
	FROM [10th_StudentDetails].[Students_Score];


-- Rank() Without Using Partition By--
SELECT *, RANK() 
	OVER (ORDER BY TotalMarks DESC)  AS RANKS
	FROM [10th_StudentDetails].[Students_Score];
--Rank() Using Partition By--
SELECT *, RANK() 
	OVER (PARTITION BY TotalMarks 
	ORDER BY TotalMarks DESC)  AS RANKS
	FROM [10th_StudentDetails].[Students_Score];


-- Dense_Rank() Without Using Partition By--
SELECT *, DENSE_RANK() 
	OVER (ORDER BY TotalMarks DESC)  AS RANKS
	FROM [10th_StudentDetails].[Students_Score];
--Dense_Rank() Using Partition BY--
SELECT *, DENSE_RANK() 
	OVER (PARTITION BY TotalMarks 
	ORDER BY TotalMarks DESC)  AS RANKS
	FROM [10th_StudentDetails].[Students_Score];

--Cast() Example--
SELECT StudentID,StudentName,CAST((TotalMarks/7) AS FLOAT) AS Percentage 
	FROM [10th_StudentDetails].[Students_Score];


--Coalesce() Example--
SELECT COALESCE(NULL, NULL, NULL, '2', NULL, 'Three','7','9');


--Scope_Identity() with Example--
INSERT INTO Employee([Name],[City])
VALUES ('Manimegalai','Vizhupuram')
SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY]  


--@@Identity with Example--
CREATE PROCEDURE InsertEmployee  
(   
@EmpName VARCHAR(MAX),  
@City VARCHAR(MAX)	      
)  
AS  
BEGIN  
	INSERT INTO Employee([Name],[City]) VALUES(@EmpName,@City)  
	SELECT @@IDENTITY AS IdentityValue
END  

EXEC InsertEmployee 'Ramya','Trivandram'


--LTRIM() EXAMPLE--
SELECT LTRIM('     LTRIM Example') AS Result;


--RTRIM() Example--
SELECT RTRIM('RTRIM EXAMPLE           ')AS Result;