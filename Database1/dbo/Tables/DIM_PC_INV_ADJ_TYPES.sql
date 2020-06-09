CREATE TABLE [dbo].[DIM_PC_INV_ADJ_TYPES] (
    [Adj_Type]          VARCHAR (20)  NOT NULL,
    [Description]       VARCHAR (100) NULL,
    [GL]                VARCHAR (20)  NULL,
    [Exported]          VARCHAR (20)  NULL,
    [Purge]             VARCHAR (20)  NULL,
    [TIMESTAMP]         DATETIME      NULL,
    [Type]              VARCHAR (20)  NULL,
    [USE_IN_RATIO_FLAG] VARCHAR (20)  NULL,
    [start_date]        DATE          NULL,
    [end_date]          DATE          NULL,
    [load_date]         DATETIME      NULL,
    [source_file_name]  VARCHAR (200) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Adj_Type]));

