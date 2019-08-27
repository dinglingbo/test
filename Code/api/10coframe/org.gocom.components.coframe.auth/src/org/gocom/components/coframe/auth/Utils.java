package org.gocom.components.coframe.auth;

/**
 * 
 */

import java.util.HashMap;


import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;


/**
 * @author chenyy
 * @date 2016-04-04 15:18:39
 * 
 */
@Bizlet("")
public class Utils {

	

	@Bizlet("")
	public static HashMap<String, Object> str2Map(String param) {
		try {
			HashMap<String, Object> p = JSONObject.parseObject(param,HashMap.class);
			return p;
		} catch (Exception e) {
			return new HashMap<String, Object>();
		}
	}
	

}
