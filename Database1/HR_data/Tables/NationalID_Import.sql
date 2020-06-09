CREATE TABLE [HR_data].[NationalID_Import] (
    [Person_ID_External] INT           NULL,
    [Country]            VARCHAR (30)  NULL,
    [NationalID]         VARCHAR (50)  NULL,
    [NationalCardType]   VARCHAR (50)  NULL,
    [IsPrimary]          VARCHAR (20)  NULL,
    [Notes]              VARCHAR (200) NULL,
    [Operation]          VARCHAR (50)  NULL,
    [Source_name]        VARCHAR (50)  NULL,
    [Source_file_Name]   VARCHAR (100) NULL,
    [Load_date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

