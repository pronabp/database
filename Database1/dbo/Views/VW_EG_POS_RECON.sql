CREATE VIEW [dbo].[VW_EG_POS_RECON]
AS SELECT
  distinct
  STORE,
  BUSINESS_DAY,
  WorkstationID,
  POSTXSequenceNumber POS_NUMBER,
  TAXTYPECode,
  BusinessDayDate,
  CASE WHEN TAXTYPECode='Refund'
  THEN -1*POS_AMOUNT
  ELSE POS_AMOUNT
  END POS_AMOUNT,
  CASE WHEN TAXTYPECode='Refund'
  THEN -1*POS_TAX_AMOUNT
  ELSE POS_TAX_AMOUNT
  END POS_TAX_AMOUNT
  ,
  TRANSACTION_NUM ENVOY_POS_NUMBER,
  Envoy_amout,
   Quantity 
  from 
  ( select 
  POSTXSequenceNumber,
  TAXTYPECode,
  WorkstationID,
  POSTXID,
  BusinessUnitID,
  BusinessDayDate,
  sum(TaxableAmountBeforeRounding) POS_AMOUNT,
  sum(TaxAmount) POS_TAX_AMOUNT
  from  
  ( 
  select 
  distinct
  POSTXSequenceNumber,
  TAXTYPECode,
  WorkstationID,
  POSTXID,
  LineItemSequence,
  BusinessUnitID,
  BusinessDayDate,
  TaxableAmountBeforeRounding,
  TaxAmount
  from [dbo].[EG_POS_ITEMLINE_TAX]
 --  where BusinessDayDate = '2020-03-10'
 -- and BusinessUnitID = 91769 
   ) A
  group by 
  POSTXSequenceNumber,
  TAXTYPECode,
  WorkstationID,
  POSTXID,
  BusinessUnitID,
   BusinessDayDate) Z
 FULL OUTER JOIN
 (

   select 
   distinct
   TRANSACTION_NUM,
   STORE,
   DRAWER_NUM,
   CAST(BUSINESS_DAY as DATE) BUSINESS_DAY,
   sum(cast(Amount as float)) Envoy_amout,
   sum(cast(Quantity as float)) Quantity 
   from [dbo].[EG_ENVOY_PITRJOURNAL_HDR] ENVY
   Where
  -- ENVY.BUSINESS_DAY = '20200310' AND
    ENVY.JOURNAL_TYPE IN ('FUEL','UPC')
	-- AND ENVY.STORE = '91769'
   group by TRANSACTION_NUM, 
   STORE,
   BUSINESS_DAY,
   DRAWER_NUM) B
   ON Z.POSTXSequenceNumber = B.TRANSACTION_NUM 
   AND STORE = BusinessUnitID
   AND BUSINESS_DAY = BusinessDayDate
   AND WorkstationID = DRAWER_NUM;