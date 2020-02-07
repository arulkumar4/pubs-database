SELECT t.price,au_ord FROM titles t
     JOIN titleauthor ta on t.title_id=ta.title_id 
	--where au_id = '213-46-8915'

-----
CREATE TABLE tb_emp_id
     (id int identity (3000,1),name varchar (100) not null,constraint emp_id primary key(id))


Insert INTo tb_emp_id values ('kb')

Insert INTo tb_emp_id values ('kb1')

Insert INTo tb_emp_id values ('kb2')

Insert INTo tb_emp_id values ('kb3')



create table tb_emp_detail(emp_id int references tb_emp_id(id),address varchar(100) );



insert into  tb_emp_detail values('3003' ,'SWARNA')

insert into  tb_emp_detail values('3002','home less' )

select * from tb_emp_id
select * from tb_emp_detail
go


-- select parent records which deoes not have child records


select id.id, id.name ,id.DEP from tb_emp_id id
	      join tb_emp_detail de 
	       on id.id = de.emp_id
		   WHERE de.emp_id IS NULL

insert into  tb_emp_detail (emp_id) values('3001' )




SELECT id.id, id.name 
FROM tb_emp_id id
WHERE NOT EXISTS (
    SELECT 1 FROM tb_emp_detail de 
    WHERE id.id = de.emp_id
)

insert into  tb_emp_detail (emp_id) values('3001' )

--update the child records where address is null

UPDATE tb_emp_detail SET address ='not set yet'  
From tb_emp_detail td  
 left join  tb_emp_id ti
 on td.emp_id= ti.id   where  td.address is null
 


 -------------------------------------
select * from tb_emp_id
select * from tb_emp_detail

Alter table tb_emp_id add  DEP varchar(20)

UPDATE tb_emp_id  set DEP='ece' where id = 3002


--update ece dep student details

UPDATE tb_emp_detail SET address ='NO NEED'  
From tb_emp_detail td  
 inner join  tb_emp_id ti
 on td.emp_id= ti.id   where ti.DEP = 'ece' 
 

-- add city and print same city guys
select * from tb_emp_id
select * from tb_emp_detail

Alter table tb_emp_id add  city varchar(20)


UPDATE tb_emp_id  set city='CHENNAI' where id = 3000
UPDATE tb_emp_id  set city='VIZAG' where id = 3001
UPDATE tb_emp_id  set city='CHENNAI' where id = 3002
UPDATE tb_emp_id  set city='CHENNAI' where id = 3003

-- cross join


SELECT ti1.id , ti2.id , ti1.city 
     FROM tb_emp_id ti1 cross join  tb_emp_id ti2 
	 --on ti1.id=ti2.id
	 where ti1.city= ti2.city and ti1.id <>ti2.id

--self join

SELECT ti1.id , ti2.id , ti1.city 
     FROM tb_emp_id ti1 ,  tb_emp_id ti2 
	 --on ti1.id=ti2.id
	 where ti1.city= ti2.city and ti1.id <>ti2.id
