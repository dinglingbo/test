/**
 * 
 */
package com.hsapi.cloud.part.invoicing;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author Administrator
 * @date 2019-06-28 14:16:25
 *
 */
@Bizlet("")
public class DeductService {
	@Bizlet("")
	public static HashMap getDataMap(DataObject[] a, String propertyField) {
		HashMap hm = new HashMap();
		List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(a));
		for (DataObject obj : list) {
			hm.put(obj.getString(propertyField), obj.getString(propertyField));			
		}
		
		return hm;
	}
	
	@Bizlet("添加提成成员")
	public static HashMap addDeductMem(DataObject sourceDO, DataObject[] dos, HashMap checkMap, String checkProperty) {
		HashMap hm = new HashMap();
		String checkValue = sourceDO.getString(checkProperty);
		if(checkMap.containsKey(checkValue)) {
			hm.put("dataList", dos);
			hm.put("checkMap", checkMap);
			return hm;
		}else {
			List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(dos));
			list.add(sourceDO);
			dos = list.toArray(new DataObject[list.size()]);
			checkMap.put(checkValue, checkValue);
			
			hm.put("dataList", dos);
			hm.put("checkMap", checkMap);
			return hm;
		}

	}
}
