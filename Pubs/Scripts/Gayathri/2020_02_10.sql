--STUFF 
SELECT STUFF
(
	'Welcome To GISbiz Technologies', 12, 20, 'Kanini Softwares'
) AS New_String

--DISTINCT 
SELECT City
FROM [10th_StudentDetails].[Teachers]

--DML Trigger
CREATE TRIGGER [10th_StudentDetails].[TeachersRecord]
ON
[10th_StudentDetails].[Teachers]
INSTEAD OF DELETE 
--FOR UPDATE
--AFTER INSERT
AS 
BEGIN
PRINT 'You DONT have permission to delete from that table'
END

DELETE FROM [10th_StudentDetails].[Teachers] WHERE City='Chennai'

--DDL TRIGGER
CREATE TRIGGER DropTable
ON 
DATABASE
FOR DROP_TABLE
AS
BEGIN
Print 'Table dropped Successfully!!!'
END

DROP TABLE Employee

--Cursor to PRINT Teachers ID & Name

ALTER PROCEDURE [10th_StudentDetails].[TeachersDetails]
AS
BEGIN
    DECLARE 
    @TeacherID INT,
    @Teachername VARCHAR(MAX)
    DECLARE cursor_teacher CURSOR
    FOR SELECT 
            TeachersID, 
            TeachersName 
        FROM 
            [10th_StudentDetails].[Teachers]
 
    OPEN cursor_teacher
 
    FETCH NEXT FROM cursor_teacher INTO 
        @TeacherID, 
        @Teachername
 
    WHILE @@FETCH_STATUS = 0
        BEGIN
            PRINT CAST(@TeacherID AS VARCHAR) +' - '+ @Teachername 
            FETCH NEXT FROM cursor_teacher INTO 
                @TeacherID, 
                @Teachername
        END
 
    CLOSE cursor_teacher
 
    DEALLOCATE cursor_teacher
END

EXEC [10th_StudentDetails].[TeachersDetails]

