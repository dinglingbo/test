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


SELECT ItemID = a.ID, hsItemCode = 'hs' + ItemNameID, ItemNameID, b.TechType,  b.ServiceType, b.ItemKind, ItemName =  b.name,  ItemCode =  a.ItemCode,  Price = ItemPrice, AStandTime = ItemTime, 
         AStandSum = A.Amt, Amt4S, FactoryName = NULL, TypeID = NULL, MakeTime = NULL, b.UseCount, a.Remark 
 FROM wbstandard.dbo.ST_ItemCarModel a WITH(NOLOCK) INNER JOIN wbstandard.dbo.ST_ItemNameStd b WITH(NOLOCK) ON a.ItemNameID = b.ID 
 WHERE a.CarModelID =  '00009402' and b.PartNameID = '00000346' 
  ORDER BY UseCount DESC  
