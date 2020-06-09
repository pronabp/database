CREATE TABLE [HR_data].[Emergency_Contact] (
    [Country]             VARCHAR (50)  NULL,
    [EmergencyName]       VARCHAR (50)  NULL,
    [Person_ID_External]  INT           NULL,
    [PhoneNumber]         VARCHAR (20)  NULL,
    [IsPrimary]           VARCHAR (20)  NULL,
    [Relationship]        VARCHAR (50)  NULL,
    [Address1]            VARCHAR (300) NULL,
    [Address2]            VARCHAR (300) NULL,
    [Address3]            VARCHAR (300) NULL,
    [SecondPhone]         VARCHAR (50)  NULL,
    [City]                VARCHAR (50)  NULL,
    [IsAddSameAsEmployee] VARCHAR (20)  NULL,
    [County]              VARCHAR (50)  NULL,
    [IsDependent]         VARCHAR (20)  NULL,
    [IsDisabled]          VARCHAR (20)  NULL,
    [EmailAddress]        VARCHAR (100) NULL,
    [Gender]              VARCHAR (20)  NULL,
    [Zip]                 INT           NULL,
    [Province]            VARCHAR (100) NULL,
    [ContactState]        VARCHAR (50)  NULL,
    [Operation]           VARCHAR (50)  NULL,
    [Source_name]         VARCHAR (50)  NULL,
    [Source_file_Name]    VARCHAR (100) NULL,
    [Load_date]           DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

