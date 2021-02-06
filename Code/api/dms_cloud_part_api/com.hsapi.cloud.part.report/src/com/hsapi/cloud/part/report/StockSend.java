/**
 * 
 */
package com.hsapi.cloud.part.report;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.hs.common.HttpUtils;
import com.hs.common.MD5;
import com.hs.kinginterface.VoucherEntity;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;
import edu.emory.mathcs.backport.java.util.Arrays;

public class StockSend {
	
	@Bizlet("")
	public static HashMap syncChangeStock() {
		HashMap hm = new HashMap();
		hm.put("code", "E");
		List<Object> lp = new ArrayList<Object>();
		lp.add(2);
		try{
			Calendar cal = new GregorianCalendar();
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
	          
			List<HashMap> list = new ArrayList();
			HashMap pr = new HashMap();
			pr.put("startDate", cal.getTime());
			System.out.println(cal.getTime());
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hsapi.cloud.part.report.stock.querySyncStock", pr);
	    	List<DataObject> stockList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(stockList, objr);
	    	lp.add(stockList.size());
	    	for(int i = 0; i<stockList.size(); i++) {
	        	DataObject d = stockList.get(i);
	        	
	        	HashMap partMap = new HashMap();
				partMap.put("id", d.get("partId"));
				partMap.put("nno", d.get("partCode"));
				partMap.put("name", d.get("partName"));
				partMap.put("brand_name", d.get("brandName"));
				partMap.put("part_type", d.get("typeName"));
				partMap.put("amount", d.get("stockQty"));
				partMap.put("price", d.get("sellPrice"));
				partMap.put("posi", d.get("shelf"));
				partMap.put("ware", d.get("storeName"));
				list.add(partMap);
	        	
	        }
	    	
			String timestamp = String.valueOf(System.currentTimeMillis());
			String sign = MD5.crypt("kaiyany" + timestamp + "007vinapi");
			sign = sign.toUpperCase();
			
			HashMap stockMap = new HashMap();
			stockMap.put("corporation_tax", "91440101793468489L");
			stockMap.put("company_name", "杭州云汽配配有限公司");
			stockMap.put("user_id", "5f57682781ac30b00d2cfb88f7c98302");
			stockMap.put("erp_type", "kaiyan");
			stockMap.put("inventory_data", list);
			stockMap.put("appkey", "kaiyany");
			stockMap.put("timestamp", timestamp);
			stockMap.put("sign", sign);
			
			String rs = HttpUtils.sendPost("https://oestest.007vin.com/inventory/datareceive", stockMap);
					//("https://oestest.007vin.com", "/inventory/datareceive", "post", null, null, stockMap);
			System.out.println(rs);
		} catch(Exception e) {
			e.printStackTrace();
			hm.put("code", "E");
		} finally {
			try {
				Object[] resultRes = callLogicFlowMethd("com.hsapi.cloud.part.report.timer", "saveSyncLog", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存库存同步记录失败" );
				e.printStackTrace();
			}
			return hm;
		}
		
	}
	
	@Bizlet("")
	public static HashMap syncAllStock() {
		HashMap hm = new HashMap();
		hm.put("code", "E");
		List<Object> lp = new ArrayList<Object>();
		lp.add(1);
		try{
			List<HashMap> list = new ArrayList();
			HashMap pr = new HashMap();
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hsapi.cloud.part.report.stock.querySyncStock", pr);
	    	List<DataObject> stockList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(stockList, objr);
	    	lp.add(stockList.size());
	    	for(int i = 0; i<stockList.size(); i++) {
	        	DataObject d = stockList.get(i);
	        	
	        	HashMap partMap = new HashMap();
				partMap.put("id", d.get("partId"));
				partMap.put("nno", d.get("partCode"));
				partMap.put("name", d.get("partName"));
				partMap.put("brand_name", d.get("brandName"));
				partMap.put("part_type", d.get("typeName"));
				partMap.put("amount", d.get("stockQty"));
				partMap.put("price", d.get("sellPrice"));
				partMap.put("posi", d.get("shelf"));
				partMap.put("ware", d.get("storeName"));
				list.add(partMap);
	        	
	        }
	    	
			String timestamp = String.valueOf(System.currentTimeMillis());
			String sign = MD5.crypt("kaiyany" + timestamp + "007vinapi");
			sign = sign.toUpperCase();
			
			HashMap stockMap = new HashMap();
			stockMap.put("corporation_tax", "91440101793468489L");
			stockMap.put("company_name", "杭州云汽配配有限公司");
			stockMap.put("user_id", "5f57682781ac30b00d2cfb88f7c98302");
			stockMap.put("erp_type", "kaiyan");
			stockMap.put("inventory_data", list);
			stockMap.put("appkey", "kaiyany");
			stockMap.put("timestamp", timestamp);
			stockMap.put("sign", sign);
			
			String rs = HttpUtils.sendPost("https://oestest.007vin.com/inventory/datareceive", stockMap);
					//("https://oestest.007vin.com", "/inventory/datareceive", "post", null, null, stockMap);
			//System.out.println(rs);
		} catch(Exception e) {
			e.printStackTrace();
			hm.put("code", "E");
		} finally {
			try {
				Object[] resultRes = callLogicFlowMethd("com.hsapi.cloud.part.report.timer", "saveSyncLog", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存库存同步记录失败" );
				e.printStackTrace();
			}
			return hm;
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
       
	public static void main(String[] args) {
		syncChangeStock();
		/*try{
			HashMap partMap = new HashMap();
			partMap.put("id", "1");
			partMap.put("nno", "06E 145 417 A");
			partMap.put("name", "真空泵垫片");
			partMap.put("brand_name", "正厂");
			partMap.put("part_type", "正厂");
			partMap.put("amount", 1.0);
			partMap.put("price", 22.0);
			partMap.put("posi", null);
			partMap.put("ware", null);
			
			List<HashMap> list = new ArrayList();
			list.add(partMap);
			
			String timestamp = String.valueOf(System.currentTimeMillis());
			String sign = MD5.crypt("kaiyany" + timestamp + "007vinapi");
			sign = sign.toUpperCase();
			
			HashMap stockMap = new HashMap();
			stockMap.put("corporation_tax", "91440101793468489L");
			stockMap.put("company_name", "杭州云汽配配有限公司");
			stockMap.put("user_id", "5f57682781ac30b00d2cfb88f7c98302");
			stockMap.put("erp_type", "kaiyan");
			stockMap.put("inventory_data", list);
			stockMap.put("appkey", "kaiyany");
			stockMap.put("timestamp", timestamp);
			stockMap.put("sign", sign);
			
			StockEntity stock = stock();
			String rs = HttpUtils.sendPost("https://oestest.007vin.com/inventory/datareceive", stockMap);
					//("https://oestest.007vin.com", "/inventory/datareceive", "post", null, null, stockMap);
			//System.out.println(rs);
		} catch(Exception e) {
			e.printStackTrace();
		}*/
	}
}