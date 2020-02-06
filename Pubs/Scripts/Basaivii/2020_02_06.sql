Select * from tb_emp_id

Select * from stores
select * from titles

--Rank

Select  RANK() OVER(ORDER BY city DESC) num ,city FROM tb_emp_id

Select  RANK() OVER(ORDER BY city ASC) num ,city FROM tb_emp_id



Select  RANK() OVER(ORDER BY state ASC) num ,city , stor_id FROM stores

Select  RANK() OVER(ORDER BY state DESC) num ,city,stor_id FROM stores

--row num

Select  ROW_NUMBER() OVER(ORDER BY state DESC) num ,city,stor_id FROM stores

Select  ROW_NUMBER() OVER(ORDER BY state ASC) num ,city , stor_id FROM stores


--all in one



Select  royalty as order_by ,
	   RANK() OVER(  ORDER BY royalty DESC) RANKK ,
	   Dense_rank() OVER( ORDER BY royalty DESC) DENSE_RANKK ,
	   ROW_NUMBER() OVER( ORDER BY royalty DESC) ROW_NUM  FROM titles


Select  royalty as order_by,  type as partistion,
		 RANK() OVER(PARTITION BY type ORDER BY royalty DESC) RANKK 
		,Dense_rank() OVER(PARTITION BY type ORDER BY royalty DESC) DENSE_RANKK ,
	   ROW_NUMBER() OVER(PARTITION BY type ORDER BY royalty DESC) ROW_NUM
	   FROM titles

 -- cast,coalesce,scope_identity(),ltrim,rtrim

SELECT CAST(22.2 AS INT)

SELECT COALESCE(NULL,1,NULL)

SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY];  

SELECT LTRIM('   ISDCBUHSDB')
SELECT RTRIM('   ISDCBUHSDB')
SELECT LTRIM('   ISDCBUHSDB     ')
SELECT RTRIM('   ISDCBUHSDB     ')