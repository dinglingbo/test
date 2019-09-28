/**
 * 
 */
package com.hsapi.system.service;

import com.eos.system.annotation.Bizlet;
import com.hs.utils.APIUtils;

/**
 * @author dlb
 * @date 2019-09-28 11:14:57
 *
 */
@Bizlet("")
public class SystemTimer {

	@Bizlet("定时清除登录二维码")
	public static void clearQrcode() {
		
		try {
			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.system.auth.timer", "clearQrcode", null);
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    
	}
	
	@Bizlet("定时收集车辆信息不完整数据")
	public static void getCarNO() {
		
		try {
			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.system.service.timer", "getCarNO", null);
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    
	}
	
	@Bizlet("定时更新车辆信息不完整数据")
	public static void handleCarVin() {
		
		try {
			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.system.service.timer", "handleCarVin", null);
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    
	}
	
	@Bizlet("定时更新车辆车型信息")
	public static void initCarModelFullNameByVin() {
		
		try {
			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.system.service.timer", "initCarModelFullNameByVin", null);
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    
	}
	
}
