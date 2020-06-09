CREATE PROC [dbo].[SP_LOAD_DIM_STORE_SKU_SUPPLIER] @filename [NVARCHAR](100) AS


/********************************

SP Name			: SP_LOAD_DIM_STORE_SKU_SUPPLIER
Target Table	: dbo.DIM_STORE_SKU_SUPPLIER
Author			: Rony Cyriac Tom
Created Date	: 10/02/2020
Modified Date	: 13/02/2020
Description		: The purpose of this stored procedure is to use an external table from data lake storage
				  and load new/modified/update historical data. This is structured to handle SCD type 2.

********************************/

Begin

declare	@exttable varchar(max), @insertnew varchar(max)
declare @updateexist varchar(max), @insertmod varchar(max)

/* ----------------

1.	DROP EXISTING EXTERNAL TABLE IF AVAILABLE AND RE-CREATE WITH A 
	FILE FROM DATA LAKE STORAGE

*/ ----------------

/*
If OBJECT_ID (N'dbo.STG_STORE_SKU_SUPPLIER') IS NOT NULL
DROP EXTERNAL TABLE dbo.STG_STORE_SKU_SUPPLIER

set @exttable = 'CREATE EXTERNAL TABLE dbo.STG_STORE_SKU_SUPPLIER (
[Store] [varchar](100) NULL,
	[SKU] [varchar](100) NULL,
	[UOM] [varchar](100) NULL,
	[Supplier] [varchar](100) NULL,
	[ALT_SUPPLIER_CODE] [varchar](100) NULL,
	[Supplier_Name] [varchar](100) NULL,
	[Supplier_Description] [varchar](100) NULL,
	[Fuel_Supplier] [varchar](100) NULL,
	[Vendor_GL] [varchar](100) NULL,
	[SUPPLIER_ADJ_GL] [varchar](100) NULL,
	[VENDOR_TYPE] [varchar](100) NULL,
	[Supplier_SKU] [varchar](100) NULL,
	[Address_Line] [varchar](100) NULL,
	[Address_2] [varchar](100) NULL,
	[City] [varchar](100) NULL,
	[Postal_Code] [varchar](100) NULL,
	[Country] [varchar](100) NULL,
	[Phone] [varchar](100) NULL,
	[Fax] [varchar](100) NULL,
	[TIMESTAMP] [varchar](100) NOT NULL
)
 WITH (LOCATION='+'N'''+'/inbound/DIM_STORE_SKU_SUPPLIER/'+ @filename + '''' + ',
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
	print('Issue observed while creating an external table dbo.STG_STORE_SKU_SUPPLIER. Error Number is ' + @ext_errorno + ' and error description is '+ @ext_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_STORE_SKU_SUPPLIER','SP_LOAD_DIM_STORES', @ext_errorno, @ext_errordesc, getutcdate()
	RAISERROR(@ext_errordesc,@ext_errorno,@ext_errorsta)
End Catch


/* ----------------

2. INSERT NEW RECORDS THAT DOES NOT EXIST ALREADY

*/ ----------------
*/

set @insertnew ='INSERT INTO dbo.DIM_STORE_SKU_SUPPLIER
SELECT 
case when STG.[Store] = '''' then null else STG.[Store] end,
case when STG.[SKU] = '''' then null else STG.[SKU] end,
case when STG.[UOM] = '''' then null else STG.[UOM] end,
case when STG.[Supplier] = '''' then null else STG.[Supplier] end,
STG.[ALT_SUPPLIER_CODE],
STG.[Supplier_Name],
STG.[Supplier_Description],
STG.[Fuel_Supplier],
STG.[Vendor_GL],
STG.[SUPPLIER_ADJ_GL],
STG.[VENDOR_TYPE],
STG.[Supplier_SKU],
STG.[Address_Line],
STG.[Address_2],
STG.[City],
STG.[Postal_Code],
STG.[Country],
STG.[Phone],
STG.[Fax],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
''1900-01-01'', 
''2999-12-31'', CAST(GETDATE() AS DATE),' + '''' + @filename +''''+'
	FROM [DBO].[STG_STORE_SKU_SUPPLIER] STG
	LEFT JOIN DBO.DIM_STORE_SKU_SUPPLIER TRGT
	ON (STG.STORE = TRGT.STORE and STG.SKU = TRGT.SKU and STG.UOM = TRGT.UOM and STG.Supplier = TRGT.Supplier)
	WHERE (TRGT.STORE IS NULL AND TRGT.SKU IS NULL AND TRGT.UOM IS NULL);'
	
