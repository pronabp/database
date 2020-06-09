CREATE VIEW [dbo].[VW_WK_QTY_SALE]
AS SELECT WOCY,CY,Item, ItemDescription, SUM(SaleQuantity) as total_qty, AVG(unit_sell_price) as avg_sell_price, AVG(ActualSalesUnitPrice) as avg_actual_sales_price, SUM(amt_incl_GST_before_discount) as total_sale_before_discount, SUM(amt_incl_GST_before_discount+discount) as total_sale_after_discount,
SUM(discount) as total_discount, SUM(TaxAmount) as total_tax, AVG(unit_cost_price) as avg_cost_price, SUM(unit_cost_price*SaleQuantity) as total_cost
FROM VW_PRICE_SALE_PROMO_TAX_TENDER
--where BusinessDayDate between '2020-03-01' and '2020-03-16'
group by WOCY,CY,Item, ItemDescription;