CREATE TABLE [dbo].[EG_WOW_SWITCH_TRANS] (
    [Header]                 VARCHAR (10)  NULL,
    [MessageTypeIndicator]   VARCHAR (100) NULL,
    [Timestamp]              VARCHAR (100) NULL,
    [MaskedPAN]              VARCHAR (100) NULL,
    [TerminalID]             VARCHAR (100) NULL,
    [RetrievalReferenceNo]   VARCHAR (100) NULL,
    [TransactionAmount]      VARCHAR (100) NULL,
    [TransactionType]        VARCHAR (100) NULL,
    [Account]                VARCHAR (100) NULL,
    [ResponseCode]           VARCHAR (100) NULL,
    [WoolworthsStoreNo]      VARCHAR (100) NULL,
    [EGStoreNo]              VARCHAR (100) NULL,
    [TransactionDisposition] VARCHAR (100) NULL,
    [FuelCardIndicator]      VARCHAR (1)   NULL,
    [LoadDate]               DATETIME      NULL,
    [LoadfileName]           VARCHAR (100) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

