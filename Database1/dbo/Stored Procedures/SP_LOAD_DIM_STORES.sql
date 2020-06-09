CREATE PROC [dbo].[SP_LOAD_DIM_STORES] @filename [NVARCHAR](100) AS


/********************************

SP Name			: SP_LD_DIM_STORES
Target Table	: dbo.DIM_STORES
Author			: Kishorekumar Balachandran
Modified By		: Kishorekumar Balachandran
Created Date	: 10/02/2020
Modified Date	: 13/02/2020
Description		: The purpose of this stored procedure is to use an external table from data lake storage
				  and load new/modified/update historical data. This is structured to handle SCD type 2.

********************************/

Begin

declare	@exttable varchar(max), @insertnew varchar(max)
declare @updateexist varchar(max), @insertmod varchar(max)

--declare @filename varchar(100)
--set @filename = 'eg_Stores_20200101_102510001.csv'

/* ----------------

1.	DROP EXISTING EXTERNAL TABLE IF AVAILABLE AND RE-CREATE WITH A 
	FILE FROM DATA LAKE STORAGE



If OBJECT_ID (N'dbo.EXT_STG_DIM_STORES') IS NOT NULL
DROP EXTERNAL TABLE dbo.EXT_STG_DIM_STORES

set @exttable = 'CREATE EXTERNAL TABLE dbo.EXT_STG_DIM_STORES (
[Corp_Lvl1] [varchar](20) NULL,
[Corp_Lvl1_Name] [varchar](100) NULL,
[Corp_Lvl2] [varchar](20) NULL,
[Corp_Lvl2_Name] [varchar](100) NULL,
[Corp_Lvl3] [varchar](20) NULL,
[Corp_Lvl3_Name] [varchar](100) NULL,
[Corp_Lvl4] [varchar](20) NULL,
[Corp_Lvl4_Name] [varchar](100) NULL,
[Store] [varchar](20) NOT NULL,
[Name] [varchar](100) NULL,
[Adress_Line_1] [varchar](250) NULL,
[Addres_Line_2] [varchar](250) NULL,
[City] [varchar](50) NULL,
[State] [varchar](20) NULL,
[ZIP] [varchar](20) NULL,
[Tel_1] [varchar](20) NULL,
[Manager] [varchar](20) NULL,
[Fax] [varchar](20) NULL,
[Currency] [varchar](10) NULL,
[Tax1] [varchar](20) NULL,
[Tax2] [varchar](20) NULL,
[Tax3] [varchar](20) NULL,
[Tax4] [varchar](20) NULL,
[Dealer_Operated] [varchar](20) NULL,
[NU1] [varchar](20) NULL,
[Store_Internal_Number] [varchar](20) NULL,
[Country] [varchar](20) NULL,
[Store_Tax_No] [varchar](20) NULL,
[Store_Group] [varchar](20) NULL,
[DEACTIVATED] [varchar](20) NULL,
[ACTIVATION_DATE] [varchar](20) NULL,
[TIMESTAMP] [varchar](100) NULL
)
 WITH (LOCATION='+'N'''+'/inbound/DIM_STORES/'+ @filename + '''' + ',
		DATA_SOURCE = DLSTORAGE,  
		FILE_FORMAT = CSVFORMATWITHHEADER,
		REJECT_TYPE = PERCENTAGE,
		REJECT_VALUE = 100,
		REJECT_SAMPLE_VALUE = 1000);'

Begin Try
	exec (@exttable)
End Try

Begin Catch
	declare @ext_errorno varchar(20), @ext_errordesc varchar(max)
	set @ext_errorno = ERROR_NUMBER()
	set @ext_errordesc = ERROR_MESSAGE()
	print('Issue observed while creating an external table dbo.EXT_STG_DIM_STORES. Error Number is ' + @ext_errorno + ' and error description is '+ @ext_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_STORES','SP_LOAD_DIM_STORES', @ext_errorno, @ext_errordesc, getutcdate()
End Catch

*/ ----------------
/* ----------------

2. INSERT NEW RECORDS THAT DOES NOT EXIST ALREADY

*/ ----------------

