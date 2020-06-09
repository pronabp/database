CREATE TABLE [dbo].[EG_STORE_EOD] (
    [BusinessUnitID]                    VARCHAR (50)    NULL,
    [WorkstationID]                     VARCHAR (50)    NULL,
    [POSTXSequenceNumber]               VARCHAR (50)    NULL,
    [POSTXID]                           VARCHAR (50)    NULL,
    [POSTXEndDateTime]                  DATETIME        NULL,
    [BusinessDayDate]                   DATE            NULL,
    [FinanceDate]                       DATE            NULL,
    [RetailSummaryTransactionCount]     INT             NULL,
    [RetailSummaryGrossSales]           DECIMAL (20, 4) NULL,
    [RetailSummaryCurrency]             VARCHAR (10)    NULL,
    [RetailSummaryGST]                  DECIMAL (20, 4) NULL,
    [CashOfficeSummaryTransactionCount] INT             NULL,
    [CashOfficeSummaryGrossAmount]      DECIMAL (20, 4) NULL,
    [CashOfficeSummaryCurrency]         VARCHAR (10)    NULL,
    [CashOfficeSummaryGST]              DECIMAL (20, 4) NULL,
    [TotalTenderLoan]                   DECIMAL (20, 4) NULL,
    [TotalTenderPickup]                 DECIMAL (20, 4) NULL,
    [TotalSafeTransfer]                 DECIMAL (20, 4) NULL,
    [TotalBankDeposit]                  DECIMAL (20, 4) NULL,
    [TotalBankReceipt]                  DECIMAL (20, 4) NULL,
    [TotalPaidIn]                       DECIMAL (20, 4) NULL,
    [TotalPaidInGST]                    DECIMAL (20, 4) NULL,
    [TotalPaidOut]                      DECIMAL (20, 4) NULL,
    [TotalPaidOutGST]                   DECIMAL (20, 4) NULL,
    [TotalAutoTenderPickup]             DECIMAL (20, 4) NULL,
    [TotalAutoReconcileTender]          DECIMAL (20, 4) NULL,
    [TotalPosTransfer]                  DECIMAL (20, 4) NULL,
    [TotalDeclarations]                 DECIMAL (20, 4) NULL,
    [source_file_name]                  VARCHAR (100)   NULL,
    [load_date]                         DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [POSTXID_Index]
    ON [dbo].[EG_STORE_EOD]([POSTXID] ASC);


GO
CREATE NONCLUSTERED INDEX [POSTXSequenceNumber_Index]
    ON [dbo].[EG_STORE_EOD]([POSTXSequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [WorkstationID_Index]
    ON [dbo].[EG_STORE_EOD]([WorkstationID] ASC);

