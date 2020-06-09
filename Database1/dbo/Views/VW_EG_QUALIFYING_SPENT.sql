CREATE VIEW [dbo].[VW_EG_QUALIFYING_SPENT]
AS select 
 distinct
  A.Inv_Lvl1,
  A.Inv_Lvl1_Name,
  B.QualifyingSpent QualifyingSpentonAllPurchase,
  B.BusinessUnitID,
  B.WorkstationID,
  B.POSTXSequenceNumber,
  A.POSTXEndDateTime,
  ItemDescription,
  SKU_Number,
  A.Spent,
  B.BusinessDayDate,
  B.PromotionDescription 
from
(select 
BusinessUnitID,
WorkstationID,
POSTXSequenceNumber,
BusinessDayDate, 
LineItemSequence,
POSTXEndDateTime,
ItemDescription,
Inv_Lvl1,
Inv_Lvl1_Name,
EPI.POSItemID,
DP.SKU_Number,
extendedamount Spent,
EPI.TransactionStatus
from [dbo].[EG_POS_ITEMLINE] EPI
LEFT JOIN [dbo].[DIM_PRODUCTS] DP
ON EPI.POSItemID = DP.SKU_Number
where EPI.BusinessDayDate >= '2020-03-24') A
Join 
(select BusinessUnitID,WorkstationID,POSTXSequenceNumber,BusinessDayDate,POSTXEndDateTime,PromotionDescription,sum(QualifyingSpent) QualifyingSpent
  from [dbo].[EG_POS_PROMO_SUMMARY]
where PromotionDescription = 'Woolworths Rewards Offline'
and BusinessDayDate >= '2020-03-24'
group by BusinessUnitID,WorkstationID,POSTXSequenceNumber,BusinessDayDate,POSTXEndDateTime,PromotionDescription ) B
ON A.BusinessUnitID = B.BusinessUnitID
AND A.WorkstationID = B.WorkstationID
AND A.POSTXSequenceNumber = B.POSTXSequenceNumber
AND A.BusinessDayDate = B.BusinessDayDate
AND A.POSTXEndDateTime = B.POSTXEndDateTime
WHERE
A.Spent > 0;