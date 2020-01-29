create procedure get_sumofprice
(@fname varchar(20),@pricesum float out)
as
begin
  set @pricesum=(select sum(price) from titles where title_id in
  (select title_id from titleauthor where au_id in
  (select au_id from authors where au_fname=@fname)))
end
