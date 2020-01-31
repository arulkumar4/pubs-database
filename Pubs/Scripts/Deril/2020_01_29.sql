--learnt about functions

---functions:
create function fnCalSal(@eid int)
returns @DisplayEmpSal table(EmployeeID int,
EmployeeName varchar(50),Date date,
Gross float,Net float)
as
begin
insert into @DisplayEmpSal
select e.Id,e.Name,sdate,(basic+HRA+DA-Ded) ,
((basic+HRA+DA-Ded)-(basic+HRA+DA-Ded)*.1) 
from EmployeeSalary es join Salary s
on es.SID=s.Id join Employee e 
on es.EID=e.Id where e.Id=@eid
return 
end

select * from fnCalSal (101)

--2
create function fnCalNet(@bas float,@hra float,@da float,@ded float)
returns float
as
begin
return((@bas+@hra+@da+@ded)-(@bas+@hra+@da+@ded*.1))
end

select dbo.fnCalNet(basic,hra,da,ded) from Salary

----------------------------------------------------------------------------------------------------------
--learnt about cursor
DECLARE @CustomerID as INT;
declare @msg varchar(max)
DECLARE @BusinessCursor as CURSOR;

SET @BusinessCursor = CURSOR FOR
SELECT CustomerID FROM Customer WHERE CustomerID IN ('3908745','3911122','3911128','3911421')

OPEN @BusinessCursor;
    FETCH NEXT FROM @BusinessCursor INTO @CustomerID;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @msg = '{
              "CustomerID": "'+CONVERT(varchar(10), @CustomerID)+'",
              "Customer": {
                "LastName": "LastName-'+CONVERT(varchar(10), @CustomerID) +'",
                "FirstName": "FirstName-'+CONVERT(varchar(10), @CustomerID)+'",    
              }
            }|'
        print @msg
    FETCH NEXT FROM @BusinessCursor INTO @CustomerID;
END