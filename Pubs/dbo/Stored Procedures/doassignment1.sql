CREATE proc doassignment1
(@ordnum varchar(10))
as
begin
  select sum(t.price*s.qty) as 'amount' from sales s join titles t
  on s.title_id=t.title_id
  where ord_num=@ordnum
end
