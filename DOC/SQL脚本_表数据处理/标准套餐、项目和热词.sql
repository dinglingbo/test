--�������
SELECT * FROM ST_PartName



--�����ȴ�
SELECT TOP 50 ID = code, Name  FROM ST_PartNameStd WHERE 
TypeID = 0 ORDER BY UseCount DESC 



--�ײ�

SELECT TOP 15 id, PackageID, PackageTypeID, CarBrandID, CarLevelID, CarLineID, CarModelID, PackageName, 
       ItemAmt, PartAmt, packageTotal, PackageAmt, Package4SAmt, CarbrandName, CarLevelName, CarLineName, 
       CarModelName, MakeTime, Remark, UseCount 
FROM dbo.vw_carmt_pkg_amt a WITH(NOLOCK) 
WHERE IsDisabled = 0 and CarModelID = '00009402'
ORDER BY UseCount DESC 

--�ײ���ϸ��
 

SELECT PkgCarMTID, type = case when typeid = 0 then '��ʱ' else '���' end, 
         PackageID, ItemNameID, ItemKind,  PartID, PartBrandID, 
         ItemCode, ItemName, Qty, Price, amt, Amt4S 
  FROM ST_PackageCarModelDetail 
  WHERE PkgCarMTID = '00027227' ORDER BY TypeID 


--��ʱ��


SELECT ItemID =  = a.ID, hs, hsItemCode = 'hs' + ItemNameID, ItemNameID, D, b.TechType, b., e, b.ServiceType, pe, e, b.ItemKind, It, ItemName =  = b.name, It, ItemCode =  = a.ItemCode, Pr, Price = ItemPrice, AStandTime = ItemTime, 
         AStandSum =  = A.Amt, Am, Amt4S, FactoryName = NULL, TypeID = NULL, MakeTime = NULL, L, b.UseCount, a., t, a.Remark 
 F 
 FROM OM wbstandard.dbo.ST_Ite_ItemCarModel a WITH(NOLOCK) INNER JOIN IN wbstandard.dbo.ST_Ite_ItemNameStd b WITH(NOLOCK) ON ON a.ItemNameID = D =  = b.ID 
 W 
 WHERE RE a.CarModelID = D = '00009402' and nd b.PartNameID = D = '00000346' 
  ORDER BY UseCount DESC  
