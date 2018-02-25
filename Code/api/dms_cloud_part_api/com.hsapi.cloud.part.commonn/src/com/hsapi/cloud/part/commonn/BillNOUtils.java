/**
 * 
 */
package com.hsapi.cloud.part.commonn;

import com.eos.system.annotation.Bizlet;

/**
 * @author Administrator
 * @date 2018-02-25 16:45:32
 *
 */
@Bizlet("")
public class BillNOUtils {
	@Bizlet("")
	public static String getMaxNOToStr(int length, int maxno) {
		String maxStr = Integer.toString(maxno);
		maxStr = String.format("%0"+Integer.toString(length)+"d", maxno);  //%n
		
		return maxStr;

	}
}
