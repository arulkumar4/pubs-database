create procedure delete_it
(@store_id varchar(10))
as
begin
begin tran
   delete from stores where stor_id=@store_id
   if(select count(*) from sales where stor_id=@store_id)>0
    rollback
   else
     commit
end