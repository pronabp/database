﻿CREATE EXTERNAL TABLE [dbo].[EXT_LKP_POSDTA_POSRegisterType] (
    [POSRegisterType] VARCHAR (20) NULL,
    [POSRegisterType_Description] VARCHAR (100) NULL
)
    WITH (
    DATA_SOURCE = [wow-data@egausimdevadlsg2],
    LOCATION = N'/inbound/posdta/wow_posdta_lkp/LKP_POSDTA_POSRegisterType.csv',
    FILE_FORMAT = [CsvFormatWithHeader],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

