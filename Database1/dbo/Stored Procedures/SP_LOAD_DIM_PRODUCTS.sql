CREATE PROC [dbo].[SP_LOAD_DIM_PRODUCTS] @filename [NVARCHAR](100) AS


/********************************

SP Name			: SP_LD_DIM_PRODUCTS
Target Table	: dbo.PRODUCTS
Author			: Rony Cyriac Tom
Created Date	: 11/02/2020
Modified Date	: 26/02/2020
Description		: The purpose of this stored procedure is to use an external table from data lake storage
				  and load new/modified/update historical data. This is structured to handle SCD type 2.

********************************/

Begin

declare	@exttable varchar(max), @insertnew varchar(max)
declare @updateexist varchar(max), @insertmod varchar(max)

--declare @filename varchar(100)
--set @filename = 'eg_products_2020-02-24T112146_2020-02-24T174551.csv'

/* ----------------

1.	DROP EXISTING EXTERNAL TABLE IF AVAILABLE AND RE-CREATE WITH A 
	FILE FROM DATA LAKE STORAGE

*/ ----------------
/*
If OBJECT_ID (N'dbo.STG_PRODUCTS') IS NOT NULL
DROP EXTERNAL TABLE dbo.STG_PRODUCTS

set @exttable = 'CREATE EXTERNAL TABLE dbo.STG_PRODUCTS (
	[Inv_Lvl1] [varchar](50) NULL,
	[Inv_Lvl1_Name] [varchar](100) NULL,
	[Inv_Lvl2] [varchar](100) NULL,
	[Inv_Lvl2_Name] [varchar](100) NULL,
	[Inv_Lvl3] [varchar](100) NULL,
	[Inv_Lvl3_Name] [varchar](100) NULL,
	[Inv_Lvl4] [varchar](100) NULL,
	[Inv_Lvl4_Name] [varchar](100) NULL,
	[SKU_Number] [varchar](100) NULL,
	[Name] [varchar](250) NULL,
	[Upper_Name] [varchar](250) NULL,
	[Linked_UPCCode_for_MM] [varchar](100) NULL,
	[UOM] [varchar](100) NULL,
	[Short_Name_for_POS] [varchar](100) NULL,
	[MFG_GlobalLocationNumber] [varchar](100) NULL,
	[ManufacturerName] [varchar](100) NULL,
	[Min_Profit] [varchar](100) NULL,
	[Base_Profit] [varchar](100) NULL,
	[Max_Profit] [varchar](100) NULL,
	[Activation_Date] [varchar](100) NULL,
	[Termination_Date] [varchar](100) NULL,
	[Shelf_Space] [varchar](100) NULL,
	[Product_Type] [varchar](100) NULL,
	[One_All_Type_for_MM] [varchar](100) NULL,
	[Link_Code_Type_for_MM] [varchar](100) NULL,
	[Number_Per_Batch] [varchar](100) NULL,
	[Value_for_MM] [varchar](100) NULL,
	[Sales_GL] [varchar](100) NULL,
	[Reserve_GL] [varchar](100) NULL,
	[Inventory_GL] [varchar](100) NULL,
	[Cost_GL] [varchar](100) NULL,
	[Shrink_GL] [varchar](100) NULL,
	[Sub_Type] [varchar](100) NULL,
	[Cost_Group] [varchar](100) NULL,
	[Generated_By_Store] [varchar](100) NULL,
	[Fuel_Network_Code] [varchar](100) NULL,
	[Octane_Rating] [varchar](100) NULL,
	[Fuel_Density] [varchar](100) NULL,
	[Purge] [varchar](100) NULL,
	[Linked_SKU] [varchar](100) NULL,
	[PROMO_DISCOUNT_GL] [varchar](100) NULL,
	[OVERRIDE_DEP_SETTING] [varchar](100) NULL,
	[ELIGIBLE_FOR_AWARD] [varchar](100) NULL,
	[BONUS_TYPE] [varchar](100) NULL,
	[BONUS_VALUE] [varchar](100) NULL,
	[PACKAGE_BREAK_FLAG] [varchar](100) NULL,
	[INHERIT_CHAR_CODE] [varchar](100) NULL,
	[BaseUnitPriceFactor] [varchar](100) NULL,
	[BaseUnitDescription] [varchar](200) NULL,
	[PromoSalesGL] [varchar](100) NULL,
	[LoyaltyPromoDiscountGL] [varchar](100) NULL,
	[CouponDiscountGL] [varchar](100) NULL,
	[TIMESTAMP] [varchar](100)NULL
)
 WITH (LOCATION='+'N'''+'/inbound/DIM_PRODUCTS/'+ @filename + '''' + ',
		DATA_SOURCE = DLSTORAGE,  
		FILE_FORMAT = CSVFORMATWITHHEADERS,
		REJECT_TYPE = PERCENTAGE,
		REJECT_VALUE = 100,
		REJECT_SAMPLE_VALUE = 1000);'

Begin Try
	exec (@exttable)
End Try

Begin Catch
	declare @ext_errorno varchar(20), @ext_errordesc varchar(max), @ext_errorsta varchar(20)
	set @ext_errorno = ERROR_NUMBER()
	set @ext_errordesc = ERROR_MESSAGE()
	set @ext_errorsta = ERROR_SEVERITY()
	print('Issue observed while creating an external table dbo.EXT_STG_DIM_PRODUCTS. Error Number is ' + @ext_errorno + ' and error description is '+ @ext_errordesc)
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PRODUCTS','SP_LOAD_DIM_PRODUCTS', @ext_errorno, @ext_errordesc, getutcdate()
	RAISERROR(@ext_errordesc,@ext_errorno,@ext_errorsta)
End Catch


/* ----------------
*/
2. INSERT NEW RECORDS THAT DOES NOT EXIST ALREADY

