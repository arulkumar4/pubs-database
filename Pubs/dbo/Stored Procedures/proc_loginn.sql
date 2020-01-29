create proc proc_loginn(@un varchar(20),@pass varchar(20) out)
as
begin
 set @pass=(select password from tblUser where username=@un)
end