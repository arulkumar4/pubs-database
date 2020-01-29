create proc Update_Authorname(@au_fname varchar(20),@au_lname varchar(40))
as
begin
update authors set au_lname=@au_lname  where au_fname=@au_fname
end