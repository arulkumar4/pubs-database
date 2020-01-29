CREATE PROCEDURE sp_GetGuids
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
