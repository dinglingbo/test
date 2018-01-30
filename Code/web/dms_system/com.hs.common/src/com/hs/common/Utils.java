/**
 * 
 */
package com.hs.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
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
	public static void append2ObjectToList(List list, Object obj1, Object obj2) {
		list.add(obj1);
		list.add(obj2);
	}

	@Bizlet("")
	public static void append3ObjectToList(List list, Object obj1, Object obj2,
			Object obj3) {
		list.add(obj1);
		list.add(obj2);
		list.add(obj3);
	}

	@Bizlet("")
	public static void append4ObjectToList(List list, Object obj1, Object obj2,
			Object obj3, Object obj4) {
		list.add(obj1);
		list.add(obj2);
		list.add(obj3);
		list.add(obj4);
	}

	@Bizlet("")
	public static void append5ObjectToList(List list, Object obj1, Object obj2,
			Object obj3, Object obj4, Object obj5) {
		list.add(obj1);
		list.add(obj2);
		list.add(obj3);
		list.add(obj4);
		list.add(obj5);
	}

	/**
	 * @param jsonStr
	 *            转换Map
	 * @return
	 */
	@Bizlet("")
	public static String getToken(String jsonStr) {
		try {
			JSONObject obj = JSONObject.parseObject(jsonStr);
			// obj = (JSONObject) obj.get("data");
			// String token = obj.getString("token");
			String token = obj.getString("data");

			return token;
		} catch (Exception e) {
			// TODO: handle exception
			return "";
		}
	}

	@Bizlet("")
	public static String getStatus(String jsonStr) {
		try {
			JSONObject obj = JSONObject.parseObject(jsonStr);

			String status = obj.getString("status");

			return status;
		} catch (Exception e) {
			// TODO: handle exception
			return "";
		}
	}

	@Bizlet("")
	public static String getLoginName(String jsonStr) {
		try {
			JSONObject obj = JSONObject.parseObject(jsonStr);
			obj = (JSONObject) obj.get("data");
			String status = obj.getString("loginName");

			return status;
		} catch (Exception e) {
			// TODO: handle exception
			return "";
		}
	}

	/**
	 * @param jsonStr
	 *            转换Map
	 * @return
	 */
	@Bizlet("")
	public static Map<String, Object> json2Token(String jsonStr) {
		try {
			HashMap p = new HashMap();
			p = (HashMap) JSON.parse(jsonStr);
			JSONObject obj = JSONObject.parseObject(jsonStr);
			obj = (JSONObject) obj.get("data");
			String token = obj.getString("token");

			return p;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
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

	@Bizlet("")
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
			groupVal="";
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

	/*
	 * @Bizlet("") public static String obj2json(UserObject obj) { try { String
	 * aa = JSONObject.toJSONString(obj); return aa; } catch (Exception e) {
	 * e.printStackTrace(); return ""; } }
	 */

	public static void main(String args[]) {
		UserObject userObj = new UserObject();

		userObj.getAttributes().put("token",
				"8f692b27-3ccd-3695-a44c-d82506ad4cbc");
		userObj.setSessionId("8f692b27-3ccd-3695-a44c-d82506ad4cbc");
		userObj.setUserId("7499");

		String abc = obj2GzipStr(userObj);
		System.out.println(abc);
		userObj = (UserObject) SerializeUtil.decompressUnserialize(abc);
		System.out.println(userObj.getSessionId());
	}

}