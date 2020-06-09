CREATE TABLE [HR_data].[Address_Type] (
    [Address_type]       VARCHAR (300) NULL,
    [Country]            VARCHAR (50)  NULL,
    [StartDate]          DATE          NULL,
    [Person_ID_External] INT           NULL,
    [City]               VARCHAR (50)  NULL,
    [County]             VARCHAR (50)  NULL,
    [EndDate]            DATE          NULL,
    [Address1]           VARCHAR (300) NULL,
    [Address2]           VARCHAR (300) NULL,
    [UserState]          VARCHAR (50)  NULL,
    [Zip]                INT           NULL,
    [Province]           VARCHAR (100) NULL,
    [Notes]              VARCHAR (200) NULL,
    [Operation]          VARCHAR (50)  NULL,
    [Source_name]        VARCHAR (50)  NULL,
    [Source_file_Name]   VARCHAR (100) NULL,
    [Load_date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

