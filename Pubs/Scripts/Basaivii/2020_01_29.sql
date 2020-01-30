-- Temp table 
   CREATE TABLE #tem_Table(id int)
   INSERT INTO #tem_Table VALUES (2)
   SELECT * FROM #tem_Table
  DROP TABLE #tem_Table
   go

ALTER PROC proc_Temp_Table(@_id int)
 AS 
   CREATE TABLE #tempo_Table(id int)
   INSERT INTO #tempo_Table VALUES (@_id)
   SELECT * FROM #tempo_Table
   DROP TABLE #tempo_Table
 -- AUTO MATICALLY IT DROPS 

   CREATE TABLE ##temp_Table(id int)
   INSERT INTO ##temp_Table VALUES (@_id)
   SELECT * FROM ##temp_Table
  DROP TABLE tempdb.DBO.##TEMP_TABLE

   -- STORES IN TEMP DATA BASE

   Declare @tb_var TABLE (id int)
   INSERT INTO @tb_var VALUES (@_id)
   SELECT * FROM @tb_var

   -- IT WILL DROPS AUTOMATICALLY

GO

proc_Temp_Table 3