CREATE proc COUNT_STRING(@value varchar(100))
as
begin
begin tran
   --select REPLACE(@value,'A','')
   DECLARE @count As Int=0
   while(SELECT  Substring(@value,(CHARINDEX('A',@value)),(CHARINDEX('A',@value))))='A'
   begin
   --select REPLACE(@value,'A','')
   
   set @count+=1
   select @count
     commit
   end
   end
