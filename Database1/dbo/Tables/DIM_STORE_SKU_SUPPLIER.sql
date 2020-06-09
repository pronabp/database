CREATE TABLE [dbo].[DIM_STORE_SKU_SUPPLIER] (
    [Store]                VARCHAR (20)  NOT NULL,
    [SKU]                  VARCHAR (20)  NOT NULL,
    [UOM]                  VARCHAR (20)  NOT NULL,
    [Supplier]             VARCHAR (20)  NULL,
    [ALT_SUPPLIER_CODE]    VARCHAR (20)  NULL,
    [Supplier_Name]        VARCHAR (100) NULL,
    [Supplier_Description] VARCHAR (200) NULL,
    [Fuel_Supplier]        VARCHAR (20)  NULL,
    [Vendor_GL]            VARCHAR (20)  NULL,
    [SUPPLIER_ADJ_GL]      VARCHAR (20)  NULL,
    [VENDOR_TYPE]          VARCHAR (10)  NULL,
    [Supplier_SKU]         VARCHAR (20)  NULL,
    [Address_Line]         VARCHAR (100) NULL,
    [Address_2]            VARCHAR (100) NULL,
    [City]                 VARCHAR (30)  NULL,
    [Postal_Code]          VARCHAR (20)  NULL,
    [Country]              VARCHAR (20)  NULL,
    [Phone]                VARCHAR (20)  NULL,
    [Fax]                  VARCHAR (20)  NULL,
    [TIMESTAMP]            DATETIME      NULL,
    [start_date]           DATE          NULL,
    [end_date]             DATE          NULL,
    [load_date]            DATETIME      NULL,
    [source_file_name]     VARCHAR (200) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Store]));

