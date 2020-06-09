CREATE TABLE [enable].[DIM_PRODUCT] (
    [Product_Name]       VARCHAR (100) NULL,
    [Product_Reference]  VARCHAR (100) NULL,
    [Start_Date]         DATE          NULL,
    [End_Date]           DATE          NULL,
    [Category_Name]      VARCHAR (100) NULL,
    [Category_Number]    VARCHAR (100) NULL,
    [Manufacturer]       VARCHAR (100) NULL,
    [Segment_Name]       VARCHAR (100) NULL,
    [Segment_Number]     VARCHAR (100) NULL,
    [SubCategory_Name]   VARCHAR (100) NULL,
    [SubCategory_Number] VARCHAR (100) NULL,
    [Load_Date]          DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

