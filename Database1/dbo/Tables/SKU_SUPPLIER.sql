CREATE TABLE [dbo].[SKU_SUPPLIER] (
    [sku]                  VARCHAR (20)  NOT NULL,
    [uom]                  VARCHAR (20)  NULL,
    [supplier]             VARCHAR (20)  NOT NULL,
    [store]                VARCHAR (20)  NOT NULL,
    [reorder_formula_code] VARCHAR (20)  NULL,
    [exported]             VARCHAR (20)  NULL,
    [purge]                VARCHAR (20)  NULL,
    [exported_to_ho]       VARCHAR (20)  NULL,
    [timestamp]            VARCHAR (30)  NULL,
    [source_file_name]     VARCHAR (100) NULL,
    [load_date]            VARCHAR (30)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([sku]));


GO
CREATE NONCLUSTERED INDEX [store_Index]
    ON [dbo].[SKU_SUPPLIER]([store] ASC);


GO
CREATE NONCLUSTERED INDEX [supplier_Index]
    ON [dbo].[SKU_SUPPLIER]([supplier] ASC);

