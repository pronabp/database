CREATE VIEW [dbo].[VW_PROMO_REDEMPTION_30032020]
AS select distinct AA.BusinessDayDate as sales_date, AA.BusinessUnitID as store, AA.POSTXID as basket_key, A.POSItemID as item, C.Name as item_name, 
A.SaleQuantityUnits as qty,A.ActualSalesUnitPrice as  unit_price, A.ExtendedAmount as amt_incl_GST_before_discount , A.ExtendedDiscountAmount*(-1) as line_discount, A.EntryMethod,
B.PromotionID, B.PromotionDescription, B.TotalRewardAmount, B.IssuesCouponScanCode, B.QualifyingSpent, B.TriggerTiming
from  EG_POS_HEADER AA INNER JOIN [EG_POS_ITEMLINE] A ON
AA.BusinessUnitID=A.BusinessUnitID and
AA.WorkstationID=A.WorkstationID and
AA.POSTXSequenceNumber=A.POSTXSequenceNumber and
AA.POSTXID=A.POSTXID and 
AA.BusinessDayDate=A.BusinessDayDate
LEFT OUTER JOIN [EG_POS_PROMO_SUMMARY] B ON
A.BusinessUnitID=B.BusinessUnitID and
A.WorkstationID=B.WorkstationID and
A.POSTXSequenceNumber=B.POSTXSequenceNumber and
A.POSTXID=B.POSTXID and 
A.BusinessDayDate=B.BusinessDayDate --and
--A.LineItemSequence=B.LineItemSequence
LEFT OUTER JOIN VW_CURR_DIM_PRODUCTS C on A.POSItemID=C.SKU_Number
where 
AA.TrainingFlag is NULL and 
--AA.POSTXID='FXCKXUJELM' and
upper(COALESCE(AA.TransactionStatus,'')) not in ('VOIDED', 'SUSPENDED', 'DELETED','SUSPENDEDDELETED', 'RETURNED') and 
upper(COALESCE(A.ItemVoidFlag,'')) not in ('TRUE','Y','YES') and upper(A.LineTXType) in ('FUELSALE','FUELSALES','SALE','SALES') and --C.product_type='F' and
A.ItemID is not NULL and upper(COALESCE(A.ReturnedFlag,'')) not in ('TRUE','Y','YES') and upper(COALESCE(A.TransactionStatus,'')) <>'VOIDED' and
lower(B.RewardType)='discount';