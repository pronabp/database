﻿CREATE VIEW [dbo].[VW_EG_POS_MSTR_SWITCH_RECON_06052020]
AS select 
SequenceNumber,
SwitfCardInitial,
CardType POSCardType,
TerminalID,
SwitchAmount,
EGStoreNo,
cast(coalesce(LoadDate,BusinessDayDate) as Date) BusinessDayDateSwitch,
SwitchTransactionTime,
BusinessUnitID,
WorkstationID,
POSTXSequenceNumber,
cast(coalesce(LoadDate,BusinessDayDate) as Date) BusinessDayDate,
FORMAT(POSTransactionTime,'yyyy-MM-dd HH:mm:ss') POSTransactionTime,
POSAmount,
Currency,
CASE WHEN SwitchAmount = POSAmount
THEN 'Match'
ELSE 'No-Match'
END ReconStatus
from 
( 
select 
SequenceNumber,
SwitfCardInitial,
TerminalID,
sum(SwitchTransaction/100) SwitchAmount,
min(SWITCHTIME) SwitchTransactionTime, 
EGStoreNo,
LoadDate
from
 (
	   select 
	       cast(RetrievalReferenceNo as decimal) SequenceNumber,
	       TerminalID,
	       EGStoreNo,
		    substring(maskedPAN,1,6) SwitfCardInitial,
	       CASE WHEN TransactionType = 'Refund'
	       THEN -1*cast(TransactionAmount as decimal)
	       ELSE cast(TransactionAmount as decimal)
	       END
	       SwitchTransaction,
		   concat(substring(coalesce(Timestamp,NULL),1,4),'-',substring(coalesce(Timestamp,NULL),5,2),'-',substring(coalesce(Timestamp,NULL),7,2)) BusinessDayDateSwitch,
	       concat(substring(coalesce(Timestamp,NULL),1,4),'-',substring(coalesce(Timestamp,NULL),5,2),'-',substring(coalesce(Timestamp,NULL),7,2),' ',substring(coalesce(Timestamp,NULL),9,2),':',substring(coalesce(Timestamp,NULL),11,2),':',substring(coalesce(Timestamp,NULL),13,2),'.000') SWITCHTIME,
		   LoadDate
	    from EG_WOW_SWITCH_TRANS
        where RetrievalReferenceNo is not null
-- and loadDate= '2020-03-25 22:55:46.800'
 ) switch
 Group By
 SequenceNumber,
 SwitfCardInitial,
 TerminalID,
-- SWITCHTIME,
--sum(SwitchTransaction),
 EGStoreNo,
 LoadDate ) A
FULL OUTER JOIN  
(
   select  [BusinessUnitID],
         [WorkstationID],
		 [POSTXSequenceNumber],
		 [BusinessDayDate],
		 sum(Amount) as POSAmount,
		 max(POSTXEndDateTime) as POSTransactionTime,
		 [Currency],
		 [CardType]
		 from (select 
         [BusinessUnitID],
         [WorkstationID],
		 [POSTXSequenceNumber],
		 [POSTXEndDateTime],
		 [BusinessDayDate],
		 CASE WHEN TenderTypeCode = 'Refund'
		 THEN -1*[Amount]
		 ELSE [Amount]
		 END Amount,
		 [Currency],
		 [CardType]
	from [dbo].[EG_POS_TENDERLINE]
	where RefusalTypeCode is NULL
	and TenderType = 'CreditDebit') X 
	group by 
	[BusinessUnitID],
    [WorkstationID],
    [POSTXSequenceNumber],
    [BusinessDayDate],
    [Currency],
    [CardType]
) B
ON  A.SequenceNumber = B.[POSTXSequenceNumber] 
AND A.EGStoreNo = B.[BusinessUnitID]
AND RIGHT(B.WorkstationID,1) = RIGHT(A.TerminalID,1)
AND SwitchAmount = POSAmount;