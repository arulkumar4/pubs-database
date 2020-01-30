--task1
CREATE table My_constraints(
				id int not null,
				[name] varchar(10) CONSTRAINT pk_name PRIMARY KEY,
				salary FLOAT CHECK(salary>1000),cityName VARCHAR(10) UNIQUE)
--insert the values
INSERT INTO My_constraints VALUES(102,'hi',500,'colachel')

SELECT * FROM My_constraints

CREATE TABLE F_example(
			ex_name VARCHAR(10) CONSTRAINT fk_name FOREIGN KEY REFERENCES My_constraints([name])
			)

INSERT INTO F_example values('deril')
SELECT * FROM F_example
-- Feedback
-- Default 
-- IDENTITY (Seed, increment)

ALTER TABLE My_constraints ADD  Area VARCHAR(10) CONSTRAINT Area_default DEFAULT('KODIMUNAI')
SELECT * FROM My_constraints
SP_HELP My_constraints
INSERT INTO My_constraints ([name], salary, cityname) values ('PRI',4000,'PCHERY')

INSERT INTO My_constraints (id) VALUES (NULL)

CREATE TABLE Employee
(
	Id INT IDENTITY(5, 5) NOT NULL, 
	[name] VARCHAR(10)
)
-- SELECT GETDATE(), LEFT,  RIGHT, INDEX

-- SELECT name, * FROM sys.objects

--RESERVED WORDS
--[DESCRIPTION]
--KEYWORDS

Create Table My_Table1  
(  
   IId int default(1500),  
   Name Nvarchar(50)Constraint Name_Default Default('Pankaj'),  
   Age Int,  
   Salary Int Default(100)  
)

INSERT INTO My_Table1 VALUES (23)


---task:
--way one
---------
DECLARE @TestValue AS VARCHAR (100) ='ADKJFDJJFIRAIJFGIJRIOJOAJDFOJAEROWEAJVOJOERUKYUJTJAFBGFBFVFRBRT'
DECLARE @CharToFind CHAR (1) = 'A'
SELECT LEN(@TestValue )-LEN(REPLACE(@TestValue ,@CharToFind,'')) as Occurrences

--way 2:
-----------
DECLARE @count As Int=0
DECLARE @i As Int=0
DECLARE @value As varchar(70)
SET @value='ADKJFDJJFIRAIJFGIJRIOJOAJDFOJAEROWEAJVOJOERUKYUJTJAFBGFBFVFRBRT'
while(@i<len(@value))
begin
if(select SUBSTRING(@value,@i,1))='A'
begin
set @count+=1
end
set @i+=1
end
select @count
