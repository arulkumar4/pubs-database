CREATE proc  proc_makeit(@titleid varchar(10))
as
begin
begin tran
   update titles set price=40 where title_id=@titleid
   if(select sum(price) from titles)>10
   begin
     commit
   end
   else
     rollback
end