CREATE PROC [dbo].[SP_LOAD_DIM_TAX_AND_CHARGES] @filename [NVARCHAR](100) AS


/********************************

SP Name			: SP_LD_DIM_TAX_AND_CHARGES
Target Table	: dbo.DIM_TAX_AND_CHARGES
Author			: Rony Cyriac Tom
Created Date	: 11/02/2020
Modified Date	: 13/02/2020
Description		: The purpose of this stored procedure is to use an external table from data lake storage
				  and load new/modified/update historical data. This is structured to handle SCD type 2.

********************************/

Begin

declare	@exttable varchar(max), @insertnew varchar(max)
declare @updateexist varchar(max), @insertmod varchar(max)

--declare @filename varchar(100)
--set @filename = 'eg_taxes_and_charges_20200105_102510005.csv'

/* ----------------

1.	DROP EXISTING EXTERNAL TABLE IF AVAILABLE AND RE-CREATE WITH A 
	FILE FROM DATA LAKE STORAGE

*/ ----------------
/*
If OBJECT_ID (N'dbo.STG_TAX_AND_CHARGES') IS NOT NULL
DROP EXTERNAL TABLE dbo.STG_TAX_AND_CHARGES

set @exttable = 'CREATE EXTERNAL TABLE dbo.STG_TAX_AND_CHARGES (
	[TaxCharge_Code] [varchar](100) NULL,
	[Type] [varchar](100) NULL,
	[Sub_Type] [varchar](100) NULL,
	[Name] [varchar](100) NULL,
	[Applies_On] [varchar](100) NULL,
	[GL] [varchar](100) NULL,
	[Value] [varchar](100) NULL,
	[Tax_Type] [varchar](100) NULL,
	[From_Date] [varchar](100)  NULL,
	[To_Date] [varchar](100)  NULL,
	[Consumption_Tax] [varchar](100) NULL,
	[Tax_Value_for_Purch] [varchar](100) NULL,
	[Calculation_Precision] [varchar](100) NULL,
	[Withhold_Liability_GL] [varchar](100) NULL,
	[Exported] [varchar](100) NULL,
	[Especifico_Tax] [varchar](100) NULL,
	[Used_Internally] [varchar](100) NULL,
	[ALLOW_LOW_MODIFY] [varchar](100) NULL,
	[ENFORCE_FOR_OS] [varchar](100) NULL,
	[Inventory_Payout] [varchar](100) NULL,
	[Purge] [varchar](100) NULL,
	[TIMESTAMP] [varchar](100) NULL,
	[Def_Number_Of_Days] [varchar](100) NULL
)
 WITH (LOCATION='+'N'''+'/inbound/DIM_TAX_AND_CHARGES/'+ @filename + '''' + ',
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
	print('Issue observed while creating an external table dbo.STG_TAX_AND_CHARGES. Error Number is ' + @ext_errorno + ' and error description is '+ @ext_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_TAX_AND_CHARGES','SP_LOAD_DIM_STORES', @ext_errorno, @ext_errordesc, getutcdate()
	RAISERROR(@ext_errordesc,@ext_errorno,@ext_errorsta)
End Catch

*/
/* ----------------

2. INSERT NEW RECORDS THAT DOES NOT EXIST ALREADY

*/ ----------------

