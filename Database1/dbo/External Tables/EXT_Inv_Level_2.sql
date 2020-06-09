CREATE EXTERNAL TABLE [dbo].[EXT_Inv_Level_2] (
    [Inv_Lvl1] VARCHAR (100) NOT NULL,
    [Inv_Lvl2] VARCHAR (100) NOT NULL,
    [Name] VARCHAR (100) NOT NULL,
    [Sales_GL] VARCHAR (100) NOT NULL,
    [Reserve_GL] VARCHAR (100) NOT NULL,
    [Inventory_GL] VARCHAR (100) NOT NULL,
    [Cost_GL] VARCHAR (100) NOT NULL,
    [Shrink_GL] VARCHAR (100) NOT NULL,
    [Min_Profit] VARCHAR (100) NOT NULL,
    [Base_Profit] VARCHAR (100) NOT NULL,
    [Max_Profit] VARCHAR (100) NOT NULL,
    [Ordered_By_PO] VARCHAR (100) NOT NULL,
    [Direct_Store_Delivery] VARCHAR (100) NOT NULL,
    [Note] VARCHAR (100) NOT NULL,
    [Internal_Seq_Number] VARCHAR (100) NOT NULL,
    [Exported] VARCHAR (100) NOT NULL,
    [Safety_Stock] VARCHAR (100) NOT NULL,
    [Purge] VARCHAR (100) NOT NULL,
    [TIMESTAMP] VARCHAR (100) NOT NULL,
    [PROMO_DISCOUNT_GL] VARCHAR (100) NOT NULL,
    [INHERIT_ROYALTY] VARCHAR (100) NOT NULL,
    [INHERIT_CHAR_CODE] VARCHAR (100) NOT NULL,
    [PromoSalesGL] VARCHAR (100) NOT NULL,
    [LoyaltyPromoDiscountGL] VARCHAR (100) NOT NULL,
    [CouponDiscountGL] VARCHAR (100) NOT NULL
)
    WITH (
    DATA_SOURCE = [DataLakeStorage],
    LOCATION = N'/enable/incremental/Inv_Level_2/Inv_Level_2.csv',
    FILE_FORMAT = [CsvFormatWithHeaderComma],
    REJECT_TYPE = PERCENTAGE,
    REJECT_VALUE = 100,
    REJECT_SAMPLE_VALUE = 1000
    );

