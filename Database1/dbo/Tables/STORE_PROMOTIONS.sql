CREATE TABLE [dbo].[STORE_PROMOTIONS] (
    [store_location_id]     VARCHAR (20)    NOT NULL,
    [promotion_id]          VARCHAR (20)    NOT NULL,
    [promotion_reason]      VARCHAR (30)    NULL,
    [type3]                 VARCHAR (20)    NULL,
    [min_customer_age]      VARCHAR (20)    NULL,
    [combo_desc]            VARCHAR (50)    NULL,
    [combo_price]           DECIMAL (14, 4) NULL,
    [item_list_id]          VARCHAR (50)    NOT NULL,
    [combo_item_qty]        DECIMAL (14, 4) NULL,
    [combo_item_unit_price] DECIMAL (14, 4) NULL,
    [discount_external_id]  VARCHAR (20)    NULL,
    [start_date]            DATE            NULL,
    [start_time]            VARCHAR (20)    NULL,
    [stop_date]             DATE            NULL,
    [stop_time]             VARCHAR (20)    NULL,
    [week_day]              VARCHAR (20)    NULL,
    [available]             VARCHAR (10)    NULL,
    [source_file_name]      VARCHAR (50)    NULL,
    [load_date]             DATE            NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([store_location_id]));


GO
CREATE NONCLUSTERED INDEX [ITEM_Index]
    ON [dbo].[STORE_PROMOTIONS]([item_list_id] ASC);


GO
CREATE NONCLUSTERED INDEX [PROMOTION_Index]
    ON [dbo].[STORE_PROMOTIONS]([promotion_id] ASC);

