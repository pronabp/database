CREATE TABLE [HR_data].[Person_Biographical_Info] (
    [DoB]              DATE          NULL,
    [UserID]           INT           NULL,
    [Country_of_Birth] VARCHAR (50)  NULL,
    [PersonID]         INT           NULL,
    [Place_of_Birth]   VARCHAR (50)  NULL,
    [Source_name]      VARCHAR (50)  NULL,
    [Source_file_Name] VARCHAR (100) NULL,
    [Load_date]        DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

