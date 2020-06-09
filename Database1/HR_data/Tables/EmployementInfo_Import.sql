CREATE TABLE [HR_data].[EmployementInfo_Import] (
    [Person_ID_External] INT           NULL,
    [Startdate]          DATE          NULL,
    [UserID]             INT           NULL,
    [JobNumber]          VARCHAR (50)  NULL,
    [OriginalStartDate]  DATE          NULL,
    [Source_name]        VARCHAR (50)  NULL,
    [Source_file_Name]   VARCHAR (100) NULL,
    [Load_date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

