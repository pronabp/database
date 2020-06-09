CREATE EXTERNAL TABLE [dbo].[EXT_Inv_Level_4] (
    [Inv_Lvl1] VARCHAR (100) NULL,
    [Inv_Lvl2] VARCHAR (100) NULL,
    [Inv_Lvl3] VARCHAR (100) NULL,
    [Inv_Lvl4] VARCHAR (100) NULL,
    [Name] VARCHAR (100) NULL,
    [Sales_GL] VARCHAR (100) NULL,
    [Reserve_GL] VARCHAR (100) NULL,
    [Inventory_GL] VARCHAR (100) NULL,
    [Cost_GL] VARCHAR (100) NULL,
    [Shrink_GL] VARCHAR (100) NULL,
    [Min_Profit] VARCHAR (100) NULL,
    [Base_Profit] VARCHAR (100) NULL,
    [Max_Profit] VARCHAR (100) NULL,
    [Ordered_By_PO] VARCHAR (100) NULL,
    [Direct_Store_Delivery] VARCHAR (100) NULL,
    [Note] VARCHAR (100) NULL,
    [Internal_Seq_Number] VARCHAR (100) NULL,
    [Exported] VARCHAR (100) NULL,
    [Safety_Stock] VARCHAR (100) NULL,
    [Purge] VARCHAR (100) NULL,
    [TIMESTAMP] VARCHAR (100) NULL,
    [PROMO_DISCOUNT_GL] VARCHAR (100) NULL,
    [INHERIT_ROYALTY] VARCHAR (100) NULL,
    [INHERIT_CHAR_CODE] VARCHAR (100) NULL,
    [PromoSalesGL] VARCHAR (100) NULL,
    [LoyaltyPromoDiscountGL] VARCHAR (100) NULL,
    [CouponDiscountGL] VARCHAR (100) NULL
)
    WITH (
    DATA_SOURCE = [DataLakeStorage],
    LOCATION = N'/enable/incremental/Inv_Level_4/Inv_Level_4.csv',
    FILE_FORMAT = [CsvFormatWithHeaderComma],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

