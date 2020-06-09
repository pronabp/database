CREATE TABLE [dbo].[EG_POS_CUSTOMER] (
    [BusinessUnitID]             VARCHAR (50)  NULL,
    [WorkstationID]              VARCHAR (50)  NULL,
    [POSTXSequenceNumber]        VARCHAR (50)  NULL,
    [POSTXID]                    VARCHAR (50)  NULL,
    [POSTXEndDateTime]           DATETIME      NULL,
    [BusinessDayDate]            DATE          NULL,
    [CustomerID]                 VARCHAR (50)  NULL,
    [CustomerName]               VARCHAR (200) NULL,
    [GivenName]                  VARCHAR (100) NULL,
    [FamilyName]                 VARCHAR (100) NULL,
    [EMailAddress]               VARCHAR (100) NULL,
    [PhoneNumber]                VARCHAR (20)  NULL,
    [ScanData]                   VARCHAR (50)  NULL,
    [CustomerExternalId]         VARCHAR (100) NULL,
    [CustomerType]               VARCHAR (50)  NULL,
    [LoyaltyCardScannedTime]     DATETIME      NULL,
    [EntryMethod]                VARCHAR (50)  NULL,
    [IsAuthenticatedOffline]     VARCHAR (50)  NULL,
    [IsAnonymous]                VARCHAR (50)  NULL,
    [RetroactiveProcessActivate] VARCHAR (50)  NULL,
    [LicensePlateID]             VARCHAR (50)  NULL,
    [VehicleModel]               VARCHAR (50)  NULL,
    [VehicleColor]               VARCHAR (50)  NULL,
    [AdditionalInfo]             VARCHAR (200) NULL,
    [source_file_name]           VARCHAR (100) NULL,
    [load_date]                  DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));


GO
CREATE NONCLUSTERED INDEX [WorkstationID_Index]
    ON [dbo].[EG_POS_CUSTOMER]([WorkstationID] ASC);


GO
CREATE NONCLUSTERED INDEX [POSTXSequenceNumber_Index]
    ON [dbo].[EG_POS_CUSTOMER]([POSTXSequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [POSTXID_Index]
    ON [dbo].[EG_POS_CUSTOMER]([POSTXID] ASC);

