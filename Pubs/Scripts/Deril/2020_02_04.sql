
--Table Value Function:
-------------------------
	--A table-valued function is a user-defined function that returns data of a table type. 
	--The return type of a table-valued function is a table, therefore, 
	--you can use the table-valued function just like you would use a table.

--Example:
----------
--database-pubs
--table-SALES
--schema-dbo

--Create Function to retrive the order data where qty greater than 10

CREATE OR ALTER FUNCTION [dbo].[OrderTable] (
    @Check_Qty INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        stor_id,
        ord_num,
        ord_date
    FROM
        [dbo].[sales]
    WHERE
        qty > @Check_Qty;

--retrive the data from function

SELECT 
	*
FROM
	[dbo].[OrderTable](10)

-------------------------------------------------------------------------------
--Multi value Table Value Function

select * from publishers
--database-pubs
--table-author,publishers
--schema-dbo

CREATE OR ALTER FUNCTION [dbo].[Author_Publisher_Data]()
    RETURNS @Datas TABLE (
        first_name VARCHAR(50),
        [state] VARCHAR(25),
        city VARCHAR(20),
		contact_type VARCHAR(20)
    )
AS
BEGIN
    INSERT INTO @Datas
    SELECT 
        au_fname,
        [state], 
        city,
		'author'
    FROM
        [dbo].authors;
 
    INSERT INTO @Datas
    SELECT 
        pub_name,  
        [state], 
        city,
        'publisher'
    FROM
        [dbo].publishers;
    RETURN;
END;

--EXECUTE THE FUNCTION

SELECT 
	*
FROM [dbo].[Author_Publisher_Data]()
	
---------------------------------------------------------------------------------------------------------
--- Understand and usage of WITH (NOLOCK):
--------------------------------------------

--CREATE TABLE CHECKNOLOCK

CREATE TABLE [dbo].[CheckNoLock]
(
	Id        INT IDENTITY(1, 1) NOT NULL, 
	firstname VARCHAR(20),
	lastname  VARCHAR(20),
	city	  VARCHAR(20),	
)

--INSERT THE VALUES

INSERT INTO
	[dbo].[CheckNoLock]
VALUES
(
	'DERIL',
	'XAVIER',
	 NULL 
),
(
	'PRIYA',
	'DERIL',
	 NULL
)

--RETRIVE THE DATA
SELECT
	*
FROM
	[dbo].[CheckNoLock]
--------------------------------------------
--USAGE OF WITH(NO LOCK)
-----------------------

SELECT 
	*
FROM
	[dbo].[CheckNoLock]
WHERE
	ID <=2
--here city value is null so i am going to update city value using transaction

BEGIN TRAN
	UPDATE 
		[dbo].[CheckNoLock] 
	SET 
		city= 'chennai' 
	WHERE 
		ID <= 2


--------------------------------------------------------------------------------------
--query window 2:

--SELECT 
--	*
--FROM
--	[dbo].[CheckNoLock]

--WHERE
--	ID <=2

--If I run the same query from above again you will notice that it never completes,
--because the UPDATE has not yet been committed.
---------------------------------------------------------------------------------------------
--so here i add with(nolock)
SELECT 
	*
FROM
	[dbo].[CheckNoLock]
	WITH 
		(
			NOLOCK
		)		
WHERE
	ID <=2
	----now it works perfectly

--This is because the UPDATE in window 1 updated these records.
--Even though that transaction has not been committed, 
--since we are using the NOLOCK hint SQL Server ignores the locks and returns the data.
------------------------------------------------------------------------------------------------------------------
-- sp_executesql (with example):
----------------------------------
--1:
----
EXECUTE sp_executesql   
          N'SELECT * FROM Sales   
          WHERE qty > @level',  
          N'@level tinyint',  
          @level = 10;  

-------------------------------------
--2:
----
DECLARE 
	@table NVARCHAR(MAX),
	@SQL NVARCHAR(MAX)

SET 
	@table=N'[dbo].[sales]'

SET
	@SQL=N'SELECT * FROM' + @table

EXEC sp_executesql @sql;	
--------------------------------------------
--using stored procedure:
-------------------------

CREATE OR ALTER PROC [dbo].[TestCase] (
    @table NVARCHAR(128)
)
AS
BEGIN
 
    DECLARE @sql NVARCHAR(MAX);
    -- construct SQL
    SET @sql = N'SELECT * FROM ' + @table;
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;

EXEC [dbo].[TestCase] 'sales'

------------------------------------------------------------

--create store procedure

CREATE OR ALTER PROC [dbo].[Test_Case_topn](
    @table NVARCHAR(128),
    @topN INT,
    @byColumn NVARCHAR(128)
)
AS
BEGIN
    DECLARE 
        @sql NVARCHAR(MAX),
        @topNStr NVARCHAR(MAX);
 
    SET @topNStr  = CAST(@topN as nvarchar(max));
 
    -- construct SQL
    SET @sql = N'SELECT TOP ' +  @topNStr  + 
                ' * FROM ' + @table + 
                    ' ORDER BY ' + @byColumn + ' DESC';
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;

--execute the procedure

EXEC [dbo].[Test_Case_topn]
        'sales',
        10, 
        'ord_num';
-----------------------------------------------------------------------------------------------------
