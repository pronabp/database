﻿CREATE TABLE [dbo].[CTRL_DELTA_LOAD] (
    [JOB_NAME]      VARCHAR (100) NULL,
    [RUN_DATETIME]  DATETIME      NULL,
    [FROM_DATETIME] DATETIME      NULL,
    [TO_DATETIME]   DATETIME      NULL,
    [SUCCESS_FLAG]  VARCHAR (5)   NULL,
    [TOTAL_RECORDS] INT           NULL,
    [FILE_NAME]     VARCHAR (100) NULL,
    [CURRENT_FLAG]  VARCHAR (5)   NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([JOB_NAME]));


GO
CREATE NONCLUSTERED INDEX [CURRENT_FLAG_Index]
    ON [dbo].[CTRL_DELTA_LOAD]([CURRENT_FLAG] ASC);

