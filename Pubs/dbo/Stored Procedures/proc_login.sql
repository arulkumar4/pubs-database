create proc proc_login(@un varchar(20),@pass varchar(20) out)
as
begin
set @pass=(select password from tbluser where username=@un)
end
