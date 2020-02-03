create database dbsql
use dbsql

create table EmployeeDetails
(
EmpId int Identity(1001,1) constraint pk_eid primary key,
Name varchar(20),
EmailId varchar(40),
Unique (EmailId),
Phone varchar(20) Not null,
Age int Check (Age>=18),
City varchar(20)default 'Chennai'
);
--create index idx_empid on EmployeeDetails(EmpId)

--sp_help EmployeeDetails

SELECT * FROM EmployeeDetails

INSERT INTO EmployeeDetails ([Name], [EmailId], [Phone], [Age])
SELECT 'Test', 'b@b.c', '123', 25;

create table EmployeeSalary(
    SalaryID int constraint pk_sid primary key,
    EmpId int constraint fk_eid foreign key references EmployeeDetails(EmpId),
    Amount varchar(20)
);

--To find the occurrences of an alphabet in a given string
DECLARE @TestValue AS VARCHAR (100) ='ADKJFDJJFIRAIJFGIJRIOJOAJDFOJAEROWEAJVOJOERUKYUJTJAFBGFBFVFRBRT'
DECLARE @CharToFind CHAR (1) = 'A'
select len(@TestValue )-len(replace(@TestValue,@CharToFind,'')) as No_of_Occurrence

 

