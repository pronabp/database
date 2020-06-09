CREATE TABLE [dbo].[ON_HAND_BY_DATE] (
    [rowid]                   VARCHAR (50)    NULL,
    [Store]                   VARCHAR (30)    NULL,
    [On_Hand_Date]            DATE            NULL,
    [SKU]                     VARCHAR (30)    NULL,
    [On_Hand_End_Of_Day]      DECIMAL (20, 4) NULL,
    [Avg_Cost_End_Of_Day]     DECIMAL (20, 4) NULL,
    [Retail_Value_End_Of_Day] DECIMAL (20, 4) NULL,
    [Exported]                VARCHAR (30)    NULL,
    [TIMESTAMP]               VARCHAR (30)    NULL,
    [source_file_name]        VARCHAR (100)   NULL,
    [load_date]               DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Store]), PARTITION([On_Hand_Date] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

