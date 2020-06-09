CREATE TABLE [enable].[OUT_ENABLE_VENDOR] (
    [Vendor_Name]               VARCHAR (100) NULL,
    [Vendor_Reference]          VARCHAR (100) NULL,
    [Vendor_Type]               VARCHAR (100) NULL,
    [External_Vendor_Reference] VARCHAR (100) NULL,
    [Vendor_ID]                 VARCHAR (100) NULL,
    [Load_Date]                 DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

