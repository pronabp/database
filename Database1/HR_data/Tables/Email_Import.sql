CREATE TABLE [HR_data].[Email_Import] (
    [EmailAddress]       VARCHAR (100) NULL,
    [EmailType]          VARCHAR (50)  NULL,
    [Person_ID_External] INT           NULL,
    [IsPrimary]          VARCHAR (20)  NULL,
    [Operation]          VARCHAR (50)  NULL,
    [Source_name]        VARCHAR (50)  NULL,
    [Source_file_Name]   VARCHAR (100) NULL,
    [Load_date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

