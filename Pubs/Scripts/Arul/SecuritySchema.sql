CREATE TABLE [Security].[ServiceAccount] (
    [Id]           INT              IDENTITY (1, 1) NOT NULL,
    [UserName]     NVARCHAR (256)   NOT NULL,
    [PasswordHash] BINARY (64)      NOT NULL,
    [Salt]         UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- [Security].[spCreateServiceAccount] 'test', 'password'

CREATE PROCEDURE [Security].[spCreateServiceAccount]
(
	@UserName	NVARCHAR (256),
	@Password	NVARCHAR (256)
)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @IsSuccess AS BIT = 0;
    DECLARE @Salt AS UNIQUEIDENTIFIER = NEWID();

    BEGIN TRY
		IF NOT EXISTS(SELECT * FROM [Security].[ServiceAccount] WHERE [UserName] = @UserName)
		BEGIN
			INSERT INTO [Security].[ServiceAccount] ([UserName], [PasswordHash], [Salt])
			VALUES(@UserName, HASHBYTES('SHA2_512', @Password + CAST(@Salt AS NVARCHAR(36))), @Salt)

			SET @IsSuccess = 1;
		END

    END TRY
    BEGIN CATCH
        SET @IsSuccess = 0;
    END CATCH

	SELECT @IsSuccess AS IsSuccess

END

-- [Security].[spFindServiceAccount] 'test', 'password'

CREATE PROCEDURE [Security].[spFindServiceAccount]
(
	@UserName NVARCHAR (256),
	@Password NVARCHAR (256)
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT Id, UserName 
	FROM [Security].[ServiceAccount] 
	WHERE [UserName] = @UserName AND [PasswordHash] = HASHBYTES('SHA2_512', @Password + CAST(Salt AS NVARCHAR(36)))

END
