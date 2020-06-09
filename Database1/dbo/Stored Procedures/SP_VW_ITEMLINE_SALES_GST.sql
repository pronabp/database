CREATE PROC [dbo].[SP_VW_ITEMLINE_SALES_GST] @fromDate [datetime],@toDate [datetime] AS
Begin
select 'EG_POS' as source, AA.BusinessDayDate as sales_date, AA.BusinessUnitID as store, AA.POSTXID as basket_key, A.ItemID as item, C.Name as item_name, A.ActualSalesUnitPrice as  unit_price, 
A.SaleQuantityUnits as qty, A.ExtendedAmount as amt_incl_GST_before_discount , A.ExtendedDiscountAmount*(-1) as discount, B.TaxTypeCode as tax_code, 
B.TaxableAmount as taxable_amt, B.TaxAmount as tax,B.TaxPercent as tax_pct, A.source_file_name
from  EG_POS_HEADER AA INNER JOIN [EG_POS_ITEMLINE] A ON
AA.BusinessUnitID=A.BusinessUnitID and
AA.WorkstationID=A.WorkstationID and
AA.POSTXSequenceNumber=A.POSTXSequenceNumber and
AA.POSTXID=A.POSTXID and 
AA.BusinessDayDate=A.BusinessDayDate
LEFT OUTER JOIN [EG_POS_ITEMLINE_TAX] B ON
A.BusinessUnitID=B.BusinessUnitID and
A.WorkstationID=B.WorkstationID and
A.POSTXSequenceNumber=B.POSTXSequenceNumber and
A.POSTXID=B.POSTXID and 
A.BusinessDayDate=B.BusinessDayDate and
A.LineItemSequence=B.LineItemSequence
LEFT OUTER JOIN VW_CURR_DIM_PRODUCTS C on A.ItemID=C.SKU_Number
where 
AA.TrainingFlag is NULL and upper(COALESCE(AA.TransactionStatus,'')) not in ('VOIDED', 'SUSPENDED', 'DELETED','SUSPENDEDDELETED', 'RETURNED') and 
upper(COALESCE(ItemVoidFlag,'')) not in ('TRUE','Y','YES') and  
A.ItemID is not NULL and upper(COALESCE(A.ReturnedFlag,'')) not in ('TRUE','Y','YES') and
A.BusinessDayDate between @fromDate and @toDate
UNION
select 'WOW_POSDM' as source, A.start_txn_date as sales_date, concat('9',A.store_nbr)  as store, A.basket_key, A.barcode_nbr  as item, C.Name as item_name, '' as unit_price,
A.prod_sell_qty as qty, A.tot_gross_incld_gst as amt_incl_GST_before_discount, A.tot_pos_wow_dlr_incld_gst as discount, '' as tax_code,
A.tot_amt_incld_gst*100/(A.gst_pct+100) as taxable_amt, A.tot_amt_incld_gst*A.gst_pct/(A.gst_pct+100) as tax, A.gst_pct as tax_pct, '' as source_file_name
from [WOW_POSDM_LINEITEM_TLOG] A LEFT OUTER JOIN VW_CURR_DIM_PRODUCTS C on A.barcode_nbr=C.SKU_Number 
where upper(COALESCE(A.void_flag,'')) not in ('TRUE','Y','YES') and (A.prod_return_qty=0 or A.prod_return_qty is null) and A.start_txn_date between @fromDate and @toDate
UNION
select 'WOW_POSDTA' as source, A.BusinessDate as sales_date, concat('9',A.SiteNumber)  as store, concat(REPLACE(A.BusinessDate,'-',''),concat('9',A.SiteNumber),A.POSNumber,A.POSTXNNumber) as basket_key, A.Barcode as item, C.Name as item_name, A.RetailUnitPrice as unit_price,
A.RetailQuantity as qty, A.NormalSalesAmount as amt_incl_GST_before_discount, (A.NormalSalesAmount-A.RetailAmount)*(-1) as discount,  B.TaxType_Description as tax_code,
A.TaxableAmount as taxable_amt, A.TaxAmount as tax, A.TaxPercent as tax_pct, '' as source_file_name
FROM [WOW_POSDTA_LINEITEM_TLOG] A LEFT OUTER JOIN [EXT_LKP_POSDTA_TaxType] B ON A.TaxTypeCode=B.TaxType
LEFT OUTER JOIN VW_CURR_DIM_PRODUCTS C on A.Barcode=C.SKU_Number
where  A.ItemTXNType='S201' and A.BusinessDate between @fromDate and @toDate
END;