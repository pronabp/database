﻿CREATE TABLE [dbo].[EG_POS_DECLARATION] (
    [BusinessUnitID]                VARCHAR (50)    NULL,
    [WorkstationID]                 VARCHAR (50)    NULL,
    [POSTXSequenceNumber]           VARCHAR (50)    NULL,
    [POSTXID]                       VARCHAR (50)    NULL,
    [POSTXEndDateTime]              DATETIME        NULL,
    [BusinessDayDate]               DATE            NULL,
    [TenderID]                      INT             NULL,
    [DeclarationType]               VARCHAR (50)    NULL,
    [TenderType]                    VARCHAR (50)    NULL,
    [Amount]                        DECIMAL (20, 4) NULL,
    [Currency]                      VARCHAR (50)    NULL,
    [TillID]                        VARCHAR (50)    NULL,
    [TillExternalId]                VARCHAR (50)    NULL,
    [TenderSummaryAmount]           DECIMAL (20, 4) NULL,
    [LoansAmount]                   DECIMAL (20, 4) NULL,
    [TenderPickupAmount]            DECIMAL (20, 4) NULL,
    [TenderOpenBalanceTotalAmount]  DECIMAL (20, 4) NULL,
    [TenderOpenBalanceOverShort]    VARCHAR (50)    NULL,
    [TenderCloseBalanceTotalAmount] DECIMAL (20, 4) NULL,
    [TenderCloseBalanceOverShort]   VARCHAR (50)    NULL,
    [TenderLoanTotalAmount]         DECIMAL (20, 4) NULL,
    [TotalTenderLoanCount]          INT             NULL,
    [TenderPickupTotalAmount]       DECIMAL (20, 4) NULL,
    [TotalTenderPickupCount]        INT             NULL,
    [TenderDepositTotalAmount]      DECIMAL (20, 4) NULL,
    [TenderReceiptTotalAmount]      DECIMAL (20, 4) NULL,
    [source_file_name]              VARCHAR (100)   NULL,
    [load_date]                     DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([BusinessUnitID]), PARTITION([BusinessDayDate] RANGE FOR VALUES ('01/01/2015 00:00:00', '02/01/2015 00:00:00', '03/01/2015 00:00:00', '04/01/2015 00:00:00', '05/01/2015 00:00:00', '06/01/2015 00:00:00', '07/01/2015 00:00:00', '08/01/2015 00:00:00', '09/01/2015 00:00:00', '10/01/2015 00:00:00', '11/01/2015 00:00:00', '12/01/2015 00:00:00', '01/01/2016 00:00:00', '02/01/2016 00:00:00', '03/01/2016 00:00:00', '04/01/2016 00:00:00', '05/01/2016 00:00:00', '06/01/2016 00:00:00', '07/01/2016 00:00:00', '08/01/2016 00:00:00', '09/01/2016 00:00:00', '10/01/2016 00:00:00', '11/01/2016 00:00:00', '12/01/2016 00:00:00', '01/01/2017 00:00:00', '02/01/2017 00:00:00', '03/01/2017 00:00:00', '04/01/2017 00:00:00', '05/01/2017 00:00:00', '06/01/2017 00:00:00', '07/01/2017 00:00:00', '08/01/2017 00:00:00', '09/01/2017 00:00:00', '10/01/2017 00:00:00', '11/01/2017 00:00:00', '12/01/2017 00:00:00', '01/01/2018 00:00:00', '02/01/2018 00:00:00', '03/01/2018 00:00:00', '04/01/2018 00:00:00', '05/01/2018 00:00:00', '06/01/2018 00:00:00', '07/01/2018 00:00:00', '08/01/2018 00:00:00', '09/01/2018 00:00:00', '10/01/2018 00:00:00', '11/01/2018 00:00:00', '12/01/2018 00:00:00', '01/01/2019 00:00:00', '02/01/2019 00:00:00', '03/01/2019 00:00:00', '04/01/2019 00:00:00', '05/01/2019 00:00:00', '06/01/2019 00:00:00', '07/01/2019 00:00:00', '08/01/2019 00:00:00', '09/01/2019 00:00:00', '10/01/2019 00:00:00', '11/01/2019 00:00:00', '12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00', '01/01/2022 00:00:00', '02/01/2022 00:00:00', '03/01/2022 00:00:00', '04/01/2022 00:00:00', '05/01/2022 00:00:00', '06/01/2022 00:00:00', '07/01/2022 00:00:00', '08/01/2022 00:00:00', '09/01/2022 00:00:00', '10/01/2022 00:00:00', '11/01/2022 00:00:00', '12/01/2022 00:00:00', '01/01/2023 00:00:00', '02/01/2023 00:00:00', '03/01/2023 00:00:00', '04/01/2023 00:00:00', '05/01/2023 00:00:00', '06/01/2023 00:00:00', '07/01/2023 00:00:00', '08/01/2023 00:00:00', '09/01/2023 00:00:00', '10/01/2023 00:00:00', '11/01/2023 00:00:00', '12/01/2023 00:00:00', '01/01/2024 00:00:00', '02/01/2024 00:00:00', '03/01/2024 00:00:00', '04/01/2024 00:00:00', '05/01/2024 00:00:00', '06/01/2024 00:00:00', '07/01/2024 00:00:00', '08/01/2024 00:00:00', '09/01/2024 00:00:00', '10/01/2024 00:00:00', '11/01/2024 00:00:00', '12/01/2024 00:00:00', '01/01/2025 00:00:00', '02/01/2025 00:00:00', '03/01/2025 00:00:00', '04/01/2025 00:00:00', '05/01/2025 00:00:00', '06/01/2025 00:00:00', '07/01/2025 00:00:00', '08/01/2025 00:00:00', '09/01/2025 00:00:00', '10/01/2025 00:00:00', '11/01/2025 00:00:00', '12/01/2025 00:00:00', '01/01/2026 00:00:00', '02/01/2026 00:00:00', '03/01/2026 00:00:00', '04/01/2026 00:00:00', '05/01/2026 00:00:00', '06/01/2026 00:00:00', '07/01/2026 00:00:00', '08/01/2026 00:00:00', '09/01/2026 00:00:00', '10/01/2026 00:00:00', '11/01/2026 00:00:00', '12/01/2026 00:00:00', '01/01/2027 00:00:00', '02/01/2027 00:00:00', '03/01/2027 00:00:00', '04/01/2027 00:00:00', '05/01/2027 00:00:00', '06/01/2027 00:00:00', '07/01/2027 00:00:00', '08/01/2027 00:00:00', '09/01/2027 00:00:00', '10/01/2027 00:00:00', '11/01/2027 00:00:00', '12/01/2027 00:00:00', '01/01/2028 00:00:00', '02/01/2028 00:00:00', '03/01/2028 00:00:00', '04/01/2028 00:00:00', '05/01/2028 00:00:00', '06/01/2028 00:00:00', '07/01/2028 00:00:00', '08/01/2028 00:00:00', '09/01/2028 00:00:00', '10/01/2028 00:00:00', '11/01/2028 00:00:00', '12/01/2028 00:00:00', '01/01/2029 00:00:00', '02/01/2029 00:00:00', '03/01/2029 00:00:00', '04/01/2029 00:00:00', '05/01/2029 00:00:00', '06/01/2029 00:00:00', '07/01/2029 00:00:00', '08/01/2029 00:00:00', '09/01/2029 00:00:00', '10/01/2029 00:00:00', '11/01/2029 00:00:00', '12/01/2029 00:00:00', '01/01/2030 00:00:00', '02/01/2030 00:00:00', '03/01/2030 00:00:00', '04/01/2030 00:00:00', '05/01/2030 00:00:00', '06/01/2030 00:00:00', '07/01/2030 00:00:00', '08/01/2030 00:00:00', '09/01/2030 00:00:00', '10/01/2030 00:00:00', '11/01/2030 00:00:00', '12/01/2030 00:00:00')));

