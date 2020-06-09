CREATE PROC [dbo].[SP_LOAD_DIM_PROMOTION_STORE] @filename [NVARCHAR](100) AS

/********************************

SP Name			: SP_LOAD_DIM_PROMOTION_STORE
Target Table	: dbo.DIM_PROMOTION_STORE
Author			: Kishorekumar Balachandran
Modified By		: Kishorekumar Balachandran
Created Date	: 14/02/2020
Modified Date	: 14/02/2020
Description		: The purpose of this stored procedure is to use an external table from data lake storage
				  and load new/modified/update historical data. This is structured to handle SCD type 2.

********************************/

Begin

declare	@exttable varchar(max), @insertnew varchar(max)
declare @updateexist varchar(max), @insertmod varchar(max)

--declare @filename varchar(100)
--set @filename = 'eg_Promotion_Stores_20200202_141823234.csv'

/* ----------------

1.	DROP EXISTING EXTERNAL TABLE IF AVAILABLE AND RE-CREATE WITH A 
	FILE FROM DATA LAKE STORAGE

*/ ----------------

/*
If OBJECT_ID (N'dbo.STG_PROMOTION_STORE') IS NOT NULL
DROP EXTERNAL TABLE dbo.STG_PROMOTION_STORE

set @exttable = 'CREATE EXTERNAL TABLE dbo.STG_PROMOTION_STORE (
[RID] varchar(20) NULL,
[PromotionKey] varchar(50) NOT NULL,
[Store] varchar(20) NOT NULL,
[Apply] varchar(20) NULL,
[LastModifiedBy] varchar(20) NULL,
[TIMESTAMP] [varchar](100) NOT NULL,
[Purge] varchar(20)
)
 WITH (LOCATION='+'N'''+'/inbound/DIM_PROMOTION_STORE/'+ @filename + '''' + ',
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
	print('Issue observed while creating an external table dbo.STG_PROMOTION_STORE. Error Number is ' + @ext_errorno + ' and error description is '+ @ext_errordesc )
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'PP_ENVOY_DIM_PROMOTION_STORE','SP_LOAD_DIM_PROMOTION_STORE', @ext_errorno, @ext_errordesc, getutcdate()
	RAISERROR(@ext_errordesc,@ext_errorno,@ext_errorsta)
End Catch


/* ----------------

2. INSERT NEW RECORDS THAT DOES NOT EXIST ALREADY

*/ ----------------
*/

set @insertnew ='INSERT INTO dbo.DIM_PROMOTION_STORE
SELECT
case when STG.[PromotionKey] = '''' then null else STG.[PromotionKey] end,
case when STG.[Store] = '''' then null else STG.[Store] end,
STG.[Apply],
STG.[LastModifiedBy],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
STG.[Purge],
''1900-01-01'', 
''2999-12-31'', CAST(GETUTCDATE() AS DATE),' + 
'''' + @filename + '''' +'
	FROM [DBO].[STG_PROMOTION_STORE] STG
	LEFT JOIN DBO.DIM_PROMOTION_STORE TRGT
	ON (STG.PromotionKey = TRGT.PromotionKey AND STG.Store = TRGT.Store)
	WHERE (TRGT.PromotionKey IS NULL AND TRGT.STORE IS NULL );'

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
	Select 'PP_ENVOY_DIM_PROMOTION_STORE','SP_LOAD_DIM_PROMOTION_STORE', @ins_errorno, @ins_errordesc, getutcdate()
	RAISERROR(@ins_errordesc,@ins_errorno,@ins_errorsta)
End Catch


/* ----------------

3.	UPDATE HISTORICAL ACTIVE DATA ONLY IF EXISTS
	MATCHING WITH KEY COMBINATIONS

*/ ----------------

set		@updateexist = '
UPDATE [dbo].[DIM_PROMOTION_STORE]
  SET [DIM_PROMOTION_STORE].[END_DATE] = dateadd (day,-1,Convert(date, substring(SRC.[TIMESTAMP],1,23),23))
  FROM DBO.[STG_PROMOTION_STORE] AS SRC
  WHERE ([DIM_PROMOTION_STORE].PromotionKey = SRC.PromotionKey AND 
  [DIM_PROMOTION_STORE].Store = SRC.Store)
  AND [DIM_PROMOTION_STORE].[END_DATE] = ''2999-12-31''
  AND [DIM_PROMOTION_STORE].[TIMESTAMP] < Convert(datetime, substring(SRC.[TIMESTAMP],1,23),121)'

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
	Select 'PP_ENVOY_DIM_PROMOTION_STORE','SP_LOAD_DIM_PROMOTION_STORE', @upd_errorno, @upd_errordesc, getutcdate()
	RAISERROR(@upd_errordesc,@upd_errorno,@upd_errorsta)
End Catch


/* ----------------

4.	INSERT MODIFIED DATA FOR THE EXISTING KEY COMBINATIONS

*/ ----------------

set @insertmod ='INSERT INTO dbo.DIM_PROMOTION_STORE
SELECT 
case when STG.[PromotionKey] = '''' then null else STG.[PromotionKey] end,
case when STG.[Store] = '''' then null else STG.[Store] end,
STG.[Apply],
STG.[LastModifiedBy],
Convert(datetime, substring(STG.[TIMESTAMP],1,23),121),
STG.[Purge],
dateadd (day,0,Convert(date, substring(STG.[TIMESTAMP],1,23),23)), 
''2999-12-31'', CAST(GETUTCDATE() AS DATE),' + '''' + @filename +''''+'
	FROM [dbo].[STG_PROMOTION_STORE] STG
	LEFT JOIN dbo.DIM_PROMOTION_STORE TRGT
	ON (STG.STORE = TRGT.STORE AND STG.PromotionKey = TRGT.PromotionKey)
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
	Select 'PP_ENVOY_DIM_PROMOTION_STORE','SP_LOAD_DIM_PROMOTION_STORE', @mod_errorno, @mod_errordesc, getutcdate()
	RAISERROR(@mod_errordesc,@mod_errorno,@mod_errorsta)
End Catch

End
