CREATE VIEW [dbo].[VW_CURR_DIM_STORES]
AS select * from [dbo].[DIM_STORES] where end_date='2999-12-31';