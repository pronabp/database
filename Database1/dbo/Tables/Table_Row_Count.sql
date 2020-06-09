CREATE TABLE [dbo].[Table_Row_Count] (
    [Table_Name]    VARCHAR (40)  NULL,
    [Calender_Date] DATETIME2 (7) NULL,
    [Row_Count]     NUMERIC (20)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

