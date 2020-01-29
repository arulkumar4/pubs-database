CREATE proc Get_Authorname(@storeid char(4))
as
begin
select (au_lname+' '+au_fname) as fullname from authors where au_id in
(select au_id from titleauthor where title_id in
(select title_id from sales where stor_id=@storeid))
end
