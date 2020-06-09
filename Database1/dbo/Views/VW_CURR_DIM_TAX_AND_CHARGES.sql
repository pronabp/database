CREATE VIEW [dbo].[VW_CURR_DIM_TAX_AND_CHARGES]
AS select * from DIM_TAX_AND_CHARGES where end_date='2999-12-31' and purge='0x46';