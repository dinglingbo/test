/**
 * 
 */
package com.hs.timer;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.hs.common.HttpUtils;

import commonj.sdo.DataObject;

/**
 * @author Administrator
 * @date 2018-12-09 22:58:33
 *
 */
@Bizlet("电子档案对接")
public class syncElectronicArchives {
	
	/*
	 * http://218.13.12.75:81/api/getAccessToken.ashx?
	 * companydata={"header": {"date": "20181208","time": "122730"},
	 *              "body": {"companycode": "881812010733001",
	 *                       "companypassword": "abcdefg"}}
	 */
	@SuppressWarnings("unchecked")
	@Bizlet("获取access_token")
	public static Map getAccessToken(String companycode, String companypassword) {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat format2 = new SimpleDateFormat("HHmmss");
		Date date = new Date();
		String headerDate = format1.format(date);
		String headerTime = format2.format(date);
		String param = null;
		JSONObject jsonObj = new JSONObject();
		Map <String, String> header = new HashMap <String, String>();
		header.put("date", headerDate);
		header.put("time", headerTime);
		jsonObj.put("header", header);
		
		Map <String, String> body = new HashMap <String, String>();
		body.put("companycode", companycode);
		body.put("companypassword", companypassword);
		jsonObj.put("body", body);
		param = "companydata="+jsonObj.toString();

		String result = HttpUtils.sendGet("http://218.13.12.75:81/api/getAccessToken.ashx", param);
		
		Gson gson = new Gson();
        Map<String, Object> map = new HashMap<String, Object>();
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
	private List getRepairData(long orgid, String startDate, String endDate) {
		DataObject param = DataObjectUtil
				.createDataObject("com.primeton.das.datatype.AnyType");
		param.setLong("orgid", orgid);
		param.setString("startDate", startDate);
		param.setString("endDate", endDate);
		
		Object[] objs = DatabaseExt.queryByNamedSql("repair",
				"com.sie.bpm.client.agent.HandoverSQL.queryTransferItems",
				param);
    	
		return null;
	}
	
	public static void main(String args[]) {
		
		Map map = getAccessToken("881812010733001", "abcdefg");
		System.out.println(map.get("access_token"));
	}
}
