CREATE TABLE [dbo].[EG_POS_ITEMLINE_DEFERRED_REWARDS] (
    [BusinessUnitID]      VARCHAR (50)    NULL,
    [WorkstationID]       VARCHAR (50)    NULL,
    [POSTXSequenceNumber] VARCHAR (50)    NULL,
    [POSTXID]             VARCHAR (50)    NULL,
    [POSTXEndDateTime]    DATETIME        NULL,
    [BusinessDayDate]     DATE            NULL,
    [LineItemSequence]    INT             NULL,
    [DRSequenceNumber]    INT             NULL,
    [PromotionID]         VARCHAR (20)    NULL,
    [DeferredID]          VARCHAR (20)    NULL,
    [DeferredRewardDesc]  VARCHAR (200)   NULL,
    [DeferredRewardType]  VARCHAR (20)    NULL,
    [DeferredRewardValue] DECIMAL (20, 4) NULL,
    [TriggerQuantity]     DECIMAL (20, 4) NULL,
    [TriggerAmount]       DECIMAL (20, 4) NULL,
    [ApportionmentAmount] DECIMAL (20, 4) NULL,
    [Currency]            VARCHAR (10)    NULL,
    [Participator]        VARCHAR (20)    NULL,
    [RewardSplitAmount]   DECIMAL (20, 4) NULL,
    [RewardLevel]         INT             NULL,
    [source_file_name]    VARCHAR (100)   NULL,
    [load_date]           DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

