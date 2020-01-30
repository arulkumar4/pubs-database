DECLARE @TestTable TABLE (TestValue VARCHAR (20));

INSERT INTO @TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

select
reverse(right (
REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))),
len(REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))))-charindex('.',
REVERSE(right (TestValue,len(Testvalue)-charindex('.',TestValue,charindex('.',TestValue)+1))))

))

FROM @TestTable