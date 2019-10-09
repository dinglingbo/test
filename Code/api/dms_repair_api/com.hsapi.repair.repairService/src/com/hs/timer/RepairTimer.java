/**
 * 
 */
package com.hs.timer;

import com.eos.system.annotation.Bizlet;
import com.hs.utils.APIUtils;


/**
 * @author dlb
 * @date 2019-09-28 10:43:00
 *
 */
@Bizlet("")
public class RepairTimer {

	@Bizlet("定时生成回访数据")
	public static void generateVisitDate() {
		
		try {
			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.repair.repairService.timersettle", "generateVisitData", null);
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    
	}
	
	public static void generateRemindData() {
		
		try {
			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.repair.repairService.timersettle", "generateRemindData", null);
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    
	}
	
	@Bizlet("定时更新项目使用次数")
	public static void updateUseTimes() {
		
		try {
			Object[] resultRes = APIUtils.callLogicFlowMethd("com.hsapi.repair.repairService.timersettle", "updateUseTimes", null);
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    
	}
	
}
