CREATE VIEW [dbo].[VW_SOH_REPORT]
AS SELECT
distinct
EWAE.Article_no AS ARTICLE_NUMBER, 
EVAE.UPC, 
EWAE.ARTICLE_DESC WOW_ARTICLE_DESCRIPTION,
EVAE.SKU_Name EG_ARTICLE_DESCRIPTION, 
EVAE.STORE,
--concat(concat(DWS.description,'-'),EWSS.Site_no) SITE_NAME, 
EWSS.STOCK_QTY Quantity,
EVAE.Termination_Date,
'' as Date,
'' as Time
FROM
[EG_WOW_ARTICLE_EAN] EWAE 
JOIN 
 (select * from [EG_WOW_SITE_SOH] where Site_no = '1433') EWSS 
ON EWAE.ARTICLE_NO=EWSS.ARTICLE_NO
JOIN ( select  coalesce(new.sku,old.sku) UPC,coalesce(old.sku,new.sku) SKU,coalesce(new.SKU_name,old.SKU_Name) SKU_Name,coalesce(new.Store,old.store) Store,coalesce(new.Termination_Date,old.Termination_Date) Termination_Date from( select distinct * from v_item_price
where Termination_Date = '00000000' and UOM = 'UN'
) new
full outer join
(select distinct * from v_item_price 
where Termination_Date <> '00000000' and UOM = 'UN') old
on new.SKU_Name = old.SKU_Name
and new.store = old.store  ) EVAE 
ON EVAE.SKU=EWAE.EAN
--AND CONCAT('9',EVAE.STORE) = EWSS.Site_no
where 
STOCK_QTY <> '0';