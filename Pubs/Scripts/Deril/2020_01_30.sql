--task

--create the function
ALTER function SplitCharacter(@TestValue varchar(20))
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @StartingPosition INT
	DECLARE @Length INT
	SET @StartingPosition=charindex('.',@TestValue,charindex('.',@TestValue,charindex('.',@TestValue)+1)+1)
	SET @Length=charindex('.',@TestValue,charindex('.',@TestValue)+1)+1
	return substring(
			@TestValue,
			charindex('.',@TestValue,charindex('.',@TestValue)+1)+1,@StartingPosition-@Length
			)
END

--declare the table
DECLARE @TestTable TABLE (TestValue VARCHAR (20));
--insert the values
INSERT INTO @TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');
--call the function
SELECT dbo.SplitCharacter(TestValue) AS Result, TestValue FROM @TestTable

---another way

DECLARE @TestTable TABLE (TestValue VARCHAR (20));

INSERT INTO @TestTable (TestValue) VALUES
('192.256.1.89'), ('192.255.091.900'), ('192.11.34.345');

UPDATE @TestTable set TestValue=PARSENAME(TestValue, 2)
SELECT TestValue FROM @TestTable;
