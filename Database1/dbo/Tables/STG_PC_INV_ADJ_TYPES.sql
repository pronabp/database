CREATE TABLE [dbo].[STG_PC_INV_ADJ_TYPES] (
    [Adj_Type]          VARCHAR (100) NOT NULL,
    [Description]       VARCHAR (100) NULL,
    [GL]                VARCHAR (100) NULL,
    [Exported]          VARCHAR (100) NULL,
    [Purge]             VARCHAR (100) NULL,
    [TIMESTAMP]         VARCHAR (100) NULL,
    [Type]              VARCHAR (100) NULL,
    [USE_IN_RATIO_FLAG] VARCHAR (20)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

