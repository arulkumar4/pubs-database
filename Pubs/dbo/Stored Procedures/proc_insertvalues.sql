CREATE procedure proc_insertvalues(
@Sid char(4),@Sname varchar(20),@Saddress varchar(20),@Scity varchar(20),@Sstate varchar(20),
@Szip varchar(20))
as
begin
begin try
insert into stores values(@Sid,@Sname,@Saddress,@Scity,@Sstate,@Szip)
end try
begin catch
 select ERROR_MESSAGE()
end catch
end
