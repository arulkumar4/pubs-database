create procedure proc_quantitysold
(@title_name varchar(20),@sold float out)
as
begin
  set @sold=(select sum(qty) from sales where title_id in
  (select title_id from titles where title=@title_name))
end