﻿CREATE TABLE [dbo].[Test] (
    [id]   INT          NOT NULL,
    [Name] VARCHAR (30) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

