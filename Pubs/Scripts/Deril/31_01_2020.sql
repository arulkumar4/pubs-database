--QUE CONVERT deril to DeRiL

DECLARE @Value VARCHAR(20)
SET @VALUE='Priya';
DECLARE @FinalValue VARCHAR(20)
SET @FinalValue='';
DECLARE @Iterator As INT=0
WHILE(@Iterator<=LEN(@VALUE))
	BEGIN
		
		IF(@Iterator%2)!=0
			BEGIN
				SET @FinalValue+=UPPER(SUBSTRING(@VALUE,@Iterator,1))
			END
		ELSE
			BEGIN
				SET @FinalValue+=LOWER(SUBSTRING(@VALUE,@Iterator,1))
			END

		SET @Iterator+=1
    END
SELECT @FinalValue

--------------------------------------------------------------------------------------------------------------------------
--GENERATE EMPLOYEE ID
ALTER PROCEDURE GenerateEmployeeId(@Name VARCHAR(20))
AS
BEGIN
	
	DECLARE @GeneratedId VARCHAR(20)
	SET @Name=REPLACE(@Name,' ', '@')
	SET @GeneratedId=SUBSTRING(@Name,1,1)
	SET @GeneratedId+=SUBSTRING(@Name,LEN(@Name),1)
	
		DECLARE @Iterator AS INT=0
		WHILE(@Iterator<=LEN(@Name))
			BEGIN
				IF(SUBSTRING(@Name,@Iterator,1))='@'
					BEGIN
						SET @GeneratedId+=SUBSTRING(@Name,@Iterator+1,1)
						SET @GeneratedId+=SUBSTRING(@Name,@Iterator-1,1)
					END
					SET @Iterator+=1
			END
	SELECT @GeneratedId AS ID
END

EXEC GenerateEmployeeId 'DERIL XAVIER'
--------------------------------------------------------------------------------------------------------------
--CTE(Common Table Expression)
--use pubs database
select * from sales

WITH Cte_Sales
(
	store_id
)
AS 
(
	SELECT stor_id FROM sales
)
	SELECT * from Cte_Sales
-------------------------------------------------------------------------

select ROUND (2.567,0,1)