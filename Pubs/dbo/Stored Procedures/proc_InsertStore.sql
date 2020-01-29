create proc proc_InsertStore(@sid varchar(10),@sname varchar(50),@saddress varchar(50),
@scity varchar(10),@sstate varchar(10),@szip varchar(10))
as
begin
insert into stores values(@sid,@sname,@saddress,@scity,@sstate,@szip)
end