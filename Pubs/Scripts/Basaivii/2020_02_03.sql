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