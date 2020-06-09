CREATE TABLE [dbo].[STG_PROMOTION_STORE] (
    [RID]            VARCHAR (20)  NULL,
    [PromotionKey]   VARCHAR (50)  NOT NULL,
    [Store]          VARCHAR (20)  NOT NULL,
    [Apply]          VARCHAR (20)  NULL,
    [LastModifiedBy] VARCHAR (20)  NULL,
    [TIMESTAMP]      VARCHAR (100) NOT NULL,
    [Purge]          VARCHAR (20)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

