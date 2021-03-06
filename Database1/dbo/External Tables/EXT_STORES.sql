﻿CREATE EXTERNAL TABLE [dbo].[EXT_STORES] (
    [Corp_Lvl1] VARCHAR (100) NULL,
    [Corp_Lvl2] VARCHAR (100) NULL,
    [Corp_Lvl3] VARCHAR (100) NULL,
    [Corp_Lvl4] VARCHAR (100) NULL,
    [Store] VARCHAR (100) NULL,
    [Name] VARCHAR (100) NULL,
    [Adress_Line_1] VARCHAR (100) NULL,
    [Addres_Line_2] VARCHAR (100) NULL,
    [City] VARCHAR (100) NULL,
    [State] VARCHAR (100) NULL,
    [ZIP] VARCHAR (100) NULL,
    [Tel_1] VARCHAR (100) NULL,
    [Manager] VARCHAR (100) NULL,
    [Fax] VARCHAR (100) NULL,
    [Currency] VARCHAR (100) NULL,
    [Tax1] VARCHAR (100) NULL,
    [Tax2] VARCHAR (100) NULL,
    [Tax3] VARCHAR (100) NULL,
    [Tax4] VARCHAR (100) NULL,
    [Modem_Dialing_Number] VARCHAR (100) NULL,
    [Dealer_Operated] VARCHAR (100) NULL,
    [NU1] VARCHAR (100) NULL,
    [Store_Internal_Number] VARCHAR (100) NULL,
    [Tag_For_Price_Change] VARCHAR (100) NULL,
    [Data_Initiated_in_Store] VARCHAR (100) NULL,
    [Maggit_Last_export_Item_Seq] VARCHAR (100) NULL,
    [Maggit_Last_export_Fuel_Seq] VARCHAR (100) NULL,
    [Store_POS_Type_if_diff] VARCHAR (100) NULL,
    [Direct_HOS_POS_Communication] VARCHAR (100) NULL,
    [Main_BZ_Level_For_POS] VARCHAR (100) NULL,
    [Store_POS_SubType_if_diff] VARCHAR (100) NULL,
    [Over_Amount] VARCHAR (100) NULL,
    [Validate_Over_Short] VARCHAR (100) NULL,
    [Reconcille_PMISC] VARCHAR (100) NULL,
    [Exported] VARCHAR (100) NULL,
    [Country] VARCHAR (100) NULL,
    [Geog_Level3] VARCHAR (100) NULL,
    [Geog_Level4] VARCHAR (100) NULL,
    [Store_Tax_No] VARCHAR (100) NULL,
    [RealTime_Interval] VARCHAR (100) NULL,
    [Business_Day_Close_Process] VARCHAR (100) NULL,
    [NO_DECIMAL_DIP_READING] VARCHAR (100) NULL,
    [Last_Seq_PO#_Shell] VARCHAR (100) NULL,
    [CurrPCBatch_ThinClient] VARCHAR (100) NULL,
    [NoOfDraws] VARCHAR (100) NULL,
    [NoOfShifts] VARCHAR (100) NULL,
    [POS_Inbox_Path] VARCHAR (100) NULL,
    [POS_Outbox_Path] VARCHAR (100) NULL,
    [Scanner_Inbox_Path] VARCHAR (100) NULL,
    [Scanner_outbox_Path] VARCHAR (100) NULL,
    [DEFAULT_LANGUAGE] VARCHAR (100) NULL,
    [ThinClientStore] VARCHAR (100) NULL,
    [NoOfShiftsForTKDisp] VARCHAR (100) NULL,
    [Last_POS_Import_Date] VARCHAR (100) NULL,
    [Last_POS_Import_Time] VARCHAR (100) NULL,
    [Skeleton_Store] VARCHAR (100) NULL,
    [Skeleton_For] VARCHAR (100) NULL,
    [Store_Group] VARCHAR (100) NULL,
    [Purge] VARCHAR (100) NULL,
    [GALLONS_TO_LITERS] VARCHAR (100) NULL,
    [POS_IP] VARCHAR (100) NULL,
    [POS_USER] VARCHAR (100) NULL,
    [POS_PASSWORD] VARCHAR (100) NULL,
    [POS_PORT] VARCHAR (100) NULL,
    [DAY_NUMBER] VARCHAR (100) NULL,
    [SHIFT_NUMBER] VARCHAR (100) NULL,
    [TCComboBoxMthRange] VARCHAR (100) NULL,
    [TCComboBoxDefaultDt] VARCHAR (100) NULL,
    [TIMESTAMP] VARCHAR (100) NULL,
    [LAST_EXPORT] VARCHAR (100) NULL,
    [Tax5] VARCHAR (100) NULL,
    [Tax6] VARCHAR (100) NULL,
    [Tax7] VARCHAR (100) NULL,
    [Tax8] VARCHAR (100) NULL,
    [LAST_POS_EXPORT] VARCHAR (100) NULL,
    [ALTERNATE_STORE_ID] VARCHAR (100) NULL,
    [IMPORT_EJRN_FILE] VARCHAR (100) NULL,
    [EJRN_DATE] VARCHAR (100) NULL,
    [SEND_JOURNAL_TO_HO] VARCHAR (100) NULL,
    [RESPECT_COMM_ROUTING] VARCHAR (100) NULL,
    [XML_COMMUNICATION] VARCHAR (100) NULL,
    [ENCRYPT_COMMUNICATION] VARCHAR (100) NULL,
    [DEACTIVATED] VARCHAR (100) NULL,
    [ACTIVATION_DATE] VARCHAR (100) NULL,
    [ALLOWED_SCANNER_USE] VARCHAR (100) NULL,
    [ENCRYPTED] VARCHAR (100) NULL,
    [Store_Envoy_Version] VARCHAR (100) NULL,
    [DoNotCreateExportFile] VARCHAR (100) NULL
)
    WITH (
    DATA_SOURCE = [DataLakeStorage],
    LOCATION = N'/enable/incremental/Stores/Stores_09_06.csv',
    FILE_FORMAT = [CsvFormatWithHeaderComma],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

