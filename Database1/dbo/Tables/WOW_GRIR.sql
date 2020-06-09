CREATE TABLE [dbo].[WOW_GRIR] (
    [PurchaseDocument]   VARCHAR (20)  NOT NULL,
    [Store]              VARCHAR (10)  NOT NULL,
    [VendorNo]           VARCHAR (15)  NULL,
    [VendorCustomerName] VARCHAR (100) NULL,
    [VendorName]         VARCHAR (100) NULL,
    [PostingDate]        DATE          NOT NULL,
    [GRAmountLC]         DECIMAL (18)  NULL,
    [RtvGRAmt]           DECIMAL (18)  NULL,
    [IRAmtLC]            DECIMAL (18)  NULL,
    [DocumentDate]       DATE          NULL,
    [InvoiceNo]          VARCHAR (20)  NULL,
    [DocumentValue]      VARCHAR (20)  NULL,
    [DeliveryNoteNumber] VARCHAR (30)  NULL,
    [Amount]             DECIMAL (18)  NULL,
    [SourceFileName]     VARCHAR (100) NULL,
    [LoadDate]           DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN, PARTITION([PostingDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

