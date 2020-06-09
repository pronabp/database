﻿CREATE TABLE [dbo].[WOW_POSDTA_HEADERS_TLOG] (
    [TXNStartTimestamp]          DATETIME      NULL,
    [SiteNumber]                 VARCHAR (50)  NOT NULL,
    [POSNumber]                  VARCHAR (50)  NOT NULL,
    [POSTXNNumber]               VARCHAR (50)  NOT NULL,
    [POSTXNIndex]                VARCHAR (50)  NULL,
    [BusinessDate]               DATE          NULL,
    [POSTXNType]                 VARCHAR (50)  NULL,
    [POSTXNTypeGroup]            VARCHAR (50)  NULL,
    [POSRegisterType]            VARCHAR (50)  NULL,
    [RegisterUsageType]          VARCHAR (50)  NULL,
    [TransactionReason]          VARCHAR (50)  NULL,
    [TrainingFlag]               VARCHAR (50)  NULL,
    [Staff_Flag]                 VARCHAR (50)  NULL,
    [SalesChannelCode]           VARCHAR (50)  NULL,
    [SalesOrg]                   VARCHAR (50)  NULL,
    [CustomerOrderNumber]        VARCHAR (50)  NULL,
    [FulfilmentOrderNumber]      VARCHAR (50)  NULL,
    [CustomerOrderDate]          DATE          NULL,
    [Cashier]                    VARCHAR (50)  NULL,
    [CashierPosition]            VARCHAR (50)  NULL,
    [LoyaltyCardNumber]          VARCHAR (50)  NULL,
    [StaffCardNumber]            VARCHAR (50)  NULL,
    [POSTXNEndTimestamp]         DATETIME      NULL,
    [POSTXNCurrency]             VARCHAR (50)  NULL,
    [SalesAmount]                FLOAT (53)    NULL,
    [TaxableAmount]              FLOAT (53)    NULL,
    [TaxAmount]                  FLOAT (53)    NULL,
    [WOWDollarAccrued]           FLOAT (53)    NULL,
    [LaybyStatus]                VARCHAR (50)  NULL,
    [LaybyAccountNumber]         VARCHAR (50)  NULL,
    [LaybyDueDate]               DATE          NULL,
    [LaybyOutstandingAmount]     VARCHAR (50)  NULL,
    [ReferenceTXNStartTimestamp] DATETIME      NULL,
    [ReferenceSiteNumber]        VARCHAR (50)  NULL,
    [ReferencePOSNumber]         VARCHAR (50)  NULL,
    [ReferencePOSTXNNumber]      VARCHAR (50)  NULL,
    [ReferenceBusinessDate]      DATE          NULL,
    [ReferenceReasonCode]        VARCHAR (50)  NULL,
    [TXNCreationTimestamp]       DATETIME      NULL,
    [SourceSystem]               VARCHAR (50)  NULL,
    [SourceName]                 VARCHAR (100) NULL,
    [EGLoadDate]                 DATETIME      NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([SiteNumber]), PARTITION([BusinessDate] RANGE FOR VALUES ('01/01/2015 00:00:00', '02/01/2015 00:00:00', '03/01/2015 00:00:00', '04/01/2015 00:00:00', '05/01/2015 00:00:00', '06/01/2015 00:00:00', '07/01/2015 00:00:00', '08/01/2015 00:00:00', '09/01/2015 00:00:00', '10/01/2015 00:00:00', '11/01/2015 00:00:00', '12/01/2015 00:00:00', '01/01/2016 00:00:00', '02/01/2016 00:00:00', '03/01/2016 00:00:00', '04/01/2016 00:00:00', '05/01/2016 00:00:00', '06/01/2016 00:00:00', '07/01/2016 00:00:00', '08/01/2016 00:00:00', '09/01/2016 00:00:00', '10/01/2016 00:00:00', '11/01/2016 00:00:00', '12/01/2016 00:00:00', '01/01/2017 00:00:00', '02/01/2017 00:00:00', '03/01/2017 00:00:00', '04/01/2017 00:00:00', '05/01/2017 00:00:00', '06/01/2017 00:00:00', '07/01/2017 00:00:00', '08/01/2017 00:00:00', '09/01/2017 00:00:00', '10/01/2017 00:00:00', '11/01/2017 00:00:00', '12/01/2017 00:00:00', '01/01/2018 00:00:00', '02/01/2018 00:00:00', '03/01/2018 00:00:00', '04/01/2018 00:00:00', '05/01/2018 00:00:00', '06/01/2018 00:00:00', '07/01/2018 00:00:00', '08/01/2018 00:00:00', '09/01/2018 00:00:00', '10/01/2018 00:00:00', '11/01/2018 00:00:00', '12/01/2018 00:00:00', '01/01/2019 00:00:00', '02/01/2019 00:00:00', '03/01/2019 00:00:00', '04/01/2019 00:00:00', '05/01/2019 00:00:00', '06/01/2019 00:00:00', '07/01/2019 00:00:00', '08/01/2019 00:00:00', '09/01/2019 00:00:00', '10/01/2019 00:00:00', '11/01/2019 00:00:00', '12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00', '01/01/2022 00:00:00', '02/01/2022 00:00:00', '03/01/2022 00:00:00', '04/01/2022 00:00:00', '05/01/2022 00:00:00', '06/01/2022 00:00:00', '07/01/2022 00:00:00', '08/01/2022 00:00:00', '09/01/2022 00:00:00', '10/01/2022 00:00:00', '11/01/2022 00:00:00', '12/01/2022 00:00:00', '01/01/2023 00:00:00', '02/01/2023 00:00:00', '03/01/2023 00:00:00', '04/01/2023 00:00:00', '05/01/2023 00:00:00', '06/01/2023 00:00:00', '07/01/2023 00:00:00', '08/01/2023 00:00:00', '09/01/2023 00:00:00', '10/01/2023 00:00:00', '11/01/2023 00:00:00', '12/01/2023 00:00:00', '01/01/2024 00:00:00', '02/01/2024 00:00:00', '03/01/2024 00:00:00', '04/01/2024 00:00:00', '05/01/2024 00:00:00', '06/01/2024 00:00:00', '07/01/2024 00:00:00', '08/01/2024 00:00:00', '09/01/2024 00:00:00', '10/01/2024 00:00:00', '11/01/2024 00:00:00', '12/01/2024 00:00:00', '01/01/2025 00:00:00', '02/01/2025 00:00:00', '03/01/2025 00:00:00', '04/01/2025 00:00:00', '05/01/2025 00:00:00', '06/01/2025 00:00:00', '07/01/2025 00:00:00', '08/01/2025 00:00:00', '09/01/2025 00:00:00', '10/01/2025 00:00:00', '11/01/2025 00:00:00', '12/01/2025 00:00:00', '01/01/2026 00:00:00', '02/01/2026 00:00:00', '03/01/2026 00:00:00', '04/01/2026 00:00:00', '05/01/2026 00:00:00', '06/01/2026 00:00:00', '07/01/2026 00:00:00', '08/01/2026 00:00:00', '09/01/2026 00:00:00', '10/01/2026 00:00:00', '11/01/2026 00:00:00', '12/01/2026 00:00:00', '01/01/2027 00:00:00', '02/01/2027 00:00:00', '03/01/2027 00:00:00', '04/01/2027 00:00:00', '05/01/2027 00:00:00', '06/01/2027 00:00:00', '07/01/2027 00:00:00', '08/01/2027 00:00:00', '09/01/2027 00:00:00', '10/01/2027 00:00:00', '11/01/2027 00:00:00', '12/01/2027 00:00:00', '01/01/2028 00:00:00', '02/01/2028 00:00:00', '03/01/2028 00:00:00', '04/01/2028 00:00:00', '05/01/2028 00:00:00', '06/01/2028 00:00:00', '07/01/2028 00:00:00', '08/01/2028 00:00:00', '09/01/2028 00:00:00', '10/01/2028 00:00:00', '11/01/2028 00:00:00', '12/01/2028 00:00:00', '01/01/2029 00:00:00', '02/01/2029 00:00:00', '03/01/2029 00:00:00', '04/01/2029 00:00:00', '05/01/2029 00:00:00', '06/01/2029 00:00:00', '07/01/2029 00:00:00', '08/01/2029 00:00:00', '09/01/2029 00:00:00', '10/01/2029 00:00:00', '11/01/2029 00:00:00', '12/01/2029 00:00:00', '01/01/2030 00:00:00', '02/01/2030 00:00:00', '03/01/2030 00:00:00', '04/01/2030 00:00:00', '05/01/2030 00:00:00', '06/01/2030 00:00:00', '07/01/2030 00:00:00', '08/01/2030 00:00:00', '09/01/2030 00:00:00', '10/01/2030 00:00:00', '11/01/2030 00:00:00', '12/01/2030 00:00:00')));

