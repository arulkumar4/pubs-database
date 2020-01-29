select * from sales

DECLARE @table nvarchar(max)
DECLARE @sql nvarchar(max)

SET @table ='sales'
SET @sql='SELECT * FROM ' + @table

EXEC sp_executesql @sql

EXEC sp_GetGuids 5, 1, 1, 0

ALTER PROCEDURE sp_GetGuids
(
   @GuidCount INT,
   @IsUpper BIT,
   @IsBraces BIT,
   @IsHypen BIT 
)
AS
BEGIN
DECLARE @myid uniqueidentifier
DECLARE @iterator As Int=0
Declare @testvalue varchar(10)
while(@iterator<@GuidCount)
begin
IF(@IsUpper)=1 and (@IsBraces)=1 and (@IsHypen)=1
begin
SET @myid = NEWID()  
print  '{'+CONVERT(varchar(255), @myid)+'}'
end
else if(@IsUpper)=1 and (@IsBraces)=1 and (@IsHypen)=0
begin
SET @myid = NEWID()
print  '{'+REPLACE(CONVERT(varchar(255), @myid),'-','')+'}'
end
else if(@IsUpper)=1 and (@IsBraces)=0 and (@IsHypen)=1
begin
SET @myid = NEWID()
print  CONVERT(varchar(255), @myid)
end
else if(@IsUpper)=1 and (@IsBraces)=0 and (@IsHypen)=0
begin
SET @myid = NEWID()
print  REPLACE(CONVERT(varchar(255), @myid),'-','')
end
else if(@IsUpper)=0 and (@IsBraces)=1 and (@IsHypen)=1
begin
SET @myid = NEWID()
print  '{'+LOWER(CONVERT(varchar(255), @myid))+'}'
end
else if(@IsUpper)=0 and (@IsBraces)=1 and (@IsHypen)=0
begin
SET @myid = NEWID()
print  '{'+LOWER(REPLACE(CONVERT(varchar(255), @myid),'-',''))+'}'
end
else if(@IsUpper)=0 and (@IsBraces)=0 and (@IsHypen)=1
begin
SET @myid = NEWID()
print  LOWER(CONVERT(varchar(255), @myid))
end
else if(@IsUpper)=0 and (@IsBraces)=0 and (@IsHypen)=0
begin
SET @myid = NEWID()
print  LOWER(REPLACE(CONVERT(varchar(255), @myid),'-',''))
end
else
begin
PRINT 'WRONG INPUT'
end
set @iterator+=1
end
END

EXEC sp_GetGuids 1,6,2,3 

--CAST integer to varchar
select CAST(7 AS nvarchar)+'-'
select CAST(7 as decimal)/2

select '4'+4
