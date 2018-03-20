/**
 * 
 */
package com.hsapi.repair.common;

import java.util.HashMap;

import com.eos.system.annotation.Bizlet;
import com.hs.common.PY4JUtils;

import commonj.sdo.DataObject;

/**
 * @author chenziming
 * @date 2018-02-28 20:06:56
 *
 */
@Bizlet("")
public class RepairCommonUtil {

	@Bizlet("")
	public static String getShortPyWithoutSpace(String text) 
	{
		String result = PY4JUtils.converterToFirstSpell(text);
		String tmp [] = result.split(",");
		return tmp[0];
	}
	@Bizlet("")
	public static String getPyWithoutSpace(String text) 
	{
		String result = PY4JUtils.converterToSpell(text);
		String tmp [] = result.split(",");
		return tmp[0];
	}

	/**
	 * @param args
	 * @author chenziming
	 */
	public static void main(String[] args) {
		// TODO 自动生成的方法存根

	}

	/**
	 * @param map
	 * @param key
	 * @param data
	 */
	@Bizlet("")
	public static HashMap<String, DataObject> putDataObjectToMap(HashMap<String, DataObject> map, String key,
			DataObject data) 
	{
		if(map == null || map.isEmpty())
		{
			map = new HashMap<String,DataObject>();
		}
		map.put(key, data);
		return map;
	
	}
	
	@Bizlet("")
	public static DataObject getDataObjectFromMap(HashMap<String, DataObject> map, String key) 
	{
		if(map == null || map.isEmpty())
		{
			return null;
		}
		
		return map.get(key);
	
	}

}
