CREATE TABLE [HR_data].[Position_Import] (
    [Code]                           INT           NULL,
    [ExternalName_defaultValue]      VARCHAR (50)  NULL,
    [ExternalName_en_GB]             VARCHAR (50)  NULL,
    [Effective_Status]               VARCHAR (5)   NULL,
    [StartDate]                      DATE          NULL,
    [JobCode_ExternalCode]           VARCHAR (50)  NULL,
    [JobTitle]                       VARCHAR (50)  NULL,
    [Regular_Temporary_ExternalCode] VARCHAR (50)  NULL,
    [TargetFTE]                      VARCHAR (10)  NULL,
    [Vacant]                         VARCHAR (30)  NULL,
    [Company_ExternalCode]           VARCHAR (50)  NULL,
    [BusinessUnit_ExternalCode]      VARCHAR (50)  NULL,
    [Division_ExternalCode]          VARCHAR (50)  NULL,
    [Department_ExternalCode]        VARCHAR (50)  NULL,
    [Location_ExternalCode]          INT           NULL,
    [Costcentre_ExternalCode]        INT           NULL,
    [PositionControlled]             VARCHAR (20)  NULL,
    [StandardHours]                  REAL          NULL,
    [Cust_JobFunction_ExternalCode]  VARCHAR (50)  NULL,
    [Cust_Country_code]              VARCHAR (50)  NULL,
    [Parent_Country_code]            VARCHAR (50)  NULL,
    [Source_name]                    VARCHAR (50)  NULL,
    [Source_file_Name]               VARCHAR (100) NULL,
    [Load_date]                      DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

