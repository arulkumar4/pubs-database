

SELECT *
FROM titles T 
RIGHT OUTER JOIN sales s
ON t.title_id != s.title_id

DROP TABLE EmployeeData
DROP TABLE Department

CREATE TABLE EmployeeData
(
	Id   int primary key,
	[name] varchar(10),
	CITY VARCHAR(20))


INSERT INTO EmployeeData 
	VALUES
	(101,'DERIL','SALEM'),
	(102,'DE','SALEM'),
	(103,'DEr','chennai'),
	(104,'GHT','nagercoil')


CREATE TABLE Department
(
	Id       int FOREIGN KEY REFERENCES EmployeeData(Id),
	dep_name varchar(10)
)
	INSERT INTO Department VALUES(101,'eee'),(102,'ece'),(103,'mech'),(104,'ete')

	SELECT 
		* 
	from 
		EmployeeData
	
	SELECT 
		* 
	from 
		Department
	
ALTER TABLE EmployeeData ADD  City varchar(20)


--update with joins
UPDATE 
  Department 
SET
	Department.dep_name='eee'
FROM EmployeeData Ed 
INNER JOIN Department d
ON Ed.Id = d.Id WHERE ed.name='de'


--self join
SELECT 
	Ed_FirstReference.id,Ed_SecondReference.id,Ed_FirstReference.city
FROM 
	EmployeeData Ed_FirstReference ,EmployeeData Ed_SecondReference
where 
	Ed_FirstReference.Id!=Ed_SecondReference.id AND Ed_FirstReference.city=Ed_SecondReference.city



select 
	* 
from
	EmployeeData

