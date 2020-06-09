CREATE VIEW [dbo].[VW_OUT_ENABLE_PROMOTION]
AS select 
distinct
"Promotion Name",
"Promotion Reference",
"Start Date",
"End Date",
"Promotion Group",
"Promotion ID"
from
 (
 select 
 distinct 
 Description as "Promotion Name",
 PROMOTION_MASTER.PromotionCode as "Promotion Reference",
 cast(cast(PROMOTION_MASTER.ValidFromDate as date) as varchar(22)) as "Start Date",
 cast(cast(PROMOTION_MASTER.ValidToDate  as date) as varchar(22)) as "End Date",
 GroupName "Promotion Group",
 PROMOTION_MASTER.PromotionCode as "Promotion ID",
 dense_rank() OVER(partition by PROMOTION_MASTER.PromotionCode ORDER BY PROMOTION_MASTER.PromotionCode,PROMOTION_MASTER.Description,GroupName ) rownum
FROM PROMOTION_MASTER
JOIN  (select PromotionCode,max(ValidFromDate) ValidFromDate from PROMOTION_MASTER
group by PromotionCode) Delta
ON PROMOTION_MASTER.PromotionCode = Delta.PromotionCode
AND PROMOTION_MASTER.ValidFromDate = Delta.ValidFromDate 
where Purge='0x46'
AND PROMOTION_MASTER.promotionCode in (SELECT DISTINCT promotion from [dbo].[VW_OUT_ENABLE_TURNOVER])
--order by 1
) a
where rownum = 1;