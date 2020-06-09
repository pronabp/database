CREATE VIEW [dbo].[VW_SELL_PRICE]
AS SELECT A.UPC_PLU as ITEM, 
CASE
 WHEN upper(COALESCE(A.UOM,'1')) IN ('LTR', 'UN','EA','1') THEN 1 
 WHEN upper(A.UOM) LIKE '%K' THEN REPLACE(UPPER(A.UOM), 'K', '000') 
 WHEN A.UOM LIKE '%.' THEN REPLACE(A.UOM, '.', '') ELSE A.UOM
END as sell_UOM,
A.Store, A.price as sell_price,  A.From_date as from_date_sell,
LEAD(dateadd(dd,-1,A.from_date),1,'2999-12-31') OVER (PARTITION BY A.UPC_PLU, A.UOM, A.Store ORDER BY  A.UPC_PLU, A.UOM, A.Store, A.from_date  ASC) AS to_date_sell
from Prices_By_Date A
--where UPC_PLU='8771' and store='91352'
where A.Purge = '0x46';