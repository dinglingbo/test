/**
 * 
 */
package com.hsapi.repair.settle;

import com.eos.system.annotation.Bizlet;

/**
 * @author Administrator
 * @date 2018-12-03 16:13:25
 *
 */
@Bizlet("")
public class RPAccountSettle {
	@Bizlet("生成应收应付数据，并直接结算收款")
    private static Object[] billSettle(String s){
		String result = "S";
		if (null==s || "".equals(s.trim())) {
			result = "E";
		}
		
		return null;
	}
}
