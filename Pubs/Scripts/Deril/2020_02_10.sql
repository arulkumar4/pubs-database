--STUFF
SELECT STUFF
(
	'deril how are you',
	CHARINDEX(' ','deril how are you'),
	1,
	'hi'
)
--
SELECT * FROM Northwind.dbo.Employees

SELECT 'Today is '+CAST(GETDATE() AS VARCHAR)

SELECT 'Today is '+CONVERT(VARCHAR,GETDATE(),1)

SELECT CAST('hello deril' as int)
--here not possible to convert string to int
--exception handling
	--TRY_CAST,TRY_CONVERT
	SELECT TRY_CAST('hello deril' as int)
	--now it will return null 

SELECT * FROM ColorTable1 ct1
JOIN ColorTable1 ct2 on  ct1.SortOrder=TRY_CAST(ct2.SortOrder AS INT)

SELECT DATENAME(WEEKDAY,GETDATE())
/* RETURN TYPR VARCHAR AS WELL AS INT */

SELECT DATEPART(MONTH,GETDATE())
--return type int

SELECT DATENAME(QUARTER,GETDATE())

SELECT DATENAME(DAYOFYEAR,GETDATE())

/*logic for find age of the person */

DECLARE @bday DateTime
SET @bday='1998-05-27'
SELECT DATEDIFF(HOUR,@bday,'2020-05-28')/8766

SELECT @@DATEFIRST

--how long order will take for delivery

SELECT * FROM Northwind.dbo.Orders

SELECT orderid,DATEDIFF(DAY,OrderDate,ShippedDate) AS [days] FROM Northwind.dbo.Orders 
WHERE
	DATEDIFF(DAY,OrderDate,ShippedDate) > 2 OR DATEDIFF(DAY,OrderDate,ShippedDate) < 0

SELECT OrderDate,ShippedDate FROM Northwind.dbo.Orders
WHERE
	DATEDIFF(DAY,OrderDate,ShippedDate) < 0

/*please provide a report that will contain following information
	northwind representative
	company name,
	company contact,
	date ordered,
	date shipped,
	number of days full fill the order,
	if nt yet full filled,it should be 'pending shipment'
*/
DECLARE @HI VARCHAR(20)='DERIL' 
SELECT
	CONCAT(e.FirstName,' ',e.LastName) as [full_name],
	c.CompanyName,
	c.ContactTitle,
	CONVERT(VARCHAR,o.OrderDate,101) AS Order_date,
	CONVERT(VARCHAR,o.ShippedDate,101) as Shipped_date,
	CASE 
	WHEN DATEDIFF(Day,o.OrderDate,o.ShippedDate) < 0
	THEN 'SOMETHING WRONG'
	WHEN DATEDIFF(Day,o.OrderDate,o.ShippedDate) IS NOT NULL
	THEN CAST(DATEDIFF(Day,o.OrderDate,o.ShippedDate) AS VARCHAR)
	ELSE 'PENDING SHIPMET'
	END AS Num_Days_To_Ship
FROM Employees e 
	join Orders o ON E.EmployeeID=o.EmployeeID
	join Customers c ON c.CustomerID=o.CustomerID

-----------------------------------------------------------------------------------------------
SELECT 
	CONCAT(fname,' ',lname) AS Employee,
	j.job_desc as Position,
	hr.Office as office,
	DATEDIFF(yyyy,hr.DOB,GETDATE()) AS Age
FROM Employee e
	JOIN jobs j ON e.job_id=j.job_id
	JOIN HR_Information hr ON hr.emp_id=e.emp_id

--offset and fetch
SELECT 
	CONCAT(fname,' ',lname) AS Employee,
	j.job_desc as Position,
	hr.Office as office,
	DATEDIFF(yyyy,hr.DOB,GETDATE()) AS Age
FROM Employee e
	JOIN jobs j ON e.job_id=j.job_id
	JOIN HR_Information hr ON hr.emp_id=e.emp_id
ORDER BY
	Employee
OFFSET 1 ROWS
FETCH NEXT 50 ROWS ONLY


SELECT * from dbo.HR_Information









