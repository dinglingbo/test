/**
 * 
 */
package com.hs.utils;

import com.eos.system.annotation.Bizlet;

/**
 * @author Administrator
 * @date 2018-12-03 14:43:50
 *
 */
@Bizlet("")
public class StringUtils {
	@Bizlet("判断字符串是否为空")
	public static String isEmpty(String s){
		String result = "S";
		if (null==s || "".equals(s.trim())) {
			result = "E";
		}
		
		return result;
	}
}
