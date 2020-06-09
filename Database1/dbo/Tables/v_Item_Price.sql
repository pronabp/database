CREATE TABLE [dbo].[v_Item_Price] (
    [SKU]              VARCHAR (25)    NULL,
    [SKU_Name]         NVARCHAR (60)   NULL,
    [UOM]              VARCHAR (3)     NULL,
    [Store]            VARCHAR (5)     NULL,
    [UPC]              VARCHAR (25)    NULL,
    [Price]            DECIMAL (11, 4) NULL,
    [Termination_Date] CHAR (8)        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