Begin Try
	exec(@insertnew)
End Try

Begin Catch
	declare @ins_errorno varchar(20), @ins_errordesc varchar(max), @ins_errorsta varchar(20)
	set @ins_errorno = ERROR_NUMBER()
	set @ins_errordesc = ERROR_MESSAGE()
	set @ins_errorsta = ERROR_SEVERITY()
	print('Inserting new records having an issue. Error Number is ' + @ins_errorno + ' and error description is '+ @ins_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_STORE_SKU_SUPPLIER','SP_LOAD_DIM_STORE_SKU_SUPPLIER', @ins_errorno, @ins_errordesc, getutcdate()
	RAISERROR(@ins_errordesc,@ins_errorno,@ins_errorsta)
End Catch


/* ----------------

3.	UPDATE HISTORICAL ACTIVE DATA ONLY IF EXISTS
	MATCHING WITH KEY COMBINATIONS

*/ ----------------

set		@updateexist = '
UPDATE [dbo].[DIM_STORE_SKU_SUPPLIER]
  SET [DIM_STORE_SKU_SUPPLIER].[END_DATE] = dateadd (day,-1,Convert(date, substring(SRC.[TIMESTAMP],1,23),23))
  FROM DBO.[STG_STORE_SKU_SUPPLIER] AS SRC
  WHERE ([DIM_STORE_SKU_SUPPLIER].STORE = SRC.STORE and [DIM_STORE_SKU_SUPPLIER].SKU = SRC.SKU and [DIM_STORE_SKU_SUPPLIER].UOM = SRC.UOM and [DIM_STORE_SKU_SUPPLIER].Supplier = SRC.Supplier)
  AND [DIM_STORE_SKU_SUPPLIER].[END_DATE] = ''2999-12-31''
  AND [DIM_STORE_SKU_SUPPLIER].[TIMESTAMP] < Convert(datetime, substring(SRC.[TIMESTAMP],1,23),121)'
  
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
	Select 'PP_ENVOY_DIM_STORE_SKU_SUPPLIER','SP_LOAD_DIM_STORE_SKU_SUPPLIER', @upd_errorno, @upd_errordesc, getutcdate()
	RAISERROR(@upd_errordesc,@upd_errorno,@upd_errorsta)
End Catch


/* ----------------

4.	INSERT MODIFIED DATA FOR THE EXISTING KEY COMBINATIONS

*/ ----------------

set @insertmod ='INSERT INTO dbo.DIM_STORE_SKU_SUPPLIER
SELECT 
case when STG.[Store] = '''' then null else STG.[Store] end,
case when STG.[SKU] = '''' then null else STG.[SKU] end,
case when STG.[UOM] = '''' then null else STG.[UOM] end,
case when STG.[Supplier] = '''' then null else STG.[Supplier] end,
STG.[ALT_SUPPLIER_CODE],
STG.[Supplier_Name],
STG.[Supplier_Description],
STG.[Fuel_Supplier],
STG.[Vendor_GL],
STG.[SUPPLIER_ADJ_GL],
STG.[VENDOR_TYPE],
STG.[Supplier_SKU],
STG.[Address_Line],
STG.[Address_2],
STG.[City],
STG.[Postal_Code],
STG.[Country],
STG.[Phone],
STG.[Fax],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
dateadd (day,0,Convert(date, substring(STG.[TIMESTAMP],1,23),23)), 
''2999-12-31'', CAST(GETDATE() AS DATE),' + '''' + @filename +''''+'
	FROM [DBO].[STG_STORE_SKU_SUPPLIER] STG
	LEFT JOIN dbo.DIM_STORE_SKU_SUPPLIER TRGT
	ON  (STG.Store = TRGT.Store and STG.SKU = TRGT.SKU and STG.UOM = TRGT.UOM and STG.Supplier = TRGT.Supplier)
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
	Select 'PP_ENVOY_DIM_STORE_SKU_SUPPLIER','SP_LOAD_DIM_STORE_SKU_SUPPLIER', @mod_errorno, @mod_errordesc, getutcdate()
	RAISERROR(@mod_errordesc,@mod_errorno,@mod_errorsta)
End Catch

End
