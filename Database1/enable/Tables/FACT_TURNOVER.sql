CREATE TABLE [enable].[FACT_TURNOVER] (
    [Date]               DATE          NULL,
    [Vendor]             VARCHAR (100) NULL,
    [Product]            VARCHAR (100) NULL,
    [Promotion]          VARCHAR (100) NULL,
    [Site]               VARCHAR (100) NULL,
    [Transaction_Type]   VARCHAR (100) NULL,
    [Units]              VARCHAR (100) NULL,
    [Value]              VARCHAR (100) NULL,
    [Currency]           VARCHAR (100) NULL,
    [External_Reference] VARCHAR (100) NULL,
    [Interface_Date]     DATE          NULL,
    [Load_Date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

