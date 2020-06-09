CREATE TABLE [HR_data].[Phone_Import] (
    [Person_ID_External] INT           NULL,
    [PhoneNumber]        VARCHAR (30)  NULL,
    [PhoneType]          VARCHAR (50)  NULL,
    [AreaCode]           VARCHAR (50)  NULL,
    [Extension]          VARCHAR (50)  NULL,
    [IsPrimary]          VARCHAR (20)  NULL,
    [Operation]          VARCHAR (50)  NULL,
    [Source_name]        VARCHAR (50)  NULL,
    [Source_file_Name]   VARCHAR (100) NULL,
    [Load_date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

