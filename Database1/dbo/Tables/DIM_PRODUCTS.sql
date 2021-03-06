﻿CREATE TABLE [dbo].[DIM_PRODUCTS] (
    [Inv_Lvl1]                 VARCHAR (50)    NULL,
    [Inv_Lvl1_Name]            VARCHAR (100)   NULL,
    [Inv_Lvl2]                 VARCHAR (50)    NULL,
    [Inv_Lvl2_Name]            VARCHAR (100)   NULL,
    [Inv_Lvl3]                 VARCHAR (50)    NULL,
    [Inv_Lvl3_Name]            VARCHAR (100)   NULL,
    [Inv_Lvl4]                 VARCHAR (50)    NULL,
    [Inv_Lvl4_Name]            VARCHAR (100)   NULL,
    [SKU_Number]               VARCHAR (50)    NOT NULL,
    [Name]                     VARCHAR (250)   NULL,
    [Upper_Name]               VARCHAR (250)   NULL,
    [Linked_UPCCode_for_MM]    VARCHAR (50)    NULL,
    [UOM]                      VARCHAR (10)    NULL,
    [Short_Name_for_POS]       VARCHAR (50)    NULL,
    [MFG_GlobalLocationNumber] VARCHAR (20)    NULL,
    [ManufacturerName]         VARCHAR (100)   NULL,
    [Min_Profit]               DECIMAL (20, 4) NULL,
    [Base_Profit]              DECIMAL (20, 4) NULL,
    [Max_Profit]               DECIMAL (20, 4) NULL,
    [Activation_Date]          VARCHAR (20)    NULL,
    [Termination_Date]         VARCHAR (20)    NULL,
    [Shelf_Space]              VARCHAR (10)    NULL,
    [Product_Type]             VARCHAR (10)    NULL,
    [One_All_Type_for_MM]      VARCHAR (20)    NULL,
    [Link_Code_Type_for_MM]    VARCHAR (20)    NULL,
    [Number_Per_Batch]         VARCHAR (20)    NULL,
    [Value_for_MM]             VARCHAR (20)    NULL,
    [Sales_GL]                 VARCHAR (20)    NULL,
    [Reserve_GL]               VARCHAR (20)    NULL,
    [Inventory_GL]             VARCHAR (20)    NULL,
    [Cost_GL]                  VARCHAR (20)    NULL,
    [Shrink_GL]                VARCHAR (20)    NULL,
    [Sub_Type]                 VARCHAR (20)    NULL,
    [Cost_Group]               VARCHAR (20)    NULL,
    [Generated_By_Store]       VARCHAR (20)    NULL,
    [Fuel_Network_Code]        VARCHAR (20)    NULL,
    [Octane_Rating]            VARCHAR (20)    NULL,
    [Fuel_Density]             VARCHAR (20)    NULL,
    [Purge]                    VARCHAR (20)    NULL,
    [Linked_SKU]               VARCHAR (20)    NULL,
    [PROMO_DISCOUNT_GL]        VARCHAR (20)    NULL,
    [OVERRIDE_DEP_SETTING]     VARCHAR (20)    NULL,
    [ELIGIBLE_FOR_AWARD]       VARCHAR (20)    NULL,
    [BONUS_TYPE]               VARCHAR (20)    NULL,
    [BONUS_VALUE]              VARCHAR (20)    NULL,
    [PACKAGE_BREAK_FLAG]       VARCHAR (20)    NULL,
    [INHERIT_CHAR_CODE]        VARCHAR (20)    NULL,
    [BaseUnitPriceFactor]      VARCHAR (20)    NULL,
    [BaseUnitDescription]      VARCHAR (200)   NULL,
    [PromoSalesGL]             VARCHAR (20)    NULL,
    [LoyaltyPromoDiscountGL]   VARCHAR (20)    NULL,
    [CouponDiscountGL]         VARCHAR (20)    NULL,
    [TIMESTAMP]                DATETIME        NULL,
    [start_date]               DATE            NULL,
    [end_date]                 DATE            NULL,
    [load_date]                DATETIME        NULL,
    [source_file_name]         VARCHAR (200)   NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([SKU_Number]));

