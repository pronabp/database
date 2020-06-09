CREATE TABLE [dbo].[EG_POS_ITEMLINE_TENDER_REWARDS] (
    [BusinessUnitID]       VARCHAR (50)    NULL,
    [WorkstationID]        VARCHAR (50)    NULL,
    [POSTXSequenceNumber]  VARCHAR (50)    NULL,
    [POSTXID]              VARCHAR (50)    NULL,
    [POSTXEndDateTime]     DATETIME        NULL,
    [BusinessDayDate]      DATE            NULL,
    [LineItemSequence]     INT             NULL,
    [TRSequenceNumber]     INT             NULL,
    [Type]                 VARCHAR (20)    NULL,
    [Value]                DECIMAL (20, 4) NULL,
    [PromotionID]          VARCHAR (20)    NULL,
    [Description]          VARCHAR (250)   NULL,
    [TriggerQuantity]      DECIMAL (20, 4) NULL,
    [TriggerQuantityUnits] DECIMAL (20, 4) NULL,
    [TriggerQuantityUoM]   VARCHAR (10)    NULL,
    [EntryMethod]          VARCHAR (20)    NULL,
    [ApportionmentAmount]  DECIMAL (20, 4) NULL,
    [Currency]             VARCHAR (10)    NULL,
    [Participator]         VARCHAR (50)    NULL,
    [RewardSplitAmount]    DECIMAL (20, 4) NULL,
    [RewardSplitCurrency]  VARCHAR (10)    NULL,
    [RewardLevel]          VARCHAR (10)    NULL,
    [source_file_name]     VARCHAR (100)   NULL,
    [load_date]            DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [LineItemSequence_Index]
    ON [dbo].[EG_POS_ITEMLINE_TENDER_REWARDS]([LineItemSequence] ASC);


GO
CREATE NONCLUSTERED INDEX [POSTXID_Index]
    ON [dbo].[EG_POS_ITEMLINE_TENDER_REWARDS]([POSTXID] ASC);


GO
CREATE NONCLUSTERED INDEX [POSTXSequenceNumber_Index]
    ON [dbo].[EG_POS_ITEMLINE_TENDER_REWARDS]([POSTXSequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [WorkstationID_Index]
    ON [dbo].[EG_POS_ITEMLINE_TENDER_REWARDS]([WorkstationID] ASC);

