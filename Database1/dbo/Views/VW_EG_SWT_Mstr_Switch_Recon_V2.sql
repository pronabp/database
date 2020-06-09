CREATE VIEW [dbo].[VW_EG_SWT_Mstr_Switch_Recon_V2]
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
  CASE 
	  WHEN SwitchAmount = POSAmount
	  THEN 'Match'
	  ELSE 'No-Match'
  END ReconStatus,
  Min_SwitchDateTime,
  min_POSDateTime
from 

( 
	select 
	  SequenceNumber,
	  TerminalID,
	  min(SwitchTime) Min_SwitchDateTime,
	  sum(SwitchTransaction/100) SwitchAmount,
	  EGStoreNo,
	  LoadDate
	from
 	(
		-- Data from EG_WOW_SWITCH_TRANS
		select 
		  cast(RetrievalReferenceNo as decimal) SequenceNumber,
	      TerminalID,
	      EGStoreNo,
		  CASE 
			WHEN TransactionType = 'Refund'
	       	THEN -1*cast(TransactionAmount as decimal)
	       	ELSE cast(TransactionAmount as decimal)
	      END
	      SwitchTransaction,
		  concat(substring(coalesce(Timestamp,NULL),1,4),'',substring(coalesce(Timestamp,NULL),5,2),
		  '-  ',substring(coalesce(Timestamp,NULL),7,2)) 
		  BusinessDayDateSwitch,
	      concat(substring(coalesce(Timestamp,NULL),1,4),'-',substring(coalesce(Timestamp,NULL),5,2),
		  '-',substring(coalesce(Timestamp,NULL),7,2),' ',substring(coalesce(Timestamp,NULL),9,2),
		  ':',substring(coalesce(Timestamp,NULL),11,2),':',substring(coalesce(Timestamp,NULL),13,2),'.000') 
		  SWITCHTIME,
	      LoadDate,
		  ResponseCode
		from EG_WOW_SWITCH_TRANS
 		  where RetrievalReferenceNo is not null
		  and ResponseCode = '00'

	) 
	switch

	Group By
 	SequenceNumber,
	TerminalID,
	EGStoreNo,
	LoadDate
) 
A
 
left join
(

	select  
	  [BusinessUnitID],
	  [WorkstationID],
	  [POSTXSequenceNumber],
	  [BusinessDayDate],
	  min(POSDateTime) as min_POSDateTime,
	  sum(Amount) as POSAmount,
	  [Currency]
	from 
	(
		select 
		  eg_pos_tenderline.BusinessUnitID,
		  eg_pos_tenderline.WorkstationID,
		  eg_pos_tenderline.POSTXSequenceNumber,
		  eg_pos_tenderline.BusinessDayDate,
		  eg_pos_tenderline.POSTXEndDateTime as POSDateTime,
		  CASE 
			WHEN TenderTypeCode = 'Refund'
			THEN -1*[Amount]
			ELSE [Amount]
		  END Amount,
		  Currency
		from 
		  EG_POS_TENDERLINE as eg_pos_tenderline
		  inner join EG_POS_HEADER as eg_pos_header
		on  
		  eg_pos_tenderline.BusinessUnitID = eg_pos_header.BusinessUnitID and
		  eg_pos_tenderline.WorkStationID = eg_pos_header.WorkStationID and
		  eg_pos_tenderline.POSTXSequenceNumber = eg_pos_header.POSTXSequenceNumber and
		  eg_pos_tenderline.BusinessDayDate = eg_pos_header.BusinessDayDate
		where 
		  RefusalTypeCode is NULL
		  and TenderType = 'CreditDebit'
		  and AuthorizationResponse = 'APPROVED'
		  and trainingflag is NULL
	)
	X 

	group by 
	[BusinessUnitID],
	[WorkstationID],
	[POSTXSequenceNumber],
	[BusinessDayDate],
	[Currency]
) 
B

ON  A.SequenceNumber = B.[POSTXSequenceNumber] 
AND A.EGStoreNo = B.[BusinessUnitID]
AND RIGHT(B.WorkstationID,1) = RIGHT(A.TerminalID,1);