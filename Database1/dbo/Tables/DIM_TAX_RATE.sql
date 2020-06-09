CREATE TABLE [dbo].[DIM_TAX_RATE] (
    [TaxCharge_Code]   VARCHAR (20)    NOT NULL,
    [AsOfDate]         VARCHAR (20)    NULL,
    [RateForPurchases] DECIMAL (20, 4) NULL,
    [RateForSales]     DECIMAL (20, 4) NULL,
    [Purge]            VARCHAR (20)    NULL,
    [TIMESTAMP]        DATETIME        NULL,
    [start_date]       DATE            NULL,
    [end_date]         DATE            NULL,
    [load_date]        DATETIME        NULL,
    [source_file_name] VARCHAR (200)   NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TaxCharge_Code]));

