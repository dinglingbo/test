/**
 * 
 */
package com.hsapi.part.invoice;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;

import net.sf.json.JSONObject;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.hs.common.Env;
import com.hs.common.HttpUtils;
import com.hs.common.Utils;
import com.hs.utils.APIUtils;

import commonj.sdo.DataObject;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2019年1月8日 下午9:46:21 
 * 类说明 
 */
/**
 * @author Administrator
 * @date 2019-01-08 21:46:24
 *
 */
@Bizlet("")
public class PurchaseService {
	@Bizlet("提交SRM采购订单")
	public static String pushPchsOrderToSRM(String companyId, String address, int isInsurance,
			int isDeposit, int isScene, int isTax, String payType, String receiver,
			String remark, String mobile, String userName, String warehouseto, 
			String guestId, int mainId, String access_token) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = apiurl + "srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("ProcurementType", 2); //订单是否过账订单中心  1是，2否 必传
		main.put("address", address); //收货地址
		main.put("company_id", companyId); //	公司组织ID
		main.put("enquiry_code", null);  //询价单号
		main.put("isInsurance", isInsurance);  //是否含轮胎险
		main.put("is_deposit", isDeposit);  //是否有定金
		main.put("is_scene", isScene);  //车辆是否在场
		main.put("is_tax", isTax);  //是否含税
		main.put("material_type", 1);  //订单类型 1临时采购 2计划采购 必传
		main.put("method", "pur.order.addOrder");
		main.put("mobile", mobile);
		main.put("order_type", 1);  //采购类型  1临时采购 2计划采购 必传
		main.put("pay_type", payType);  //	结算方式  JS05 月结 JS01 现金结算 必传
		main.put("receiver", receiver);
		main.put("remark", remark);
		main.put("status", 3); //固定值 3 （提交订单） 必传
		main.put("user_name", userName);  //操作人
		main.put("warehouseto", warehouseto);  //	采购方 往来单位ID  	对应 guestID 必传
		
		/*
		 *  amout  金额                                                必传
		 *  brand_id  品牌ID              必传
		 *  code  配件编码                                           必传
		 *  guest_id  供应商ID             必传
		 *  isMatchPrice  是否不可修改价格        0否 1是 必传
		 *  isPlatOuter  平台供应商                      固定值 0 必传
		 *  material_name  配件名称
		 *  oem_code  	OEM码
		 *  qty  数量                                               必传
		 *  quality_id  品质ID          必传
		 *  remark  备注
		 *  sales_price  单价       必传
		 *  unit  单位
		 * */
		//查询订单明细
		HashMap params = new HashMap();
		params.put("mainId",mainId);
    	Object[] objs = DatabaseExt.queryByNamedSql("part","com.hsapi.part.invoice.orderSettle.queryPchsOrderDetail", params);
    	List<HashMap> detailList = new ArrayList<HashMap>();
    	CollectionUtils.addAll(detailList, objs);
    	for(int  i=0;i<objs.length;i++){
    		HashMap m = new HashMap();
    		m.put("amout",detailList.get(i).get("orderAmt"));
    		m.put("brand_id",detailList.get(i).get("srmBrandId"));
    		m.put("code",detailList.get(i).get("partCode"));
    		m.put("guest_id",guestId);
    		m.put("isMatchPrice",1);
    		m.put("isPlatOuter",0);
    		m.put("material_name",detailList.get(i).get("partName"));
    		m.put("oem_code",detailList.get(i).get("oemCode"));
    		m.put("qty",detailList.get(i).get("orderQty"));
    		m.put("quality_id",detailList.get(i).get("srmQualityId"));
    		m.put("remark",detailList.get(i).get("remark"));
    		m.put("sales_price",detailList.get(i).get("orderPrice"));
    		m.put("unit",detailList.get(i).get("enterUnitId"));
    		detailList.add(m);
		}
    	
    	HashMap[] details = detailList.toArray(new HashMap[detailList.size()]);
    	
		for(int i=0; i<details.length; i++) {
			HashMap m = details[i];
			m.put("isMatchPrice", 1);
			m.put("isPlatOuter", 0);
			m.put("guest_id", guestId);
		}

