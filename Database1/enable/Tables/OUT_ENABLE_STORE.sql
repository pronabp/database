CREATE TABLE [enable].[OUT_ENABLE_STORE] (
    [SiteName]      VARCHAR (100) NULL,
    [SiteReference] VARCHAR (100) NULL,
    [StartDate]     DATE          NULL,
    [EndDate]       DATE          NULL,
    [Area]          VARCHAR (100) NULL,
    [Region]        VARCHAR (100) NULL,
    [State]         VARCHAR (100) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

