CREATE TABLE [dbo].[DIM_WOW_ARTICLE_HIERARCHY_OLD_Mar182020] (
    [Hierarchy ID]         VARCHAR (50) NULL,
    [Product]              VARCHAR (50) NULL,
    [Group]                VARCHAR (50) NULL,
    [Department]           VARCHAR (50) NULL,
    [Dept Description]     VARCHAR (50) NULL,
    [Category]             VARCHAR (50) NULL,
    [Category Description] VARCHAR (50) NULL,
    [Sub-Category]         VARCHAR (50) NULL,
    [Sub Cat Description]  VARCHAR (50) NULL,
    [Segment]              VARCHAR (50) NULL,
    [Segment Description ] VARCHAR (50) NULL,
    [Sales Organization]   VARCHAR (50) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

