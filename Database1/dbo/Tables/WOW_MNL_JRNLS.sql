CREATE TABLE [dbo].[WOW_MNL_JRNLS] (
    [CompanyCode]         VARCHAR (10)  NULL,
    [GLAccount]           VARCHAR (10)  NOT NULL,
    [GLAccountName]       VARCHAR (100) NULL,
    [BatchNo]             VARCHAR (30)  NULL,
    [DcoumentType]        VARCHAR (5)   NULL,
    [DocumentNo]          VARCHAR (20)  NULL,
    [Litm]                INT           NULL,
    [DoccumentValue]      DECIMAL (18)  NULL,
    [VendorNo]            VARCHAR (20)  NULL,
    [VendorCustomerName]  VARCHAR (100) NULL,
    [PostingDate]         DATE          NOT NULL,
    [DocumentDate]        DATE          NOT NULL,
    [EntryDate]           DATE          NOT NULL,
    [ProfitCentre]        VARCHAR (20)  NULL,
    [Pe]                  INT           NULL,
    [Year]                INT           NULL,
    [UserName]            VARCHAR (20)  NULL,
    [InvoiceNo]           VARCHAR (50)  NULL,
    [TradeDepartment]     VARCHAR (80)  NULL,
    [TextLineDescription] VARCHAR (100) NULL,
    [SourceFileName]      VARCHAR (100) NULL,
    [LoadDate]            DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN, PARTITION([PostingDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

