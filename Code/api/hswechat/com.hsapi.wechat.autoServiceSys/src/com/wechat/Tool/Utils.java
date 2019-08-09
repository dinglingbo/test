package com.wechat.Tool;

/**
 * 
 */

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
	
	/**
	 * 一个月份：2592000000
	 * @param orderDate
	 * @param number
	 * @return
	 */
	@Bizlet("")
	public static String dateFromStirng(Date orderDate,int number) {
		Calendar orderCalendar= Calendar.getInstance();
		orderCalendar.setTime(orderDate);
		orderCalendar.set(Calendar.MONTH,orderCalendar.get(Calendar.MONTH)+number); //增加一月
	    Date date=orderCalendar.getTime();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
	    String dateNowStr = sdf.format(date);
		return dateNowStr;
	}
	
	/**
	 * （原金额 - 销售金额）/原金额，小数点后面四位
	 * @param oldAmt  原金额
	 * @param sellAmt  销售金额
	 * @return
	 */
	@Bizlet("")
	public static Double oneOrderNumber(double oldAmt,double sellAmt) {
		double num = (oldAmt - sellAmt) / oldAmt;
		DecimalFormat decimalFormat =new DecimalFormat("#.0000");
		return Double.valueOf(decimalFormat.format(num));
	}
	
	/**
	 * 销售金额 / 工时，小数点后面2位
	 * @param qty 工时
	 * @param sellAmt 销售金额
	 * @return
	 */
	@Bizlet("")
	public static Double twoOrderNumber(double qty,double sellAmt) {
		DecimalFormat decimalFormat =new DecimalFormat("#.00");
		return Double.valueOf(decimalFormat.format(sellAmt / qty));
	}
}
