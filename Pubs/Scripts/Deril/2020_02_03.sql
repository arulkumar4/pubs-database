--CREATE SCHEMA
CREATE SCHEMA Security
GO



--CREATE TABLE SCHEMA-DBO
--Table name:UserAccount


CREATE TABLE [Security].[UserAccount]
(
    UserID INT IDENTITY(1,1) NOT NULL,
    LoginName NVARCHAR(40) NOT NULL,
    PasswordHash BINARY(64) NOT NULL,
    [guid] UNIQUEIDENTIFIER 
    CONSTRAINT [PK_User_UserID] PRIMARY KEY CLUSTERED (UserID ASC)
)

---------------------------------------------------------------------------------

--retrive the data
SELECT * FROM [Security].[UserAccount]

----------------------------------------------------------------------------------

--create the procedure for insert the data

CREATE PROCEDURE [Security].[AddNewUser]
    @pLogin NVARCHAR(50), 
    @pPassword NVARCHAR(50),
    @responseMessage NVARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @GeneratedId UNIQUEIDENTIFIER=NEWID()
    BEGIN TRY
	    --here one way hashing algoritham i used and security purpose i add guid to the password
        INSERT INTO [Security].[UserAccount] (LoginName, PasswordHash, [guid])
        VALUES(@pLogin, HASHBYTES('SHA2_512', @pPassword+CAST(@GeneratedId AS NVARCHAR(36))), @GeneratedId)

       SET @responseMessage='Success'

    END TRY
    BEGIN CATCH
        SET @responseMessage=ERROR_MESSAGE() 
    END CATCH

END
------------------------------------------------------------------------------------
--execute the procedure

DECLARE @responseMessage NVARCHAR(250)

EXEC [Security].AddNewUser
          @pLogin = N'deril',
          @pPassword = N'123456789',
          @responseMessage=@responseMessage OUTPUT

SELECT * FROM [Security].UserAccount
--------------------------------------------------------------------------------------

--find the password is already exist if exist means return exist

CREATE PROCEDURE [Security].AlreadyExist
    @pLoginName NVARCHAR(254),
    @pPassword NVARCHAR(50),
    @responseMessage NVARCHAR(250)='' OUTPUT
AS
BEGIN

    SET NOCOUNT ON

    DECLARE @userID INT
    IF EXISTS (SELECT TOP 1 UserID FROM [Security].[UserAccount] WHERE LoginName=@pLoginName)
    BEGIN
	
       SET @userID=(SELECT UserID FROM [Security].[UserAccount] WHERE LoginName=@pLoginName AND PasswordHash=HASHBYTES('SHA2_512', @pPassword+CAST([guid] AS NVARCHAR(36))))
       IF(@userID IS NULL)
           SET @responseMessage='NOT EXIST'
       ELSE 
           SET @responseMessage='EXIST'
    END
    ELSE
       SET @responseMessage='Invalid login'

END
------------------------------------------------------------------------------------------------------------
--execute the procedure

DECLARE	@responseMessage nvarchar(250)
EXEC	[Security].AlreadyExist
		@pLoginName = N'Deril',
		@pPassword = N'123456789',
		@responseMessage = @responseMessage OUTPUT

SELECT	@responseMessage as N'@responseMessage'

