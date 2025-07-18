
IF OBJECT_ID('counttotalworkinhours', 'U') IS NOT NULL
    DROP TABLE counttotalworkinhours;

IF OBJECT_ID('CalculateWorkingHours', 'P') IS NOT NULL
    DROP PROCEDURE CalculateWorkingHours;
GO

-- Section 2: Create the result table
CREATE TABLE counttotalworkinhours (
    START_DATE DATETIME,
    END_DATE DATETIME,
    NO_OF_HOURS INT
);
GO


CREATE PROCEDURE CalculateWorkingHours
    @Start_Date DATETIME,
    @End_Date DATETIME
AS
BEGIN
    SET NOCOUNT ON; 

    DECLARE @current_date DATE;
    DECLARE @end_date_only DATE;
    DECLARE @working_days_count INT;
    DECLARE @total_hours INT;
    DECLARE @is_sunday BIT;
    DECLARE @is_first_or_second_saturday BIT;
    DECLARE @week_of_month INT;

    -- Initialize variables
    SET @current_date = CAST(@Start_Date AS DATE); 
    SET @end_date_only = CAST(@End_Date AS DATE);   
    SET @working_days_count = 0;                    


    WHile @current_date <= @end_date_only
    BEGIN
        SET @is_sunday = 0;
        SET @is_first_or_second_saturday = 0;

   
        IF DATEPART(weekday, @current_date) = 1
        BEGIN
            SET @is_sunday = 1;
        END

 
        IF DATEPART(weekday, @current_date) = 7
        BEGIN

            SET @week_of_month = (DAY(@current_date) - 1) / 7 + 1;

         
            IF @week_of_month <= 2
            BEGIN
                SET @is_first_or_second_saturday = 1;
            END
        END


        IF (@current_date = CAST(@Start_Date AS DATE) OR @current_date = CAST(@End_Date AS DATE))
        BEGIN
            SET @working_days_count = @working_days_count + 1;
        END
  
        ELSE IF NOT (@is_sunday = 1 OR @is_first_or_second_saturday = 1)
        BEGIN
            SET @working_days_count = @working_days_count + 1;
        END

       
        SET @current_date = DATEADD(day, 1, @current_date);
    END;

    SET @total_hours = @working_days_count * 24;

    INSERT INTO counttotalworkinhours (START_DATE, END_DATE, NO_OF_HOURS)
    VALUES (@Start_Date, @End_Date, @total_hours);

END;
GO


EXEC CalculateWorkingHours '2023-07-12', '2023-07-13';
GO

-- Sample 2: 2023-07-01 to 2023-07-17
EXEC CalculateWorkingHours '2023-07-01', '2023-07-17';
GO

-- Sample 3: 2023-07-17 to 2023-07-13 (Start_Date > End_Date)
EXEC CalculateWorkingHours '2023-07-17', '2023-07-13';
GO


SELECT START_DATE, END_DATE, NO_OF_HOURS
FROM counttotalworkinhours;
GO
