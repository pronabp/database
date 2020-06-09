CREATE TABLE [enable].[DIM_PROMOTION] (
    [Promotion_Name]      VARCHAR (100) NULL,
    [Promotion_Reference] VARCHAR (100) NULL,
    [Start_Date]          DATE          NULL,
    [End_Date]            DATE          NULL,
    [Promotion_Group]     VARCHAR (100) NULL,
    [Promotion_ID]        VARCHAR (100) NULL,
    [Load_Date]           DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

