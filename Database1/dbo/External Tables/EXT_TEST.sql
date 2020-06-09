CREATE EXTERNAL TABLE [dbo].[EXT_TEST] (
    [Site_no] VARCHAR (50) NULL,
    [site_name] VARCHAR (200) NULL,
    [Article_no] VARCHAR (50) NULL,
    [Article_desc] VARCHAR (200) NULL,
    [STOCK_QTY] DECIMAL (20, 4) NULL
)
    WITH (
    DATA_SOURCE = [DLStorage],
    LOCATION = N'/inbound/EG_USER/SITE_SOH.csv',
    FILE_FORMAT = [CsvFormatWithHeader],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

