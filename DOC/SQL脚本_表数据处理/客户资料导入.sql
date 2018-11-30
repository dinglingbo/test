


/*

11.30数据同步

1、复制并删除原有的
com_app_function
com_cap_resauth

*/

/*
*/














/*
226
86
31
*/

select * from WBSystem..WB_Companies where CustomID like '%31%'  --COM20110804000001



select * from WX_Client where compcode = 'COM20110804000001'

select ClientID, ClientCode, ClientName, Mobile, ProvinceID, CityID, CountyID, Street, Address 
from wbrepair..WX_Client where compcode = 'COM20110804000001'

select a.carno, a.Carplate, a.CarModel, a.EngineNO, a.UnderpanNO, a.color, a.CarModelIDLY, a.CarID 
from wbrepair..WX_ClientCars a
inner join wbrepair..wx_client b
on a.clientcode = b.ClientCode
where b.compcode = 'COM20110804000001'


select a.clientcode, a.Sender, a.Mobile, a.CSex, a.Birthday, a.PaperNO from wbrepair..wx_Sender a
inner join wbrepair..wx_client b
on a.clientcode = b.ClientCode
where b.compcode = 'COM20110804000001'

















