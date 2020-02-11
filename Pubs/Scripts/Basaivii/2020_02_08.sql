
CREATE TABLE tb_MARKS (marks int );

INSERT INTO tb_MARKS VALUES(100);
INSERT INTO tb_MARKS VALUES(98);
INSERT INTO tb_MARKS VALUES(76);
INSERT INTO tb_MARKS VALUES(54);




-------------------------------------------------------------

SELECT * FROM stores

SELECT LEAD(zip,1) over(order by stor_id) FROM stores

SELECT marks FROM tb_MARKS


 SELECT marks - LEAD(marks,1) over (order by marks DESC)  from tb_MARKS



-- select one.marks-two.M from tb_MARKS as one,@LEAD as two



----------------------------------------

CREATE TABLE Bank_Table 
	(
	bank_Name varchar(100),
	bank_Id varchar(100) constraint PK_bankid PRIMARY KEY,
	due_Date date
	)

CREATE TABLE Account_Table
	(
	acc_no BIGINT,
	C_Name varchar(100),
	T_A BIGINT,
	T_D date,
	bank_Id varchar(100) constraint FK_bankid REFERENCES Bank_Table(bank_Id)
	)

CREATE TABLE Payment_Table
	(
	Payment_Id varchar (100),
	acc_no BIGINT ,
	P_D date ,
	P_A bigint
	)

GO

Insert Into Bank_Table values ('basa','zaq12wsx',GETDATE())
Insert Into Bank_Table values ('basav','zaq12wsxc',GETDATE()+1)
Insert Into Bank_Table values ('basava','zaq12wsxcd',GETDATE()+2)
Insert Into Bank_Table values ('basavai','zaq12wsxcde',GETDATE()+3)
Insert Into Bank_Table values ('basavaia','zaq12wsxcde3',GETDATE()+4)

SELECT * FROM Payment_Table

GO

INSERT INTO Account_Table VALUES ('101','KB',10000,GETDATE()-2,'zaq12wsx')
INSERT INTO Account_Table VALUES ('101','KB',10000,GETDATE()-3,'zaq12wsx')
INSERT INTO Account_Table VALUES ('102','KBK',10000,GETDATE()-3,'zaq12wsxc')
INSERT INTO Account_Table VALUES ('102','KBK',10000,GETDATE()-3,'zaq12wsxc')
INSERT INTO Account_Table VALUES ('102','KBK',10000,GETDATE()-8,'zaq12wsxc')

SELECT * FROM Payment_Table

GO

INSERT INTO Payment_Table VALUES ('ASD','101',GETDATE()-1,15000)
INSERT INTO Payment_Table VALUES ('ASJ','102',GETDATE()-1,4000)

SELECT * FROM Payment_Table
go


SELECT * FROM Payment_Table
SELECT * FROM Bank_Table
SELECT * FROM Account_Table


select sum(at.T_A)

from Bank_Table as bt join 
	 Account_Table as at
	 on bt.bank_Id=at.bank_Id
Where bt.due_Date = '2020-02-10'
group  by at.bank_Id
	

select sum(P_A)
from Payment_Table
where acc_no in (select acc_no
				from Account_Table as at
				join Bank_Table as bt
				on bt.bank_Id=at.bank_Id
				Where bt.due_Date = '2020-02-10'
				group by acc_no
				)
