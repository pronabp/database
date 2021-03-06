﻿CREATE TABLE [dbo].[WOW_INTERIMGP_ADJ] (
    [Date]                        DATE            NULL,
    [Site]                        VARCHAR (50)    NULL,
    [Sub_Category]                VARCHAR (50)    NULL,
    [Segment]                     VARCHAR (50)    NULL,
    [Article]                     VARCHAR (50)    NULL,
    [VN_Vendor]                   VARCHAR (50)    NULL,
    [Sales_Quantity_in_Sales_UoM] DECIMAL (20, 4) NULL,
    [Sales_Retail_Value_excl_Tax] DECIMAL (20, 4) NULL,
    [Initial_GP]                  DECIMAL (20, 4) NULL,
    [Total_Stock_Adjs]            DECIMAL (20, 4) NULL,
    [Scanback]                    DECIMAL (20, 4) NULL,
    [Coop_Total]                  DECIMAL (20, 4) NULL,
    [SOH_Sync_Cost_value]         DECIMAL (20, 4) NULL,
    [Stock_Take_Cost_value]       DECIMAL (20, 4) NULL,
    [Stock_Correction_Cost_Value] DECIMAL (20, 4) NULL,
    [Cycle_count_Cost_value]      DECIMAL (20, 4) NULL,
    [Insurance_Stock_Cost_Value]  DECIMAL (20, 4) NULL,
    [Dumps_Cost_Value]            DECIMAL (20, 4) NULL,
    [Promo_Income_Scan_Fin]       DECIMAL (20, 4) NULL,
    [Prom_Income_Co_op_Gross_Fin] DECIMAL (20, 4) NULL,
    [Other_Deferred_Rebates_Fin]  DECIMAL (20, 4) NULL,
    [Manual_Claims]               DECIMAL (20, 4) NULL,
    [Sales_Qty_BUom]              DECIMAL (20, 4) NULL,
    [Controllable_Dumps_Qty_BUoM] DECIMAL (20, 4) NULL,
    [Controllable_Dumps_Qty_SUoM] DECIMAL (20, 4) NULL,
    [Interim_GP]                  VARCHAR (50)    NULL,
    [source_file_name]            VARCHAR (100)   NULL,
    [load_date]                   DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Segment]), PARTITION([Date] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

