CREATE TABLE [dbo].[PC_ENTRIES] (
    [rowid]                VARCHAR (50)    NULL,
    [Store]                VARCHAR (30)    NULL,
    [Store_Batch]          VARCHAR (30)    NULL,
    [SKU]                  VARCHAR (30)    NULL,
    [Location]             VARCHAR (30)    NULL,
    [Name]                 VARCHAR (50)    NULL,
    [Upper_Name]           VARCHAR (50)    NULL,
    [UOM]                  VARCHAR (10)    NULL,
    [Qty_OH_Before]        DECIMAL (20, 4) NULL,
    [Qty_OH_Now_string]    DECIMAL (20, 4) NULL,
    [Qty_Variance]         DECIMAL (20, 4) NULL,
    [Retail_OH_Before]     DECIMAL (20, 4) NULL,
    [Retail_OH_Now_string] DECIMAL (20, 4) NULL,
    [Retail_Variance]      DECIMAL (20, 4) NULL,
    [Variance_flag]        VARCHAR (10)    NULL,
    [From_Scanner]         VARCHAR (10)    NULL,
    [Adj_Type]             VARCHAR (10)    NULL,
    [HO_Register]          VARCHAR (10)    NULL,
    [Count_Date_EOD]       DATE            NULL,
    [Inventory_GL]         VARCHAR (30)    NULL,
    [Shrink_SpoilGL]       VARCHAR (30)    NULL,
    [Updated_HO]           VARCHAR (10)    NULL,
    [Exported]             VARCHAR (10)    NULL,
    [TIMESTAMP]            DATETIME2 (7)   NULL,
    [To_Or_From_Store]     VARCHAR (10)    NULL,
    [Transfer_Reference]   VARCHAR (30)    NULL,
    [Transfer_Cost]        DECIMAL (20, 4) NULL,
    [source_file_name]     VARCHAR (100)   NULL,
    [load_date]            DATE            NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Store]), PARTITION([Count_Date_EOD] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [SKU_Index]
    ON [dbo].[PC_ENTRIES]([SKU] ASC);


GO
CREATE NONCLUSTERED INDEX [Adj_Type_Index]
    ON [dbo].[PC_ENTRIES]([Adj_Type] ASC);

