CREATE proc  Increase
(@store_id varchar(20))
as
begin
 update sales set qty=qty+2 where 
 stor_id=@store_id
end
