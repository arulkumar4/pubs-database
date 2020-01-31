--CREATE TYPE TABUL AS TABLE (Testvalue VARCHAR(20))

--CREATE FUNCTION filter_IP(@TestTable TABUL )
--RETURNS @FILTERD_TABLE TABLE (old varchar(20) , filterd varchar(10))
--AS
--BEGIN
--INSERT INTO @FILTERD_TABLE (old) 
--SELECT (Testvalue) FROM @TestTable

--INSERT INTO @FILTERD_TABLE (filterd)
--select
--reverse(
--right (REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))),
--               len(REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))))-charindex('.', 
--                     REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))))
--		      )
--				)
--FROM @TestTable




--DECLARE @TestTable TABLE (TestValue VARCHAR (20));

--INSERT INTO @TestTable (TestValue) VALUES
--('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');


CREATE FUNCTION dbo.filter_IP(@Testvalue VARCHAR(20) )
RETURNS  varchar(20)
AS
BEGIN

Declare @filterd_value varchar(20)
set @filterd_value=
reverse(
right (REVERSE(right (@TestValue,len(@Testvalue)-charindex('.',@TestValue,charindex('.',@TestValue)+1))),
               len(REVERSE(right (@TestValue,len(@Testvalue)-charindex('.',@TestValue,charindex('.',@TestValue)+1))))-charindex('.', 
                     REVERSE(right (@TestValue,len(@Testvalue)-charindex('.',@TestValue,charindex('.',@TestValue)+1))))
		      )
				)

RETURN @filterd_value;
END;

  
CREATE TABLE TestTable  (TestValue VARCHAR (20));

INSERT INTO TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');


SELECT dbo.filter_IP(TestValue) FROM TestTable as Filtered_ip

DROP TABLE TestTable




----------  CTE 


with ip (ipv4 )
as
(select * from TestTable)

select * from ip