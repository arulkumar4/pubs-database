create proc doassignment
(@fname varchar(10))
as
begin
  update titles set price=price+2 where
  title_id in(select title_id from titleauthor where au_id 
  in(select au_id from authors where au_fname=@fname))
end