CREATE TABLE [dbo].[STORE_SKU_SOH_BY_DATE] (
    [rowid]                   VARCHAR (30)   NULL,
    [store]                   VARCHAR (30)   NULL,
    [on_hand_date]            DATE           NULL,
    [sku]                     VARCHAR (30)   NULL,
    [on_hand_end_of_day]      INT            NULL,
    [avg_cost_end_of_day]     DECIMAL (4, 2) NULL,
    [retail_value_end_of_day] DECIMAL (4, 2) NULL,
    [exported]                VARCHAR (50)   NULL,
    [timestamp]               VARCHAR (30)   NULL,
    [source_file_name]        VARCHAR (100)  NULL,
    [load_date]               DATE           NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

