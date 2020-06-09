CREATE TABLE [dbo].[DIM_WOW_ARTICLE_EAN] (
    [EAN_SequenceNo]      VARCHAR (25)  NULL,
    [Article]             VARCHAR (20)  NULL,
    [Article_Description] VARCHAR (250) NULL,
    [Display_UoM]         VARCHAR (30)  NULL,
    [EAN_UPC]             VARCHAR (50)  NULL,
    [EAN_Number_Type]     VARCHAR (10)  NULL,
    [Vendor_GTIN]         VARCHAR (50)  NULL,
    [Ind_Main_EAN]        VARCHAR (20)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = REPLICATE);

