CREATE TABLE [meta].[Cutoff_Store] (
    [Store]      VARCHAR (50) NULL,
    [Cutoffdate] DATE         NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

