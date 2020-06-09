CREATE TABLE [HR_data].[Person_Info] (
    [StartDate]             DATE          NULL,
    [FirstName]             VARCHAR (30)  NULL,
    [LastName]              VARCHAR (30)  NULL,
    [Person_ID_External]    INT           NULL,
    [Preferred_Name]        VARCHAR (30)  NULL,
    [Salutation]            VARCHAR (10)  NULL,
    [Disability_Start_Date] DATE          NULL,
    [Disability_End_Date]   DATE          NULL,
    [End_date]              DATE          NULL,
    [FormalName]            VARCHAR (30)  NULL,
    [MiddleName]            VARCHAR (30)  NULL,
    [Gender]                VARCHAR (20)  NULL,
    [MaritalStatus]         VARCHAR (20)  NULL,
    [Nationality]           VARCHAR (30)  NULL,
    [Native_Language]       VARCHAR (30)  NULL,
    [Operation]             VARCHAR (20)  NULL,
    [Source_name]           VARCHAR (50)  NULL,
    [Source_file_Name]      VARCHAR (100) NULL,
    [Load_date]             DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

