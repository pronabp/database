﻿CREATE EXTERNAL TABLE [dbo].[EXT_Inv_Level_1] (
    [Inv_Lvl1] VARCHAR (100) NOT NULL,
    [Name] VARCHAR (100) NOT NULL,
    [Sales_GL] VARCHAR (100) NOT NULL,
    [Reserve_GL] VARCHAR (100) NOT NULL,
    [Inventory_GL] VARCHAR (100) NOT NULL,
    [Cost_GL] VARCHAR (100) NOT NULL,
    [Shrink_GL] VARCHAR (100) NOT NULL,
    [Allow_Discount_NU] VARCHAR (100) NOT NULL,
    [Allow_Food_Stamps_NU] VARCHAR (100) NOT NULL,
    [Fuel_Type] VARCHAR (100) NOT NULL,
    [Min_Profit] VARCHAR (100) NOT NULL,
    [Base_Profit] VARCHAR (100) NOT NULL,
    [Max_Profit] VARCHAR (100) NOT NULL,
    [Ordered_By_PO] VARCHAR (100) NOT NULL,
    [Required_Levels] VARCHAR (100) NOT NULL,
    [Valid_UOMs_String] VARCHAR (100) NOT NULL,
    [Restriction_Code_NU] VARCHAR (100) NOT NULL,
    [InvLvl_Tax_Class] VARCHAR (100) NOT NULL,
    [ReOrder_formula_Code_NU] VARCHAR (100) NOT NULL,
    [Default_Network_Code_NU] VARCHAR (100) NOT NULL,
    [Note] VARCHAR (100) NOT NULL,
    [Internal_Seq_Number] VARCHAR (100) NOT NULL,
    [Exported] VARCHAR (100) NOT NULL,
    [Safety_Stock] VARCHAR (100) NOT NULL,
    [Purge] VARCHAR (100) NOT NULL,
    [TIMESTAMP] VARCHAR (100) NOT NULL,
    [PROMO_DISCOUNT_GL] VARCHAR (100) NOT NULL,
    [Award_Dep] VARCHAR (100) NOT NULL,
    [PACKAGE_BREAK_FLAG] VARCHAR (100) NOT NULL,
    [PromoSalesGL] VARCHAR (100) NOT NULL,
    [LoyaltyPromoDiscountGL] VARCHAR (100) NOT NULL,
    [CouponDiscountGL] VARCHAR (100) NOT NULL
)
    WITH (
    DATA_SOURCE = [DataLakeStorage],
    LOCATION = N'/enable/incremental/Inv_Level_1/Inv_Level_1.csv',
    FILE_FORMAT = [CsvFormatWithHeaderComma],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

