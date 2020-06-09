CREATE TABLE [enable].[OUT_ENABLE_PRODUCT] (
    [ProductName]       VARCHAR (100) NULL,
    [ProductReference]  VARCHAR (100) NULL,
    [StartDate]         DATE          NULL,
    [EndDate]           DATE          NULL,
    [CategoryName]      VARCHAR (100) NULL,
    [CategoryNumber]    VARCHAR (100) NULL,
    [Manufacturer]      VARCHAR (100) NULL,
    [SegmentName]       VARCHAR (100) NULL,
    [SegmentNumber]     VARCHAR (100) NULL,
    [SubCategoryName]   VARCHAR (100) NULL,
    [SubCategoryNumber] VARCHAR (100) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

