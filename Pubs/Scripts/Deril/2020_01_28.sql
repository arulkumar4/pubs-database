--small app(generate guid) using stored procedure :
--------------------------------

--one way:
-----------
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
--------------------------------------------------------------------------
--another way using temp table
---------------------------
ALTER PROCEDURE SmallApp(
   @Count INT,
   @IsUpper BIT = 1 ,
   @IsBrace BIT = 0,
   @IsHypen BIT = 1
)
AS
BEGIN
DECLARE @FinalIds TABLE (Id varchar(42))
DECLARE @Iterator as INT=0

WHILE(@Iterator<@Count)
	BEGIN
	INSERT INTO @FinalIds (Id) values (NEWID())
	SET @Iterator+=1
	END

IF(@IsBrace)=1
	UPDATE @FinalIds SET Id=CONCAT('{', Id, '}');


IF(@IsHypen)=0
	UPDATE @FinalIds SET Id=REPLACE(Id,'-','')

SELECT IIF(@IsUpper = 1, UPPER(Id), LOWER(Id)) AS Id FROM @FinalIds;

END
GO

exec SmallApp 1,1,1,0

