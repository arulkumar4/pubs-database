create proc  proc_cal(@titleid varchar(10))
as
begin
begin tran
   update titles set price=10 where title_id=@titleid
   if(select sum(qty) from sales)>10
   begin
     commit
   end
   else
     rollback
end