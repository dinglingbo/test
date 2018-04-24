/**
 * 
 */
package com.hsapi.part.purchase;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.hs.common.HttpUtils;
import com.hs.common.JsonUtils;
import com.primeton.bfs.engine.json.JSONArray;
import com.primeton.bfs.engine.json.JSONException;
import com.primeton.bfs.engine.json.JSONObject;
import com.primeton.ext.das.common.DASResourceCache;
import com.primeton.ext.das.common.DASXSDLoader;
import com.primeton.ext.das.common.fileloader.DASFileCacher;

import commonj.sdo.ChangeSummary;
import commonj.sdo.DataGraph;
import commonj.sdo.DataObject;
import commonj.sdo.Property;
import commonj.sdo.Sequence;
import commonj.sdo.Type;

/**
 * @author chenziming
 * @date 2018-02-10 09:55:56
 * 
 */
@Bizlet("")
public class PriceQuery {

	/**
	 * @param param
	 * @return
	 */
	@Bizlet("")
	public static HashMap getSellPrice(String url, HashMap params) {
		String keywords = (String) params.get("keywords");
		String CarPlate = (String) params.get("CarPlate");
		String page_size = (String) params.get("page_size");
		String page = (String) params.get("page").toString();
		String serial = (String) params.get("serial");

		StringBuilder param = new StringBuilder();
		param.append("serial=" + serial);
		if (keywords != null && keywords.trim().length() > 0) {
			try {
				param.append("&keywords=" + java.net.URLEncoder.encode(keywords,"utf-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
		if (CarPlate != null && CarPlate.trim().length() > 0) {
			param.append("&CarPlate=" + CarPlate);
		}
		param.append("&page_size=" + page_size);
		param.append("&page=" + page);

		String result = sendGet(url, param.toString(),"utf-8").substring(1);
		// System.out.println(result);
		HashMap map = new HashMap();
		JSONObject jsonObject = null;
		List list = new ArrayList();
		try {
			jsonObject = new JSONObject(result);

			JSONArray objects = jsonObject.getJSONArray("data");

			int i = 0;
			for (i = 0; i < objects.length(); i++) {
				JSONObject tmp = (JSONObject) objects.get(i);
				Iterator iterator = tmp.keys();
				DataObject tmp1 = DataObjectUtil
						.createDataObject("commonj.sdo.DataObject");
				while (iterator.hasNext()) {
					String key = (String) iterator.next();
					Object value = tmp.get(key);
					if (value == null || "null".equals(value.toString())
							|| value.toString().trim().isEmpty()) {
						tmp1.set("key","");
					} else {
						tmp1.set(key, value.toString());
					}
				}
				list.add(tmp1);
			}
			String num = jsonObject.getString("num");
			map.put("data", list);
			map.put("num", num);
		} catch (JSONException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		// System.out.println(jsonObject);
		return map;
	}

	/**
	 * @param param
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@Bizlet("")
	public static HashMap getGoodsPrice(String url, HashMap params) {
		String keywords = (String) params.get("keywords");
		String brand = (String) params.get("CarPlate");
		String page_size = (String) params.get("page_size");
		String page = (String) params.get("page").toString();
		String serial = (String) params.get("serial");

		StringBuilder param = new StringBuilder();
		param.append("serial=" + serial);
		if (keywords != null && keywords.trim().length() > 0) 
		{
			try {
				param.append("&keywords=" + java.net.URLEncoder.encode(keywords,"utf-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
		if (brand != null && brand.trim().length() > 0) {
			try {
				param.append("&brand=" + java.net.URLEncoder.encode(brand,"utf-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
		param.append("&page_size=" + page_size);
		param.append("&page=" + page);
	//	System.out.println(param);
		String result = sendGet(url, param.toString(),"utf-8").substring(1);
	//	System.out.println(result);
		HashMap map = new HashMap();
		JSONObject jsonObject = null;
		List list = new ArrayList();
		try {
			jsonObject = new JSONObject(result);

			JSONArray objects = jsonObject.getJSONArray("data");

			int i = 0;
			for (i = 0; i < objects.length(); i++) {
				JSONObject tmp = (JSONObject) objects.get(i);
				Iterator iterator = tmp.keys();
				DataObject tmp1 = DataObjectUtil
						.createDataObject("commonj.sdo.DataObject");
				while (iterator.hasNext()) {
					String key = (String) iterator.next();
					Object value = tmp.get(key);
					if (value == null || "null".equals(value.toString())
							|| value.toString().trim().isEmpty()) {
						// tmp1.set("key",null);
					} else {
						tmp1.set(key, value.toString());
					}
				}
				list.add(tmp1);
			}
			String num = jsonObject.getString("num");
			map.put("data", list);
			map.put("num", num);
		} catch (JSONException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		// System.out.println(jsonObject);
		return map;
	}

	public static String unicode2String(String unicode) {
		if (StringUtils.isBlank(unicode))
			return null;
		StringBuilder sb = new StringBuilder();
		int i = -1;
		int pos = 0;

		while ((i = unicode.indexOf("\\u", pos)) != -1) {
			sb.append(unicode.substring(pos, i));
			if (i + 5 < unicode.length()) {
				pos = i + 6;
				sb.append((char) Integer.parseInt(
						unicode.substring(i + 2, i + 6), 16));
			}
		}

		return sb.toString();
	}
	
	/***
	 * 发送get请求
	 */
	@Bizlet("")
	public static String sendGet(String url, String param,String chatSet) {
		String result = "";
		BufferedReader in = null;
		try {
			String urlNameString = url
					+ ((param == null || (param.trim().length() == 0) ? ""
							: ("?" + param)));
			URL realUrl = new URL(urlNameString);
			// 打开和URL之间的连接
			URLConnection connection = realUrl.openConnection();
			// 设置通用的请求属性
			connection.setRequestProperty("accept", "*/*");
			connection.setRequestProperty("connection", "Keep-Alive");
			connection.setRequestProperty("user-agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 建立实际的连接
			connection.connect();
			// 获取所有响应头字段
			Map<String, List<String>> map = connection.getHeaderFields();
			// 遍历所有的响应头字段
			for (String key : map.keySet()) {
				System.out.println(key + "--->" + map.get(key));
			}
			// 定义 BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(
					connection.getInputStream(),chatSet));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送GET请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输入流
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
}
