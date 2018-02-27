package com.hsweb.system.llq;

import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import com.eos.system.annotation.Bizlet;
import com.hs.common.MD5;

@Bizlet("llq工具类")
public class LlqCall {

	@Bizlet("setHashKey")
	public void setHashKey(Map<String, Object> params) {
		String securityKey = params.get("securityKey").toString();	
		params.remove("securityKey");
		Long time = (new Date()).getTime();// 1516266450.711719

		String tms = time.toString().substring(0, 10);
		params.put("time", tms);
		System.out.println("tms=" + tms);
		Map<String, Object> sortMap = sortMapByKey(params); // 按Key进行排序

		StringBuffer s = new StringBuffer();
		for (Map.Entry<String, Object> entry : sortMap.entrySet()) {
			s.append(entry.getValue());
			System.out.println(entry.getKey() + "：" + entry.getValue());
		}
		
		String hash = MD5.crypt(s.toString() + securityKey);
		System.out.println("hash=" + hash);
		params.put("hash", hash);
	}

	/**
	 * 使用 Map按key进行排序
	 * 
	 * @param map
	 * @return
	 */
	public static Map<String, Object> sortMapByKey(Map<String, Object> map) {
		if (map == null || map.isEmpty()) {
			return null;
		}
		

		Map<String, Object> sortMap = new TreeMap<String, Object>(
				new Comparator<String>() {
					public int compare(String str1, String str2) {
						// 降序排序
						// return str2.compareTo(str1);
						return str1.compareTo(str2);
					}
				});

		sortMap.putAll(map);
		return sortMap;
	}

	public static void main(String[] args) {
		LlqCall llq = new LlqCall();
		Map<String, Object> map = new HashMap<String, Object>();
		llq.setHashKey(map);
	}

}
