﻿CREATE TABLE [dbo].[TestRound] (
    [id]       INT          NOT NULL,
    [lastName] VARCHAR (20) NULL,
    [zipCode]  VARCHAR (6)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

