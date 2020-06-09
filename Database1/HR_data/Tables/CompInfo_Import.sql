CREATE TABLE [HR_data].[CompInfo_Import] (
    [Startdate]        DATE          NULL,
    [UserID]           VARCHAR (50)  NULL,
    [EventReason]      VARCHAR (50)  NULL,
    [PayGroup]         VARCHAR (50)  NULL,
    [PayType]          VARCHAR (50)  NULL,
    [EndDate]          DATE          NULL,
    [Source_file_Name] VARCHAR (100) NULL,
    [Load_date]        DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

