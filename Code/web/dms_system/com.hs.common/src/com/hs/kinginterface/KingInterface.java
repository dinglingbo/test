/**
 * 
 */
package com.hs.kinginterface;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.kingdee.bos.webapi.sdk.K3CloudApi;
import com.kingdee.bos.webapi.sdk.OperateParam;
import com.kingdee.bos.webapi.sdk.OperatorResult;
import com.kingdee.bos.webapi.sdk.QueryParam;
import com.kingdee.bos.webapi.sdk.QueryResultInfo;
import com.kingdee.bos.webapi.sdk.SaveParam;
import com.kingdee.bos.webapi.sdk.SaveResult;
import com.kingdee.bos.webapi.sdk.SuccessEntity;

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
	public static HashMap addSupplier(String fullName, String shortName, String orgNum) throws Exception {
		K3CloudApi api=new K3CloudApi();
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

		return hm;
		
	}
	
	/**
	 * 提交供应商资料
	 * */
	private static boolean submitSupplier(String id) throws Exception{
		K3CloudApi api=new K3CloudApi();
		
		OperateParam param = new OperateParam();
		param.setIds(id);
		
		OperatorResult sRet = api.submit("BD_Supplier", param);
		if (sRet.isSuccessfully()) {
			return true;
		} 
		
		return false;
	}
	
	/**
	 * 审核供应商资料
	 * */
	private static boolean auditSupplier(String id) throws Exception{
		K3CloudApi api=new K3CloudApi();
	
		OperateParam param = new OperateParam();
		param.setIds(id);
		
		OperatorResult sRet = api.audit("BD_Supplier", param);
		if (sRet.isSuccessfully()) {
			return true;
		} 
		
		return false;
	}
	
	/**
	 * 添加供应商资料
	 */
	@Bizlet("")
	public static HashMap addCustom(String fullName, String shortName, String orgNum) throws Exception {
		K3CloudApi api=new K3CloudApi();
		Customer c = new Customer();
		
		CommonFNumber orgid = new CommonFNumber();
		if(orgNum == null) {
			orgNum = "KY001";
		}
		orgid.setFNumber(orgNum);
		c.setFCreateOrgId(orgid);
		
		c.setFNumber(SeqHelper.genNumber("KH"));

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

		return hm;
		
	}
	
	/**
	 * 提交客户资料
	 * */
	private static boolean submitCustom(String id) throws Exception{
		K3CloudApi api=new K3CloudApi();
		
		OperateParam param = new OperateParam();
		param.setIds(id);
		
		OperatorResult sRet = api.submit("BD_Customer", param);
		if (sRet.isSuccessfully()) {
			return true;
		} 
		
		return false;
	}
	
	/**
	 * 审核客户资料
	 * */
	private static boolean auditCustom(String id) throws Exception{
		K3CloudApi api=new K3CloudApi();
	
		OperateParam param = new OperateParam();
		//param.setCreateOrgId("KY001");
		param.setIds(id);
		
		OperatorResult sRet = api.audit("BD_Customer", param);
		if (sRet.isSuccessfully()) {
			return true;
		} 
		
		return false;
	}
	
	
	public static void main(String[] args) {
		Gson gson=new Gson();
		String json="{\"TaskId\":\"7\",\"Status\":2,\"Result\":{\"Result\":{\"ResponseStatus\":{\"IsSuccess\":true,\"Errors\":[],\"SuccessEntitys\":[{\"Id\":100082,\"Number\":\"BC20190914023210001\",\"DIndex\":0},{\"Id\":100083,\"Number\":\"BC20190914023310002\",\"DIndex\":1},{\"Id\":100084,\"Number\":\"BC20190914023310003\",\"DIndex\":2},{\"Id\":100085,\"Number\":\"BC20190914023310004\",\"DIndex\":3},{\"Id\":100086,\"Number\":\"BC20190914023310005\",\"DIndex\":4},{\"Id\":100087,\"Number\":\"BC20190914023310006\",\"DIndex\":5},{\"Id\":100088,\"Number\":\"BC20190914023310007\",\"DIndex\":6},{\"Id\":100089,\"Number\":\"BC20190914023310008\",\"DIndex\":7},{\"Id\":100090,\"Number\":\"BC20190914023310009\",\"DIndex\":8},{\"Id\":100091,\"Number\":\"BC20190914023310010\",\"DIndex\":9},{\"Id\":100092,\"Number\":\"BC20190914023310011\",\"DIndex\":10},{\"Id\":100093,\"Number\":\"BC20190914023310012\",\"DIndex\":11},{\"Id\":100094,\"Number\":\"BC20190914023310013\",\"DIndex\":12},{\"Id\":100095,\"Number\":\"BC20190914023310014\",\"DIndex\":13},{\"Id\":100096,\"Number\":\"BC20190914023310015\",\"DIndex\":14},{\"Id\":100097,\"Number\":\"BC20190914023310016\",\"DIndex\":15},{\"Id\":100098,\"Number\":\"BC20190914023310017\",\"DIndex\":16},{\"Id\":100099,\"Number\":\"BC20190914023310018\",\"DIndex\":17},{\"Id\":100100,\"Number\":\"BC20190914023310019\",\"DIndex\":18},{\"Id\":100101,\"Number\":\"BC20190914023310020\",\"DIndex\":19}],\"SuccessMessages\":[],\"MsgCode\":0},\"NeedReturnData\":[]}},\"Cancelled\":false,\"IsFaulted\":false,\"FaultedException\":null,\"ProgressInfos\":null,\"Successful\":true,\"Message\":\"\",\"Progress\":100,\"ProgressDesc\":\"\"}";
		QueryResultInfo ret= gson.fromJson(json, QueryResultInfo.class);
		String oStr=gson.toJson(ret.getResult());
	}
	
	
}
