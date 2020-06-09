CREATE VIEW [dbo].[VW_PRICE_SALE_PROMO_TAX_TENDER_31032020]
AS SELECT distinct B.WOCY,MONTH(A.BusinessDayDate) as MOCY,B.QOCY, B.CY,A.BusinessDayDate, A.POSTXID,  A.BusinessUnitID,A.WorkstationID,A.LineTXType, A.Item, A.ItemDescription, A.SaleQuantity,
A.ActualSalesUnitPrice,A.UnitOfMeasureCode, A.amt_incl_GST_before_discount, A.discount,
A.PromotionID, A.PromotionDescription, A.TotalRewardAmount, A.IssuesCouponScanCode, A.QualifyingSpent,
A.TaxTypeCode, A.TaxableAmount, A.TaxAmount,A.TaxPercent,
CASE
  WHEN A.buy_UOM is not NULL and A.cost_price is not NULL THEN A.cost_price/A.buy_UOM
  ELSE NULL
END as unit_cost_price,
CASE
  WHEN A.sell_UOM is not NULL and A.sell_price is not NULL THEN A.sell_price/A.sell_UOM
  ELSE NULL
END as unit_sell_price,
C.EntryMethod	as TenderEntryMethod,
C.RefusalTypeCode	as TenderRefusalTypeCode,
REPLACE(C.TenderType, 'X:','') as TenderType	,
C.TenderTypeCode	,
C.TenderDescription	,
C.PromotionID	as TenderPromotionID,
C.Amount as TenderAmount	,
C.Currency	as TenderCurrency,
C.Cashback	as TenderCashback,
C.CashbackCurrency	as TenderCashbackCurrency,
C.SignatureRequiredFlag	,
C.VerifiedByPINFlag	,
C.RequestedAmount	,
C.RequestedAmountCurrency	,
C.AuthorizationCode	,
C.ReferenceNumber	,
C.MerchantNumber	,
C.ProviderID	,
C.AuthorizationDateTime	,
C.AuthorizingTermID	,
C.AuthorizationResponse	,
C.CardID	,
C.CardType	,
C.AuthorizationType	,
C.RoundingAmount	,
C.RoundingCurrency	,
C.RoundingDirection	,
C.TenderChange	,
C.ChangeCurrency	
FROM [VW_PRICE_SALE_TAX_REDUMPTION] A INNER JOIN DIM_CALENDAR B ON A.BusinessDayDate=B.CLNDR_DATE
LEFT OUTER JOIN EG_POS_TENDERLINE C ON
A.BusinessUnitID=C.BusinessUnitID and 
A.POSTXID=C.POSTXID and
A.BusinessDayDate=C.BusinessDayDate
where C.VoidFlag is NULL;