
DECLARE @TestTable 
TABLE (TestValue VARCHAR (20));

INSERT INTO @TestTable (TestValue) 
 VALUES ('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

select
reverse(
right (REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))),
               len(REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))))-charindex('.', 
                     REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))))
		      )
				)
FROM @TestTable

SELECT FNNAME(tE) FROM 

-- link
--------  "https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=afff822c2f777dcd3e622c4d9a2851a2"



-- second way

DECLARE @TestTable TABLE (TestValue VARCHAR (20));

INSERT INTO @TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

SELECT parsename(TestValue,2) From @TestTable

--------link 
----------------  "https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=9252e66acf4239b656655b241b779ad2"



--scalar Valued Function
go

CREATE FUNCTION addition (@fristNum int ,@secondNum int )
RETURNS @thirdValue TABLE (FilteredValue varchar(20))
AS 
BEGIN
INSERT INTO @thirdValue VALUES ()
RETURN 
END




----
CREATE FUNCTION FILTERED_IP(@Value varchar)
RETURNS @thirdValue TABLE (FilteredValue varchar(20))
AS 
BEGIN
INSERT INTO @thirdValue VALUES (@Value)
RETURN ;
END;
 
 DECLARE @table1 table (alue varchar)
set @table1=FILTERED_IP('2')
 SELECT * FROM @table1

  
CREATE TABLE TestTable  (TestValue VARCHAR (20));

INSERT INTO TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');