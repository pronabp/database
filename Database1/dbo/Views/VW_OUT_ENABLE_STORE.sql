CREATE VIEW [dbo].[VW_OUT_ENABLE_STORE]
AS SELECT 
Name as 'Site Name',
store as 'Site Reference',
'2020-03-24' as 'Start Date',
''  'End Date',
Corp_Lvl4_Name as Area,
Corp_Lvl3_Name as Region,
substring(Corp_Lvl3_Name, charindex('-',Corp_Lvl3_Name)+1, len(Corp_Lvl3_Name)) as State
FROM 
VW_CURR_DIM_STORES
where store = '91433';