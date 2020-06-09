CREATE VIEW [dbo].[VW_OUT_ENABLE_VENDOR]
AS SELECT
DISTINCT
SUPPLIER_NAME  'Vendor Name',
SUPPLIER  'Vendor Reference',
'Supplier' 'Vendor Type'
FROM 
VW_CURR_DIM_STORE_SKU_SUPPLIER
where SUPPLIER IN (SELECT 
      distinct [Vendor]
      
  FROM [dbo].[VW_OUT_ENABLE_TURNOVER]);