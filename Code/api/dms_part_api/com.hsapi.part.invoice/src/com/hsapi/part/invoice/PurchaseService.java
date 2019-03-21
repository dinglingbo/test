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
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.hs.common.Env;
import com.hs.common.HttpUtils;
import com.hs.common.Utils;
import com.primeton.ext.engine.component.LogicComponentFactory;

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
	@Bizlet("提交电商采购订单")
	public static String pushPchsOrderToSRM(String address, String mobile,
			 String receiver, String account,String storeCode,
			 String remark,  int mainId, String access_token) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = apiurl + "srm/router/rest?token="+access_token;
		if(mobile == null) {
			mobile = "";
		}
		if(address == null) {
			address = "";
		}
		if(remark == null) {
			remark = "";
		}
		if(storeCode == null ){
			storeCode = "";
		}
		Map main = new HashMap();   
		main.put("token", access_token);
		main.put("address", address); //收货地址
		main.put("orderCode", ""); //订单单号(为空为新增)
		main.put("mobile", mobile);
		main.put("receiver", receiver);  //收货人
		main.put("account", account);  //车道在电商注册的账号
		main.put("remark", remark);
		main.put("storeCode", storeCode);
		main.put("status", 3); //固定值 3 （提交订单） 必传
		
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
    	List<HashMap> mater = new ArrayList<HashMap>();
    	CollectionUtils.addAll(detailList, objs);
    	for(int  i=0;i<objs.length;i++){
    		HashMap m = new HashMap();
    		String detailRemark = (String) detailList.get(i).get("remark");
    		if(detailRemark == null) {
    			detailRemark = "";
    		}
    		m.put("amout",detailList.get(i).get("orderAmt"));
    		m.put("brand_id",detailList.get(i).get("srmBrandId"));
    		m.put("code",detailList.get(i).get("partCode"));
    		m.put("isMatchPrice",1);
    		m.put("isPlatOuter",0);
    		m.put("material_name",detailList.get(i).get("partName"));
    		m.put("oem_code",detailList.get(i).get("oemCode"));
    		m.put("qty",detailList.get(i).get("orderQty"));
    		m.put("quality_id",detailList.get(i).get("srmQualityId"));
    		m.put("remark",detailRemark);
    		m.put("sales_price",detailList.get(i).get("orderPrice"));
    		m.put("unit",detailList.get(i).get("enterUnitId"));
			m.put("isMatchPrice", 1);
			m.put("isPlatOuter", 0);
    		mater.add(m);
		}
    	
    	HashMap[] details = mater.toArray(new HashMap[mater.size()]);

		main.put("mater", details);
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;
				
	}
	
	@Bizlet("更新电商订单状态")
	public static String upadateOrderStatus(String access_token,String orderCode,int orderStatus,String remark) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
//		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		String urlParam = apiurl + "jpWeb/f/api/LaneElectricity/updateOrderStatus";

		Map main = new HashMap();   
		main.put("token", access_token); //电商编码
		main.put("orderCode",orderCode);
		main.put("orderStatus", orderStatus);
		main.put("orderStatus", orderStatus);
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
				
	}
	
	@Bizlet("查询电商配件列表，带库存数量      根据SKU查询库存明细")
	public static String querySRMSKUList(String access_token,String classesId,String brandCode,String carCode,
			String partsCode, String partsName, int count,int currpage) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
//		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		String urlParam = apiurl+"jpWeb/f/api/LaneElectricityGoods/getGoodsListByParams";
		
		if(count==0) {
			count = 20;
		}
		if(currpage == 0) {
			currpage = 1;
		}
		
		Map main = new HashMap();   
		if(brandCode != null && !brandCode.equals("")) {
			main.put("venderCode", brandCode); //品牌ID
		}
		if(carCode != null && !carCode.equals("")) {
			main.put("carCode", carCode);  //厂牌ID
		}
		if(partsCode != null && !partsCode.equals("")) {
			main.put("partsCode", partsCode);  //配件编码
		}
		if(partsName != null && !partsName.equals("")) {
			main.put("partsName", partsName);  //配件名称
		}
		
		if(classesId != null && !classesId.equals("")) {
			main.put("classesId", classesId);  //分类ID
		}
		main.put("count", count);  //	每页显示条数
		main.put("currpage", currpage);  //当前 页码
		main.put("token", access_token); 
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
				
	}
	
	@Bizlet("根据电商编码查询电商库存明细")
	public static String querySRMStockByCode(String access_token,String code,int count,int currpage) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
//		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		String urlParam = apiurl + "jpWeb/f/api/LaneElectricityGoods/goodsDetail";

		if(count==0) {
			count = 20;
		}
		if(currpage == 0) {
			currpage = 1;
		}
		if(code == null || code.equals("")) {
			return "{\"status\":\"-1\", \"resultMsg\":\"请输入查询条件!\"}";
		}
		Map main = new HashMap();   
		main.put("token", access_token);
		main.put("goodsCode", code); //电商编码
		main.put("count",count);
		main.put("currpage", currpage);
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
//		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		String urlParam = "http://srm.hszb.harsons.cn/srm/router/rest?token="+access_token;
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
		main.put("token", access_token);
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
	
	@Bizlet("查询电商品牌")
	public static String queryPartBrand(String access_token) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = apiurl+"jpWeb/f/api/LaneElectricity/getLabelList";
				//apiurl + "srm/router/rest?token="+access_token;
//		String urlParam = "http://srm.hszb.harsons.cn/srm/router/rest?token="+access_token;
		Map main = new HashMap(); 
		main.put("token", access_token); 
		main.put("page", 1);
		main.put("rows", 1000); 
		
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
//		String urlParam = "http://srm.hszb.harsons.cn/srm/router/rest?token="+access_token;
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
		String urlParam = apiurl+"jpWeb/f/api/LaneElectricity/getVenderList?";
				//apiurl + "srm/router/rest?token="+access_token;