		main.put("mater", details);
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;
				
	}
	
	@Bizlet("查询SRM配件列表，带库存数量      根据SKU查询库存明细")
	public static String querySRMSKUList(String access_token,String brandId,String carId,
			String categoryF, String categoryS, String categoryT, int count,
			int currpage, String key, String sortOrder) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		if(key == null || key.equals("")) {
			return "{\"status\":\"-1\", \"resultMsg\":\"请输入查询条件!\"}";
		}
		if(count==0) {
			count = 20;
		}
		if(currpage == 0) {
			currpage = 1;
		}
		if(sortOrder == null || sortOrder.equals("")) {
			sortOrder = "desc";
		}
		Map main = new HashMap();   
		main.put("type", 1); //固定值 1
		main.put("method", "base.partQuery.partSkuList");
		if(brandId != null && !brandId.equals("")) {
			main.put("brandId", brandId); //品牌ID
		}
		if(carId != null && !carId.equals("")) {
			main.put("carId", carId);  //厂牌ID
		}
		if(categoryF != null && !categoryF.equals("")) {
			main.put("categoryF_id", categoryF);  //车身分类一级ID
		}
		if(categoryS != null && !categoryS.equals("")) {
			main.put("categoryS_id", categoryS);  //车身分类二级ID
		}
		if(categoryT != null && !categoryT.equals("")) {
			main.put("categoryT_id", categoryT);  //车身分类三级ID
		}
		main.put("count", count);  //	每页显示条数
		main.put("currpage", currpage);  //当前 页码
		main.put("key", key);
		main.put("sortOrder", sortOrder);  // ‘asc’ 升序 'desc' 降序
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
				
	}
	
	@Bizlet("根据SKU查询库存明细")
	public static String querySRMSKUDetailStockList(String access_token,String guestId,
			int count,int currpage, String id, String isGP, String isHS, String isJP,
			int isMaterial, String isSRM, String sort, String sortOrder) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		if(id == null || id.equals("")) {
			return "{\"status\":\"-1\", \"resultMsg\":\"请输入查询条件!\"}";
		}
		if(count==0) {
			count = 20;
		}
		if(currpage == 0) {
			currpage = 1;
		}
		if(sort == null || sort.equals("")) {
			sort = "qty";
		}
		if(sortOrder == null || sortOrder.equals("")) {
			sortOrder = "desc";
		}
		Map main = new HashMap();   
		main.put("method", "base.partQuery.getSkuInvList");
		if(isGP != null && !isGP.equals("")) {
			main.put("isGP", isGP);  //车身分类一级ID
		}
		if(isHS != null && !isHS.equals("")) {
			main.put("isHS", isHS);  //车身分类二级ID
		}
		if(isJP != null && !isJP.equals("")) {
			main.put("isJP", isJP);  //车身分类三级ID
		}
		if(isSRM != null && !isSRM.equals("")) {
			main.put("isSRM", isSRM);  //车身分类三级ID
		}
		main.put("guestId", guestId);
		main.put("isMaterial", 1);
		main.put("count", count);  //	每页显示条数
		main.put("currpage", currpage);  //当前 页码
		main.put("id", id);
		main.put("sort", sort);
		main.put("sortOrder", sortOrder);  // ‘asc’ 升序 'desc' 降序
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
	}
	
	@Bizlet("查询SRM品牌")
	public static String queryPartBrand(String access_token) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("method", "base.brand.listAll");
		main.put("type", 1);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
	}
	
	@Bizlet("查询SRM品质")
	public static String queryPartQuality(String access_token) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("method", "base.brand.listAll");
		main.put("parent_id", 0);  
		main.put("type", 1);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
	}
	
	@Bizlet("查询SRM厂牌")
	public static String queryCarplate(String access_token) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("method", "base.lable.listAll");
		main.put("parent_id", 0);  
		main.put("type", 1);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
	}
	
	@Bizlet("查询SRM车身分类")
	public static String queryPartType(String access_token, String parentId) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("method", "base.category.listAll");
		main.put("parent_id", parentId);  
		main.put("type", 1);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
	}
	
	private static String getGuestById(String access_token,String guestId) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("method", "base.supplier.getGuestByCompanyName");
		main.put("id", guestId);
		//main.put("name", count);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;		
	}
	
	private static DataObject setGuestInfo(String access_token, String guestId, String guestName, int orgid, String userName) throws Throwable {
		//根据srm_guest_id查询往来单位信息
		DataObject criteria = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
    	criteria.set("_entity", "com.hsapi.part.data.com.ComGuest");
    	criteria.set("_expr[1]/srmGuestId", guestId);
    	criteria.set("_expr[1]/_op", "=");
    	DataObject[] result = com.eos.foundation.database.DatabaseUtil
    	.queryEntitiesByCriteriaEntity("common", criteria);
    	
    	if(result.length <= 0) {
    		criteria.set("_expr[1]/srmGuestId", null);
        	criteria.set("_expr[1]/_op", null);
        	criteria.set("_expr[1]/fullName", guestName);
        	criteria.set("_expr[1]/_op", "like");
        	result = com.eos.foundation.database.DatabaseUtil
        		    	.queryEntitiesByCriteriaEntity("common", criteria);
        	if(result.length <= 0) {
        		//如果不存在，后台自动新增，然后返回新增后的结果
        		//com.hsapi.part.baseDataCrud.crud.saveSupplier  supplier  orgid  userName
        		String retMsg = getGuestById(access_token, guestId);
        		Gson gson = new Gson();
                Map<String, Object> resultMap = new HashMap<String, Object>();
                resultMap = gson.fromJson(retMsg, resultMap.getClass());
                String status = (String) resultMap.get("status");
                HashMap map = null;
                if(status.equals("0")) {
                	Map data = (Map) resultMap.get("data");
                	List<Object> params = new ArrayList<Object>();
            		DataObject guest = DataObjectUtil
    						.createDataObject("com.hsapi.part.data.com.ComGuest");
            		guest.set("orgid", orgid);
            		guest.set("is_supplier", 1);
            		guest.set("fullName", data.get("guestName"));
            		guest.set("shortName", data.get("guestName"));
            		guest.set("contactor", data.get("salesMan"));
            		guest.set("contactorTel", data.get("salesManTel"));
            		guest.set("tel", data.get("salesManTel"));
            		guest.set("mobile", data.get("salesManTel"));
            		guest.set("srmGuestId", guestId);
        			params.add(guest);
        			params.add(orgid);
        			params.add(userName);
        			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.part.baseDataCrud.crud", "saveSupplier", params.toArray(new Object[params.size()]));
        			String errCode = (String) resultRes[0];
        			String errMsg = (String) resultRes[1];
        			Integer gstId = (Integer) resultRes[2];
        			DataObject supplier = (DataObject) resultRes[3];
        			if(errCode.equals("S")) {
        				supplier.set("status", "0");
        				return supplier;
        			}else {
        				DataObject rs = DataObjectUtil
        						.createDataObject("com.hsapi.part.data.com.ComGuest");
                		rs.set("status", -1);
                		rs.set("msg", "请新增供应商资料!");
                		return rs;
        			}
                }
        		
                DataObject rs = DataObjectUtil
						.createDataObject("com.hsapi.part.data.com.ComGuest");
        		rs.set("status", -1);
        		rs.set("msg", "请新增供应商资料!");
        		return rs;
    			
        	}else {
        		HashMap pm = new HashMap();
        		pm.put("guestId", guestId);
        		pm.put("id", result[0].get("id"));
        		DatabaseExt.executeNamedSql(
						"common",
						"com.hsapi.part.invoice.orderSettle.updateGuestInfo",
						pm);
        		DataObject rs = result[0];
        		rs.set("status", "0");
        		return rs;
        	}
    	}else {
    		DataObject rs = result[0];
    		rs.set("status", "0");
    		return rs;
    	}
		    
	}
	
	private static DataObject setPartInfo(String access_token, String partId, String partCode, String partName, 
			int orgid, String userName, String brandId, String brandName, String qualityId, String qualityName) throws Throwable {
		//根据srm_brand_id   srm_quality_id  srm_part_id 查询配件基础资料信息
		DataObject criteria = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
    	criteria.set("_entity", "com.hsapi.part.data.com.ComAttribute");
    	criteria.set("_expr[1]/srmBrandId", brandId);
    	criteria.set("_expr[1]/_op", "=");
    	criteria.set("_expr[2]/srmQualityId", qualityId);
    	criteria.set("_expr[2]/_op", "=");
    	criteria.set("_expr[3]/code", partCode);
    	criteria.set("_expr[3]/_op", "=");
    	DataObject[] result = com.eos.foundation.database.DatabaseUtil
    	.queryEntitiesByCriteriaEntity("common", criteria);
    	
    	if(result.length <= 0) {
    		//如果不存在，后台自动新增，然后返回新增后的结果
    		//com.hsapi.part.invoice.orderSettle.queryPartByPartBrand
    		HashMap params = new HashMap();
    		params.put("partCode",partCode);
    		params.put("brandName",brandName);
        	Object[] objs = DatabaseExt.queryByNamedSql("common","com.hsapi.part.invoice.orderSettle.queryPartByPartBrand", params);
        	List<HashMap> detailList = new ArrayList<HashMap>();
        	CollectionUtils.addAll(detailList, objs);
        	DataObject obj = null;
        	if(objs.length > 0) {
        		obj = result[0];
        		obj.set("status", 0);
        		//com.hsapi.part.invoice.orderSettle.updatePartInfo
        		HashMap pm = new HashMap();
        		pm.put("brandId", brandId);
        		pm.put("partId", partId);
        		pm.put("qualityId", qualityId);
        		pm.put("id", obj.get("id").toString());
        		DatabaseExt.executeNamedSql(
						"common",
						"com.hsapi.part.invoice.orderSettle.updatePartInfo",
						pm);
        		
        		return obj;
        	}else {
        		DataObject rs = DataObjectUtil
						.createDataObject("com.hsapi.part.data.com.ComGuest");
        		rs.set("status", -1);
        		rs.set("msg", "请新增配件基础资料!");
        		return rs;
        	}
        	
    	}else {
    		DataObject rs = result[0];
    		rs.set("status", "0");
    		return rs;
    	}
	}
	
	/*
	 *  根据SRM往来单位ID，往来单位名称在车道上查询存不存在；                         返回车道往来单位信息
		根据SRM上配件内码/（配件编码，配件品牌，配件品质）查询配件是否存在；   返回车道配件基础资料
		
		不能返回的，后台自动新增，后台新增不能获取到必填写值的，前端弹出新增
	 * */
	@Bizlet("")
	public static Map queryGuestAndSKU(String access_token, String guestId,
			String guestName, String partId, String partCode, String partName, String brandId,
			String brandName, String qualityId, String qualityName, int orgid, String userName) throws Throwable {
		if(guestId == null || guestId.equals("")) {
			HashMap mp = new HashMap();
			mp.put("status", -1);
			mp.put("resultMsg", "请传递guestId!");
			return mp;
		}
		
		DataObject guest = setGuestInfo(access_token, guestId, guestName, orgid, userName);
		DataObject part = setPartInfo(access_token, partId, partCode, partName, orgid, userName, brandId, 
				brandName, qualityId, qualityName);
		HashMap map = new HashMap();
		map.put("guest", guest);
		map.put("part", part);
		return map;
				
	}
	
	private static String sendPostByJson(String urlParam, String json) {
		StringBuffer resultBuffer = null;
		HttpURLConnection con = null;
		OutputStreamWriter osw = null;
		BufferedReader br = null;
		// 发送请求
		try {
			URL url = new URL(urlParam);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(true);
			con.setRequestProperty("Content-Type",
					"application/json;charset=UTF-8");
			con.setRequestProperty("accept", "application/json,text/plain,*/*");

			con.setConnectTimeout(60000);// 连接超时 单位毫秒
			con.setReadTimeout(60000);// 读取超时 单位毫秒
			if (json != null && json.length() > 0) {
				osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
				osw.write(json);
				osw.flush();
			}

			// 读取返回内容
			if (con.getResponseCode() == 200) {
				resultBuffer = new StringBuffer();
				br = new BufferedReader(new InputStreamReader(
						con.getInputStream(), "UTF-8"));
				String temp;
				while ((temp = br.readLine()) != null) {
					resultBuffer.append(temp);
				}
			} else {
				System.out.println("con.getResponseCode = "
						+ con.getResponseCode());
			}
			return resultBuffer.toString();
		} catch (Exception e) {
			System.out.println("Access Error At:" + urlParam);
			e.printStackTrace();
			return "{\"resultCode\":\"Http_Send_Error\", \"resultMsg\":\""
					+ e.getMessage() + "\"}";
		} finally {
			if (osw != null) {
				try {
					osw.close();
				} catch (IOException e) {
					osw = null;
					throw new RuntimeException(e);
				} finally {
					if (con != null) {
						con.disconnect();
						con = null;
					}
				}
			}
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					br = null;
					throw new RuntimeException(e);
				} finally {
					if (con != null) {
						con.disconnect();
						con = null;
					}
				}
			}
		}
	}
	
}
