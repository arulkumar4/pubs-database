--DATABSE-PUBS

--Rank() function:
	--The RANK() function is a window function that assigns a rank to each row within a partition of a result set.
	--The rows within a partition that have the same values will receive the same rank. 
	--The rank of the first row within a partition is one. 
	--The RANK() function adds the number of tied rows to the tied rank to calculate the rank of the next row,
	--therefore, the ranks may not be consecutive.

SELECT * FROM (
--EXAMPLE 1:
SELECT 
	stor_id,
	ord_num,
	qty,
RANK() OVER
(
	ORDER BY qty
) qty_rank
FROM
	sales
)t
WHERE
	qty_rank >2
-----------------------------------
--PARTITION BY clause divides the products into partitions by specific column.

SELECT * FROM titles


SELECT 
	title_id,
	title,
	ytd_sales,
	price,
RANK () OVER
(
	PARTITION BY  ytd_sales
	ORDER     BY  price 
)price_rank
FROM
	titles
----------------------------------------------------------
--ROW_NUMBER-window function
	--The ROW_NUMBER() is a window function that assigns a sequential integer to each row within a partition of a result set. 
	--The row number starts with one for the first row in each partition.
SELECT 
 *
FROM 
	titles

SELECT 
ROW_NUMBER() OVER
(
	ORDER BY 
	au_lname
) NAME_RANK,
	au_lname,
	au_fname,
	phone,
	city
FROM 
	authors
--------------------------------------------------------------------------
SELECT 
	title_id,
	title,
	ytd_sales,
	price,
ROW_NUMBER () OVER
(
	ORDER     BY  price DESC
)price_rank
FROM
	titles
----------------------------------------------
--DENSE_RANK()-WINDOW FUNCTION

	--The DENSE_RANK() is a window function that assigns a rank to each row within a partition of a result set. 
	--Unlike the RANK() function, the DENSE_RANK() function returns consecutive rank values. 
	--Rows in each partition receive the same ranks if they have the same values.


CREATE TABLE [dbo].TestDense_Rank (
 char_value VARCHAR(10)
);
 
INSERT INTO [dbo].TestDense_Rank(char_value)
VALUES('A'),('B'),('B'),('C'),('C'),('C'),('D'),('E');
 
 

SELECT
 char_value,
 DENSE_RANK() OVER (
 ORDER BY char_value
 ) my_dense_rank,
 RANK() OVER (
 ORDER BY char_value
 ) my_rank
FROM
 [dbo].TestDense_Rank;
 ----------------------------------
 SELECT 
	title_id,
	title,
	ytd_sales,
	price,
DENSE_RANK () OVER
(
	PARTITION BY title_
	ORDER     BY  price DESC
)price_rank
FROM
	titles

select distinct title_id from titles
select title_id from titles
---------------------------------------------------------------------------------------
--CAST FUNCTION
SELECT CAST('345' AS INT)

--COALESCE
SELECT COALESCE(NULL, NULL, NULL, 'DERIL', NULL, 'Example');

-----------------------------------------
--SCOPE-IDENTITY
IF OBJECT_ID(N't6', N'U') IS NOT NULL   
    DROP TABLE t6;  
GO  
IF OBJECT_ID(N't7', N'U') IS NOT NULL   
    DROP TABLE t7;  
GO  
CREATE TABLE t6(id int IDENTITY);  
CREATE TABLE t7(id int IDENTITY(100,1));  
GO  
CREATE TRIGGER t6ins ON t6 FOR INSERT   
AS  
BEGIN  
   INSERT t7 DEFAULT VALUES  
END;  
GO  
--End of trigger definition  
  
SELECT id FROM t6;  
--IDs empty.  
  
SELECT id FROM t7;  
--ID is empty.  
  
--Do the following in Session 1  
INSERT t6 DEFAULT VALUES;  
SELECT @@IDENTITY;  
/*Returns the value 100. This was inserted by the trigger.*/  
  
SELECT SCOPE_IDENTITY();  
/* Returns the value 1. This was inserted by the   
INSERT statement two statements before this query.*/  
  
SELECT IDENT_CURRENT('t7');  
/* Returns value inserted into t7, that is in the trigger.*/  
  
SELECT IDENT_CURRENT('t6');  
/* Returns value inserted into t6. This was the INSERT statement four statements before this query.*/  
  
-- Do the following in Session 2.  
SELECT @@IDENTITY;  
/* Returns NULL because there has been no INSERT action   
up to this point in this session.*/  
  
SELECT SCOPE_IDENTITY();  
/* Returns NULL because there has been no INSERT action   
up to this point in this scope in this session.*/  
  
SELECT IDENT_CURRENT('t7');  
/* Returns the last value inserted into t7.*/  
-----------------------------------------------------------

--DATALENGTH to return the size in bytes for a given string expression. 
--These outputs may differ depending on the data type and type of encoding used in the column.
SELECT DATALENGTH(title) FROM titles
SELECT * FROM titles


--IDENT_INCR -Returns the increment value specified when creating a table or view's identity column
SELECT TABLE_SCHEMA, TABLE_NAME,   
   IDENT_INCR(TABLE_SCHEMA + '.' + TABLE_NAME) AS IDENT_INCR  
FROM INFORMATION_SCHEMA.TABLES  
WHERE IDENT_INCR(TABLE_SCHEMA + '.' + TABLE_NAME) IS NOT NULL;
--------------------------------------------------------------------------

SELECT SYSDATETIME()  
    ,SYSDATETIMEOFFSET()  
    ,SYSUTCDATETIME()  
    ,CURRENT_TIMESTAMP  
    ,GETDATE()  
    ,GETUTCDATE(); 
