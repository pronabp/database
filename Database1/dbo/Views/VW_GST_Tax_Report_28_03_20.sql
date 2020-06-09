CREATE VIEW [dbo].[VW_GST_Tax_Report_28_03_20]
AS select * from (
select distinct AA.BusinessDayDate as sales_date, AA.BusinessUnitID as store, AA.POSTXID as basket_key, A.POSItemID as item, C.Name as item_name, A.ActualSalesUnitPrice as  unit_price, 
CASE
  WHEN A.LineTXType='FuelSale' THEN A.SaleQuantityUnits ELSE A.SaleQuantity
END as SaleQuantity,
A.ExtendedAmount as amt_incl_GST_before_discount , A.ExtendedDiscountAmount*(-1) as discount, B.TaxTypeCode as tax_code, 
B.TaxableAmount as taxable_amt, B.TaxAmount as tax,B.TaxPercent as tax_pct,
CASE
  WHEN B.TaxAmount is NULL THEN 'NO TAX'
  ELSE '20'
END as sell_tax_code,
C.Sales_GL as Envoy_Sales_GL, substring(Sales_GL,1,8) as SAP_Sales_GL, C.Cost_GL as Envoy_Cost_GL, substring(Cost_GL,1,8) as SAP_Cost_GL
from  EG_POS_HEADER AA INNER JOIN EG_POS_ITEMLINE A ON
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
LEFT OUTER JOIN VW_CURR_DIM_PRODUCTS C on A.POSItemID=C.SKU_Number
where 
AA.TrainingFlag is NULL and upper(COALESCE(AA.TransactionStatus,'')) not in ('VOIDED', 'SUSPENDED', 'DELETED','SUSPENDEDDELETED', 'RETURNED') and 
upper(COALESCE(ItemVoidFlag,'')) not in ('TRUE','Y','YES') and  
A.ItemID is not NULL and upper(COALESCE(A.ReturnedFlag,'')) not in ('TRUE','Y','YES')
) Z1 INNER JOIN
(select distinct TaxCharge_Code, TYPE, SUB_TYPE, NAME, GL as TAX_GL from VW_CURR_DIM_TAX_AND_CHARGES) Z2 ON Z1.sell_tax_code=Z2.TaxCharge_Code;