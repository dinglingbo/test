/**
 * 
 */
package com.hsapi.system.kingkong;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import com.eos.system.annotation.Bizlet;

/**
 * @author dlb
 * @date 2020-01-08 20:55:19
 *
 */
@Bizlet("")
public class KingInterface {
	
	/**
	 * 添加客户资料
	 */
	@Bizlet("")
	public static HashMap addCutom(String fullName, String shortName, String orgNum) throws Exception {
		/*K3CloudApi api=new K3CloudApi();
		Supplier s = new Supplier();
		
		CommonFNumber orgid = new CommonFNumber();
		if(orgNum == null) {
			orgNum = "KY001";
		}
		orgid.setFNumber(orgNum);
		s.setFCreateOrgId(orgid);
		s.setFUseOrgId(orgid);
		
		s.setFNumber(SeqHelper.genNumber("SP"));

		s.setFName(fullName);
		s.setFShortName(shortName);
		
		FFinanceInfo f = new FFinanceInfo();
		CommonFNumber currency = new CommonFNumber();
		currency.setFNumber("PRE001");
		f.setFPayCurrencyId(currency);
		s.setFFinanceInfo(f);
		
		HashMap hm = new HashMap();
		hm.put("code", "E");
		SaveResult sRet = api.save("BD_Supplier", new SaveParam<Supplier>(s));
		if (sRet.isSuccessfully()) {
			hm.put("code", "S");
			Gson gson = new Gson();
			List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
			SuccessEntity successEntity = list.get(0);
			hm.put("id", successEntity.getId());
			hm.put("number", successEntity.getNumber());
			
			submitSupplier(successEntity.getId());
			
			auditSupplier(successEntity.getId());
		} 

		return hm;*/
		return null;
		
	}
	
	/**
	 * 提交供应商资料
	 * */
	private static boolean submitSupplier(String id) throws Exception{
		/*K3CloudApi api=new K3CloudApi();
		
		OperateParam param = new OperateParam();
		param.setIds(id.toString());
		
		OperatorResult sRet = api.submit("BD_Supplier", param);
		if (sRet.isSuccessfully()) {
			return true;
		} */
		
		return false;
	}
	
	/**
	 * 审核供应商资料
	 * */
	private static boolean auditSupplier(String id) throws Exception{
		/*K3CloudApi api=new K3CloudApi();
	
		OperateParam param = new OperateParam();
		param.setIds(id.toString());
		
		OperatorResult sRet = api.aduit("BD_Supplier", param);
		if (sRet.isSuccessfully()) {
			return true;
		} */
		
		return false;
	}
	
	/**
	 * 添加供应商资料
	 */
	@Bizlet("")
	public static HashMap addSupplier(String fullName, String shortName, String orgNum) throws Exception {
		/*K3CloudApi api=new K3CloudApi();
		Customer c = new Customer();
		
		CommonFNumber orgid = new CommonFNumber();
		if(orgNum == null) {
			orgNum = "KY001";
		}
		orgid.setFNumber(orgNum);
		c.setFCreateOrgId(orgid);
		
		c.setFNumber(SeqHelper.genNumber("SP"));

		c.setFName(fullName);
		c.setFShortName(shortName);
		
		CommonFNumber currency = new CommonFNumber();
		currency.setFNumber("PRE001");
		c.setFTRADINGCURRID(currency);
		
		c.setFPriority("1");
		
		HashMap hm = new HashMap();
		hm.put("code", "E");
		SaveResult sRet = api.save("BD_Customer", new SaveParam<Customer>(c));
		if (sRet.isSuccessfully()) {
			hm.put("code", "S");
			Gson gson = new Gson();
			List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
			SuccessEntity successEntity = list.get(0);
			hm.put("id", successEntity.getId());
			hm.put("number", successEntity.getNumber());
			
			submitCustom(successEntity.getId());
			
			auditCustom(successEntity.getId());
		} 

		return hm;*/
		return null;
		
	}
	
	/**
	 * 提交客户资料
	 * */
	private static boolean submitCustom(String id) throws Exception{
		/*K3CloudApi api=new K3CloudApi();
		
		OperateParam param = new OperateParam();
		param.setIds(id.toString());
		
		OperatorResult sRet = api.submit("BD_Customer", param);
		if (sRet.isSuccessfully()) {
			return true;
		} */
		
		return false;
	}
	
	/**
	 * 审核客户资料
	 * */
	private static boolean auditCustom(String id) throws Exception{
		/*K3CloudApi api=new K3CloudApi();
	
		OperateParam param = new OperateParam();
		param.setIds(id.toString());
		
		OperatorResult sRet = api.aduit("BD_Customer", param);
		if (sRet.isSuccessfully()) {
			return true;
		} */
		
		return false;
	}
	
	@Bizlet("")
	public static void testAdd() throws Exception {
		/*K3CloudApi api=new K3CloudApi();
		Customer c = new Customer();
		c.setCustID(176828);
		
		CommonFNumber orgid = new CommonFNumber();
		orgid.setFNumber("KY001");
		c.setFCreateOrgId(orgid);
		
		c.setFNumber(SeqHelper.genNumber("BC"));

		c.setFName("admin_客户名称-A" + UUID.randomUUID().toString());
		c.setFShortName("admin_客户简称-A" + UUID.randomUUID().toString());
		
		CommonFNumber currency = new CommonFNumber();
		currency.setFNumber("PRE001");
		c.setFTRADINGCURRID(currency);
		
		c.setFPriority("1");
		
		SaveResult sRet = api.save("BD_Customer", new SaveParam<Customer>(c));
		if (sRet.isSuccessfully()) {
			Gson gson = new Gson();
			System.out.println(
					String.format("%s", gson.toJson(sRet.getResult().getResponseStatus().getSuccessEntitys())));
		} else {
			//fail("dcs is null!");
		}
		*/
	}
	
	@Bizlet("")
	public static void test() throws Exception {
		
		/*K3CloudApi api = new K3CloudApi();
		List<Customer> datas = null;
		try {
			datas = api.executeBillQuery(
					new QueryParam().setFormId("BD_Customer").setFieldKeys("FCUSTID,FNumber,FName,FCreateDate"),
					Customer.class);
			if (datas != null) {
				Customer meta = ((Customer) (datas.toArray()[0]));
				System.out.println(String.format("%s", new Gson().toJson(meta)));
			} else {
				//fail("datas is null!");
			}
		} catch (Exception e) {

			//fail(e.getMessage());
		}

		if (datas != null) {
			System.out.println(String.format("Total:%s", datas.size()));
		} else {
			//fail("dcs is null!");
		}*/
	}
}
