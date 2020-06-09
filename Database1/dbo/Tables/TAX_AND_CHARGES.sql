CREATE TABLE [dbo].[TAX_AND_CHARGES] (
    [taxcharge_code]        VARCHAR (10)  NOT NULL,
    [type]                  VARCHAR (10)  NULL,
    [sub_type]              VARCHAR (10)  NULL,
    [name]                  VARCHAR (50)  NULL,
    [applies_on]            VARCHAR (50)  NULL,
    [gl]                    VARCHAR (10)  NOT NULL,
    [value]                 VARCHAR (10)  NULL,
    [tax_type]              VARCHAR (10)  NULL,
    [from_date]             VARCHAR (30)  NULL,
    [to_date]               VARCHAR (30)  NULL,
    [consumption_tax]       VARCHAR (10)  NULL,
    [tax_value_for_purch]   VARCHAR (10)  NULL,
    [calculation_precision] VARCHAR (10)  NULL,
    [withhold_liability_gl] VARCHAR (10)  NULL,
    [exported]              VARCHAR (10)  NULL,
    [especifico_tax]        VARCHAR (10)  NULL,
    [used_internally]       VARCHAR (10)  NULL,
    [allow_low_modify]      VARCHAR (10)  NULL,
    [enforce_for_os]        VARCHAR (10)  NULL,
    [inventory_payout]      VARCHAR (10)  NULL,
    [purge]                 VARCHAR (10)  NULL,
    [timestamp]             VARCHAR (40)  NULL,
    [def_number_of_days]    VARCHAR (10)  NULL,
    [source_file_name]      VARCHAR (100) NULL,
    [load_date]             DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([from_date]), PARTITION([to_date] RANGE FOR VALUES ('01/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2020 00:00:00', '02/01/2021 00:00:00', '03/01/2020 00:00:00', '03/01/2021 00:00:00', '04/01/2020 00:00:00', '04/01/2021 00:00:00', '05/01/2020 00:00:00', '05/01/2021 00:00:00', '06/01/2020 00:00:00', '06/01/2021 00:00:00', '07/01/2020 00:00:00', '07/01/2021 00:00:00', '08/01/2020 00:00:00', '08/01/2021 00:00:00', '09/01/2020 00:00:00', '09/01/2021 00:00:00', '10/01/2020 00:00:00', '10/01/2021 00:00:00', '11/01/2020 00:00:00', '11/01/2021 00:00:00', '12/01/2019 00:00:00', '12/01/2020 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [taxcharge_code_Index]
    ON [dbo].[TAX_AND_CHARGES]([taxcharge_code] ASC);

