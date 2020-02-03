--Table Variable--

DECLARE @TestTable TABLE
(ID INT PRIMARY KEY,
Col1 VARCHAR(40) UNIQUE,
Col2 VARCHAR(40) NOT NULL,
Col3 int CHECK (Col3>=18))
    
 INSERT INTO @TestTable
 VALUES(1,'Value1',12 , 20)
    
 SELECT * FROM @TestTable

 --Global Temp Table--

CREATE TABLE ##Globaltemp
(Column1 INT);
    INSERT INTO ##Globaltemp 
    VALUES (11111);


--Table Function--

   CREATE FUNCTION dbo.func_Globaltemptable
   (@Column1 INT
   )
   RETURNS VARCHAR(50)
   AS
   BEGIN
     DECLARE @value VARCHAR(50)
     SET @value = 22222 
     RETURN @value
   END

   SELECT Column1,dbo.Func_Globaltemptable(Column1)AS New_Column FROM ##Globaltemp