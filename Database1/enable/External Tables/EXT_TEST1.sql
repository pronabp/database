﻿CREATE EXTERNAL TABLE [enable].[EXT_TEST1] (
    [Inv_Lvl1] VARCHAR (50) NULL,
    [Inv_Lvl1_Name] VARCHAR (100) NULL,
    [Inv_Lvl2] VARCHAR (100) NULL,
    [Inv_Lvl2_Name] VARCHAR (100) NULL,
    [Inv_Lvl3] VARCHAR (100) NULL,
    [Inv_Lvl3_Name] VARCHAR (100) NULL,
    [Inv_Lvl4] VARCHAR (100) NULL,
    [Inv_Lvl4_Name] VARCHAR (100) NULL,
    [SKU_Number] VARCHAR (100) NULL,
    [Name] VARCHAR (250) NULL,
    [Upper_Name] VARCHAR (250) NULL,
    [Linked_UPCCode_for_MM] VARCHAR (100) NULL,
    [UOM] VARCHAR (100) NULL,
    [Short_Name_for_POS] VARCHAR (100) NULL,
    [MFG_GlobalLocationNumber] VARCHAR (100) NULL,
    [ManufacturerName] VARCHAR (100) NULL,
    [Min_Profit] VARCHAR (100) NULL,
    [Base_Profit] VARCHAR (100) NULL,
    [Max_Profit] VARCHAR (100) NULL,
    [Activation_Date] VARCHAR (100) NULL,
    [Termination_Date] VARCHAR (100) NULL,
    [Shelf_Space] VARCHAR (100) NULL,
    [Product_Type] VARCHAR (100) NULL,
    [One_All_Type_for_MM] VARCHAR (100) NULL,
    [Link_Code_Type_for_MM] VARCHAR (100) NULL,
    [Number_Per_Batch] VARCHAR (100) NULL,
    [Value_for_MM] VARCHAR (100) NULL,
    [Sales_GL] VARCHAR (100) NULL,
    [Reserve_GL] VARCHAR (100) NULL,
    [Inventory_GL] VARCHAR (100) NULL,
    [Cost_GL] VARCHAR (100) NULL,
    [Shrink_GL] VARCHAR (100) NULL,
    [Sub_Type] VARCHAR (100) NULL,
    [Cost_Group] VARCHAR (100) NULL,
    [Generated_By_Store] VARCHAR (100) NULL,
    [Fuel_Network_Code] VARCHAR (100) NULL,
    [Octane_Rating] VARCHAR (100) NULL,
    [Fuel_Density] VARCHAR (100) NULL,
    [Purge] VARCHAR (100) NULL,
    [Linked_SKU] VARCHAR (100) NULL,
    [PROMO_DISCOUNT_GL] VARCHAR (100) NULL,
    [OVERRIDE_DEP_SETTING] VARCHAR (100) NULL,
    [ELIGIBLE_FOR_AWARD] VARCHAR (100) NULL,
    [BONUS_TYPE] VARCHAR (100) NULL,
    [BONUS_VALUE] VARCHAR (100) NULL,
    [PACKAGE_BREAK_FLAG] VARCHAR (100) NULL,
    [INHERIT_CHAR_CODE] VARCHAR (100) NULL,
    [BaseUnitPriceFactor] VARCHAR (100) NULL,
    [BaseUnitDescription] VARCHAR (200) NULL,
    [PromoSalesGL] VARCHAR (100) NULL,
    [LoyaltyPromoDiscountGL] VARCHAR (100) NULL,
    [CouponDiscountGL] VARCHAR (100) NULL,
    [TIMESTAMP] VARCHAR (100) NULL
)
    WITH (
    DATA_SOURCE = [DataLakeStorage],
    LOCATION = N'/enable/incremental/Products/Refined_Products.csv',
    FILE_FORMAT = [CsvFormatWithHeader],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );
