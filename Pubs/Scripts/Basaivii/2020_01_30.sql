
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

-- link
--------  "https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=afff822c2f777dcd3e622c4d9a2851a2"



-- second way

DECLARE @TestTable TABLE (TestValue VARCHAR (20));

INSERT INTO @TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

SELECT parsename(TestValue,2) From @TestTable

--------link 
----------------  "https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=9252e66acf4239b656655b241b779ad2"