/**
 * 
 */
package com.hs.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.eos.system.annotation.Bizlet;

/**
 * @author Guine
 * @date 2017-12-08 13:37:20
 * 
 */
@Bizlet("")
public class JsonUtils {

	@Bizlet("")
	public static JSONObject obj2JsonObj(Object obj) {
		return (new JSONObject(obj));
	}
	
	@Bizlet("")
	public static HashMap Json2HashMap(String json) {
		return Json2HashMap(new JSONObject(json));
	}

	public static HashMap Json2HashMap(JSONObject jobj) {
		HashMap rmap = new HashMap();
		for (Iterator<String> keys = jobj.keys(); keys.hasNext();) {
			try {
				String key1 = keys.next();
				/*
				 * System.out.println("key1---" + key1 + "------" + jo.get(key1)
				 * + (jo.get(key1) instanceof JSONObject) + jo.get(key1) +
				 * (jo.get(key1) instanceof JSONArray));
				 */
				if (jobj.get(key1) instanceof JSONObject) {

					rmap.put(key1, Json2HashMap((JSONObject) jobj.get(key1)));
					continue;
				}
				if (jobj.get(key1) instanceof JSONArray) {
					rmap.put(key1,
							JsonArray2HashMap((JSONArray) jobj.get(key1)));
					continue;
				}
				/*
				 * System.out.println("key1:" + key1 + "----------jo.get(key1):"
				 * + jo.get(key1));
				 */
				setMap(key1, jobj.get(key1), rmap);

			} catch (JSONException e) {
				e.printStackTrace();
			}

		}

		return rmap;
	}

	public static ArrayList<Object> JsonArray2HashMap(JSONArray joArr) {
		ArrayList<Object> rList = new ArrayList<Object>();
		for (int i = 0; i < joArr.length(); i++) {
			try {
				if (joArr.get(i) instanceof JSONObject) {

					rList.add(Json2HashMap((JSONObject) joArr.get(i)));
					continue;
				}
				if (joArr.get(i) instanceof JSONArray) {

					rList.add(JsonArray2HashMap((JSONArray) joArr.get(i)));
					continue;
				}
				System.out.println("Excepton~~~~~");

			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		return rList;
	}

	public static void setMap(String key, Object value, HashMap rMap) {
		if (value == null || "".equals(value)) {
			rMap.put("\"" + key + "\"", "\"\"");
		} else {
			rMap.put("\"" + key + "\"", value);
		}
	}

	public static void JsonObject2HashMap(JSONObject jo, List<Map<?, ?>> rstList) {
		for (Iterator<String> keys = jo.keys(); keys.hasNext();) {
			try {
				String key1 = keys.next();
				System.out.println("key1---" + key1 + "------" + jo.get(key1)
						+ (jo.get(key1) instanceof JSONObject) + jo.get(key1)
						+ (jo.get(key1) instanceof JSONArray));
				if (jo.get(key1) instanceof JSONObject) {

					JsonObject2HashMap((JSONObject) jo.get(key1), rstList);
					continue;
				}
				if (jo.get(key1) instanceof JSONArray) {
					JsonArray2HashMap((JSONArray) jo.get(key1), rstList);
					continue;
				}
				System.out.println("key1:" + key1 + "----------jo.get(key1):"
						+ jo.get(key1));
				json2HashMap(key1, jo.get(key1), rstList);

			} catch (JSONException e) {
				e.printStackTrace();
			}

		}

	}

	public static void JsonArray2HashMap(JSONArray joArr,
			List<Map<?, ?>> rstList) {
		for (int i = 0; i < joArr.length(); i++) {
			try {
				if (joArr.get(i) instanceof JSONObject) {

					JsonObject2HashMap((JSONObject) joArr.get(i), rstList);
					continue;
				}
				if (joArr.get(i) instanceof JSONArray) {

					JsonArray2HashMap((JSONArray) joArr.get(i), rstList);
					continue;
				}
				System.out.println("Excepton~~~~~");

			} catch (JSONException e) {
				e.printStackTrace();
			}

		}

	}

	public static void json2HashMap(String key, Object value,
			List<Map<?, ?>> rstList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put(key, value);
		rstList.add(map);
	}

}
