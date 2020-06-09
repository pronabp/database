CREATE VIEW [VW_EG_POS_NON_LYLTY_TXNS]
AS select	distinct '3' as partner_id, a.WorkstationID as pos_no, a.BusinessUnitID as site_no, a.POSTXSequenceNumber as trans_no, 
		a.POSTXEndDateTime as sale_date, a.ItemID as item_nbr,
		a.ItemDescription as item_description, 
		coalesce(cast(a.SaleQuantityUnits as decimal(10,2)),0.00) as quantity,
		coalesce(cast(a.RegularSalesUnitPrice as decimal(10,2)),0.00) as unit_price,
		(coalesce(cast(a.ExtendedAmount as decimal(10,2)),0.00) - coalesce(cast(a.ExtendedDiscountAmount as decimal(10,2)),0.00)) as sale_price,
		coalesce(cast(a.ExtendedDiscountAmount as decimal(10,2)),0.00) as discount
	from 
		dbo.EG_POS_ITEMLINE a (nolock) JOIN dbo.EG_POS_HEADER b (nolock)
			ON a.POSTXID = b.POSTXID
			where exists (select distinct POSTXID, BusinessDayDate from EG_POS_HEADER (nolock)
							where POSTXID NOT IN (select distinct POSTXID from EG_POS_LOYALTY_SUMMARY (nolock)))
			and a.BusinessUnitID = b.BusinessUnitID
			and a.POSTXEndDateTime = b.POSTXEndDateTime
			and a.WorkstationID = b.WorkstationID
			and a.POSTXSequenceNumber = b.POSTXSequenceNumber
			and b.TrainingFlag is NULL and upper(COALESCE(b.TransactionStatus,'')) not in ('VOIDED', 'SUSPENDED', 'DELETED','SUSPENDEDDELETED', 'RETURNED')
			and upper(COALESCE(a.ItemVoidFlag,'')) not in ('TRUE','Y','YES')  
			and a.ItemID is not NULL and upper(COALESCE(a.ReturnedFlag,'')) not in ('TRUE','Y','YES')
			and a.LineitemAction is null;