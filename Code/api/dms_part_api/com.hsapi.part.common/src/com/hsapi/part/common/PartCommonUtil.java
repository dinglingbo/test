/**
 * 
 */
package com.hsapi.part.common;

import com.eos.system.annotation.Bizlet;
import com.hs.common.PY4JUtils;

/**
 * @author chenziming
 * @date 2018-02-28 20:06:56
 *
 */
@Bizlet("")
public class PartCommonUtil 
{

	@Bizlet("")
	public static String getShortPyWithoutSpace(String text)
	{
		String result = PY4JUtils.converterToFirstSpell(text);
		return result;
	}
	/**
	 * @param args
	 * @author chenziming
	 */
	public static void main(String[] args) {
		// TODO 自动生成的方法存根

	}

}
