CREATE VIEW [dbo].[VW_PRICE_SALE_TAX_REDUMPTION]
AS SELECT distinct A.BusinessUnitID, A.WorkstationID, A.POSTXID,A.BusinessDayDate, A.LineTXType, A.POSItemID as item, A.ItemDescription,  A.RegularSalesUnitPrice, 
A.ActualSalesUnitPrice, 
CASE
  WHEN A.LineTXType='FuelSale' THEN A.SaleQuantityUnits ELSE A.SaleQuantity
END as SaleQuantity,
A.UnitOfMeasureCode,
/*
CASE
 WHEN upper(COALESCE(A.UnitOfMeasureCode,'1')) IN ('LTR', 'UN','EA','EACH','1') THEN 1 
 WHEN upper(A.UnitOfMeasureCode) LIKE '%K' THEN REPLACE(UPPER(A.UnitOfMeasureCode), 'K', '000') 
 WHEN A.UnitOfMeasureCode LIKE '%.' THEN REPLACE(A.UnitOfMeasureCode, '.', '') ELSE A.UnitOfMeasureCode
END as UOM, 
*/
A.ExtendedAmount as amt_incl_GST_before_discount , A.ExtendedDiscountAmount*(-1) as discount, 
E.PromotionID, E.PromotionDescription, E.TotalRewardAmount, E.IssuesCouponScanCode, E.QualifyingSpent,
D.TaxTypeCode, D.TaxableAmount, D.TaxAmount,D.TaxPercent, 
B.buy_UOM, B.cost_price, B.from_date_cost, B.to_date_cost, C.sell_UOM, C.sell_price, C.from_date_sell, C.to_date_sell
FROM [EG_POS_ITEMLINE] A
LEFT OUTER JOIN [VW_COST_PRICE] B ON A.POSItemID=B.ITEM and A.BusinessUnitID=B.Store 
LEFT OUTER JOIN [VW_SELL_PRICE] C ON A.POSItemID=C.ITEM and A.BusinessUnitID=C.Store
LEFT OUTER JOIN [EG_POS_ITEMLINE_TAX] D ON
A.BusinessUnitID=D.BusinessUnitID and
A.WorkstationID=D.WorkstationID and
A.POSTXSequenceNumber=D.POSTXSequenceNumber and
A.POSTXID=D.POSTXID and 
A.BusinessDayDate=D.BusinessDayDate and
A.LineItemSequence=D.LineItemSequence
LEFT OUTER JOIN [VW_PROMO_REDEMPTION] E ON
A.BusinessUnitID=E.store and
A.POSItemID=E.item and
A.BusinessDayDate=E.sales_date and
A.POSTXID=E.basket_key
where upper(A.LineTXType) in ('FUELSALE','SALE','SALES') and A.TransactionStatus is NULL 
and upper(COALESCE(A.ItemVoidFlag,'')) not in ('TRUE','Y','YES') and 
A.BusinessDayDate between COALESCE(B.from_date_cost,'1900-01-01') and COALESCE(B.to_date_cost,'2999-12-31') and
A.BusinessDayDate between COALESCE(C.from_date_sell,'1900-01-01') and COALESCE(C.to_date_sell,'2999-12-31');