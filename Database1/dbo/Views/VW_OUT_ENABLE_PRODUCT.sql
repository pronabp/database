CREATE VIEW [dbo].[VW_OUT_ENABLE_PRODUCT]
AS select 
distinct
A.Name as "Product Name",
cast(A.SKU_NUMBER as varchar(50)) as "Product Reference",
cast(cast (A.Activation_Date as date) as varchar(22)) as "Start Date",
 '' as "End Date",
A.Inv_Lvl2_Name as "Category Name",
A.Inv_Lvl2 as "Category Number",
coalesce(C.ManufacturerName,'') as Manufacturer,
A.Inv_Lvl1_Name as "Segment Name",
A.Inv_Lvl1 as "Segment Number",
A.Inv_Lvl3_Name as "Sub Category Name",
A.Inv_Lvl3 as "Sub Category Number"
FROM
VW_CURR_DIM_PRODUCTS A 
INNER JOIN
VW_CURR_DIM_STORE_SKU_SUPPLIER B ON A.SKU_NUMBER=B.SKU -- 870,629
LEFT JOIN DIM_MANUFACTURER C
ON substring(A.SKU_NUMBER,1,len(CompanyPrefix)) = CompanyPrefix
where A.SKU_NUMBER in (
select distinct product
FROM [dbo].[VW_OUT_ENABLE_TURNOVER])
union all
select 
concat('ROWCOUNT_IS ',count(distinct [Product])) ,'','','','','','','','','',''
from [dbo].[VW_OUT_ENABLE_TURNOVER];