*/ ----------------

set @insertnew ='INSERT INTO dbo.DIM_PRODUCTS
SELECT STG.[Inv_Lvl1],
	STG.[Inv_Lvl1_Name],
	STG.[Inv_Lvl2],
	STG.[Inv_Lvl2_Name],
	STG.[Inv_Lvl3] [varchar],
	STG.[Inv_Lvl3_Name],
	STG.[Inv_Lvl4],
	STG.[Inv_Lvl4_Name],
	case when STG.[SKU_Number] = '''' then null else STG.[SKU_Number] end,
	STG.[Name],
	STG.[Upper_Name],
	STG.[Linked_UPCCode_for_MM],
	STG.[UOM],
	STG.[Short_Name_for_POS],
	STG.[MFG_GlobalLocationNumber],
	STG.[ManufacturerName],
	STG.[Min_Profit] [decimal],
	STG.[Base_Profit] [decimal],
	STG.[Max_Profit] [decimal],
    STG.[Activation_Date],
	STG.[Termination_Date],
	STG.[Shelf_Space],
	STG.[Product_Type],
	STG.[One_All_Type_for_MM],
	STG.[Link_Code_Type_for_MM],
	STG.[Number_Per_Batch],
	STG.[Value_for_MM],
	STG.[Sales_GL],
	STG.[Reserve_GL],
	STG.[Inventory_GL],
	STG.[Cost_GL],
	STG.[Shrink_GL],
	STG.[Sub_Type],
	STG.[Cost_Group],
	STG.[Generated_By_Store],
	STG.[Fuel_Network_Code],
	STG.[Octane_Rating],
	STG.[Fuel_Density],
	STG.[Purge],
	STG.[Linked_SKU],
	STG.[PROMO_DISCOUNT_GL],
	STG.[OVERRIDE_DEP_SETTING],
	STG.[ELIGIBLE_FOR_AWARD],
	STG.[BONUS_TYPE],
	STG.[BONUS_VALUE],
	STG.[PACKAGE_BREAK_FLAG],
	STG.[INHERIT_CHAR_CODE],
	STG.[BaseUnitPriceFactor],
	STG.[BaseUnitDescription],
	STG.[PromoSalesGL],
	STG.[LoyaltyPromoDiscountGL],
	STG.[CouponDiscountGL],
	Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
''1900-01-01'', 
''2999-12-31'', CAST(getutcdate() AS DATE),' + '''' + @filename +''''+'
	FROM [dbo].[STG_PRODUCTS] STG
	LEFT JOIN dbo.DIM_PRODUCTS TRGT
	ON STG.SKU_Number = TRGT.SKU_Number
	WHERE (TRGT.SKU_Number IS NULL);'

Begin Try
	exec(@insertnew)
End Try

Begin Catch
	declare @ins_errorno varchar(20), @ins_errordesc varchar(max), @ins_errorsta varchar(20)
	set @ins_errorno = ERROR_NUMBER()
	set @ins_errordesc = ERROR_MESSAGE()
	set @ins_errorsta = ERROR_SEVERITY()
	print('Inserting new records having an issue. Error Number is ' + @ins_errorno + ' and error description is '+ @ins_errordesc)
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PRODUCTS','SP_LOAD_DIM_PRODUCTS', @ins_errorno, @ins_errordesc, getutcdate()
	RAISERROR(@ins_errordesc,@ins_errorno,@ins_errorsta)
End Catch


/* ----------------

3.	UPDATE HISTORICAL ACTIVE DATA ONLY IF EXISTS
	MATCHING WITH KEY COMBINATIONS

*/ ----------------

set		@updateexist = '
UPDATE [dbo].[DIM_PRODUCTS]
  SET [DIM_PRODUCTS].[END_DATE] = dateadd (day,-1,Convert(date, substring(SRC.[TIMESTAMP],1,23),23))
  FROM dbo.[STG_PRODUCTS] AS SRC
  WHERE [DIM_PRODUCTS].SKU_Number = SRC.SKU_Number
  AND [DIM_PRODUCTS].[END_DATE] = ''2999-12-31''
  AND [DIM_PRODUCTS].[TIMESTAMP] < Convert(datetime, substring(SRC.[TIMESTAMP],1,23),121)'


Begin Try
	exec(@updateexist)
End Try

Begin Catch
	declare @upd_errorno varchar(20), @upd_errordesc varchar(max), @upd_errorsta varchar(20)
	set @upd_errorno = ERROR_NUMBER()
	set @upd_errordesc = ERROR_MESSAGE()
	set @upd_errorsta = ERROR_SEVERITY()
	print('Updating historical data having an issue. Error Number is ' + @upd_errorno + ' and error description is '+ @upd_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PRODUCTS','SP_LOAD_DIM_PRODUCTS', @upd_errorno, @upd_errordesc, getutcdate()
	RAISERROR(@upd_errordesc,@upd_errorno,@upd_errorsta)
End Catch


/* ----------------

4.	INSERT MODIFIED DATA FOR THE EXISTING KEY COMBINATIONS

*/ ----------------

set @insertmod ='INSERT INTO dbo.DIM_PRODUCTS
SELECT STG.[Inv_Lvl1],
	STG.[Inv_Lvl1_Name],
	STG.[Inv_Lvl2],
	STG.[Inv_Lvl2_Name],
	STG.[Inv_Lvl3] [varchar],
	STG.[Inv_Lvl3_Name],
	STG.[Inv_Lvl4],
	STG.[Inv_Lvl4_Name],
	case when STG.[SKU_Number] = '''' then null else STG.[SKU_Number] end,
	STG.[Name],
	STG.[Upper_Name],
	STG.[Linked_UPCCode_for_MM],
	STG.[UOM],
	STG.[Short_Name_for_POS],
	STG.[MFG_GlobalLocationNumber],
	STG.[ManufacturerName],
	STG.[Min_Profit] [decimal],
	STG.[Base_Profit] [decimal],
	STG.[Max_Profit] [decimal],
	STG.[Activation_Date],
	STG.[Termination_Date],
	STG.[Shelf_Space],
	STG.[Product_Type],
	STG.[One_All_Type_for_MM],
	STG.[Link_Code_Type_for_MM],
	STG.[Number_Per_Batch],
	STG.[Value_for_MM],
	STG.[Sales_GL],
	STG.[Reserve_GL],
	STG.[Inventory_GL],
	STG.[Cost_GL],
	STG.[Shrink_GL],
	STG.[Sub_Type],
	STG.[Cost_Group],
	STG.[Generated_By_Store],
	STG.[Fuel_Network_Code],
	STG.[Octane_Rating],
	STG.[Fuel_Density],
	STG.[Purge],
	STG.[Linked_SKU],
	STG.[PROMO_DISCOUNT_GL],
	STG.[OVERRIDE_DEP_SETTING],
	STG.[ELIGIBLE_FOR_AWARD],
	STG.[BONUS_TYPE],
	STG.[BONUS_VALUE],
	STG.[PACKAGE_BREAK_FLAG],
	STG.[INHERIT_CHAR_CODE],
	STG.[BaseUnitPriceFactor],
	STG.[BaseUnitDescription],
	STG.[PromoSalesGL],
	STG.[LoyaltyPromoDiscountGL],
	STG.[CouponDiscountGL],
	Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
	dateadd (day,0,Convert(date, substring(STG.[TIMESTAMP],1,23),23)), ''2999-12-31'', CAST(getutcdate() AS DATE),' + '''' + @filename +''''+'
	FROM [dbo].[STG_PRODUCTS] STG
	LEFT JOIN dbo.DIM_PRODUCTS TRGT
	ON STG.SKU_Number = TRGT.SKU_Number
	WHERE Convert(datetime, substring(STG.[TIMESTAMP],1,23),121) > TRGT.[TIMESTAMP]
	AND TRGT.end_date = dateadd (day,-1,Convert(date, substring(STG.[TIMESTAMP],1,23),23))'
	
Begin Try
	exec(@insertmod)
End Try

Begin Catch
	declare @mod_errorno varchar(20), @mod_errordesc varchar(max), @mod_errorsta varchar(20)
	set @mod_errorno = ERROR_NUMBER()
	set @mod_errordesc = ERROR_MESSAGE()
	set @mod_errorsta = ERROR_SEVERITY()
	print('Inserting modified data having an issue. Error Number is ' + @mod_errorno + ' and error description is '+ @mod_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PRODUCTS','SP_LOAD_DIM_PRODUCTS', @mod_errorno, @mod_errordesc, getutcdate()
	RAISERROR(@mod_errordesc,@mod_errorno,@mod_errorsta)
End Catch  

End