//		String urlParam = "http://srm.hszb.harsons.cn/srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("token", access_token);
		main.put("page", 1);
		main.put("rows", 1000);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
	}
	
	@Bizlet("查询SRM车身分类")
	public static String queryPartType(String access_token) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = apiurl+"jpWeb/f/api/LaneElectricity/classeList";
				//apiurl + "srm/router/rest?token="+access_token;
//		String urlParam = "http://srm.hszb.harsons.cn/srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("token", access_token);
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
		String urlParam =apiurl+ "jpWeb/f/api/LaneElectricity/getSupplierList";
				//apiurl + "srm/router/rest?token="+access_token;
//		String urlParam = "http://srm.hszb.harsons.cn/srm/router/rest?token="+access_token;
		Map main = new HashMap();  
		main.put("token", access_token);
		main.put("storeCode", guestId); //电商供应商编码
		main.put("page", 1);
		main.put("rows", 10000);
		//main.put("name", count);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;		
	}
	
	private static DataObject setGuestInfo(String access_token,String guestId, String guestName, int orgid, String userName) throws Throwable {
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
        		String retMsg = getGuestById(access_token,guestId);
        		Gson gson = new Gson();
                Map<String, Object> resultMap = new HashMap<String, Object>();
                resultMap = gson.fromJson(retMsg, resultMap.getClass());
                String status =  resultMap.get("code")+"";
                HashMap map = null;
                Map dataMap = (Map) resultMap.get("data");
                List<Object> list= (ArrayList) dataMap.get("rows");
                
                if(status.equals("0.0")&& list.size()!=0) {
                	Map data =(Map)list.get(0);
                	List<Object> params = new ArrayList<Object>();
            		DataObject guest = DataObjectUtil
    						.createDataObject("com.hsapi.part.data.com.ComGuest");
            		guest.set("orgid", orgid);
            		guest.set("isSupplier", 1);
            		guest.set("fullName", data.get("companyName"));
            		guest.set("shortName", data.get("companyName"));
            		guest.set("contactor", data.get("salesMan"));
            		guest.set("contactorTel", data.get("salesManTel"));
            		guest.set("tel", data.get("salesManTel"));
            		guest.set("mobile", data.get("salesManTel"));
            		guest.set("srmGuestId", guestId);
        			params.add(guest);
        			params.add(orgid);
        			params.add(userName);
        			Object[] resultRes = callLogicFlowMethd("com.hsapi.part.baseDataCrud.crud", "saveSupplier", params.toArray(new Object[params.size()]));
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
	
	private static DataObject setPartInfo(String access_token,String partId, String partCode, String partName, 
			int orgid, String userName, String brandId, String brandName, String qualityId, String qualityName) throws Throwable {
		//根据srm_brand_id   srm_quality_id  srm_part_id 查询配件基础资料信息
		DataObject criteria = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
    	criteria.set("_entity", "com.hsapi.part.data.com.ComAttribute");
    	criteria.set("_expr[1]/srmBrandId", brandId);
    	criteria.set("_expr[1]/_op", "=");
//    	criteria.set("_expr[2]/srmQualityId", qualityId);
//    	criteria.set("_expr[2]/_op", "=");
    	criteria.set("_expr[2]/code", partCode);
    	criteria.set("_expr[2]/_op", "=");
    	DataObject[] result = com.eos.foundation.database.DatabaseUtil
    	.queryEntitiesByCriteriaEntity("common", criteria);
    	
    	if(result.length <= 0) {
    		//如果不存在，后台自动新增，然后返回新增后的结果
    		//com.hsapi.part.invoice.orderSettle.queryPartByPartBrand
    		if(brandName.equals("原厂品牌")) {
    			brandName = "原厂";
    		}
    		HashMap params = new HashMap();
    		params.put("partCode",partCode);
    		params.put("brandName",brandName);
        	Object[] objs = DatabaseExt.queryByNamedSql("common","com.hsapi.part.invoice.orderSettle.queryPartByPartBrand", params);
        	List<DataObject> detailList = new ArrayList<DataObject>();
        	CollectionUtils.addAll(detailList, objs);
        	DataObject obj =DataObjectUtil
					.createDataObject("com.hsapi.part.data.com.ComAttribute");
        	if(objs.length > 0) {
        		obj = detailList.get(0);
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
						.createDataObject("com.hsapi.part.data.com.ComAttribute");
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
	public static Map queryGuestAndSKU( String access_token,String guestId,
			String guestName, String partId, String partCode, String partName, String brandId,
			String brandName, String qualityId, String qualityName, int orgid, String userName) throws Throwable {
		if(guestId == null || guestId.equals("")) {
			HashMap mp = new HashMap();
			mp.put("status", -1);
			mp.put("resultMsg", "请传递guestId!");
			return mp;
		}

		
		DataObject guest = setGuestInfo( access_token,guestId, guestName, orgid, userName);
		DataObject part = setPartInfo( access_token, partId, partCode, partName, orgid, userName, brandId, 
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
	
	@Bizlet("方法调用API")
	public static Object[] callLogicFlowMethd(String componentName,
			String operationName, Object... params) throws Throwable {
		int len = params == null ? 0 : params.length;
		ILogicComponent logicComponent = LogicComponentFactory
				.create(componentName);
		Object[] ps = new Object[len];
		int idx = 0;
		for (Object o : params) {
			ps[idx] = o;
			idx++;
		}
		return logicComponent.invoke(operationName, ps);
	}
	
}
