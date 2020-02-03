-- GetGuidList 100, 1, 0, 1

CREATE PROCEDURE GetGuidList
(
	@Count		INT,
	@IsUpper	BIT = 0 ,
	@IsBrace	BIT = 0,
	@IsHypen	BIT = 1
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

