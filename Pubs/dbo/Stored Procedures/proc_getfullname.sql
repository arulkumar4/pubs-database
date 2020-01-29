create  procedure proc_getfullname(@authorid varchar(20),@state varchar(10))
as
begin
 select concat(au_lname,' ',au_fname) as 'fullname' from authors where au_id=@authorid or state=@state
end