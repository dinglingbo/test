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
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.hs.common.Env;
import com.hs.common.HttpUtils;

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
	
	@Bizlet("查询SRM配件列表，带库存数量")
	public static String querySRMSKUList(String access_token,String brandId,String carId,
			String categoryF, String categoryS, String categoryT, int count,
			int currpage, String key, String sortOrder) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam = "http://124.172.221.179:83/srm/router/rest?token="+access_token;
				//apiurl + "srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("type", 1); //固定值 1
		main.put("method", "base.partQuery.partSkuList");
		main.put("brandId", brandId); //品牌ID
		main.put("carId", carId);  //厂牌ID
		main.put("categoryF_id", categoryF);  //车身分类一级ID
		main.put("categoryS_id", categoryS);  //车身分类二级ID
		main.put("categoryT_id", categoryT);  //车身分类三级ID
		main.put("count", count);  //	每页显示条数
		main.put("currpage", currpage);  //当前 页码
		main.put("key", key);
		main.put("sortOrder", sortOrder);  // ‘asc’ 升序 'desc' 降序
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
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

			con.setConnectTimeout(20000);// 连接超时 单位毫秒
			con.setReadTimeout(20000);// 读取超时 单位毫秒
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
	
	public static void main(String[] args) {
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		Map<String, Object> attrMap = muo.getUserObject().getAttributes();
		String accessToken = (String) attrMap.get("srmtoken");
		//(String access_token,String brandId,String carId,
		//		String categoryF, String categoryS, String categoryT, int count,
		//		int currpage, String key, String sortOrder)
		querySRMSKUList(accessToken,null,null,null,null,null,20,1,null,"desc");
	} 
	
}
