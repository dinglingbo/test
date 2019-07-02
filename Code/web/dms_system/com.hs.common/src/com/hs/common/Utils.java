/**
 * 
 */
package com.hs.common;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanMap;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.eos.data.datacontext.IMapContextFactory;
import com.eos.data.datacontext.ISessionMap;
import com.eos.data.datacontext.UserObject;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.infra.security.BASE64Decoder;
import com.primeton.ext.infra.security.BASE64Encoder;

import commonj.sdo.DataObject;

/**
 * @author chenyy
 * @date 2016-04-04 15:18:39
 * 
 */
@Bizlet("")
public class Utils {

	@Bizlet("")
	public static List createObjectList() {
		return new ArrayList();
	}

	@Bizlet("")
	public static Object[] listToArray(List list) {
		if (list == null || list.size() == 0) {
			return null;
		}
		return list.toArray(new Object[list.size()]);
	}

	@Bizlet("")
	public static List<DataObject> createList() {
		return new ArrayList<DataObject>();
	}

	@Bizlet("")
	public static void appendObjectToList(List list, Object object) {
		list.add(object);
	}

	@Bizlet("")
	public static Object[] appendObjectToArray(Object[] list, Object object) {
		Object[] temp;
		if (list == null) {
			temp = new Object[1];
		} else {
			temp = new Object[list.length + 1];
			for (int i = 0; i < list.length; i++) {
				temp[i] = list[i];
			}
		}
		temp[temp.length - 1] = object;
		return temp;
	}

	@Bizlet("")
	public static Object[] appendArray2Array(Object[] arrTo, Object[] arr) {
		Object[] temp;
		if (arrTo != null && arr != null) {
			temp = new Object[arrTo.length + arr.length];
			for (int i = 0; i < arrTo.length; i++) {
				temp[i] = arrTo[i];
			}
			for (int i = 0; i < arr.length; i++) {
				temp[arrTo.length + i] = arr[i];
			}
		} else if (arrTo == null) {
			return arr;
		} else {
			return arrTo;
		}
		return temp;
	}

	@Bizlet("")
	public static String map2Str(Map<String, Object> params) {
		try {
			return JSONObject.toJSONString(params);
		} catch (Exception e) {
			return "ERROR";
		}
	}
	
	@Bizlet("")
	public static HashMap<String, Object> str2Map(String param) {
		try {
			HashMap<String, Object> p = JSONObject.parseObject(param,HashMap.class);
			return p;
		} catch (Exception e) {
			return new HashMap<String, Object>();
		}
	}
	
	@Bizlet("")
	public static HashMap<String, Object> str3Map(String param,String index) {
		JSONObject obj=JSONObject.parseObject(param);
		String obj2 = (obj.getJSONObject(index)).toJSONString();
		try {		
			HashMap<String, Object> p = JSONObject.parseObject(obj2,HashMap.class);
			return p;
		} catch (Exception e) {
			return new HashMap<String, Object>();
		}
	}
	
	@Bizlet("")
	public static HashMap<String, Object>[] parseArray(String param,String index) {
		List<HashMap<String, Object>> lp = new ArrayList<HashMap<String, Object>>();
		JSONObject obj=JSONObject.parseObject(param);
		String obj2 = (obj.getJSONArray(index)).toJSONString();
		try {		
			HashMap<String, Object>[] p = JSONObject.parseObject(obj2,HashMap[].class);
			return p;
		} catch (Exception e) {
			return lp.toArray(new HashMap[0]); 
		}
	}
	
