CREATE TABLE [dbo].[EG_POS_PAID_IN_OUT] (
    [BusinessUnitID]          VARCHAR (50)    NULL,
    [WorkstationID]           VARCHAR (50)    NULL,
    [POSTXSequenceNumber]     VARCHAR (50)    NULL,
    [POSTXID]                 VARCHAR (50)    NULL,
    [POSTXEndDateTime]        DATETIME        NULL,
    [BusinessDayDate]         DATE            NULL,
    [TenderID]                VARCHAR (10)    NULL,
    [TenderType]              VARCHAR (10)    NULL,
    [PaidAmount]              DECIMAL (20, 4) NULL,
    [PaidReason]              VARCHAR (200)   NULL,
    [PaidCurrency]            VARCHAR (10)    NULL,
    [AccountSource]           VARCHAR (50)    NULL,
    [AccountDestination]      VARCHAR (50)    NULL,
    [Total]                   DECIMAL (20, 4) NULL,
    [TotalTaxAmount]          DECIMAL (20, 4) NULL,
    [TotalTaxExclusiveAmount] DECIMAL (20, 4) NULL,
    [TotalTaxInclusiveAmount] DECIMAL (20, 4) NULL,
    [TotalCurrencyCode]       VARCHAR (10)    NULL,
    [source_file_name]        VARCHAR (100)   NULL,
    [load_date]               DATE            NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [POSTXID_Index]
    ON [dbo].[EG_POS_PAID_IN_OUT]([POSTXID] ASC);


GO
CREATE NONCLUSTERED INDEX [POSTXSequenceNumber_Index]
    ON [dbo].[EG_POS_PAID_IN_OUT]([POSTXSequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [WorkstationID_Index]
    ON [dbo].[EG_POS_PAID_IN_OUT]([WorkstationID] ASC);

