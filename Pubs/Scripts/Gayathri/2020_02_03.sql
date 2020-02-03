CREATE SCHEMA [Security]
GO
CREATE TABLE Security.UserAccount
(
Username VARCHAR(MAX),
Password VARCHAR(MAX)
);
UPDATE Security.UserAccount
SET Password = EncryptByPassPhrase('key', Password)
SELECT Username, Password FROM Security.UserAccount
SELECT*FROM Security.UserAccount
DROP TABLE Security.UserAccount

--SP for Inserting Encrypted Password for username--

CREATE PROCEDURE Security.UN_PASS_ENCRYPTION
(
@Username VARCHAR(MAX),
@Password VARCHAR(MAX)
)
AS
BEGIN
	SET @Password=EncryptByPassPhrase('key', @Password)
	INSERT INTO Security.UserAccount([Username],[Password]) VALUES
	(@Username, @Password)
	SELECT * FROM Security.UserAccount

END

EXEC Security.UN_PASS_ENCRYPTION
'Karthi','saro'

--SP to Check the User Input(password) with table data to return
--TREU OR FALSE

ALTER PROCEDURE Security.Check_Passwords
(
@Username VARCHAR(MAX),
@Password VARCHAR(MAX)
)
AS 
BEGIN
	
	IF EXISTS (SELECT Username FROM Security.UserAccount
	WHERE convert(varchar(MAX),DecryptByPassPhrase('key', Password))=@Password AND Username=@Username	)
	BEGIN
		PRINT 'TRUE'
	END
	ELSE
	BEGIN
		PRINT 'FALSE'
	END
END	

EXEC Security.Check_Passwords 'karthi','saro'
SELECT * FROM Security.UserAccount
