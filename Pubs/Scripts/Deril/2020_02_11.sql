SELECT
	Post_xml.value('(/root/Posts/@Id)[1]','int') as [PostId],
	Post_xml.value('(/root/Posts/@Title)[1]','varchar(500)') as [PostTitle]
FROM Posts 
---Temporal Table

select * from PostTemporal

CREATE TABLE PostTemporal (
	Id INT NOT NULL PRIMARY KEY CLUSTERED,
	CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
	Score INT NOT NULL DEFAULT 0,
	ViewCount INT,
	Body VARCHAR(MAX) NOT NULL,
	OwnerUserId INT,
	LastActivityDate DATETIME NOT NULL DEFAULT GETDATE(),
	Tiitle VARCHAR(500),
	Tags VARCHAR(255),
	AnswerCount INT,
	CommentCount INT,
	FaviouriteCount INT,
	SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
	SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME(SysStartTime,SysEndTime)
)
WITH
	(
	SYSTEM_VERSIONING=ON(HISTORY_TABLE = DBO.PostsHistory)
	);


--rename the column name
sp_rename 'PostTemporal.title', 'Title', 'COLUMN'



---insert the value into posttemporal table
insert PostTemporal(
	Id,
	CreationDate,
	Score,
	ViewCount,
	Body,
	OwnerUserId,
	LastActivityDate,
	Title,
	Tags,
	AnswerCount ,
	CommentCount ,
	FaviouriteCount
)
SELECT 
	ID,
	JSON_VALUE(Post_json,'$.Post.CreationDate') AS CreationDate,
	JSON_VALUE(Post_json,'$.Post.Score') AS Score,
	JSON_VALUE(Post_json,'$.Post.ViewCount') AS ViewCount,
	JSON_VALUE(Post_json,'$.Post.Body') AS Body,
	JSON_VALUE(Post_json,'$.Post.OwnerUserId') AS OwnerUserId,
	JSON_VALUE(Post_json,'$.Post.LastActivityDate') AS LastActivityDate,
	JSON_VALUE(Post_json,'$.Post.Title') AS Title,
	JSON_VALUE(Post_json,'$.Post.Tags') AS Tags,
	JSON_VALUE(Post_json,'$.Post.AnswerCount') AS AnswerCount,
	JSON_VALUE(Post_json,'$.Post.CommentCount') AS CommentCount,
	JSON_VALUE(Post_json,'$.Post.FaviouriteCount') AS FaviouriteCount
FROM Posts
WHERE
	JSON_VALUE(Post_json,'$.Post.Tags') LIKE '%python%' AND
	JSON_VALUE(Post_json,'$.Post.Score') > 20 AND
	JSON_VALUE(Post_json,'$.Post.Body') IS NOT NULL;

SELECT * FROM PostTemporal
SELECT * FROM PostsHistory

--now posttemporal table have values but postshistory have no value

--I am going to upddate the tables

UPDATE PostTemporal
	SET Title='Estimating users age based on their facebook sites they like'
	WHERE Id=116;

UPDATE PostTemporal
	SET Title='which cost function best for neural network'
	WHERE Id=9850;

--Error handling

-- Run this script to follow along with the demo
USE [master];
GO

-- Checking to see if our database exists and if it does drop it
IF DATABASEPROPERTYEX ('ABCCompany','Version') IS NOT NULL
BEGIN
	ALTER DATABASE [ABCCompany] SET SINGLE_USER
	WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [ABCCompany];
END
GO

CREATE DATABASE [ABCCompany];
GO

ALTER DATABASE [ABCCompany] SET RECOVERY SIMPLE;
GO

USE [ABCCompany];
GO

CREATE SCHEMA [Sales];
GO

CREATE SCHEMA [Bank];
GO

CREATE TABLE [Sales].[SalesPersonLevel] (
	[Id] int identity(1,1) NOT NULL,
	[LevelName] nvarchar(500) NOT NULL,
	[CreateDate] datetime NOT NULL DEFAULT GETDATE(),
	[ModifyDate] datetime NULL
	CONSTRAINT [PK_SalesPersonLevel] PRIMARY KEY CLUSTERED ([Id]));
GO

INSERT INTO [Sales].[SalesPersonLevel] ([LevelName])
	VALUES	('President'),
			('Manager'),
			('Staff');
GO
	
