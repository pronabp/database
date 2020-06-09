CREATE PROC [dbo].[SP_LOAD_DIM_PC_INV_ADJ_TYPES] @filename [NVARCHAR](100) AS


/********************************

SP Name			: SP_LOAD_DIM_PC_INV_ADJ_TYPES
Target Table	: dbo.DIM_PC_INV_ADJ_TYPES
Author			: Kishorekumar Balachandran
Created Date	: 10/02/2020
Modified Date	: 11/02/2020
Description		: The purpose of this stored procedure is to use an external table from data lake storage
				  and load new/modified/update historical data. This is structured to handle SCD type 2.

********************************/

Begin
declare	@exttable varchar(max), @insertnew varchar(max)
declare @updateexist varchar(max), @insertmod varchar(max)

--declare	@filename varchar(100)
--set @filename = 'eg_pc_inv_adj_types_1900-01-01T000000_2020-02-20T095626.csv'

/* ----------------

1.	DROP EXISTING EXTERNAL TABLE IF AVAILABLE AND RE-CREATE WITH A 
	FILE FROM DATA LAKE STORAGE

 ----------------

If OBJECT_ID (N'dbo.STG_PC_INV_ADJ_TYPES') IS NOT NULL
DROP EXTERNAL TABLE dbo.STG_PC_INV_ADJ_TYPES

set @exttable = 'CREATE EXTERNAL TABLE dbo.STG_PC_INV_ADJ_TYPES (
[Adj_Type] varchar(100) NOT NULL,
[Description] varchar(100) NULL,
[GL] varchar(100) NULL,
[Exported] varchar(100) NULL,
[Purge] varchar(100) NULL,
[TIMESTAMP] varchar(100) NULL,
[Type] varchar(100) NULL,
[USE_IN_RATIO_FLAG] varchar(20) NULL

)
 WITH (LOCATION='+'N'''+'/inbound/DIM_PC_INV_ADJ_TYPES/'+ @filename + '''' + ',
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
	Select 'PP_ENVOY_DIM_PC_INV_ADJ_TYPES','SP_LOAD_DIM_STORES', @ext_errorno, @ext_errordesc, getutcdate()
End Catch

*/
/* ----------------

2. INSERT NEW RECORDS THAT DOES NOT EXIST ALREADY

*/ ----------------

set @insertnew ='INSERT INTO dbo.DIM_PC_INV_ADJ_TYPES
SELECT case when STG.[Adj_Type] = '''' then null else STG.[Adj_Type] end,
STG.[Description],
STG.[GL],
STG.[Exported],
STG.[Purge],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
STG.[Type],
STG.[USE_IN_RATIO_FLAG],
''1900-01-01'', 
''2999-12-31'', CAST(getutcdate() AS DATE),' + '''' + @filename +'''' + '
	FROM [DBO].[STG_PC_INV_ADJ_TYPES] STG
	LEFT JOIN DBO.DIM_PC_INV_ADJ_TYPES TRGT
	ON STG.Adj_Type = TRGT.Adj_Type
	WHERE TRGT.Adj_Type IS NULL'

Begin Try
	exec(@insertnew)
End Try

Begin Catch
	declare @ins_errorno varchar(20), @ins_errordesc varchar(max), @ins_errorsta varchar(max)
	set @ins_errorno = ERROR_NUMBER()
	set @ins_errordesc = ERROR_MESSAGE()
	set @ins_errorsta = ERROR_SEVERITY()
	print('Inserting new records having an issue. Error Number is ' + @ins_errorno + ' and error description is '+ @ins_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PC_INV_ADJ_TYPES','SP_LOAD_DIM_PC_INV_ADJ_TYPES', @ins_errorno, @ins_errordesc, getutcdate()
	RAISERROR(@ins_errordesc,@ins_errorno,@ins_errorsta)
End Catch


/* ----------------

3.	UPDATE HISTORICAL ACTIVE DATA ONLY IF EXISTS
	MATCHING WITH KEY COMBINATIONS

*/ ----------------

set		@updateexist = '
UPDATE DBO.[DIM_PC_INV_ADJ_TYPES]
  SET [DIM_PC_INV_ADJ_TYPES].[END_DATE] = dateadd (day,-1,Convert(date, substring(SRC.[TIMESTAMP],1,23),23))
  FROM DBO.[STG_PC_INV_ADJ_TYPES] AS SRC
  WHERE [DIM_PC_INV_ADJ_TYPES].Adj_Type = SRC.Adj_Type
  AND [DIM_PC_INV_ADJ_TYPES].[END_DATE] = ''2999-12-31''
  AND [DIM_PC_INV_ADJ_TYPES].[TIMESTAMP] < Convert(datetime, substring(SRC.[TIMESTAMP],1,23),121)'

  
Begin Try
	exec(@updateexist)
End Try

Begin Catch
	declare @upd_errorno varchar(20), @upd_errordesc varchar(max), @upd_errorsta varchar(max)
	set @upd_errorno = ERROR_NUMBER()
	set @upd_errordesc = ERROR_MESSAGE()
	set @upd_errorsta = ERROR_SEVERITY()
	print('Updating historical data having an issue. Error Number is ' + @upd_errorno + ' and error description is '+ @upd_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PC_INV_ADJ_TYPES','SP_LOAD_DIM_PC_INV_ADJ_TYPES', @upd_errorno, @upd_errordesc, getutcdate()
	RAISERROR(@upd_errordesc,@upd_errorno,@upd_errorsta)
End Catch


/* ----------------

4.	INSERT MODIFIED DATA FOR THE EXISTING KEY COMBINATIONS

*/ ----------------

set @insertmod ='INSERT INTO dbo.DIM_PC_INV_ADJ_TYPES
SELECT case when STG.[Adj_Type] = '''' then null else STG.[Adj_Type] end,
STG.[Description],
STG.[GL],
STG.[Exported],
STG.[Purge],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
STG.[Type],
STG.[USE_IN_RATIO_FLAG],
dateadd (day,0,Convert(date, substring(STG.[TIMESTAMP],1,23),23)), 
''2999-12-31'', CAST(GETUTCDATE() AS DATE),' + '''' + @filename +'''' + '
	FROM [DBO].[STG_PC_INV_ADJ_TYPES] STG
	LEFT JOIN dbo.DIM_PC_INV_ADJ_TYPES TRGT
	ON STG.Adj_Type = TRGT.Adj_Type
	WHERE Convert(datetime, substring(STG.[TIMESTAMP],1,23),121) > TRGT.[TIMESTAMP]
	AND TRGT.end_date = dateadd (day,-1,Convert(date, substring(STG.[TIMESTAMP],1,23),23))'

	
Begin Try
	exec(@insertmod)
End Try

Begin Catch
	declare @mod_errorno varchar(20), @mod_errordesc varchar(max), @mod_errorsta varchar(max)
	set @mod_errorno = ERROR_NUMBER()
	set @mod_errordesc = ERROR_MESSAGE()
	set @mod_errorsta = ERROR_SEVERITY()
	print('Inserting modified data having an issue. Error Number is ' + @mod_errorno + ' and error description is '+ @mod_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PC_INV_ADJ_TYPES','SP_LOAD_DIM_PC_INV_ADJ_TYPES', @mod_errorno, @mod_errordesc, getutcdate()
	RAISERROR(@mod_errordesc,@mod_errorno,@mod_errorsta)
End Catch

End
