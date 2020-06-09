CREATE VIEW [dbo].[VW_COST_PRICE]
AS SELECT A.PO_ITEM as ITEM, B.Name, 
CASE
 WHEN upper(COALESCE(A.UOM,'1')) IN ('LTR', 'UN','EA','1') THEN 1 
 WHEN upper(A.UOM) LIKE '%K' THEN REPLACE(UPPER(A.UOM), 'K', '000') 
 WHEN A.UOM LIKE '%.' THEN REPLACE(A.UOM, '.', '') ELSE A.UOM
END as buy_UOM,
A.Store, A.Regular_Cost as cost_price,  A.From_date as from_date_cost,
LEAD(dateadd(dd,-1,A.from_date),1,'2999-12-31') OVER (PARTITION BY A.PO_ITEM, A.UOM, A.Store ORDER BY  A.PO_ITEM, A.UOM, A.Store, A.from_date  ASC) AS to_date_cost
from PO_COST_BY_DATE A LEFT OUTER JOIN [dbo].[VW_CURR_DIM_PRODUCTS] B
ON A.PO_ITEM=B.SKU_NUMBER
where A.Purge = '0x46';