/**
 * 
 */
package com.hsapi.system.kingkong;

import java.util.List;
import java.util.UUID;

import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.kingdee.bos.webapi.sdk.K3CloudApi;
import com.kingdee.bos.webapi.sdk.QueryParam;
import com.kingdee.bos.webapi.sdk.SaveParam;
import com.kingdee.bos.webapi.sdk.SaveResult;

/**
 * @author dlb
 * @date 2020-01-08 20:55:19
 *
 */
@Bizlet("")
public class KingInterface {
	
	@Bizlet("")
	public static void testAdd() throws Exception {
		K3CloudApi api=new K3CloudApi();
		Customer c = new Customer();
		
		CommonFNumber orgid = new CommonFNumber();
		orgid.setFNumber("KY001");
		c.setFCreateOrgId(orgid);
		
		c.setFNumber(SeqHelper.genNumber("BC"));

		c.setFName("aimin_客户名称-A" + UUID.randomUUID().toString());
		c.setFShortName("aimin_客户简称-A" + UUID.randomUUID().toString());
		
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
		
	}
	
	@Bizlet("")
	public static void test() throws Exception {
		
		K3CloudApi api = new K3CloudApi();
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
		}
	}
}
