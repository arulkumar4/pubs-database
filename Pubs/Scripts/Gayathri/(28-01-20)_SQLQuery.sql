--Write a SP to generate GUID with user input values for --
--UPPERCASE, GUID COUNT, HYPEN, BRACES--

ALTER PROCEDURE sp_newguid
 (
  @GuidCount INT,
  @UpperCase BIT,
  @Braces BIT,
  @Hypen BIT	
 ) 
 AS 
 BEGIN
 DECLARE @Count INT
 SET @Count=1
 WHILE(@COUNT<=@GuidCount)
    BEGIN
        DECLARE @Guid varchar(38)
        SET @Guid = NEWID()
        IF(@UpperCase=1)
            SET @Guid=UPPER(@Guid)
        ELSE
            SET @Guid=LOWER(@Guid)
        BEGIN
            IF(@Braces=1)
                SET @Guid=CONCAT('{',@Guid,'}')
            BEGIN
                IF(@Hypen=1) 
                    SET @Guid=REPLACE(@Guid,'-','')  
            END
        END       
        SET @Count  = @Count + 1
        PRINT @Guid
    END
 END

 EXECUTE sp_newguid '3','1','1','0'

 --STORE PROCEDURE FOR CREATING TEMP TABLE--

CREATE PROCEDURE EmployeeTempTable
(
@EmpId VARCHAR(4),
@EmpName VARCHAR(100),
@EmpCity VARCHAR(100),
@EmpState VARCHAR(100)
)
AS
BEGIN
     DECLARE @EmpTable TABLE
    (
    EmpId VARCHAR(4),
    EmpName VARCHAR(100)
    )
    BEGIN
        INSERT INTO @EmpTable(EmpId,EmpName) VALUES (@EmpId , @EmpName)
        SELECT * FROM @EmpTable
        WHERE EmpId=@EmpId AND EmpName=@EmpName
        
    END
    CREATE TABLE #EmpLocation
    (
    EmpCity VARCHAR(100),
    EmpState VARCHAR(100)
    )
    BEGIN
        INSERT INTO #EmpLocation(EmpCity,EmpState) VALUES (@EmpCity , @EmpState)
        SELECT * FROM #EmpLocation
        WHERE EmpCity=@EmpCity AND EmpState=@EmpState
    END
END
EXEC EmployeeTempTable '1001','Bharath','Chennai','TamilNadu'








