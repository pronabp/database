CREATE VIEW [dbo].[EG_POS_ENVY_SKU_SALES_RECON]
AS select 
POS.SKU POS_SKU,
ItemDescription,
BusinessUnitID,
BusinessDayDate,
(POS.amt-POS.discount) POS_amount, 
cast (round(POS.qty,0) as int) POS_qty,
Env.SKU,
Env.amount,
Env.refund, 
cast(round(Env.Qty,0) as int)as  envy_qty, 
Env.r_qty   envy_refund_qty,
Env.gst
from
 (
 select POSItemID as SKU,ItemDescription,BusinessUnitID,
BusinessDayDate,sum(extendedamount) amt,sum(extendeddiscountamount) discount,sum(SaleQuantityUnits) qty
from  
(
select 
line.* 
from
( 
   select 
    distinct
	BusinessUnitID,
	WorkstationID,
	POSTXSequenceNumber,
	BusinessDayDate
	from 
	[dbo].[EG_POS_HEADER]
	where 
	TrainingFlag 
	is null ) Header
	inner join 
	( select 
	distinct POSTXSequenceNumber,
	POSItemID,
	ItemDescription,
	WorkstationID,
	BusinessUnitID,
	BusinessDayDate,
	LineItemSequence,
	case 
	  when transactionstatus = 'Returned' OR ItemVoidFlag = 'true'
	  then -1*coalesce(extendedamount,0)
	  else coalesce(extendedamount,0)
	  end 
	extendedamount,
   case 
      when transactionstatus = 'Returned' OR ItemVoidFlag = 'true'
      then -1*coalesce(SaleQuantity*SaleQuantityUnits,0)
      else coalesce(SaleQuantity*SaleQuantityUnits,0)
      end 
   SaleQuantityUnits,
   coalesce(extendeddiscountamount,0) extendeddiscountamount
 from [dbo].[EG_POS_ITEMLINE]
where  (TransactionStatus is null OR TransactionStatus = 'Resumed' OR TransactionStatus = 'Returned' )
--AND LineTXType IN ('FuelSale','Sale')
) line
ON header.BusinessUnitID = line.BusinessUnitID
AND header.WorkstationID = line.WorkstationID
AND header.POSTXSequenceNumber = line.POSTXSequenceNumber
AND header.BusinessDayDate = line.BusinessDayDate
WHERE  line.extendedamount <> 0.0
) A
 group by 
 POSItemID,ItemDescription,BusinessUnitID,
BusinessDayDate ) POS
 Left join
  (
select Code_or_UPC SKU,Store,recons_date,sum(Amount_Including_TaxIncl) amount,sum(refund_amount) refund,sum(Qty_sold_in_UPC_UOM) qty,sum(refund_count) r_qty,sum(TaxIncl_Amount) gst
from [dbo].[Recons_Sales_Details]
where 
Amount_Including_TaxIncl <> 0
and Type in ('F','R','H')
group by Code_or_UPC,Store,recons_date ) Env
ON trim(POS.SKU) = trim(Env.SKU)
and POS.BusinessUnitID = Env.Store
and POS.BusinessDayDate = cast(Env.recons_date as datetime)

where (POS.amt-POS.discount)  <> 0;