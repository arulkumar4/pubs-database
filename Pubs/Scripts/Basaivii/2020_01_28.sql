DECLARE @guid uniqueidentifier = NEWID(); 

SELECT @guid


CREATE PROCEDURE sp_GetGuid
(
  @GuidCount   INT,
  @IsUpper BIT,
  @IsBraces	BIT,
  @IsHypen	BIT	
 )
 AS 
   DECLARE @wct INT =0;
   WHILE @wct<@GuidCount
	BEGIN 
	  DECLARE @guid uniqueidentifier = NEWID(); 
			
		IF (@IsBraces=0  AND @IsUpper= 0 AND @IsHypen=0)
		 begin
		 SELECT LOWER(REPLACE(@guid,'-',''))
		END

		IF (@IsBraces=0  AND @IsUpper= 0 AND @IsHypen=1)
		 begin
		 SELECT LOWER(@guid)
		END

		IF (@IsBraces=0  AND @IsUpper= 1 AND @IsHypen=0)
		 begin
		 SELECT REPLACE(@guid,'-','')
		END

		IF (@IsBraces=0  AND @IsUpper= 1 AND @IsHypen=1)
		 begin
		 SELECT @guid
		END
		IF (@IsBraces=1  AND @IsUpper= 0 AND @IsHypen=0)
		 begin
		 SELECT CONCAT('{' ,LOWER(REPLACE(@guid,'-','')),'}')
		END

		IF (@IsBraces=1  AND @IsUpper= 0 AND @IsHypen=1)
		 begin
		 SELECT CONCAT('{' ,LOWER(@guid),'}')
		END

		IF (@IsBraces=1  AND @IsUpper= 1 AND @IsHypen=0)
		 begin
		SELECT CONCAT('{' ,REPLACE(@guid,'-',''),'}')
		END

		IF (@IsBraces=1  AND @IsUpper= 1 AND @IsHypen=1)
		 begin
		SELECT CONCAT('{' ,@guid,'}')
		END

	  SET @wct+=1;	
			
	END
	GO

	EXEC sp_GetGuid @GuidCount = 5,  @IsUpper =0 , @IsBraces=1,  @IsHypen=0

	sp_GetGuid @GuidCount = 5,  @IsUpper =0 , @IsBraces=1,  @IsHypen=0

	sp_GetGuid 4,0,1,1
	
GetGuidList 100, 1, 0, 1

go 

CREATE PROCEDURE GetGuidList
(
@Count INT,
@IsUpper BIT = 0 ,
@IsBrace BIT = 0,
@IsHypen BIT = 1
)
AS
BEGIN

SET NOCOUNT ON;

DECLARE @GuidList TABLE (Id VARCHAR(40));
DECLARE @inc INT = 1;

WHILE @inc <= @Count
BEGIN
INSERT INTO @GuidList (Id) VALUES (NEWID());

SET @inc = @inc + 1;
END

IF (@IsBrace = 1)
UPDATE @GuidList SET Id = CONCAT('{', Id, '}');

IF (@IsHypen = 0)
UPDATE @GuidList SET Id = REPLACE(Id, '-', '');

SELECT IIF(@IsUpper = 1, UPPER(Id), LOWER(Id)) AS Id FROM @GuidList;

END
GO
