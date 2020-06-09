CREATE TABLE [dbo].[DIM_WOW_ARTICLE_EAN_OLD_18Mar2020] (
    [Article]            VARCHAR (50)  NULL,
    [ArticleDescription] VARCHAR (200) NULL,
    [SequenceNoEAN]      VARCHAR (5)   NULL,
    [DisplayUOM]         VARCHAR (5)   NULL,
    [UOMDescription]     VARCHAR (20)  NULL,
    [Vendor]             VARCHAR (20)  NULL,
    [VendorDescription]  VARCHAR (200) NULL,
    [EANNo]              VARCHAR (30)  NULL,
    [MainEANOfVendor]    VARCHAR (50)  NULL,
    [CartonsPerLayer]    VARCHAR (20)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = REPLICATE);

