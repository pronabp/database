CREATE TABLE [dbo].[EG_POS_HEADER_APPROVAL] (
    [BusinessUnitID]        VARCHAR (70)  NULL,
    [WorkstationID]         VARCHAR (70)  NULL,
    [POSTXSequenceNumber]   VARCHAR (70)  NULL,
    [POSTXID]               VARCHAR (70)  NULL,
    [POSTXEndDateTime]      DATETIME      NULL,
    [BusinessDayDate]       DATE          NULL,
    [ApprovalSeqID]         VARCHAR (100) NULL,
    [ApproverID]            VARCHAR (100) NULL,
    [ApproverName]          VARCHAR (100) NULL,
    [ApproverType]          VARCHAR (100) NULL,
    [ApprovalDescription]   VARCHAR (250) NULL,
    [BusinessRule]          VARCHAR (400) NULL,
    [BusinessActionMessage] VARCHAR (400) NULL,
    [BusinessActionType]    VARCHAR (100) NULL,
    [IsApproved]            VARCHAR (50)  NULL,
    [source_file_name]      VARCHAR (200) NULL,
    [load_date]             DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