set @insertnew ='INSERT INTO dbo.DIM_STORES
SELECT STG.[Corp_Lvl1],
STG.[Corp_Lvl1_Name],
STG.[Corp_Lvl2],
STG.[Corp_Lvl2_Name],
STG.[Corp_Lvl3],
STG.[Corp_Lvl3_Name],
STG.[Corp_Lvl4],
STG.[Corp_Lvl4_Name],
case when STG.[Store] = '''' then null else STG.[Store] end,
STG.[Name],
STG.[Adress_Line_1],
STG.[Addres_Line_2],
STG.[City],
STG.[State],
STG.[ZIP],
STG.[Tel_1],
STG.[Manager],
STG.[Fax],
STG.[Currency],
STG.[Tax1],
STG.[Tax2],
STG.[Tax3],
STG.[Tax4],
STG.[Dealer_Operated],
STG.[NU1],
STG.[Store_Internal_Number],
STG.[Country],
STG.[Store_Tax_No],
STG.[Store_Group],
STG.[DEACTIVATED],
STG.[ACTIVATION_DATE],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
''1900-01-01'', 
''2999-12-31'', CAST(getutcdate() AS DATE),' + 
'''' + @filename + '''' +'
	FROM [DBO].[STG_STORES] STG
	LEFT JOIN DBO.DIM_STORES TRGT
	ON STG.STORE = TRGT.STORE
	WHERE (TRGT.STORE IS NULL);'

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
	Select 'PP_ENVOY_DIM_STORES','SP_LOAD_DIM_STORES', @ins_errorno, @ins_errordesc, getutcdate()
	RAISERROR(@ins_errordesc,@ins_errorno,@ins_errorsta)
End Catch


/* ----------------

3.	UPDATE HISTORICAL ACTIVE DATA ONLY IF EXISTS
	MATCHING WITH KEY COMBINATIONS

*/ ----------------

set		@updateexist = '
UPDATE [dbo].[DIM_STORES]
  SET [DIM_STORES].[END_DATE] = dateadd (day,-1,Convert(date, substring(SRC.[TIMESTAMP],1,23),23))
  FROM DBO.[STG_STORES] AS SRC
  WHERE [DIM_STORES].STORE = SRC.STORE
  AND [DIM_STORES].[END_DATE] = ''2999-12-31''
  AND [DIM_STORES].[TIMESTAMP] < Convert(datetime, substring(SRC.[TIMESTAMP],1,23),121)'

Begin Try
	exec(@updateexist)
End Try

Begin Catch
	declare @upd_errorno varchar(20), @upd_errordesc varchar(max), @upd_errorsta varchar(20)
	set @upd_errorno = ERROR_NUMBER()
	set @upd_errordesc = ERROR_MESSAGE()
	set @upd_errorsta = ERROR_SEVERITY()
	print('Updating historical data having an issue. Error Number is ' + @upd_errorno + ' and error description is '+ @upd_errordesc)
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_STORES','SP_LOAD_DIM_STORES', @upd_errorno, @upd_errordesc, getutcdate()
	RAISERROR(@upd_errordesc,@upd_errorno,@upd_errorsta)
End Catch


/* ----------------

4.	INSERT MODIFIED DATA FOR THE EXISTING KEY COMBINATIONS

*/ ----------------

set @insertmod ='INSERT INTO dbo.DIM_STORES
SELECT 
STG.[Corp_Lvl1],
STG.[Corp_Lvl1_Name],
STG.[Corp_Lvl2],
STG.[Corp_Lvl2_Name],
STG.[Corp_Lvl3],
STG.[Corp_Lvl3_Name],
STG.[Corp_Lvl4],
STG.[Corp_Lvl4_Name],
case when STG.[Store] = '''' then null else STG.[Store] end,
STG.[Name],
STG.[Adress_Line_1],
STG.[Addres_Line_2],
STG.[City],
STG.[State],
STG.[ZIP],
STG.[Tel_1],
STG.[Manager],
STG.[Fax],
STG.[Currency],
STG.[Tax1],
STG.[Tax2],
STG.[Tax3],
STG.[Tax4],
STG.[Dealer_Operated],
STG.[NU1],
STG.[Store_Internal_Number],
STG.[Country],
STG.[Store_Tax_No],
STG.[Store_Group],
STG.[DEACTIVATED],
STG.[ACTIVATION_DATE],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
dateadd (day,0,Convert(date, substring(STG.[TIMESTAMP],1,23),23)), ''2999-12-31'', CAST(getutcdate() AS DATE),' + '''' + @filename +''''+'
	FROM [DBO].[STG_STORES] STG
	LEFT JOIN dbo.DIM_STORES TRGT
	ON STG.STORE = TRGT.STORE
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
	Select 'PP_ENVOY_DIM_STORES','SP_LOAD_DIM_STORES', @mod_errorno, @mod_errordesc, getutcdate()
	RAISERROR(@mod_errordesc,@mod_errorno,@mod_errorsta)
End Catch

End
