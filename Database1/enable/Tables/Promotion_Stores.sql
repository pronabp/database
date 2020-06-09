CREATE TABLE [enable].[Promotion_Stores] (
    [RID]            BIGINT        NOT NULL,
    [PromotionKey]   BIGINT        NOT NULL,
    [Store]          VARCHAR (5)   NOT NULL,
    [Apply]          VARCHAR (10)  NOT NULL,
    [LastModifiedBy] NVARCHAR (35) NOT NULL,
    [TimeStamp]      DATETIME      NOT NULL,
    [Purge]          VARCHAR (10)  NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

