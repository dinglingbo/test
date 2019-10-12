/**
 * 
 */
package com.hs.timer;

import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.tuscany.sca.policy.authorization.AuthorizationPolicy.AcessControl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.hs.common.HttpUtils;
import com.hs.common.HttpsUtils;
import com.hs.common.Menu;
import com.hs.utils.APIUtils;

import commonj.sdo.DataObject;

/**
 * @author Administrator
 * @date 2018-12-09 22:58:33
 *
 */
@Bizlet("电子档案对接")
public class SyncElectronicArchives {
	
	/*
	 * http://218.13.12.75:81/api/getAccessToken.ashx?
	 * companydata={"header": {"date": "20181208","time": "122730"},
	 *              "body": {"companycode": "881812010733001",
	 *                       "companypassword": "abcdefg"}}
	 */
	@SuppressWarnings("unchecked")
	@Bizlet("获取access_token")
	public static Map<String, String> getAccessToken(String companycode, String companypassword, String eTokenUrl) {
		JSONObject jsonObj = new JSONObject();
		
		//佛山需要请求的参数
		//报文头
		Map <String, Map <String, String>> companydata = new HashMap <String, Map <String, String>>();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat format2 = new SimpleDateFormat("HHmmss");
		Date date = new Date();
		String headerDate = format1.format(date);
		String headerTime = format2.format(date);
		Map <String, String> header = new HashMap <String, String>();
		
		header.put("date", headerDate);
		header.put("time", headerTime);
		

		//报文体
		Map <String, String> body = new HashMap <String, String>();
		body.put("companycode", companycode);
		body.put("companypassword", companypassword);
	
		companydata.put("header", header);
		companydata.put("body", body);
		
	    //截取到域名或者地址
	    String[] words = eTokenUrl.split("/");
	    String ipUtl = words[2];
		String regex=".*[a-zA-Z]+.*";
		//判断是否包含字母
		boolean falg = ipUtl.matches(regex);
		String result = "";
		if(falg){
			//是域名
			//上海需要的参数
			jsonObj.put("companycode", companycode);
			jsonObj.put("companypassword", companypassword);
			String param = null;
			param = jsonObj.toString();
			result = HttpUtils.sendPostByJson(eTokenUrl, param);
		}else{
			//是IP地址
			jsonObj.put("header", header);
			jsonObj.put("body", body);
			//jsonObj.put("companydata", companydata);
			String param = null;
			param = jsonObj.toString();
			try {
				param = URLEncoder.encode(param, "utf-8");
				String getStr = "companydata="+param;
				result = HttpUtils.sendHttpsGet(eTokenUrl,getStr);
			} catch (UnsupportedEncodingException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
		
		//String result = HttpsUtils.sendHttpsPost(eTokenUrl, body, header);
		//String result = HttpUtils.getHttpByParamAddHeaders(eTokenUrl, body, "POST", header);
		
		Gson gson = new Gson();
        Map<String, String> map = new HashMap<String, String>();
        map = gson.fromJson(result, map.getClass());
		return map;
	}
	
	/*
	 * http://218.13.12.75:81/api/upRepairInfo.ashx?
	 * repairdata={"access_token": "51BD025C5B2299BEEE97F3E6433E7070C292B310436C86771ECEE77C2997370F",
	 *             "header": {"date": "20180826","time": "172522"},
	 *             "body": {"vehicleplatenumber": "粤EFS888","vehicleplatecolor": "蓝","companyname": "标狮维修店",
	 *                         "vin": "4454465656565","repairdate": "20180825","repairmileage": "30000","settledate": "20180830",
	 *                         "faultdescription": "发动机漏油","costlistcode": "20180000123",
	 *                      "vehiclePartsList": [{"partsname": "机油","partsquantity": "1.1","partscode": "js0001"},
	 *                                           {"partsname": "皮带","partsquantity": "2","partscode": "js0002"}],
	 *                      "repairProjectList": [{"repairproject": "换机油","workinghours": "2.1"},
	 *                                            {"repairproject": "换皮带","workinghours": "1"}]}}
	 * 查询时间段内的结算单信息
	 */
	private static void pushRepairData(String orgid, String orgName, String startDate, String endDate, String accessToken,String ePushUrl) {
		DataObject param = DataObjectUtil
				.createDataObject("com.primeton.das.datatype.AnyType");
		param.setString("orgid", orgid);
		param.setString("startDate", startDate);
		param.setString("endDate", endDate);
		String paramStr = null;
		SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat format2 = new SimpleDateFormat("HHmmss");
		
		Date date = new Date();
		String headerDate = format1.format(date);
		String headerTime = format2.format(date);
		
		//请求头
        Map <String, String> header = new HashMap <String, String>();
		header.put("date", headerDate);
		header.put("time", headerTime);
		
		Object[] objs = DatabaseExt.queryByNamedSql("repair",
				"com.hs.repair.query.queryRpsMaintain",
				param);
		if(objs != null && objs.length > 0) {

			List<DataObject> mainList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(mainList, objs);
	    	
			Object[] objItems = DatabaseExt.queryByNamedSql("repair",
					"com.hs.repair.query.queryRpsItem",
					param);

			Object[] objParts = DatabaseExt.queryByNamedSql("repair",
					"com.hs.repair.query.queryRpsPart",
					param);
			List<DataObject> itemList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(itemList, objItems);
			List<DataObject> partList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(partList, objParts);
	    	
	    	for(int i = 0; i<mainList.size(); i++) {
	        	DataObject d = mainList.get(i);
	        	
	        	String id = d.getString("id");
	        	String serviceCode = d.getString("serviceCode");
	        	String carNo = d.getString("carNo");
	        	String carVin = d.getString("carVin");
	        	String enterDate = d.getString("enterDate");
	        	String outDate = d.getString("outDate");
	        	String faultPhen = d.getString("faultPhen");
	        	String enterKilometers = d.getString("enterKilometers");
	        	
	        	if(enterDate != null && enterDate != "") {
	        		enterDate = enterDate.substring(0, 10).replaceAll("-", "");
	        	}
	        	if(outDate != null && outDate != "") {
	        		outDate = outDate.substring(0, 10).replaceAll("-", "");
	        	}
	        	
	        	JSONObject jsonObj = new JSONObject();
	        	jsonObj.put("access_token", accessToken);
	        	/*Map <String, Object> info = new HashMap <String, Object>();*/
	        	//jsonObj.put("info", info);
	    		
	    		Map <String, String> basicInfo = new HashMap <String, String>();
	    		
	    		
	    		basicInfo.put("vehicleplatecolor", "黑");
	    		//维修企业名称
	    		basicInfo.put("companyname", orgName);
	    		//结算编号
	    		basicInfo.put("costlistcode", serviceCode);
	    		
	    		basicInfo.put("vin", carVin);
	    		//车牌号
	    		basicInfo.put("vehicleplatenumber", carNo);
	    		
	    		//送修日期
	    		basicInfo.put("repairdate", enterDate);
	    		//送修里程
	    		basicInfo.put("repairmileage", enterKilometers == "" ? "0": enterKilometers);
	    		//结算日期
	    		basicInfo.put("settledate", outDate);
	    		//故障描述
	    		basicInfo.put("faultdescription", faultPhen == "" ? "-": faultPhen);
	    		
	    		basicInfo = getFormatData(basicInfo);
	    		jsonObj.put("basicInfo", basicInfo);
	    		
	    		List<Map<String,String>> tList=new ArrayList<Map<String,String>>();
	    		for (DataObject obj : itemList) {
	    			if(obj.getString("serviceId").equals(id)) {		    			
		    			Map <String, String> item = new HashMap <String, String>();
		    			item.put("repairproject", obj.getString("itemName"));
		    			item.put("workinghours", obj.getString("itemItem"));
		    			item = getFormatData(item);
		    			tList.add(item);
	    			}
	    			
				}
	    		
	    		jsonObj.put("repairprojectlist", tList);
	    		
	    		List<Map<String,String>> pList=new ArrayList<Map<String,String>>();
	    		for (DataObject obj : partList) {
	    			if(obj.getString("serviceId").equals(id)) {		    			
		    			Map <String, String> item = new HashMap <String, String>();
		    			item.put("partscode", obj.getString("partCode"));
		    			item.put("partsname", obj.getString("partName"));
		    			item.put("partsquantity", obj.getString("qty"));
		    			item = getFormatData(item);
		    			pList.add(item);
	    			}
	    			
				}
	    		
	    		jsonObj.put("vehiclepartslist", pList);
	    		
	    		//ePushUrl
	    		//截取到域名或者地址
	    	    String[] words = ePushUrl.split("/");
	    	    String ipUtl = words[2];
	    		String regex=".*[a-zA-Z]+.*";
	    		//判断是否包含字母
	    		boolean falg = ipUtl.matches(regex);
	    		String result = "";
	    		if(falg){
	    			//是域名
	    			//上海需要的参数
	    			paramStr = jsonObj.toString();
		    		result = HttpUtils.sendPostByJson(ePushUrl, paramStr);
	    		}else{
	    			//是IP地址
	    			JSONObject jsonObjIp = new JSONObject();
	    			jsonObjIp.put("access_token", accessToken);
	    			jsonObjIp.put("header", header);
	    			
	    			JSONObject jsonObjBody = new JSONObject();
	    			jsonObjBody.put("repairprojectlist", tList);
	    			jsonObjBody.put("vehiclepartslist", pList);
	    		   
	    			jsonObjBody.put("vehicleplatecolor", "黑");
	    			jsonObjBody.put("companyname", basicInfo.get("companyname"));
	    			jsonObjBody.put("costlistcode", basicInfo.get("costlistcode"));
	    			jsonObjBody.put("vin", basicInfo.get("vin"));
	    			jsonObjBody.put("vehicleplatenumber", basicInfo.get("vehicleplatenumber"));
	    			jsonObjBody.put("repairdate", basicInfo.get("repairdate"));
	    			jsonObjBody.put("repairmileage", basicInfo.get("repairmileage"));
	    			jsonObjBody.put("settledate", basicInfo.get("settledate"));
	    			jsonObjBody.put("faultdescription", basicInfo.get("faultdescription"));
	    			jsonObjBody.put("costlistcode", basicInfo.get("costlistcode"));
	    			
	    			jsonObjIp.put("body", jsonObjBody);
	    			paramStr = jsonObjIp.toString();
	    			try {
	    				paramStr = URLEncoder.encode(paramStr, "utf-8");
						String getStr = "repairdata="+paramStr;
		    			result = HttpUtils.sendHttpsGet(ePushUrl,getStr);
					} catch (UnsupportedEncodingException e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
					}
	    		}	
	    		Gson gson = new Gson();
	            Map<String, String> map = new HashMap<String, String>();
	            map = gson.fromJson(result, map.getClass());
	            //System.out.println(id);
	    		
	        }
		}
    	
		return;
	}
	
	private static  Map<String, String> getFormatData(Map<String, String> map){	
		 for(String key:map.keySet()){
			   String value = map.get(key);
			   if(value==null || "".equals(value)){
				   if("vehicleplatenumber".equals(key) || "companyname".equals(key) || "vin".equals(key) || "faultdescription".equals(key)
						   || "partscode".equals(key) || "partsname".equals(key) || "repairproject".equals(key)){
					   map.put(key, "无");
				   }
				   if("repairmileage".equals(key) || "workinghours".equals(key) || "partsquantity".equals(key)){
					   map.put(key, "0");
				   }
			   }
		}
		return map;
	}
	
	
	/*
	 * 查询需要提交电子档案的公司信息
	 */
	private static List<DataObject> getCompanyInfo() {
		/*DataObject criteria = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
    	criteria.set("_entity", "com.hs.common.com.ComCompany");
    	criteria.set("_expr[1]/isOpenSystem", 0);
    	criteria.set("_expr[1]/_op", "=");
    	criteria.set("_expr[2]/_property", "eRecordUser");
    	criteria.set("_expr[2]/_op", "notnull");
    	criteria.set("_expr[3]/_property", "eRecordPwd");
    	criteria.set("_expr[3]/_op", "notnull");
    	criteria.set("_expr[4]/tenantId", 121);
    	criteria.set("_expr[4]/_op", "=");
    	criteria.set("_expr[5]/orgid", 601);
    	criteria.set("_expr[5]/_op", "=");
    	DataObject[] result = com.eos.foundation.database.DatabaseUtil
    	.queryEntitiesByCriteriaEntity("common", criteria);*/
    	
		DataObject param = DataObjectUtil
				.createDataObject("com.primeton.das.datatype.AnyType");
		param.setString("isOpenSystem", "0");
		param.setString("keyidId", "1030");
		param.setString("keyidValue", "1");
    	Object[] objResult = DatabaseExt.queryByNamedSql("common",
				"com.hs.repair.query.queryCompany",
				param);
        List<DataObject> result = new ArrayList<DataObject>();
    	CollectionUtils.addAll(result, objResult);
    	return result;
	}
	
	@SuppressWarnings("unused")
	@Bizlet("推送维修数据")
	 /*凌晨2点上传，取前一天的数据*/
	public static String pushElectricData() {
		List<DataObject> compList = getCompanyInfo();
		if(compList != null && compList.size() > 0) {
			for(int i=0; i<compList.size(); i++) {
				DataObject compObj = compList.get(i);
				String orgid = compObj.getString("orgid");
				String compName = compObj.getString("name");
				String eRecordUser = compObj.getString("eRecordUser");
				String eRecordPwd = compObj.getString("eRecordPwd");
				String ePushUrl = compObj.getString("ePushUrl");
				String eTokenUrl = compObj.getString("eTokenUrl");
				String accessToken = null;
				if(eRecordUser != null && !"".equals(eRecordUser)){
					//if(StringUtils.isNotBlank(eRecordUser) && !StringUtils.equals("", eRecordUser))
					if(eRecordPwd != null  && !"".equals(eRecordPwd)){
						if(eTokenUrl != null  && !"".equals(eTokenUrl)){
							Map<String, String> tokenMap = getAccessToken(eRecordUser, eRecordPwd,eTokenUrl);
							accessToken = tokenMap.get("access_token");
						}
					}
				}
				if(accessToken != null && !"".equals(accessToken)) { 
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.DATE, 0);
				    String endDate = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
				    cal.add(Calendar.DATE, -1);
				    String startDate = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
				    if(ePushUrl != null && !"".equals(ePushUrl)){
				    	Date tstart = new Date();
				    	pushRepairData(orgid, compName, startDate, endDate, accessToken,ePushUrl);
				    	Date tend = new Date();
				    	
				    	List<Object> params = new ArrayList<Object>();
	            		
	        			params.add("电子档案");
	        			params.add("com.hs.timer.SyncElectronicArchives");
	        			params.add("orgid="+orgid);
	        			params.add("1");
	        			params.add("1");
	        			params.add(tstart);
	        			params.add(tend);
				    	
				    	try {
							Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.system.employee.slog", "saveTimerExecuteLog", params.toArray(new Object[params.size()]));
						} catch (Throwable e) {
							e.printStackTrace();
						}
				    }
					
				}
			}
		}
				
		return null;
	}
	
	public static void main(String args[]) {
		
		//Map map = getAccessToken("881812010733001", "abcdefg");
		//Map map = getAccessToken("431302000062483", "07388971111a","https://hunan.qichedangan.cn/restservices/lcipprodatarest/lcipprogetaccesstoken/query");
		//System.out.println(map.get("access_token"));
		
		Map map = getAccessToken("111111111111001", "123456a","https://218.13.12.75:444/api/getAccessToken.ashx");
		System.out.println(map.get("access_token"));
		
		/*Calendar cal = Calendar.getInstance();
	    String today = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
	    System.out.println(today);
	    cal.add(Calendar.DATE, -1);
	    String yesterday = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
	    System.out.println(yesterday);
	    
	    JSONObject jsonObj = new JSONObject();
    	jsonObj.put("access_token", "232");
		Map <String, String> header = new HashMap <String, String>();
		header.put("date", "244");
		header.put("time", "8565");
		jsonObj.put("header", header);
		
		Map <String, Object> body = new HashMap <String, Object>();
		body.put("vehicleplatenumber", "8565");
		body.put("vehicleplatecolor", "");
		body.put("companyname", "8565");
		body.put("vin", "8565");
		body.put("repairdate", "8565");
		body.put("repairmileage", "8565");
		body.put("settledate", "8565");
		
		
		List userList=new ArrayList();
		for (int i=0; i<3; i++) {
			Map <String, String> item = new HashMap <String, String>();
			item.put("repairproject", "3232");
			item.put("workinghours", "rerer");
			userList.add(item);
		}
		body.put("t", userList);
		jsonObj.put("body", body);
		System.out.println(jsonObj.toString());*/
	}
}
