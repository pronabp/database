CREATE EXTERNAL TABLE [dbo].[EXT_LKP_POSDTA_ReturnReason] (
    [ReturnReason] VARCHAR (20) NULL,
    [ReturnReason_Group] VARCHAR (20) NULL,
    [ReturnReason_Description] VARCHAR (100) NULL
)
    WITH (
    DATA_SOURCE = [wow-data@egausimdevadlsg2],
    LOCATION = N'/inbound/posdta/wow_posdta_lkp/LKP_POSDTA_ReturnReason.csv',
    FILE_FORMAT = [CsvFormatWithHeader],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