set @insertnew ='INSERT INTO dbo.DIM_TAX_AND_CHARGES
SELECT 
case when STG.[TaxCharge_Code] = '''' then null else STG.[TaxCharge_Code] end,
STG.[Type],
STG.[Sub_Type],
STG.[Name],
STG.[Applies_On],
STG.[GL],
STG.[Value],
STG.[Tax_Type],
STG.[From_Date],
STG.[To_Date],
STG.[Consumption_Tax],
STG.[Tax_Value_for_Purch],
STG.[Calculation_Precision],
STG.[Withhold_Liability_GL],
STG.[Exported],
STG.[Especifico_Tax],
STG.[Used_Internally],
STG.[ALLOW_LOW_MODIFY],
STG.[ENFORCE_FOR_OS],
STG.[Inventory_Payout],
STG.[Purge],
STG.[Def_Number_Of_Days],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
''1900-01-01'', 
''2999-12-31'', CAST(getutcdate() AS DATE),' + '''' + @filename +''''+'
	FROM [DBO].[STG_TAX_AND_CHARGES] STG
	LEFT JOIN DBO.DIM_TAX_AND_CHARGES TRGT
	ON STG.TaxCharge_Code = TRGT.TaxCharge_Code
	WHERE (TRGT.TaxCharge_Code IS NULL);'
	
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
	Select 'PP_ENVOY_DIM_TAX_AND_CHARGES','SP_LOAD_DIM_STORES', @ins_errorno, @ins_errordesc, getutcdate()
	RAISERROR(@ins_errordesc,@ins_errorno,@ins_errorsta)
End Catch


/* ----------------

3.	UPDATE HISTORICAL ACTIVE DATA ONLY IF EXISTS
	MATCHING WITH KEY COMBINATIONS

*/ ----------------

set		@updateexist = '
UPDATE [dbo].[DIM_TAX_AND_CHARGES]
  SET [DIM_TAX_AND_CHARGES].[END_DATE] = dateadd (day,-1,Convert(date, substring(SRC.[TIMESTAMP],1,23),23))
  FROM DBO.[STG_TAX_AND_CHARGES] AS SRC
  WHERE [DIM_TAX_AND_CHARGES].TaxCharge_Code = SRC.TaxCharge_Code
  AND [DIM_TAX_AND_CHARGES].[END_DATE] = ''2999-12-31''
  AND [DIM_TAX_AND_CHARGES].[TIMESTAMP] < Convert(datetime, substring(SRC.[TIMESTAMP],1,23),121)'
  
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
	Select 'PP_ENVOY_DIM_TAX_AND_CHARGES','SP_LOAD_DIM_STORES', @upd_errorno, @upd_errordesc, getutcdate()
	RAISERROR(@upd_errordesc,@upd_errorno,@upd_errorsta)
End Catch


/* ----------------

4.	INSERT MODIFIED DATA FOR THE EXISTING KEY COMBINATIONS

*/ ----------------

set @insertmod ='INSERT INTO dbo.DIM_TAX_AND_CHARGES
SELECT 
case when STG.[TaxCharge_Code] = '''' then null else STG.[TaxCharge_Code] end,
STG.[Type],
STG.[Sub_Type],
STG.[Name],
STG.[Applies_On],
STG.[GL],
STG.[Value],
STG.[Tax_Type],
STG.[From_Date],
STG.[To_Date],
STG.[Consumption_Tax],
STG.[Tax_Value_for_Purch],
STG.[Calculation_Precision],
STG.[Withhold_Liability_GL],
STG.[Exported],
STG.[Especifico_Tax],
STG.[Used_Internally],
STG.[ALLOW_LOW_MODIFY],
STG.[ENFORCE_FOR_OS],
STG.[Inventory_Payout],
STG.[Purge],
STG.[Def_Number_Of_Days],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
dateadd (day,0,Convert(date, substring(STG.[TIMESTAMP],1,23),23)),
''2999-12-31'', CAST(getutcdate() AS DATE),' + '''' + @filename +''''+'
	FROM [DBO].[STG_TAX_AND_CHARGES] STG
	LEFT JOIN dbo.DIM_TAX_AND_CHARGES TRGT
	ON STG.TaxCharge_Code = TRGT.TaxCharge_Code
	WHERE Convert(datetime, substring(STG.[TIMESTAMP],1,23),121)  > TRGT.[TIMESTAMP]
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
	Select 'PP_ENVOY_DIM_TAX_AND_CHARGES','SP_LOAD_DIM_STORES', @mod_errorno, @mod_errordesc, getutcdate()
	RAISERROR(@mod_errordesc,@mod_errorno,@mod_errorsta)
End Catch

End