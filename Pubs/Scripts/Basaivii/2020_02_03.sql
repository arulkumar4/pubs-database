-- create schema
CREATE SCHEMA 
           Security

GO
 
 -- create table

 CREATE TABLE 
	Security.UserAccount (UserName varchar(100),
						  U_PassWord BINARY(64) not null,
						  CONSTRAINT pk_UserName PRIMARY KEY (UserName) )




INSERT INTO Security.UserAccount VALUES ('BASAVAa' ,  HASHBYTES('SHA2_256', 'LOL'))

SELECT * FROM Security.UserAccount
go


-- Create insertion procedure

CREATE PROCEDURE Security.insert_Data(@userName varchar(100) , @password varchar(50))
AS
INSERT INTO Security.UserAccount VALUES (@userName ,  HASHBYTES('SHA2_256', @password))
GO

EXEC Security.insert_Data 'KB' , 'password'
go


-- Creating procdure to verify password

CREATE PROCEDURE Security.Verify_data( @password varchar(50))
AS
--SELECT IIF(U_Password = HASHBYTES('SHA2_256', @password),'Password Exists ', 'No mathes found') FROM  Security.UserAccount
--set Nocount on;
	Declare @dupli int;
	set @dupli=(
	SELECT 
        count (U_Password)
			FROM  Security.UserAccount  WHERE U_Password = HASHBYTES('SHA2_256', @password)
			)

	if (@dupli>0)
	    BEGIN
		PRINT  'true'
		END 
	ELSE
		BEGIN
		PRINT 'FALSE'
		END

go


EXEC Security.Verify_data 'password'



-------------------------------------------------------

--Improvements on encrioption

---Creating table

 CREATE TABLE 
	Security.UserAccount1 (UserName varchar(100),
						  U_PassWord BINARY(64) not null,
						  passGIID uniqueidentifier ,
						  CONSTRAINT pk_UserName1 PRIMARY KEY (UserName) )
go

-- creating procedure to Encrypy data along with GUID

CREATE PROCEDURE Security.insert_Data1(@userName varchar(100) , @password varchar(50))
AS

DECLARE @salt UNIQUEIDENTIFIER=NEWID();

INSERT INTO Security.UserAccount1 VALUES (@userName ,  HASHBYTES('SHA2_512', @password+CAST(@salt AS NVARCHAR(36))),@salt)
GO

EXEC Security.insert_Data1 'KB' , 'password'
go

SELECT * FROM Security.UserAccount1

GO

------Verify Password in db

ALter PROCEDURE Security.Verify_data1(@username varchar(100), @password varchar(50))
AS
Declare @P_GUID nvarchar(100);
SET @P_GUID= (SELECT passGIID from Security.UserAccount1 where UserName= @username )
Declare @dupli int;
set @dupli=(
			SELECT 
				 count (U_PassWord)
				FROM  Security.UserAccount1  WHERE U_Password = HASHBYTES('SHA2_512', @password+cast(@P_GUID as nvarchar(36))
				))

if (@dupli>0)
  BEGIN
	PRINT  'true'
	END 
ELSE
	BEGIN
	PRINT 'FALSE'
	END

go


EXEC Security.Verify_data1 'KB' , 'password'
