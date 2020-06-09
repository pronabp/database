CREATE TABLE [dbo].[DIM_PROMOTION_STORE] (
    [PromotionKey]     VARCHAR (20)  NULL,
    [Store]            VARCHAR (20)  NOT NULL,
    [Apply]            VARCHAR (20)  NULL,
    [LastModifiedBy]   VARCHAR (20)  NULL,
    [TimeStamp]        DATETIME      NULL,
    [Purge]            VARCHAR (20)  NULL,
    [start_date]       DATE          NULL,
    [end_date]         DATE          NULL,
    [load_date]        DATETIME      NULL,
    [source_file_name] VARCHAR (200) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([PromotionKey]));

