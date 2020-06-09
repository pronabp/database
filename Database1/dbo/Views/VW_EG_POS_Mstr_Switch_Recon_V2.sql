CREATE VIEW [dbo].[VW_EG_POS_Mstr_Switch_Recon_V2]
AS select 
  BusinessUnitID,
  WorkstationID,
  POSTXSequenceNumber,
  cast(coalesce(LoadDate,BusinessDayDate) as Date) BusinessDayDateSwitch,
  cast(coalesce(LoadDate,BusinessDayDate) as Date) BusinessDayDate, 
  POSAmount,
  Currency,
  TenderType,
  TenderTypeCode,
  TenderDescription,
  Min_POSDateTime,
  CASE 
		WHEN TenderType = 'CreditDebit' and SwitchAmount = POSAmount
			THEN 'Match'
		WHEN TenderType = 'CreditDebit' and SwitchAmount <> POSAmount
			THEN 'No-Match'
		ELSE 'Not Applcable'
  END ReconStatus,
  SequenceNumber,		
  TerminalID,			
  SwitchAmount,			
  EGStoreNo,			
  AuthorizationResponse,
  CardID,
  CardType,
  min_SwitchTime
from 
(
	select  
    BusinessUnitID,
    WorkstationID,
	POSTXSequenceNumber,
	TenderType,
	TenderTypeCode,
	TenderDescription,
	AuthorizationResponse,
	CardID,
	CardType,
	BusinessDayDate,
	min(POSDateTime) as Min_POSDateTime,
	sum(Amount) as POSAmount,
	Currency 
	from
	(
		select 
          eg_pos_tenderline.BusinessUnitID,
          eg_pos_tenderline.WorkstationID,
		  eg_pos_tenderline.POSTXSequenceNumber,
		  eg_pos_tenderline.TenderType,
		  eg_pos_tenderline.TenderTypeCode,
		  eg_pos_tenderline.TenderDescription,
		  eg_pos_tenderline.AuthorizationResponse,
		  eg_pos_tenderline.CardID,
		  eg_pos_tenderline.CardType,
		  eg_pos_tenderline.BusinessDayDate,
		  eg_pos_tenderline.TenderEndDateTime POSDateTime,
		  CASE WHEN TenderTypeCode = 'Refund'
			THEN -1*Amount
			ELSE Amount
		  END Amount,
		  Currency
		from EG_POS_TENDERLINE as eg_pos_tenderline
		inner join EG_POS_HEADER as eg_pos_header
		on  
		  eg_pos_tenderline.BusinessUnitID = eg_pos_header.BusinessUnitID and
		  eg_pos_tenderline.WorkStationID = eg_pos_header.WorkStationID and
		  eg_pos_tenderline.POSTXSequenceNumber = eg_pos_header.POSTXSequenceNumber and
		  eg_pos_tenderline.BusinessDayDate = eg_pos_header.BusinessDayDate
		where 
		  RefusalTypeCode is not NULL
		  and trainingflag is NULL
	)
	X 
	group by 
	  BusinessUnitID,
      WorkstationID,
	  POSTXSequenceNumber,
	  TenderType,
	  TenderTypeCode,
	  TenderDescription,
	  AuthorizationResponse,
	  CardID,
	  CardType,
	  BusinessDayDate,
	  POSDateTime,
	  Currency

) 
B

left join

( 
	select 
	SequenceNumber,
	TerminalID,
	min(SWITCHTIME) min_SwitchTime,
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

	) 
	switch
	Group By
	SequenceNumber,
	TerminalID,
	EGStoreNo,
	LoadDate 
)
A
ON  A.SequenceNumber = B.[POSTXSequenceNumber] 
AND A.EGStoreNo = B.[BusinessUnitID]
AND RIGHT(B.WorkstationID,1) = RIGHT(A.TerminalID,1);