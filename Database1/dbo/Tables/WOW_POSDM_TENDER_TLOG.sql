﻿CREATE TABLE [dbo].[WOW_POSDM_TENDER_TLOG] (
    [start_txn_date]         DATE         NULL,
    [store_nbr]              VARCHAR (50) NULL,
    [checkout_nbr]           VARCHAR (50) NULL,
    [start_txn_time]         VARCHAR (50) NULL,
    [tkt_nbr]                VARCHAR (50) NULL,
    [txn_sqnc_nbr]           VARCHAR (50) NULL,
    [basket_key]             VARCHAR (50) NULL,
    [cashout_flag]           VARCHAR (50) NULL,
    [division_nbr]           VARCHAR (50) NULL,
    [sales_chnl_code]        VARCHAR (50) NULL,
    [lylty_card_nbr]         VARCHAR (50) NULL,
    [lylty_acct_type]        VARCHAR (50) NULL,
    [void_flag]              VARCHAR (50) NULL,
    [cncld_flag]             VARCHAR (50) NULL,
    [return_flag]            VARCHAR (50) NULL,
    [liquor_flag]            VARCHAR (50) NULL,
    [rounding_flag]          VARCHAR (50) NULL,
    [cashback_flag]          VARCHAR (50) NULL,
    [change_flag]            VARCHAR (50) NULL,
    [eft_authorisation_flag] VARCHAR (50) NULL,
    [tender_type]            VARCHAR (50) NULL,
    [tender_nbr]             VARCHAR (50) NULL,
    [tender_card_id]         VARCHAR (50) NULL,
    [tender_card_bin]        VARCHAR (50) NULL,
    [tender_type_code]       VARCHAR (50) NULL,
    [tender_amt]             FLOAT (53)   NULL,
    [txn_date]               DATE         NULL,
    [txn_time]               VARCHAR (50) NULL,
    [update_process_name]    VARCHAR (50) NULL,
    [td_load_dttm]           VARCHAR (50) NULL,
    [load_dttm]              VARCHAR (50) NULL,
    [processing_dttm]        VARCHAR (50) NULL,
    [update_dttm]            VARCHAR (50) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([store_nbr]), PARTITION([start_txn_date] RANGE FOR VALUES ('01/01/2015 00:00:00', '02/01/2015 00:00:00', '03/01/2015 00:00:00', '04/01/2015 00:00:00', '05/01/2015 00:00:00', '06/01/2015 00:00:00', '07/01/2015 00:00:00', '08/01/2015 00:00:00', '09/01/2015 00:00:00', '10/01/2015 00:00:00', '11/01/2015 00:00:00', '12/01/2015 00:00:00', '01/01/2016 00:00:00', '02/01/2016 00:00:00', '03/01/2016 00:00:00', '04/01/2016 00:00:00', '05/01/2016 00:00:00', '06/01/2016 00:00:00', '07/01/2016 00:00:00', '08/01/2016 00:00:00', '09/01/2016 00:00:00', '10/01/2016 00:00:00', '11/01/2016 00:00:00', '12/01/2016 00:00:00', '01/01/2017 00:00:00', '02/01/2017 00:00:00', '03/01/2017 00:00:00', '04/01/2017 00:00:00', '05/01/2017 00:00:00', '06/01/2017 00:00:00', '07/01/2017 00:00:00', '08/01/2017 00:00:00', '09/01/2017 00:00:00', '10/01/2017 00:00:00', '11/01/2017 00:00:00', '12/01/2017 00:00:00', '01/01/2018 00:00:00', '02/01/2018 00:00:00', '03/01/2018 00:00:00', '04/01/2018 00:00:00', '05/01/2018 00:00:00', '06/01/2018 00:00:00', '07/01/2018 00:00:00', '08/01/2018 00:00:00', '09/01/2018 00:00:00', '10/01/2018 00:00:00', '11/01/2018 00:00:00', '12/01/2018 00:00:00', '01/01/2019 00:00:00', '02/01/2019 00:00:00', '03/01/2019 00:00:00', '04/01/2019 00:00:00', '05/01/2019 00:00:00', '06/01/2019 00:00:00', '07/01/2019 00:00:00', '08/01/2019 00:00:00', '09/01/2019 00:00:00', '10/01/2019 00:00:00', '11/01/2019 00:00:00', '12/01/2019 00:00:00', '01/01/2020 00:00:00')));

