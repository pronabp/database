CREATE TABLE [dbo].[TAX_RATE] (
    [row_id]             INT           NULL,
    [taxcharge_code]     VARCHAR (100) NOT NULL,
    [as_of_date]         DATE          NULL,
    [rate_for_purchases] VARCHAR (20)  NULL,
    [rate_for_sales]     VARCHAR (20)  NULL,
    [timestamp]          VARCHAR (30)  NULL,
    [purge]              VARCHAR (10)  NULL,
    [source_file_name]   VARCHAR (100) NULL,
    [load_date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

