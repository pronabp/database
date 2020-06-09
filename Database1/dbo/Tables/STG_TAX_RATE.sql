CREATE TABLE [dbo].[STG_TAX_RATE] (
    [TaxCharge_Code]   VARCHAR (20)    NULL,
    [AsOfDate]         VARCHAR (20)    NULL,
    [RateForPurchases] DECIMAL (20, 4) NULL,
    [RateForSales]     DECIMAL (20, 4) NULL,
    [Purge]            VARCHAR (20)    NULL,
    [TIMESTAMP]        DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TaxCharge_Code]));

