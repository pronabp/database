CREATE PROC [dbo].[SP_LOAD_STG_PRODUCTS] AS

Begin

declare @insertnew varchar(max)

Insert into  dbo.STG_PRODUCTS     
SELECT  
A.Inv_Lvl1 as Inv_Lvl1,  
B.Name as Inv_Lvl1_Name,  
A.Inv_Lvl2 as Inv_Lvl2,    
C.Name as Inv_Lvl2_Name,  
A.Inv_Lvl3 as Inv_Lvl3,  
D.Name as Inv_Lvl3_Name,  
A.Inv_Lvl4 as Inv_Lvl4,  
E.Name as Inv_Lvl4_Name,  
A.SKU_Number as SKU_Number,  
A.Name as Name,  
A.Upper_Name as Upper_Name,  
A.Linked_UPCCode_for_MM as Linked_UPCCode_for_MM,  
A.UOM as UOM,  
A.Short_Name_for_POS as Short_Name_for_POS,  
'' as MFG_GlobalLocationNumber,  
'' as ManufacturerName,  
A.Min_Profit as Min_Profit,  
A.Base_Profit as Base_Profit,  
A.Max_Profit as Max_Profit,  
A.Activation_Date as Activation_Date,  
A.Termination_Date as Termination_Date,  
A.Shelf_Space as Shelf_Space,  
A.Product_Type as Product_Type,  
A.One_All_Type_for_MM as One_All_Type_for_MM,  
A.Link_Code_Type_for_MM as Link_Code_Type_for_MM,  
A.Number_Per_Batch as Number_Per_Batch,  
A.Value_for_MM as Value_for_MM,  
A.Sales_GL as Sales_GL,  
A.Reserve_GL as Reserve_GL,  
A.Inventory_GL as Inventory_GL,  
A.Cost_GL as Cost_GL,  
A.Shrink_GL as Shrink_GL,  
A.Sub_Type as Sub_Type,  
A.Cost_Group as Cost_Group,  
A.Generated_By_Store as Generated_By_Store,  
A.Fuel_Network_Code as Fuel_Network_Code,  
A.Octane_Rating as Octane_Rating,  
A.Fuel_Density as Fuel_Density,  
A.Purge as Purge,  
A.Linked_SKU as Linked_SKU,  
A.PROMO_DISCOUNT_GL as PROMO_DISCOUNT_GL,  
A.OVERRIDE_DEP_SETTING as OVERRIDE_DEP_SETTING,  
A.ELIGIBLE_FOR_AWARD as ELIGIBLE_FOR_AWARD,         
A.BONUS_TYPE as BONUS_TYPE,  
A.BONUS_VALUE as BONUS_VALUE,  
A.PACKAGE_BREAK_FLAG as PACKAGE_BREAK_FLAG,  
A.INHERIT_CHAR_CODE as INHERIT_CHAR_CODE,  
A.BaseUnitPriceFactor as BaseUnitPriceFactor,  
A.BaseUnitDescription as BaseUnitDescription,  
A.PromoSalesGL as PromoSalesGL,  
A.LoyaltyPromoDiscountGL as LoyaltyPromoDiscountGL,  
A.CouponDiscountGL as CouponDiscountGL,  
CASE  
WHEN A.TIMESTAMP >= B.TIMESTAMP AND A.TIMESTAMP >= C.TIMESTAMP AND A.TIMESTAMP >= D.TIMESTAMP AND A.TIMESTAMP >= E.TIMESTAMP THEN A.TIMESTAMP  
WHEN B.TIMESTAMP >= A.TIMESTAMP AND B.TIMESTAMP >= C.TIMESTAMP AND B.TIMESTAMP >= D.TIMESTAMP AND B.TIMESTAMP >= E.TIMESTAMP THEN B.TIMESTAMP  
WHEN C.TIMESTAMP >= A.TIMESTAMP AND C.TIMESTAMP >= B.TIMESTAMP AND C.TIMESTAMP >= D.TIMESTAMP AND C.TIMESTAMP >= E.TIMESTAMP THEN C.TIMESTAMP  
WHEN D.TIMESTAMP >= A.TIMESTAMP AND D.TIMESTAMP >= B.TIMESTAMP AND D.TIMESTAMP >= C.TIMESTAMP AND D.TIMESTAMP >= E.TIMESTAMP THEN D.TIMESTAMP  
WHEN E.TIMESTAMP >= A.TIMESTAMP AND E.TIMESTAMP >= B.TIMESTAMP AND E.TIMESTAMP >= C.TIMESTAMP AND E.TIMESTAMP >= D.TIMESTAMP THEN E.TIMESTAMP  
ELSE A.TIMESTAMP  
END AS TIMESTAMP  
From EXT_Products A LEFT OUTER JOIN EXT_Inv_Level_1 B ON A.Inv_Lvl1=B.Inv_Lvl1  
LEFT OUTER JOIN EXT_Inv_Level_2 C ON A.Inv_Lvl1=C.Inv_Lvl1 and A.Inv_Lvl2=C.Inv_Lvl2  
LEFT OUTER JOIN EXT_Inv_Level_3 D ON A.Inv_Lvl1 = D.Inv_Lvl1 and A.Inv_Lvl2 = D.Inv_Lvl2 and A.Inv_Lvl3 = D.Inv_Lvl3  
LEFT OUTER JOIN EXT_Inv_Level_4 E ON A.Inv_Lvl1 = E.Inv_Lvl1 and A.Inv_Lvl2 = E.Inv_Lvl2 and A.Inv_Lvl3 = E.Inv_Lvl3 and A.Inv_Lvl4=E.Inv_Lvl4;

/*Begin Try
	exec(@insertnew)
End Try

Begin Catch
	declare @ins_errorno varchar(20), @ins_errordesc varchar(max), @ins_errorsta varchar(20)
	set @ins_errorno = ERROR_NUMBER()
	set @ins_errordesc = ERROR_MESSAGE()
	set @ins_errorsta = ERROR_SEVERITY()
	print('Inserting new records having an issue. Error Number is ' + @ins_errorno + ' and error description is '+ @ins_errordesc)
	insert into ctrl.CNTRL_ERROR_LOGS
	Select 'STG_PRODUCTS','SP_STG_PRODUCTS', @ins_errorno, @ins_errordesc, getutcdate()
	RAISERROR(@ins_errordesc,@ins_errorno,@ins_errorsta)
End Catch
*/
End
