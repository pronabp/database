﻿CREATE TABLE [dbo].[TESTJOSN] (
    [id]     VARCHAR (10) NULL,
    [lang]   VARCHAR (30) NULL,
    [editin] VARCHAR (30) NULL,
    [auth]   VARCHAR (30) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

