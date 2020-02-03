-------To find the third decimal value from the given value----

DECLARE @TestTable TABLE (TestValue VARCHAR (20));

INSERT INTO @TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

SELECT TestValue,PARSENAME(TestValue,2) AS RESULTS FROM @TestTable


---Alternative solution----

DECLARE @TestTable TABLE 
(
TestValue VARCHAR (20),
Decimal1 VARCHAR(20)
);
	INSERT INTO @TestTable (TestValue) VALUES
	('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

	UPDATE @TestTable
	SET Decimal1 = RIGHT(TestValue,LEN(TestValue)-CHARINDEX('.',TestValue))
	UPDATE @TestTable
	SET Decimal1 = RIGHT(Decimal1,LEN(Decimal1)-CHARINDEX('.',Decimal1))
	UPDATE @TestTable
	SET Decimal1 = LEFT(Decimal1,(LEN(Decimal1))-CHARINDEX('.',Decimal1))
	SELECT Replace(Decimal1,'.','') AS RESULT FROM @TestTable 
 
	
--Using Scalar Valued function to get the third value 

DECLARE @TestTable TABLE 
(
TestValue VARCHAR (20),
Decimal1 VARCHAR(20)
);
	INSERT INTO @TestTable (TestValue) VALUES
	('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

--Scalar-valued function

ALTER FUNCTION dbo.fnGetTHirsdValue
(
@TestValue VARCHAR(20)
)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @Decimal1 VARCHAR(20);
	SET @Decimal1 = RIGHT(@TestValue,LEN(@TestValue)-CHARINDEX('.',@TestValue))
	SET @Decimal1 = RIGHT(@Decimal1,LEN(@Decimal1)-CHARINDEX('.',@Decimal1))
	SET @Decimal1 = LEFT(@Decimal1,(LEN(@Decimal1))-CHARINDEX('.',@Decimal1))
	SET @Decimal1=REPLACE(@Decimal1,'.','')
	RETURN @Decimal1
END

SELECT TestValue,dbo.fnGetTHirsdValue(TestValue) AS RESULT FROM @TestTable