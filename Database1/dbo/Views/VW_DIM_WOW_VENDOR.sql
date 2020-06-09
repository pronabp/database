CREATE VIEW [dbo].[VW_DIM_WOW_VENDOR] ([VENDOR], [NAME], [STREET_NAME], [LOCATION], [POSTAL_CODE], [REGION], [COUNTRY], [TAX_NO], [DELETE_IND], [DUNS_NO], [FAX_NO], [INDUSTRY], [VENDOR_CODE])
AS SELECT 
     [Vendor]			,
	 [NAME]				,
     [Street Name]      ,
	 [LOCATION]			,
	 [Postal Code]      ,
	 [Region]			,
	 [Country]			,
     [Tax Number 2]     ,
     [Deletion Indicator],
     [D-U-N-S Number]   ,
     [Fax Number]       ,
     [Industry]			,
	 [Sort Field]   
FROM [dbo].[DIM_WOW_VENDOR];