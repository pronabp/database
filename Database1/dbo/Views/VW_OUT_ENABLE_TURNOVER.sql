CREATE VIEW [dbo].[VW_OUT_ENABLE_TURNOVER]
AS select 
distinct
cast(cast(B.BusinessDayDate as date) as Varchar(22)) as Date,
D.Supplier as Vendor,
cast(B.ItemID as Varchar(50)) as Product,
case 
when C.PromotionID is null 
then 'N/A' 
else C.PromotionID 
end as Promotion,
B.BusinessUnitID as Site,
'Sales' as "Transaction Type",
B.SaleQuantityUnits as Units,
cast(B.ExtendedAmount as decimal(14,2)) as Value,
B.CurrencyCode as Currency,
'' as "External Reference",
'' as "Interface Date"
from (select * from EG_POS_ITEMLINE
WHERE TransactionStatus is NULL) B 
JOIN [dbo].[EG_POS_PROMO_SUMMARY] C ON
B.BusinessUnitID=C.BusinessUnitID and 
B.WorkstationID=C.WorkstationID and 
B.POSTXSequenceNumber=C.POSTXSequenceNumber and
B.POSTXID=C.POSTXID and
B.POSTXEndDateTime=C.POSTXEndDateTime and
B.BusinessDayDate=C.BusinessDayDate 
--B.LineItemSequence=C.LineItemSequence
JOIN (select * from DIM_STORE_SKU_SUPPLIER
where store = '91433') D ON
B.ItemID=D.SKU
where --B.BusinessDayDate = '2020-04-06'
--and 
C.PromotionID is not null
and
B.ExtendedAmount is not null
and
B.CurrencyCode is not null
and C.PromotionID like 'EG%'
and B.BusinessDayDate >= '2020-03-24';