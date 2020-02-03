-- constraints 
-----------------------------------------------

create table student_Detail (
	s_Id int  primary key ,
	s_Name varchar(50) not null,
	s_Age int check(s_Age>3)
	)


create table student_Address(
	s_Id int 
		foreign key REFERENCES student_Detail(s_Id),
	s_Address varchar(100) 
		default 'null'
		)


alter table student_Address 
	alter column s_EmeContact bigint 


update student_Address set s_EmeContact = 9092660514 where s_Id=101; 
update student_Address set s_EmeContact = 9092660515 where s_Id=102;
update student_Address set s_EmeContact = 9092660516 where s_Id=103;


alter table student_Address 
	add constraint s_phone unique (s_EmeContact)
	




create table student_Class(
	s_Id int  
		foreign key REFERENCES student_Detail(s_Id),
	s_Class int not null 
	)



select * from student_Detail
select * from student_Address
select * from student_Class


create  index student_info
	on student_Detail(s_Id,s_Name)

select * from student_info
SELECT *
FROM student_Detail WITH(INDEX( student_info))

--s_Rank int not null unique check (s_Rank>0),

insert into student_Detail values (101,'arun',5);

insert into student_Detail values (102,'balu',6);

insert into student_Detail values (103,'chiru',7);


insert into student_Address values (101,'11-3,600119');
insert into student_Address values (102,'11-5,600119');
insert into student_Address (s_Id) values (103);


insert into student_Class values (101,1);
insert into student_Class values (102,2);
insert into student_Class values (103,3);

--delete from student_Address where s_Id=103;
go


delete from student_Class where s_Id>100


-- identity
---------------------------------------------

alter table student_class 
	add slNo int identity (1,1);


	---task
	----------

go

Declare @TestValue  varchar(100)
	Set @TestValue = 'ADKJFDJJFIRAIJFGIJRIOJOAJDFOJAEROWEAJVOJOERUKYUJTJAFBGFBFVFRBRT'

Declare @CharToFind CHAR(1);
Set @CharToFind = 'A'
select 
	(len(@TestValue ) - len(replace(@TestValue ,@CharToFind, '')))/len(@CharToFind) as repeatedWords

SELECT LEN(@TestValue) - LEN(REPLACE(@TestValue, @CharToFind, ''))

go