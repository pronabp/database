CREATE VIEW [dbo].[VW_DIM_WOW_ARTICLE_HIERARCHY] ([ARTICLE], [ARTICLE_GROUP], [DEPARTMENT], [DEPT_DESC], [CATEGORY], [CATEGORY_DEC], [SUB_CATAGORY], [SUB_CATEGORY_DESC], [SEGMENT], [SEGMENT_DESC ], [SALES_ORG])
AS SELECT 
	[Product]             ,
    [Group]               ,
    [Department]          ,
    [Dept Description]    ,
    [Category]            ,
    [Category Description],
    [Sub-Category]        ,
    [Sub Cat Description] ,
    [Segment]             ,
    [Segment Description ],
    [Sales Organization]  
FROM [dbo].[DIM_WOW_ARTICLE_HIERARCHY];