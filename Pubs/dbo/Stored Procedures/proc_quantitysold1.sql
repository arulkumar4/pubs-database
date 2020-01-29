CREATE  proc proc_quantitysold1
(@store_name varchar(20))
as
begin
  select title_id,sum(qty) from sales s join stores st
  on s.stor_id=st.stor_id where stor_name=@store_name
  group by title_id
end
