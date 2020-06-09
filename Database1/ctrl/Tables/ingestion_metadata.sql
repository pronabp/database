CREATE TABLE [ctrl].[ingestion_metadata] (
    [azure_name]    VARCHAR (250) NULL,
    [azure_key]     VARCHAR (250) NULL,
    [azure_value]   VARCHAR (250) NULL,
    [azure_process] VARCHAR (250) NULL,
    [azure_id]      INT           IDENTITY (1, 1) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

