/**
 * 
 */
package com.hs.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.eos.data.datacontext.UserObject;
import com.eos.system.annotation.Bizlet;

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
			HashMap<String, Object> p = JSONObject.parseObject(param,
					HashMap.class);
			return p;
		} catch (Exception e) {
			return new HashMap<String, Object>();
		}
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

		Float retailPrice = 20603.0f;
		System.out.println(Math.round(retailPrice * 1.16 * 100) / 100.0);

	}

}
