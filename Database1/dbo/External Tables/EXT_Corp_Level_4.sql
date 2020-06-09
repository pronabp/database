CREATE EXTERNAL TABLE [dbo].[EXT_Corp_Level_4] (
    [Corp_Lvl1] VARCHAR (100) NULL,
    [Corp_Lvl2] VARCHAR (100) NULL,
    [Corp_Lvl3] VARCHAR (100) NULL,
    [Corp_Lvl4] VARCHAR (100) NULL,
    [Name] VARCHAR (100) NULL,
    [Adress_Line_1] VARCHAR (100) NULL,
    [Addres_Line_2] VARCHAR (100) NULL,
    [City] VARCHAR (100) NULL,
    [State] VARCHAR (100) NULL,
    [ZIP] VARCHAR (100) NULL,
    [Tel_1] VARCHAR (100) NULL,
    [Tel_2] VARCHAR (100) NULL,
    [Fax] VARCHAR (100) NULL,
    [Person] VARCHAR (100) NULL,
    [Exported] VARCHAR (100) NULL,
    [Purge] VARCHAR (100) NULL,
    [TIMESTAMP] VARCHAR (100) NULL
)
    WITH (
    DATA_SOURCE = [DataLakeStorage],
    LOCATION = N'/enable/incremental/Corp_Level_4/Corp_Level_4.csv',
    FILE_FORMAT = [CsvFormatWithHeaderComma],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

