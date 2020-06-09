CREATE TABLE [dbo].[WOW_STKLOSS_DAILY] (
    [Site]                      VARCHAR (50)    NULL,
    [Article]                   VARCHAR (50)    NULL,
    [Date]                      DATE            NULL,
    [Stock_loss_exc_waste_dump] DECIMAL (20, 4) NULL,
    [stock_loss_waste_dump]     DECIMAL (20, 4) NULL,
    [stock_holdout]             DECIMAL (20, 4) NULL,
    [stock_procv_adj]           DECIMAL (20, 4) NULL,
    [cyclic_counts_pilferage]   DECIMAL (20, 4) NULL,
    [stock_sync]                DECIMAL (20, 4) NULL,
    [stock_take_var]            DECIMAL (20, 4) NULL,
    [source_file_name]          VARCHAR (100)   NULL,
    [load_date]                 DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Site]), PARTITION([Date] RANGE FOR VALUES ('12/01/2019 00:00:00', '01/01/2020 00:00:00', '02/01/2020 00:00:00', '03/01/2020 00:00:00', '04/01/2020 00:00:00', '05/01/2020 00:00:00', '06/01/2020 00:00:00', '07/01/2020 00:00:00', '08/01/2020 00:00:00', '09/01/2020 00:00:00', '10/01/2020 00:00:00', '11/01/2020 00:00:00', '12/01/2020 00:00:00', '01/01/2021 00:00:00', '02/01/2021 00:00:00', '03/01/2021 00:00:00', '04/01/2021 00:00:00', '05/01/2021 00:00:00', '06/01/2021 00:00:00', '07/01/2021 00:00:00', '08/01/2021 00:00:00', '09/01/2021 00:00:00', '10/01/2021 00:00:00', '11/01/2021 00:00:00', '12/01/2021 00:00:00')));

