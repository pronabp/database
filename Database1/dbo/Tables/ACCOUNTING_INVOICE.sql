CREATE TABLE [dbo].[ACCOUNTING_INVOICE] (
    [Generation_DateTime] DATETIME        NULL,
    [country_id]          VARCHAR (10)    NULL,
    [export_number]       VARCHAR (20)    NULL,
    [batch_number]        VARCHAR (20)    NULL,
    [ordinal_number]      VARCHAR (20)    NULL,
    [origin_store]        VARCHAR (20)    NULL,
    [posting_date]        DATE            NULL,
    [invoice_number]      VARCHAR (20)    NOT NULL,
    [invoice_date]        DATE            NOT NULL,
    [invoice_type]        VARCHAR (20)    NULL,
    [merch_or_fuel]       VARCHAR (20)    NULL,
    [due_date]            DATE            NULL,
    [supplier_id]         VARCHAR (20)    NULL,
    [supplier_name]       VARCHAR (30)    NULL,
    [amount]              DECIMAL (14, 4) NULL,
    [memo]                VARCHAR (50)    NULL,
    [store]               VARCHAR (20)    NOT NULL,
    [gl_account]          VARCHAR (20)    NOT NULL,
    [gl_description]      VARCHAR (50)    NULL,
    [amount2]             DECIMAL (14, 4) NULL,
    [fuel_volume]         DECIMAL (14, 4) NULL,
    [memo3]               VARCHAR (50)    NULL,
    [source_file_name]    VARCHAR (50)    NULL,
    [load_date]           DATE            NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([store]), PARTITION([invoice_date] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [gl_account_Index]
    ON [dbo].[ACCOUNTING_INVOICE]([gl_account] ASC);


GO
CREATE NONCLUSTERED INDEX [invoice_number_Index]
    ON [dbo].[ACCOUNTING_INVOICE]([invoice_number] ASC);


GO
CREATE NONCLUSTERED INDEX [origin_store_Index]
    ON [dbo].[ACCOUNTING_INVOICE]([origin_store] ASC);


GO
CREATE NONCLUSTERED INDEX [supplier_id_Index]
    ON [dbo].[ACCOUNTING_INVOICE]([supplier_id] ASC);

