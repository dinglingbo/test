/**
 * 
 */
package com.hs.utils;

import java.util.Date;

import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * @author Administrator
 * @date 2018-12-03 14:29:19
 *
 */
@Bizlet("")
public class APIUtils {
	/**
	 * 调用逻辑流
	 * 
	 * @param componentName
	 * @param operationName
	 * @param params
	 * @return
	 * @throws Throwable
	 */
	@Bizlet("方法调用API")
	public static Object[] callLogicFlowMethd(String componentName,
			String operationName, Object... params) throws Throwable {
		int len = params == null ? 0 : params.length;
		ILogicComponent logicComponent = LogicComponentFactory
				.create(componentName);
		Object[] ps = new Object[len];
		int idx = 0;
		if(params != null) {
			for (Object o : params) {
				ps[idx] = o;
				idx++;
			}
		}
		return logicComponent.invoke(operationName, ps);
	}
	
	@Bizlet("")
	public static void log(String message) {
		System.out.println(new Date() + " system-utils-log:" + message);
	}
}
