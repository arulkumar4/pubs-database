create proc Get_allauthors
as
begin
select (au_lname+' '+au_fname)as fullname from authors
end
