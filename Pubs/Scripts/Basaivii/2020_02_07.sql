
-- User defined table


CREATE TYPE ut_EMP AS TABLE 
	(
	ID INT ,
	NAME VARCHAR(100),
	DEP VARCHAR(100)
	)

CREATE TABLE Employee_UTT
	(
	emp_id int,
	emp_name varchar(100),
	emp_dep varchar(100),

	)

	go

SELECT * FROM Employee_UTT
GO


CREATE PROC INS_EMP (@ut_emp [ut_EMP] readonly )
as
BEGIN
INSERT INTO Employee_UTT (emp_id,emp_name,emp_dep)  
	SELECT * FROM @ut_emp
END



DECLARE @I_P ut_EMP

INSERT INTO @I_P VALUES (101, 'BASAVA','ECE')
INSERT INTO @I_P VALUES (102, 'BASAVII','ECE')
INSERT INTO @I_P VALUES (103, 'BASIVII','EEE')
INSERT INTO @I_P VALUES (104, 'BASAVAa','EtCE')

EXEC  INS_EMP @I_P



---------cousor

----- static query

GO
ALTER PROC selectingTB (@tb_Name nvarchar(50))
AS 
IF(@tb_Name = 'sales')
   SELECT * FROM sales;
ELSE IF(@tb_Name = 'jobs')
	   SELECT * FROM jobs;
	 ELSE
	    SELECT 'CHOSE CORRECT TABLE ';
GO

EXEC selectingTB 'jobs'


-----Dynamic Query
go

ALTER PROC printingData (@tb_Name nvarchar(100) ,
						@col_Name  nvarchar(100),
						@schar nvarchar(100)
						)
 AS
	DECLARE @VARIABLE1 NVARCHAR(100);
	SET @VARIABLE1= N'SELECT '+@col_Name+
					' FROM '+@tb_Name+
					' WHERE '+@col_Name+
						' LIKE '''+@schar+'%''';
	exec sp_EXECUTESQL @VARIABLE1;
	PRINT @VARIABLE1
go

EXEC printingData 'authors','au_lname','w';
SELECT au_lname FROM authors WHERE au_lname LIKE 'w%'

exec sp_EXECUTESQL N'SELECT * FROM authors';