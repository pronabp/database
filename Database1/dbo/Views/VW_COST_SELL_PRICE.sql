CREATE VIEW [dbo].[VW_COST_SELL_PRICE]
AS select Z.ITEM, Z.Name, Z.buy_UOM, Z.Store, Z.cost_price, Z.from_date_cost, 
LEAD(Z.from_date_cost,1,'2999-12-31') OVER (PARTITION BY Z.ITEM, Z.buy_UOM, Z.Store ORDER BY  Z.ITEM, Z.buy_UOM, Z.Store, Z.from_date_cost  ASC) AS to_date_cost,
Z.sell_UOM, Z.Sell_price, Z.from_date_sell,
LEAD(Z.from_date_sell,1,'2999-12-31') OVER (PARTITION BY Z.ITEM, Z.buy_UOM, Z.Store ORDER BY  Z.ITEM, Z.buy_UOM, Z.Store, Z.from_date_sell  ASC) AS to_date_sell
from (
select A.PO_ITEM as ITEM, B.Name, A.UOM as buy_UOM, A.Store, A.Regular_Cost as cost_price,  A.From_date as from_date_cost, 
C.UOM as sell_UOM, C.Price as Sell_price, C.From_Date as from_date_sell
from PO_COST_BY_DATE A FULL OUTER JOIN [dbo].[VW_CURR_DIM_PRODUCTS] B
ON A.PO_ITEM=B.SKU_NUMBER
FULL OUTER JOIN Prices_By_Date C ON
A.PO_ITEM=C.UPC_PLU and
A.Store=C.Store
where A.Purge = '0x46' and C.Purge = '0x46' --and A.UOM in ('--LTR', '--UN', '1K','2K')
--and A.From_date=C.From_Date --and A.Regular_Cost> C.Price
) Z;