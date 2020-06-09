CREATE VIEW [dbo].[VW_POS_Declaration]
AS SELECT Z4.WOCY, Z4.BusinessDayDate, Z4.tx_time, Z4.POSTXBeginDateTime, Z4.POSTXEndDateTime, Z4.postxid, Z4.store, Z4.store_name, Z4.pos_id, Z4.POSOperatorName, sum(Z4.Amount) as Amount,
LAG(sum(Z4.Amount),1,0) OVER (PARTITION BY Z4.WOCY,Z4.store,Z4.pos_id ORDER BY  Z4.WOCY, Z4.store, Z4.store_name, Z4.pos_id, Z4.BusinessDayDate, Z4.tx_time  ASC) AS PrevAmount, Z4.TXType
from (
select Z3.WOCY, Z3.BusinessDayDate, Z3.tx_time, Z3.POSTXBeginDateTime, Z3.POSTXEndDateTime, Z3.postxid, Z3.store, Z3.store_name, 
CASE
   WHEN Z3.WorkstationID is NULL THEN Z3.WorkstationID_2 ELSE Z3.WorkstationID
END AS pos_id, 
Z3.POSOperatorName, Z3.Amount ,Z3.TXType
--, COALESCE(len(Z3.WorkstationID),0) as len_WorkstationID, COALESCE(len(Z3.WorkstationID_2),0) as len_WorkstationID_2
FROM
(
select C.WOCY, Z1.BusinessDayDate, Z1.tx_time, Z1.POSTXBeginDateTime, Z1.POSTXEndDateTime, Z1.postxid, Z1.store, Z1.store_name, Z1.WorkstationID, Z1.POSOperatorName, Z1.Amount,Z1.TXType, Z1.TillID, Z2.postxid as postxid_2, Z2.workstationID as workstationID_2
FROM (
select distinct --C.WOCY, 
A.BusinessDayDate,
CASE
  WHEN upper(A.TXType)='TILLSETTLE' THEN convert(date, A.POSTXEndDateTime, 23) ELSE A.BusinessDayDate
END AS actual_date,
CASE
  WHEN A.SettlementDate is NULL  THEN  convert(varchar, A.POSTXEndDateTime, 24) ELSE convert(varchar, A.SettlementDate, 24)
END AS tx_time,
A.POSTXBeginDateTime,  A.POSTXEndDateTime, A.postxid, A.BusinessUnitID as store, D.Name as store_name,
B.WorkstationID,
A.POSOperatorID, A.POSOperatorName,
CASE
  WHEN lower(B.DeclarationType)='short' THEN B.Amount*(-1) ELSE B.Amount
END AS Amount,
A.TXType, B.TillID, B.source_file_name
FROM [dbo].[EG_POS_HEADER] A INNER JOIN [dbo].[EG_POS_DECLARATION] B ON
A.BusinessUnitID=B.BusinessUnitID and
A.POSTXSequenceNumber=B.POSTXSequenceNumber and
A.POSTXEndDateTime=B.POSTXEndDateTime
and A.BusinessDayDate=B.BusinessDayDate
--INNER JOIN DIM_CALENDAR C ON convert(date,A.POSTXEndDateTime,23)=C.CLNDR_DATE
LEFT OUTER JOIN VW_CURR_DIM_STORES D ON A.BusinessUnitID=D.Store
where upper(A.TXType) in ('TILLSETTLE', 'TENDERDECLARATION') and A.TrainingFlag is NULL and B.DeclarationType is not NULL and upper(B.TillID) not like '%SAFE' 
--and convert(date,A.POSTXEndDateTime,23) between '2020-03-01' and '2020-03-06'
--order by WOCY, store, pos_id, BusinessDayDate, tx_time
) Z1 INNER JOIN DIM_CALENDAR C ON Z1.actual_date=C.CLNDR_DATE
LEFT OUTER JOIN
(
select distinct 
A.postxid, B.workstationID from [EG_POS_HEADER] A LEFT OUTER JOIN [EG_POS_DECLARATION] B ON 
A.BusinessUnitID=B.BusinessUnitID and
A.POSTXSequenceNumber=B.POSTXSequenceNumber and
A.POSTXEndDateTime=B.POSTXEndDateTime and
A.postxid=B.postxid
where upper(A.txtype) = 'TENDERDECLARATION' and   B.DeclarationType is NULL and  B.workstationid is not NULL and upper(B.TillID) not like '%SAFE' 
--and convert(date,B.POSTXEndDateTime,23) between '2020-03-01' and '2020-03-06'
) Z2
ON Z1.postxid=Z2.postxid
) Z3 
where COALESCE(len(Z3.WorkstationID),0)+COALESCE(len(Z3.WorkstationID_2),0) >0
) Z4
GROUP BY WOCY, BusinessDayDate, tx_time, POSTXBeginDateTime, POSTXEndDateTime, postxid, store, store_name, pos_id,POSOperatorName,TXType;