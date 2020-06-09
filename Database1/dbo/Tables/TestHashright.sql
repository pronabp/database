CREATE TABLE [dbo].[TestHashright] (
    [id]           INT          NOT NULL,
    [On_Hand_Date] DATE         NULL,
    [lastName]     VARCHAR (20) NULL,
    [zipCode]      VARCHAR (6)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([id]), PARTITION([On_Hand_Date] RANGE RIGHT FOR VALUES ('01/01/1992 00:00:00', '02/01/1992 00:00:00', '03/01/1992 00:00:00', '04/01/1992 00:00:00', '05/01/1992 00:00:00')));

