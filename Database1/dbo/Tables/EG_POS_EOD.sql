CREATE TABLE [dbo].[EG_POS_EOD] (
    [BusinessUnitID]        VARCHAR (50)    NULL,
    [WorkstationID]         VARCHAR (50)    NULL,
    [POSTXSequenceNumber]   VARCHAR (50)    NULL,
    [POSTXID]               VARCHAR (50)    NULL,
    [POSTXEndDateTime]      DATETIME        NULL,
    [BusinessDayDate]       DATE            NULL,
    [TillID]                VARCHAR (50)    NULL,
    [OpenBusinessDayDate]   DATE            NULL,
    [CloseBusinessDayDate]  DATE            NULL,
    [TotalTransactionCount] INT             NULL,
    [TotalNetSalesAmount]   DECIMAL (20, 4) NULL,
    [TotalNetSalesCurrency] VARCHAR (10)    NULL,
    [TotalNetReturnAmount]  DECIMAL (20, 4) NULL,
    [TotalTaxAmount]        DECIMAL (20, 4) NULL,
    [GrossPositiveAmount]   DECIMAL (20, 4) NULL,
    [LoanAmount]            DECIMAL (20, 4) NULL,
    [LoanAmountCurrency]    VARCHAR (10)    NULL,
    [TenderPickupAmount]    DECIMAL (20, 4) NULL,
    [TenderPickupCurrency]  VARCHAR (10)    NULL,
    [RefundAmount]          DECIMAL (20, 4) NULL,
    [RefundAmountCurrency]  VARCHAR (10)    NULL,
    [PaidInAmount]          DECIMAL (20, 4) NULL,
    [PaidInCurrency]        VARCHAR (10)    NULL,
    [PaidOutAmount]         DECIMAL (20, 4) NULL,
    [PaidOutCurrency]       VARCHAR (10)    NULL,
    [TenderID]              INT             NULL,
    [TenderCount]           INT             NULL,
    [TenderDescription]     VARCHAR (250)   NULL,
    [TenderSalesType]       VARCHAR (20)    NULL,
    [TenderSalesAmount]     DECIMAL (20, 4) NULL,
    [TenderSalesCurrency]   VARCHAR (10)    NULL,
    [source_file_name]      VARCHAR (100)   NULL,
    [load_date]             DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [POSTXID_Index]
    ON [dbo].[EG_POS_EOD]([POSTXID] ASC);


GO
CREATE NONCLUSTERED INDEX [POSTXSequenceNumber_Index]
    ON [dbo].[EG_POS_EOD]([POSTXSequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [WorkstationID_Index]
    ON [dbo].[EG_POS_EOD]([WorkstationID] ASC);

