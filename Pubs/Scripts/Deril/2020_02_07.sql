SELECT
	*
FROM
	SALES

SELECT  stor_id,SUM(qty) from sales
GROUP BY stor_id

--precent rank
SELECT 
	stor_id,
	SUM(qty),
	PERCENT_RANK() OVER
	(
	ORDER BY SUM(qty) ASC
	) AS percent_rank_column
FROM 
	sales
group by
	stor_id

-----
SELECT EOMONTH(GETDATE(),-12)
SELECT DATEADD(SECOND,1,GETDATE()) 
---------------------------------------

---table as parameter fro stored procedure

Create Table [dbo].Cars
(
    Id int primary key,
    [Name] nvarchar(50),
    company nvarchar(50)
)
Go
-----------------

CREATE TYPE CarTableType AS TABLE
(
    Id int primary key,
    Name nvarchar(50),
    company nvarchar(50)
)
Go

CREATE PROCEDURE spInsertCars
@CarType CarTableType READONLY
AS
BEGIN
    INSERT INTO Cars
    SELECT * FROM @CarType
END



DECLARE @CarTableType CarTableType

INSERT INTO @CarTableType VALUES (1, 'Corrolla', 'Toyota')
INSERT INTO @CarTableType VALUES (2, 'Civic', 'Honda')
INSERT INTO @CarTableType VALUES (3, '6', 'Audi')
INSERT INTO @CarTableType VALUES (4, 'c100', 'Mercedez')
INSERT INTO @CarTableType VALUES (5, 'Mustang', 'Ford')

EXECUTE spInsertCars @CarTableType

SELECT 
	*
FROM
	[dbo].[cars]

----------------------------------------------------------
CREATE or ALTER PROCEDURE Find_Table
@tablename VARCHAR(20)
AS
BEGIN
 DECLARE @DER VARCHAR(20)
 SET @DER=(SELECT
  	TABLE_NAME
FROM
  	INFORMATION_SCHEMA.TABLES
where
	TABLE_NAME=@tablename)
	SELECT @DER AS VALUE
	SELECT Count(*) FROM @DER

END

exec Find_Table 'sales'


SELECT
  	TABLE_NAME
FROM
  	INFORMATION_SCHEMA.TABLES
where
	TABLE_NAME='sales'

CREATE OR ALTER PROCEDURE test
@dfrt varchar(20)
AS 
BEGIN
    declare @df as varchar(20)
	set @df=@dfrt
    SELECT count(*) FROM @df

    
END

exec test
