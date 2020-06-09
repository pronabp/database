CREATE TABLE [dbo].[DIM_WOW_FISCAL_CALENDAR] (
    [CLNDR_DATE]    DATE          NOT NULL,
    [LITRL_DATE]    VARCHAR (200) NULL,
    [DOW]           INT           NULL,
    [DAY_OF_MT]     INT           NULL,
    [FY]            INT           NULL,
    [FY_START_DATE] DATE          NULL,
    [FY_END_DATE]   DATE          NULL,
    [HOFY]          INT           NULL,
    [FH_START_DATE] DATE          NULL,
    [FH_END_DATE]   DATE          NULL,
    [QOFY]          INT           NULL,
    [FQ_START_DATE] DATE          NULL,
    [FQ_END_DATE]   DATE          NULL,
    [POFY]          INT           NULL,
    [FP_START_DATE] DATE          NULL,
    [FP_END_DATE]   DATE          NULL,
    [WOFY]          INT           NULL,
    [WOFP]          INT           NULL,
    [FW_START_DATE] DATE          NULL,
    [FW_END_DATE]   DATE          NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = REPLICATE);

