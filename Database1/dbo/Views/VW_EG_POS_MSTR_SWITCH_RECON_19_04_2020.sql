CREATE VIEW [dbo].[VW_EG_POS_MSTR_SWITCH_RECON_19_04_2020]
AS select 
SequenceNumber,
TerminalID,
SwitchAmount,
EGStoreNo,
cast(coalesce(LoadDate,BusinessDayDate) as Date) BusinessDayDateSwitch,
BusinessUnitID,
WorkstationID,
POSTXSequenceNumber,
cast(coalesce(LoadDate,BusinessDayDate) as Date) BusinessDayDate,
POSAmount,
Currency,
CASE WHEN SwitchAmount = POSAmount
THEN 'Match'
ELSE 'No-Match'
END ReconStatus
from 
( select 
SequenceNumber,
TerminalID,
sum(SwitchTransaction/100) SwitchAmount,
EGStoreNo,
LoadDate

from
 (
	   select cast(RetrievalReferenceNo as decimal) SequenceNumber,
	       TerminalID,
	       EGStoreNo,
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
 --and RetrievalReferenceNo = 1056
 ) switch
 Group By
 SequenceNumber,
TerminalID,
--SWITCHTIME,
--sum(SwitchTransaction),
EGStoreNo,
LoadDate ) A
full outer join  
(
   select  
         [BusinessUnitID],
         [WorkstationID],
		 [POSTXSequenceNumber],
		 [BusinessDayDate],
		 sum(Amount) as POSAmount,
		 [Currency] from (select 
         [BusinessUnitID],
         [WorkstationID],
		 [POSTXSequenceNumber],
		 [BusinessDayDate],
		 CASE WHEN TenderTypeCode = 'Refund'
		 THEN -1*[Amount]
		 ELSE [Amount]
		 END Amount,
		 [Currency]
	from [dbo].[EG_POS_TENDERLINE]
	where RefusalTypeCode is NULL
	and TenderType = 'CreditDebit'
	and AuthorizationResponse = 'APPROVED'
) X group by [BusinessUnitID],
         [WorkstationID],
		 [POSTXSequenceNumber],
		 [BusinessDayDate],
		  [Currency]
) B
ON  A.SequenceNumber = B.[POSTXSequenceNumber] 
AND A.EGStoreNo = B.[BusinessUnitID]
AND RIGHT(B.WorkstationID,1) = RIGHT(A.TerminalID,1);