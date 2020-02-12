Select * from stores

select * from stores 
order by zip offset 2 ROWS;

select * from stores 
order by zip offset 2 ROWS
FETCH FIRST 1 ROWS ONLY;

Select * from stores
Select * from sales


Select * from stores st where stor_id =all (Select stor_id from sales as sa where st.stor_id= sa.stor_id)

Select * from stores st where stor_id =all (Select stor_id from sales as sa where sa.stor_id= 6380)

Select * from stores st where stor_id =any (Select stor_id from sales as sa where sa.stor_id= 6380)

Select * from stores st where  exists (Select stor_id from sales as sa where sa.stor_id= 6380)

Select * from stores st where stor_id in (Select stor_id from sales)

select stor_id  from sales sa where stor_id in (select stor_id from stores)



Select * from Account_Table
Select * from Payment_Table
select * from Bank_Table

Insert into Bank_Table values ('basavaaa','asdfghjkl',GETDATE())
Insert into Account_Table values (103,'KBKB',10000,GETDATE(),'asdfghjkl')


Select * from Account_Table where acc_no in (select acc_no from Payment_Table)

Select * from Account_Table where acc_no = any (select acc_no from Payment_Table)

Select * from Account_Table where Exists (select acc_no from Payment_Table)

Select acc_no ,sum(T_A) from Account_Table 
where acc_no = some (select acc_no from Payment_Table)
group by acc_no



Select acc_no ,sum(T_A) as Total_cre from Account_Table 
where acc_no = some (select acc_no from Payment_Table)
group by acc_no
order by Total_cre desc offset 0 rows
fetch first 5 ROWS ONLY 



select at.acc_no from  Account_Table as at ,Payment_Table as pt
where at.acc_no = pt.acc_no 
Group by at.acc_no


-- universal ansi 


select cast('dfghj'  as int)

select Try_cast('dfghj'  as int)

select cast(GETDATE() as varchar(10))


