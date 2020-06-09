CREATE TABLE [ctrl].[CNTRL_ERROR_LOGS] (
    [JobName]       VARCHAR (50)  NULL,
    [ProcedureName] VARCHAR (50)  NULL,
    [ErrorNumber]   VARCHAR (10)  NULL,
    [ErrorMessage]  VARCHAR (600) NULL,
    [ErrorDate]     DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

