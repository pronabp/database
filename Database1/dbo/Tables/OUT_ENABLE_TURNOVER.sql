CREATE TABLE [dbo].[OUT_ENABLE_TURNOVER] (
    [Date]              NVARCHAR (MAX)  NULL,
    [Vendor]            NVARCHAR (MAX)  NULL,
    [Product]           NVARCHAR (MAX)  NULL,
    [Promotion]         NVARCHAR (MAX)  NULL,
    [Site]              NVARCHAR (MAX)  NULL,
    [TransactionType]   NVARCHAR (MAX)  NULL,
    [Units]             NVARCHAR (MAX)  NULL,
    [Value]             DECIMAL (14, 2) NULL,
    [Currency]          NVARCHAR (MAX)  NULL,
    [ExternalReference] NVARCHAR (MAX)  NULL,
    [InterfaceDate]     DATE            NULL
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