CREATE TABLE [Sales].[SalesPerson] (
	[Id] int identity(1,1) NOT NULL,
	[FirstName] nvarchar(500) NOT NULL,
	[LastName] nvarchar(500) NOT NULL,
	[SalaryHr] decimal(32,2) NULL,
	[ManagerId] int NULL,
	[LevelId] int NOT NULL,
	[Email] nvarchar(500) NULL,
	[StartDate] date NOT NULL,
	[CreateDate] datetime NOT NULL DEFAULT GETDATE(),
	[ModifyDate] datetime NULL
	CONSTRAINT [PK_SalesPerson] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_SalesPersonLevel] FOREIGN KEY ([LevelId]) REFERENCES [Sales].[SalesPersonLevel] ([Id]),
	CONSTRAINT [FK_SalesPersonManagerId] FOREIGN KEY ([ManagerId]) REFERENCES [Sales].[SalesPerson] ([Id]));
GO

INSERT INTO [Sales].[SalesPerson] ([FirstName],[LastName],[SalaryHr],[ManagerId],[LevelId],[Email],[StartDate]) 
	VALUES	('Tom','Jones',300,1,1,'Tom.Jones@ABCCorp.com','1/5/2016'),
			('Sally','Smith',175,1,2,'Sally.Smith@ABCCorp.com','1/7/2018'),
			('Bill','House',100,2,3,'Bill.House@ABCCorp.com','1/8/2018'),
			('Karen','Knocks',100,2,3,'Karen.Knocks@ABCCorp.com','1/15/2017'),
			('Lisa','James',75,2,3,'Lisa.James@ABCCorp.com','6/1/2018'),
			('Kerrie','Friend',125,2,3,'Kerrie.Friend@ABCCorp.com','8/14/2018'),
			('Jason','Henderson',55,2,3,'Jason.Henderson@ABCCorp.com','1/14/2017'),
			('Wanda','Jones',55,2,3,'Tom.Jones@ABCCorp.com','9/1/2017'),
			('Jared','Lee',65,2,3,'Jared.Lee@ABCCorp.com','9/8/2018'),
			('Tammy','Smith',75,2,3,NULL,'2/5/2018');
GO

ALTER INDEX ALL ON [Sales].[SalesPerson] REBUILD;
GO

CREATE TABLE [Sales].[SalesTerritoryStatus] (
	[Id] int identity(1,1) NOT NULL,
	[StatusName] nvarchar(500) NOT NULL,
	[CreateDate] datetime NOT NULL DEFAULT GETDATE(),
	[ModifyDate] datetime NULL
	CONSTRAINT [PK_SalesTerritoryStatus] PRIMARY KEY CLUSTERED ([Id]));
GO

INSERT INTO [Sales].[SalesTerritoryStatus] ([StatusName])
	VALUES	('On Hold'),
			('In Progress'),
			('Closed');
GO

CREATE TABLE [Sales].[SalesTerritory] (
	[Id] int identity(1,1) NOT NULL,
	[TerritoryName] nvarchar(500) NOT NULL,
	[Group] nvarchar(500) NULL,
	[StatusId] int NOT NULL,
	[CreateDate] datetime NOT NULL DEFAULT GETDATE(),
	[ModifyDate] datetime NULL
	CONSTRAINT [PK_SalesTerritory] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_StatusId] FOREIGN KEY ([StatusId]) REFERENCES [Sales].[SalesTerritoryStatus] ([Id]));
GO

INSERT INTO [Sales].[SalesTerritory] ([TerritoryName],[Group],[StatusId]) 
	VALUES	('Northwest','North America',2),
			('Northeast','North America',2),
			('Southwest','North America',2),
			('Southeast','North America',1),
			('Canada','North America',3),
			('France','Europe',1),
			('Germany','Europe',2),
			('Australia','Pacific',2),
			('United Kingdom','Europe',3),
			('Spain','Europe',1);

ALTER INDEX ALL ON [Sales].[SalesTerritory] REBUILD;
GO

CREATE TABLE [Sales].[SalesOrder] (
	[Id] int identity(1,1) NOT NULL,
	[SalesPerson] int NOT NULL,
	[SalesAmount] decimal(36,2) NOT NULL,
	[SalesDate] datetime NOT NULL,
	[SalesTerritory] int NOT NULL,
	[OrderDescription] nvarchar(MAX) NULL,
	[CreateDate] datetime NOT NULL DEFAULT GETDATE(),
	[ModifyDate] datetime NULL
	CONSTRAINT [PK_SalesOrder] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_SalesPerson] FOREIGN KEY ([SalesPerson]) REFERENCES [Sales].[SalesPerson] ([Id]),
	CONSTRAINT [FK_SalesTerritory] FOREIGN KEY ([SalesTerritory]) REFERENCES [Sales].[SalesTerritory] ([Id]));
