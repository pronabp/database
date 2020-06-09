CREATE TABLE [dbo].[EG_POS_LOYALTY_SUMMARY] (
    [BusinessUnitID]      VARCHAR (50)    NULL,
    [WorkstationID]       VARCHAR (50)    NULL,
    [POSTXSequenceNumber] VARCHAR (50)    NULL,
    [POSTXID]             VARCHAR (50)    NULL,
    [POSTXEndDateTime]    DATETIME        NULL,
    [BusinessDayDate]     DATE            NULL,
    [LoyaltyAccountID]    VARCHAR (50)    NULL,
    [LoyaltyAccountDesc]  VARCHAR (250)   NULL,
    [OpenBalance]         DECIMAL (20, 4) NULL,
    [Balance]             DECIMAL (20, 4) NULL,
    [Redeemed]            DECIMAL (20, 4) NULL,
    [PointsEarned]        DECIMAL (20, 4) NULL,
    [source_file_name]    VARCHAR (100)   NULL,
    [load_date]           DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

