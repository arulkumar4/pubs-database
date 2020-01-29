CREATE proc proc_updatesales
(@ordernumber varchar(20))
as
begin
   update sales set qty=qty+1 where ord_num=@ordernumber
   select title,price,qty,price*qty Total from titles t join sales s on
   t.title_id=s.title_id where s.ord_num=@ordernumber
end
