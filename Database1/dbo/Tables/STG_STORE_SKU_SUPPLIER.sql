CREATE TABLE [dbo].[STG_STORE_SKU_SUPPLIER] (
    [Store]                VARCHAR (100) NULL,
    [SKU]                  VARCHAR (100) NULL,
    [UOM]                  VARCHAR (100) NULL,
    [Supplier]             VARCHAR (100) NULL,
    [ALT_SUPPLIER_CODE]    VARCHAR (100) NULL,
    [Supplier_Name]        VARCHAR (100) NULL,
    [Supplier_Description] VARCHAR (100) NULL,
    [Fuel_Supplier]        VARCHAR (100) NULL,
    [Vendor_GL]            VARCHAR (100) NULL,
    [SUPPLIER_ADJ_GL]      VARCHAR (100) NULL,
    [VENDOR_TYPE]          VARCHAR (100) NULL,
    [Supplier_SKU]         VARCHAR (100) NULL,
    [Address_Line]         VARCHAR (100) NULL,
    [Address_2]            VARCHAR (100) NULL,
    [City]                 VARCHAR (100) NULL,
    [Postal_Code]          VARCHAR (100) NULL,
    [Country]              VARCHAR (100) NULL,
    [Phone]                VARCHAR (100) NULL,
    [Fax]                  VARCHAR (100) NULL,
    [TIMESTAMP]            VARCHAR (100) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

