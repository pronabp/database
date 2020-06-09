CREATE TABLE [dbo].[EG_POS_ITEMLINE_APPROVAL] (
    [BusinessUnitID]                VARCHAR (50)  NULL,
    [WorkstationID]                 VARCHAR (50)  NULL,
    [POSTXSequenceNumber]           VARCHAR (50)  NULL,
    [POSTXID]                       VARCHAR (50)  NULL,
    [POSTXEndDateTime]              DATETIME      NULL,
    [BusinessDayDate]               DATE          NULL,
    [LineItemSequence]              INT           NULL,
    [ApprovalSequenceNumber]        INT           NULL,
    [ApproverID]                    VARCHAR (20)  NULL,
    [ApproverType]                  VARCHAR (20)  NULL,
    [ApproverName]                  VARCHAR (50)  NULL,
    [ApprovalDescription]           VARCHAR (200) NULL,
    [ApprovalBusinessActionMessage] VARCHAR (400) NULL,
    [ApprovalBusinessActionType]    VARCHAR (100) NULL,
    [ApprovalIsApproved]            VARCHAR (10)  NULL,
    [ApprovalReasonGroup]           VARCHAR (100) NULL,
    [ApprovalReasonName]            VARCHAR (100) NULL,
    [ApprovalReasonCode]            VARCHAR (100) NULL,
    [source_file_name]              VARCHAR (100) NULL,
    [load_date]                     DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

