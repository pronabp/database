CREATE TABLE [dbo].[DIM_MANUFACTURER] (
    [GlobalLocationNumber] VARCHAR (20)  NULL,
    [ManufacturerName]     VARCHAR (250) NULL,
    [Notes]                VARCHAR (100) NULL,
    [ManufacturerGLN]      VARCHAR (100) NULL,
    [CompanyPrefix]        VARCHAR (50)  NULL,
    [Timestamp]            DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