	@Bizlet("")
	public static String strArry(DataObject[] obj,String property1,String  property2,
									String property3,String property4) {
		
		List<HashMap<String,String>> resList =new ArrayList<HashMap<String, String>>();
		for(DataObject a : obj){
			HashMap <String,String> map =new HashMap<String, String>();
			if(a.getString(property1) == null){
				map.put(property1,"");
			}else{
				map.put(property1,a.getString(property1));
			}
			if(a.getString(property2) == null){
				map.put(property2,"");
			}else{
				map.put(property2,a.getString(property2));
			}
			if(a.getString(property3) == null){
				map.put(property3,"");
			}else{
				map.put(property3,a.getString(property3));
			}
			if(a.getString(property4) == null){
				map.put(property4,"");
			}else{
				map.put(property4,a.getString(property4));
			}
			resList.add(map);
		}
		JSONArray array= JSONArray.parseArray(JSON.toJSONString(resList));
		String  result =JSONArray.toJSONString(resList);
		return result;
	}
	
	@Bizlet("")
	public static String strArry2(DataObject[] obj,String property1,String  property2) {
		
		List<HashMap<String,String>> resList =new ArrayList<HashMap<String, String>>();
		for(DataObject a : obj){
			HashMap <String,String> map =new HashMap<String, String>();
			if(a.getString(property1) == null){
				map.put(property1,"");
			}else{
				map.put(property1,a.getString(property1));
			}
			if(a.getString(property2) == null){
				map.put(property2,"");
			}else{
				map.put(property2,a.getString(property2));
			}
			resList.add(map);
		}
		String  result =JSONArray.toJSONString(resList);
		return result;
	}
	/**
	 * Json转对象
	 * 
	 * @param param
	 * @param obj
	 * @return
	 */
	@Bizlet("")
	public static <E> E json2Object(String param, Class<E> obj) {
		try {
			return JSONObject.parseObject(param, obj);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 对象转Json
	 * 
	 * @param obj
	 * @return
	 */
	@Bizlet("")
	public static <E> String obj2json(E obj) {
		try {
			net.sf.json.JSONObject jsonStu = net.sf.json.JSONObject
					.fromObject(obj);
			return jsonStu.toString();
			// return JSONObject.toJSONString(obj);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("对象转换Json失败");
			return "";
		}
	}

	@Bizlet("")
	public static <E> String obj2ByteStr(E obj) {
		try {
			String aa = new String(SerializeUtil.serialize(obj));
			// System.out.println(aa);
			return aa;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("序列化对象失败");
			return "";
		}
	}

	@Bizlet("序列化并压缩对象")
	public static <E> String obj2GzipStr(E obj) {
		try {
			// String aa = SerializeUtil.serialize(obj);
			// System.out.println(aa);
			// System.out.println("Gzip Str：");
			String aa = SerializeUtil.serialize2GzipStr(obj);
			// System.out.println(aa);
			return aa;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("序列化对象失败");
			return "";
		}
	}

	@Bizlet("反序列化压缩对象")
	public static Object gzipStr2Obj(String str) {
		try {
			Object aa = SerializeUtil.decompressUnserialize(str);
			return aa;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("反序列化对象失败");
			return null;
		}
	}
	
	@Bizlet("对象转换为Map")
	public static Map obj2Map(Object obj) {
        if (obj == null) {
            return null;
        }
        BeanMap beanMap = new org.apache.commons.beanutils.BeanMap(obj);
        Map map = (Map) beanMap.getBean();
        return map;//new org.apache.commons.beanutils.BeanMap(obj);
    }

	@Bizlet("")
	public static HashMap<String, Object>[] row2Column(
			HashMap<String, Object>[] p, String byCols, String sumCols,
			String groupBy) {
		if (p == null || p.length < 1 || byCols == null || sumCols == null) {
			return p;
		}

		List<HashMap<String, Object>> lp = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> mp = null;

		String[] cols = byCols.split(",");
		String[] sCols = sumCols.split(",");
		String[] groups = groupBy.split(",");

		byCols = "," + byCols + ",";
		sumCols = "," + sumCols + ",";
		String colName = "";
		String currVal = "";
		String tmpVal = "";
		String groupVal = "";
		for (HashMap<String, Object> hmap : p) {
			tmpVal = "";
			groupVal = "";
			for (String c : cols) {
				tmpVal += hmap.get(c);
			}
			for (String g : groups) {
				groupVal += hmap.get(g);
			}

			if (groupVal.equals(currVal)) {
				// 求和
				for (String sc : sCols) {
					mp.put(tmpVal + "_" + sc,
							getFloatFromMap(mp, tmpVal + "_" + sc)
									+ getFloatFromMap(hmap, sc));
				}
			} else {
				// 生成新对象
				currVal = groupVal;
				mp = new HashMap<String, Object>();
				for (String key : hmap.keySet()) {
					// 非转置对象
					if (byCols.indexOf(key) == -1 && sumCols.indexOf(key) == -1) {
						mp.put(key, hmap.get(key));
					}
				}
				// 转置对象
				for (String sc : sCols) {
					mp.put(tmpVal + "_" + sc, hmap.get(sc));
				}
				lp.add(mp);
			}
		}

		return lp.toArray(new HashMap[0]);
	}

	private static float getFloatFromMap(Map p, String key) {
		Object o = p.get(key);
		try {
			if (o != null) {
				return Float.valueOf(o.toString());
			} else {
				return 0;
			}
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}

	/**
	 * 获取用户真实IP地址，不使用request.getRemoteAddr()的原因是有可能用户使用了代理软件方式避免真实IP地址,
	 * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值
	 * 
	 * @return ip
	 */
	@Bizlet("")
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		System.out.println("x-forwarded-for ip: " + ip);
		if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
			// 多次反向代理后会有多个ip值，第一个ip才是真实ip
			if (ip.indexOf(",") != -1) {
				ip = ip.split(",")[0];
			}
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
			System.out.println("Proxy-Client-IP ip: " + ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
			System.out.println("WL-Proxy-Client-IP ip: " + ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
			System.out.println("HTTP_CLIENT_IP ip: " + ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			System.out.println("HTTP_X_FORWARDED_FOR ip: " + ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
			System.out.println("X-Real-IP ip: " + ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
			System.out.println("getRemoteAddr ip: " + ip);
		}
		System.out.println("获取客户端ip: " + ip);
		return ip;
	}
	
	@Bizlet("")
	public static HashMap<String, Object> putMapProperty(HashMap<String, Object> map, String propertyName, Object propertyValue) {
		map.put(propertyName, propertyValue);
		return map;
	}

	@Bizlet("")
	public static String createSessionId() {
		return java.util.UUID.randomUUID().toString();
	}

	@Bizlet("")
	public static String getMd5SessionId(HttpServletRequest request) {
		String ip = getIpAddr(request);
		return MD5.crypt(createSessionId() + ip);
	}

	@Bizlet("hashCode")
	public static Integer hashCode(Object obj) {
		return obj.hashCode();
	}

	/**
	 * 必填校验
	 * 
	 * @param checkObject
	 *            要校验的DynamicObject
	 * @param keys
	 *            要校验的DynamicObject的key字符串数组
	 * @return 如果DynamicObject的key都有值（不为null和""，则返回"0"，否则返回该key）
	 */
	@Bizlet("Empty Check")
	public static String emptyCheck(DataObject checkObject, String propertys) {
		String[] keys = propertys.split(",");
		for (int i = 0; i < keys.length; i++) {
			propertys = keys[i].replaceAll(" ", "");
			if ((checkObject.get(propertys) == null)
					|| (checkObject.get(propertys).toString().equals(""))) {
				return "属性【" + propertys + "】值为空！";
			}
		}
		return "0";
	}
	
	@Bizlet("宝马零件信息处理")
	public static Map<String, String> bmpPartsInfoProcess(String param) {
		// 正则表达式规则
		String reg = "doTooltip\\((.*?)</table>";
		String regEx1 = "formulHead_gb(.*?)</td>"; // formulHead_gb(.*?)</td>
		String regEx2 = "ResultWhite(.*?)</td>";// ResultWhite(.*?)</td>
		// 编译正则表达式
		Pattern pattern = Pattern.compile(reg);
		Pattern pattern1 = Pattern.compile(regEx1);
		Pattern pattern2 = Pattern.compile(regEx2);

		Matcher matcher = pattern.matcher(param);
		while (matcher.find()) {
			param = param.replaceAll(matcher.group(1), "");
		}

		param = param.replaceAll("ResultWhite2", "ResultWhite")
				.replaceAll("align=\"right\"", "").replaceAll("nowrap", "")
				.replaceAll("<b><i>", "").replaceAll("</b></i>", "")
				.replaceAll("<br>", "").replaceAll("&nbsp;", "")
				.replaceAll("\n", "").replaceAll("\r", "").replaceAll("  ", "");
		Map<String, String> map = new HashMap();
		// 忽略大小写的写法
		// Pattern pat = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
		Matcher matcher1 = pattern1.matcher(param);
		Matcher matcher2 = pattern2.matcher(param);
		// 查找字符串中是否有匹配正则表达式的字符/字符串
		// boolean rs = matcher1.find();]
		int i = 0;
		String tmp;
		while (matcher1.find()) {
			tmp = matcher1.group(1);
			if (i > 1) {
				if (tmp.endsWith("</a>")) {
					tmp = tmp.replaceAll("</a>", "");
				}
				tmp = tmp.replaceAll(" ", "").replaceAll("\\.", "").replaceAll(",", "\\.");
			}
			map.put("k" + i, tmp.substring(tmp.lastIndexOf(">") + 1));

			matcher2.find();
			tmp = matcher2.group(1);
			if (i > 1) {
				if (tmp.endsWith("</a>")) {
					tmp = tmp.replaceAll("</a>", "");
				}
				tmp = tmp.replaceAll(" ", "").replaceAll("\\.", "").replaceAll(",", "\\.");
			}
			map.put("v" + i, tmp.substring(tmp.lastIndexOf(">") + 1));
			System.out.println(i + "：" + map.get("k" + i) + " ="
					+ map.get("v" + i));
			i++;
		}
		
		while (matcher2.find()) {
			tmp = matcher2.group(1);
			if (i > 1) {
				if (tmp.endsWith("</a>")) {
					tmp = tmp.replaceAll("</a>", "");
				}
				tmp = tmp.replaceAll(" ", "");
			}
			map.put("v" + i, tmp.substring(tmp.lastIndexOf(">") + 1));
			System.out.println(i + "：" + map.get("k" + i) + " ="
					+ map.get("v" + i));
			i++;
		}
		return map;

	}
	
	/*
	 * @Bizlet("")
		public static void method() {
		
		IMapContextFactory contextFactory = com.primeton.ext.common.muo.MUODataContextHelper
		.getMapContextFactory();
		ISessionMap sessionMap = contextFactory.getSessionMap();
		Object sessionRoot = sessionMap.getRootObject();
		System.out.println(sessionRoot);
		IRequestMap requestMap = contextFactory.getRequestMap();
		Object requestRoot = requestMap.getRootObject();
		System.out.println(requestRoot);
		IApplicationMap applicationMap = contextFactory.getApplicationMap();
		Object applicationRoot = applicationMap.getRootObject();
		System.out.println(applicationRoot);
		}
	 * */
	@Bizlet("")
	public static String getSessionInfo() {
		IMapContextFactory contextFactory = com.primeton.ext.common.muo.MUODataContextHelper
				.getMapContextFactory();
		ISessionMap sessionMap = contextFactory.getSessionMap();
		Object sessionRoot = sessionMap.getRootObject();
		System.out.println(sessionRoot);
		
		return "0";
	}
	
	/**
	 * @Description: 将base64编码字符串转换为图片
	 * @Author: 
	 * @CreateTime: 
	 * @param imgStr base64编码字符串
	 * @param path 图片路径-具体到文件
	 * @return
	*/
	@Bizlet("")
	public static boolean generateImage(String imgStr, String path) {
		if (imgStr == null) {
			return false;
		}
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			//解密
			byte[] b = decoder.decodeBuffer(imgStr);
			//处理数据
			for (int i=0; i<b.length; i++) {
				if (b[i]<0) {
					b[i] += 256;
				}
			}
			OutputStream out = new FileOutputStream(path);
			out.write(b);
			out.flush();
			out.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	/**
	 * @Description: 根据图片地址转换为base64编码字符串
	 * @Author: 
	 * @CreateTime: 
	 * @return
	 */
	@Bizlet("")
	public static String getImageStr(String imgFile) {
		InputStream inputStream = null;
		byte[] data = null;

		try {
			inputStream = new FileInputStream(imgFile);
			data = new byte[inputStream.available()];
			inputStream.read(data);
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	    // 加密
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);
		
	}
	
	
	/**
	 * 
	 * @功能： 营业执照识别
	 */
	@Bizlet("营业执照识别")
	public static Map licenseRecog(String imgPath) throws Exception {
		Map outResult = new HashMap();
		outResult.put("errCode", "S");
		String host = "https://dm-58.data.aliyun.com";
		String path = "/rest/160601/ocr/ocr_business_license.json";
		String method = "POST";
		String appcode = "4afe7a5f18df4c978eb41e9ceeb376ae";
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Authorization", "APPCODE " + appcode);
		headers.put("Content-Type", "application/json; charset=UTF-8");
		Map<String, String> querys = new HashMap<String, String>();

		//String pathP = getClasspath() + pd.getStrings("path");
		String bodys = "{\"image\":\"" + GetImageStr(imgPath) + "\"}";

		HttpResponse response = HttpUtils.doPost(host, path, method, headers,
				querys, bodys);
		int responseCode = response.getStatusLine().getStatusCode();
		if (responseCode == 200) {
			String res = EntityUtils.toString(response.getEntity());
			JSONObject licenseObj = JSONObject.parseObject(res);
			System.out.println(licenseObj);
			
			//if ((boolean) licenseObj.get("success")) {
			if (licenseObj.getBoolean("success")) {

				//PageData pdLicense = new PageData();
				if ("FailInRecognition".equals(licenseObj.get("reg_num"))) {
					//pdLicense.put("license_code", "");// 营业执照号
					outResult.put("license_code", "");// 营业执照号
				} else {
					//pdLicense.put("license_code", licenseObj.get("reg_num"));// 营业执照号
					outResult.put("license_code", licenseObj.get("reg_num"));// 营业执照号
				}

				if ("FailInRecognition".equals(licenseObj.get("name"))) {
					outResult.put("name", "");// 公司名称
				} else {
					outResult.put("name", licenseObj.get("name"));// 公司名称
				}

				if ("FailInRecognition".equals(licenseObj.get("address"))) {
					outResult.put("address", "");// 注册地址
				} else {
					outResult.put("address", licenseObj.get("address"));// 注册地址
				}

				if ("FailInRecognition".equals(licenseObj.get("captial"))) {
					outResult.put("register_money", 0);// 注册资金
				} else {
					outResult.put("register_money", licenseObj.get("captial"));// 注册资金
				}

				if (!"".equals(licenseObj.get("establish_date"))) {
					String establish_time = licenseObj
							.getString("establish_date");
					String establish_time1 = establish_time.substring(0, 4)
							+ "-" + establish_time.substring(4, 6) + "-"
							+ establish_time.substring(6, 8);

					outResult.put("establish_time", establish_time1);// 注册日期
				} else {
					outResult.put("establish_time", "");// 注册日期
				}

				if ("FailInRecognition".equals(licenseObj.get("person"))) {
					outResult.put("legal_person", "");
				} else {
					outResult.put("legal_person", licenseObj.get("person"));// 法人
				}

				// person//法人
				return outResult;
			} else {
				System.out.println("识别营业执照信息失败.");
				outResult.put("errCode", "E");
				return outResult;
			}

		} else {
			System.out.println("识别营业执照信息失败.");
			outResult.put("errCode", "E");
			return outResult;
		}
	}

	/**
	 * 
	 * @功能： 身份证识别
	 * @日期：2018年5月20日
	 */
	@Bizlet("身份证识别")
	public static Map idCardRecog(String imgPath) throws Exception {
		Map outResult = new HashMap();
		outResult.put("errCode", "S");
		String host = "http://dm-51.data.aliyun.com";
		String path = "/rest/160601/ocr/ocr_idcard.json";
		String appcode = "4afe7a5f18df4c978eb41e9ceeb376ae";
		//String imgFile = getClasspath() + pd.getStrings("path");// 图片路径

		JSONObject configObj = new JSONObject();
		configObj.put("side", "face");// 身份证正面识别
		String config_str = configObj.toString();

		String method = "POST";
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("Authorization", "APPCODE " + appcode);
		Map<String, String> querys = new HashMap<String, String>();

		// 拼装请求body的json字符串
		JSONObject requestObj = new JSONObject();
		String imgBase64 = GetImageStr(imgPath);
		requestObj.put("image", imgBase64);
		if (config_str.length() > 0) {
			requestObj.put("configure", config_str);
		}

		String bodys = requestObj.toString();
		HttpResponse response = HttpUtils.doPost(host, path, method, headers,
				querys, bodys);
		int responseCode = response.getStatusLine().getStatusCode();
		if (responseCode == 200) {
			String res = EntityUtils.toString(response.getEntity());
			JSONObject idCardObj = JSONObject.parseObject(res);
			
			if (idCardObj.getBoolean("success")) {

				//PageData pdCard = new PageData();
				outResult.put("legal_person", idCardObj.get("name"));
				outResult.put("id_card", idCardObj.get("num"));

				return outResult;
			} else {
				System.out.println("识别身份证信息失败.");
				outResult.put("errCode", "E");
				return outResult;
			}
		} else {
			System.out.println("识别身份证信息失败.");
			outResult.put("errCode", "E");
			return outResult;
		}
	}

	/**
	 * 
	 * @功能：将图片文件转化为字节数组字符串，并对其进行Base64编码处理
	 * @作者： YYH
	 * @日期：2018年5月20日
	 */
	public static String GetImageStr(String imgFile) throws Exception {
		String imgBase64 = "";
		
		HttpURLConnection connection = (HttpURLConnection) new URL(imgFile).openConnection();
		connection.setRequestMethod("GET");
		int code = connection.getResponseCode();
	    if (code == 200 || code == 206) {
			int contentLength = connection.getContentLength();
			InputStream is = connection.getInputStream();
			DataInputStream dataInputStream = new DataInputStream(is);
			byte[] content = new byte[contentLength];//new byte[(int) dataInputStream.length()];
			dataInputStream.readFully(content);
			dataInputStream.close();
			is.close();
			
			BASE64Encoder encoder = new BASE64Encoder();
			imgBase64 = encoder.encode(content);
	    }
		
		//File file = new File(imgFile);
		//byte[] content = new byte[(int) file.length()];
		//FileInputStream finputstream = new FileInputStream(file);
		//finputstream.read(content);
		//finputstream.close();
		//BASE64Encoder encoder = new BASE64Encoder();
		//imgBase64 = new String(encodeBase64(content));
		//imgBase64 = encoder.encode(content);

		return imgBase64;
	}
	
	@Bizlet("")
    public static java.util.Date getCarVerificationDate(Date regDate) throws ParseException {		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();//创建一个date对象保存当前时间
		String nowStr = simpleDateFormat.format(date);
		String regStr = simpleDateFormat.format(regDate);
		
		Date nowDate = simpleDateFormat.parse(nowStr);//调用parse()方法时 注意 传入的格式必须符合simpleDateFormat对象的格式，即"yyyy-MM-dd HH:mm:ss:SSS" 否则会报错！！
		regDate = simpleDateFormat.parse(regStr);
		
		if(regDate.getTime() >= nowDate.getTime()) return null;

		Calendar bef = Calendar.getInstance();
        Calendar aft = Calendar.getInstance();
        bef.setTime(nowDate);
        aft.setTime(regDate);
        
        int year1 = bef.get(Calendar.YEAR);
        int year2 = aft.get(Calendar.YEAR);
        int month1 = bef.get(Calendar.MONTH);
        int month2 = aft.get(Calendar.MONTH);
        int day1 = bef.get(Calendar.DAY_OF_MONTH);
        int day2 = aft.get(Calendar.DAY_OF_MONTH);
        // 获取年的差值 
        int yearInterval = year1 - year2;
        // 如果 d1的 月-日 小于 d2的 月-日 那么 yearInterval-- 这样就得到了相差的年数
        if (month1 < month2 || month1 == month2 && day1 < day2) {
            yearInterval--;
        }
        // 获取月数差值
        int monthInterval = (month1 + 12) - month2;
        if (day1 < day2) {
            monthInterval--;
        }
        monthInterval %= 12;
        int monthsDiff = Math.abs(yearInterval * 12 + monthInterval);
        //System.out.println("相差月份：" + monthsDiff);
        //6年 = 72月，免检， 年审到期日期 regDate + 8年
        //6年 到 15年包含15年，1年检1次
        //15年以上 是半年1检
        if((int) monthsDiff <= 72) {
        	aft.add(Calendar.YEAR, 7);
            return aft.getTime();
        }else if(monthsDiff>72 && monthsDiff<=180) {
        	//7年 = 72 + 12  8年 = 72 + 24  9年 = 72 + 36 10年 = 72 + 48
        	System.out.println((monthsDiff*1.0 - 72)/12);
        	int d = (int) Math.ceil((monthsDiff*1.0 - 72)/12);
        	aft.add(Calendar.YEAR, d + 6);
        	if(aft.getTime().getTime() < nowDate.getTime() && monthsDiff < 180) {
        		aft.add(Calendar.YEAR, 1);
        	}else if(aft.getTime().getTime() < nowDate.getTime()) {
        		aft.add(Calendar.MONTH, 6);
        	}
        	return aft.getTime();
        }else {
        	int m = (int) Math.ceil((monthsDiff*1.0 - 180)/6);
        	aft.add(Calendar.MONTH, m*6 + 180);
        	if(aft.getTime().getTime() < nowDate.getTime()) {
        		aft.add(Calendar.MONTH, 6);
        	}
        	return aft.getTime();
        }
    }

	/**
	 * 
	 * @功能： 得到 当前 class路径
	 * @作者： YYH
	 * @日期：2018年5月20日
	 */
	public String getClasspath() {
		String path = (String.valueOf(Thread.currentThread()
				.getContextClassLoader().getResource("")) + "../../")
				.replaceAll("file:/", "").replaceAll("%20", " ").trim();
		if (path.indexOf(":") != 1) {
			path = java.io.File.separator + path;
		}
		return path;
	}
	
	@Bizlet("")
	public static String encode(String str) {
		try {
			str = URLEncoder.encode(str,"utf-8");
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return str;
		
	}
	
	@Bizlet("")
	public static String decode(String str) {
		try {
			str = URLDecoder.decode(str,"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		return str;
	}
	

	/*
	 * @Bizlet("") public static String obj2json(UserObject obj) { try { String
	 * aa = JSONObject.toJSONString(obj); return aa; } catch (Exception e) {
	 * e.printStackTrace(); return ""; } }
	 */

	public static void main(String args[]) {
		/*
		 * UserObject userObj = new UserObject();
		 * 
		 * userObj.getAttributes().put("token",
		 * "8f692b27-3ccd-3695-a44c-d82506ad4cbc");
		 * userObj.setSessionId("8f692b27-3ccd-3695-a44c-d82506ad4cbc");
		 * userObj.setUserId("7499");
		 * 
		 * String abc = obj2GzipStr(userObj); System.out.println(abc); userObj =
		 * (UserObject) SerializeUtil.decompressUnserialize(abc);
		 * System.out.println(userObj.getSessionId());
		 */
		// System.out.println(createSessionId());
		// System.out.println(createSessionId());

		/*
		 * String a = "sfd"; a.hashCode(); Map map = new HashMap();
		 * map.put("disct", "DDT2017092200015");
		 * System.out.println(Utils.obj2json(map));
		 */

		//Float retailPrice = 20603.0f;
		//System.out.println(Math.round(retailPrice * 1.16 * 100) / 100.0);
		
		//getSessionInfo();
		
		/*SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat format2 = new SimpleDateFormat("HHmmss");
		Date date = new Date();
		System.out.println(format1.format(date));

		System.out.println(format2.format(date));
		
		JSONObject jsonObj = new JSONObject();
		Map <String, String> ingredients = new HashMap <String, String>();
		ingredients.put("apples", "3kg");
		ingredients.put("sugar", "1kg");
		ingredients.put("pastry", "2.4kg");
		ingredients.put("bestEaten", "outdoors");
		jsonObj.put("ingredients", ingredients);
		System.out.println(jsonObj);*/
		
		//String strImg = getImageStr("F:/86619-106.jpg");
	    //System.out.println(strImg);
	    String strImg = "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PAIIOCVA0HFqOigGgVwFCDq5ctIYAgj4KEDQ8XHWqBmBbAIEnWxO7IUAAjUWIOjUeHIZWt8LEHT6/hQAAAEECDqcAwjUV4CgU9+5ZWQIIJBRgKCTEYrdEPBQgKDj4aRRMgII5CtA0MnXk9YQcEmAoOPSbFALAghUIkDQqYSdThEoRYCgUwoznSCAgMsC3QSdRx99dOJVV1114HnnnffogQceOGj//84775zylre85alvfetbM0899dQnp0yZsj0+7vg+//qv/3rAXXfdNS3pMmvWrI0f+9jHHrRjf/KTn+xtP3/jG9/4jP37ddddd0By/6lTp2796Ec/+oDtf9lll71k1apVk6N9TjvttFU333zzvuvWrRv23V1HH3302r/4i794bOLEiTtcnhdqQyAPAYJOHoq0gQACXgt0E3RswOvXrx/3mc985sCzzjrrd7fccsv0xYsXz2gXROJh6O1vf/sTg4ODY5KB6J577tnj7rvv3vN973vf76N2LOA88cQTE+K/F/3M2vjyl7/84je96U1PWdD5/ve/v+873/nONRZg7LiZM2duOfLII1+wOr/0pS/Nev/7378qGb68njiKRyCDAEEnAxK7IIBAvQW6DTqRSjygpAUY2+8rX/nK/4gHob/6q7+6/8ADD9wcBaX169fvdvPNN+8drbREqz8WitrpJ4NOckXH+rDglAxg9vsWgOo9q4wOgaYAQYczAQEE+l6g06BjASO69HTmmWc+ZpeW4qsso126ioeX6JJU/JKVtRUPOmmXrazf+fPnrx1tRee+++6bfNxxx623FSVrN77S0/cTD0BfCBB0+mKaGSQCCIwk0GnQia/krFmzZoJdWkq7bBXtt2DBgifs0lPaPTpRULLLS9GKjO0/f/78Z+2eHwtFyXBiK0jWbzLopK3oREHHLq0dddRRz9tx0SUtzgoE+kGAoNMPs8wYEUBgRIFeg060ohMFErskFb9fJurcgs4//dM/zd599923RTcct1tlSa7oxMNJWtCJVmySA/32t789w1Z0LDTZP3/729/uTtDhP4h+EiDo9NNsM1YEEEgVyCvo2H04tmqSDDrxS13R6k67p6isQLuHZsqUKds6WdFJuxnanq6aNm3a1mh1iKDDfwD9KEDQ6cdZZ8wIIDBMII+gY6ss0c3EFmyiFZ2VK1dOjp6kaneDcdp9M53eoxOt6Ngl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";
	    generateImage(strImg, "F:/86619-107.jpg");
	}
	
	

}