GO

INSERT INTO [Sales].[SalesOrder] ([SalesPerson],[SalesAmount],[SalesDate],[SalesTerritory],[OrderDescription]) 
	VALUES (1,2500,'04/05/2019',1,REPLICATE('Sales Description ',10)),
		   (2,3000,'03/02/2019',4,REPLICATE('Sales Description ',10)),
		   (3,4200,'06/02/2019',3,REPLICATE('Sales Description ',10)),
		   (4,1900,'07/01/2019',7,REPLICATE('Sales Description ',10)),
		   (7,2200,'05/15/2019',6,REPLICATE('Sales Description ',10)),
		   (9,5200,'06/03/2019',5,REPLICATE('Sales Description ',10)),
		   (10,7800,'04/13/2019',4,REPLICATE('Sales Description ',10)),
		   (3,4400,'03/23/2019',3,REPLICATE('Sales Description ',10)),
		   (5,1900,'02/15/2019',2,REPLICATE('Sales Description ',10)),
		   (5,7000,'6/09/2019',1,REPLICATE('Sales Description ',10));
GO

ALTER INDEX ALL ON [Sales].[SalesOrder] REBUILD;
GO

-- Create our banking information
CREATE TABLE [Bank].[Savings] (
	[Id] int identity(1,1) NOT NULL,
	[TransactionNotes] nvarchar(50) NOT NULL,
	[Amount] decimal(36,2) NULL,
	[CreateDate] datetime NOT NULL DEFAULT GETDATE(),
	[ModifyDate] datetime NULL
	CONSTRAINT [PK_Savings] PRIMARY KEY CLUSTERED ([Id]));
GO

INSERT INTO [Bank].[Savings] ([TransactionNotes], [Amount])
	VALUES ('Just Started', 5000.00),
		   ('Mowing Lawns', 500.00),
		   ('Short this month', -1400.00);
GO

CREATE TABLE [Bank].[Checking] (
	[Id] int identity(1,1) NOT NULL,
	[TransactionNotes] nvarchar(50) NOT NULL,
	[Amount] decimal(36,2) NULL,
	[CreateDate] datetime NOT NULL DEFAULT GETDATE(),
	[ModifyDate] datetime NULL
	CONSTRAINT [PK_Checking] PRIMARY KEY CLUSTERED ([Id]));
GO

INSERT INTO [Bank].[Checking] ([TransactionNotes], [Amount])
	VALUES ('Rent', -1200.00),
		   ('Paycheck', 2000.00),
		   ('Car Payment', -450.00);
GO

	
	
SELECT *
	FROM 
[Bank].[Savings]

SELECT SUM(Amount) AS 'Balance','checking' AS 'Account type'
FROM Bank.Checking
UNION ALL
SELECT SUM(Amount) AS 'Balance','Savings' AS 'Account type'
FROM Bank.Savings
GO

BEGIN TRY

	BEGIN TRANSACTION;

		INSERT INTO Bank.Savings(Amount,TransactionNotes)
			VALUES(-500,'sorry mom i really need this game')

		INSERT INTO Bank.Checking(Amount,TransactionNotes)
			VALUES(500,'adding fund out to buy the sealed original super mario bros on nes')

	COMMIT TRANSACTION;

END TRY

BEGIN CATCH

	IF(@@TRANCOUNT > 0)
		
		ROLLBACK TRANSACTION;

		THROW;

END CATCH
GO

---------------------------

DECLARE @ErrorId int;
SELECT 1/0;

SET @ErrorId=@@ERROR

SELECT @ErrorId
GO

--ID=8134




SELECT 
	message_id,
	language_id,
	severity,
	is_event_logged,
	[text]
FROM [sys].[messages]
WHERE message_id=8134
GO

CREATE TABLE Orders (OrderId Int, CustId int);
CREATE TABLE OrderItems (OrderItemId int, OrderId int, SKU VARCHAR(50), Qty int)
INSERT INTO Orders(OrderID, CustID) VALUES
    (1, 1001), (2, 2002), (3, 3003)
INSERT INTO OrderItems (OrderItemId, OrderId, Qty, SKU) VALUES
    (1, 1, 10, 'Part1'),
    (2, 1, 5, 'Part5'),
    (3, 2, 15, 'Part2')

SELECT o.OrderId, COUNT(i.OrderItemID) AS NumberOfItems
FROM Orders o
INNER JOIN OrderItems i ON o.OrderId = i.OrderId
GROUP BY o.OrderId