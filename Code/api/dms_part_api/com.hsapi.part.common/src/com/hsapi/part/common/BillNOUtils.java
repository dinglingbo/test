/**
 * 
 */
package com.hsapi.part.common;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

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
	
	
	@Bizlet("")
	public static Long getColumnValue(String entityName, String column, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		//cond.set("_expr[1]/" + column, enterType);
		//cond.set("_expr[2]/_op", "between");
		//cond.set("_expr[2]/createdate", null);
		
		//Date d = com.eos.foundation.common.utils.DateUtil.getJVMDate();
		//String dt = com.eos.foundation.common.utils.DateUtil.format(d, "yyyy-MM-dd");
		
		//cond.set("_expr[2]/_min", dt);
		//cond.set("_expr[2]/_pattern", "yyyy-MM-dd");
		
		cond.set("_select/_field", column);

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		System.out.println(result[0]);
		if (result != null && result.length > 0) {
			Long tk = result[0].getLong(column);
			//String tk = result[0].getString("max_" + maxColumn);
			//String t = String.format("%5d", (Long.parseLong(tk.substring(15) + 1)));
			//return tk.substring(0, 15) + t;
			return tk;
		} else {
			return null;
		}

	}
	
	@Bizlet("")
	public static String getColumnMaxDateValue(String entityName, String maxColumn, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		
		cond.set("_select/_max[1]", maxColumn);

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		//System.out.println(result[0]);
		if (result != null && result.length > 0) {
			String tk = result[0].getString("max_" + maxColumn);
			//String test = "2017-08-12 12:23:36";
			if(tk != "" && tk != null) {
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//String t = sdf.fo
				java.util.Date date = null;
				try {
					 DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");  //yyyy-MM-dd'T'HH:mm:ss.SSSZ  
			         date = df.parse(tk);  
			         //System.out.println(date);  
			           
			         //SimpleDateFormat df1 = new SimpleDateFormat ("EEE MMM dd HH:mm:ss Z yyyy", Locale.UK);  
			         //System.out.println(df1.parse(date.toString()));  
			         //System.out.println(df1.format(date));  
			           
			         //DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
			         //System.out.println(df2.format(date));
			         
			         tk = sdf.format(date);
					//date = sdf.parse(tk);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			
			return tk;
		} else {
			return null;
		}

	}
	
	
	@Bizlet("")
	public static String getColumnMaxStringValue(String entityName, String maxColumn, String column, String columnValue, Integer n, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		cond.set("_expr[1]/" + column, columnValue);
		cond.set("_expr[1]/_op", "=");
		cond.set("_select/_max[1]", maxColumn);

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		//System.out.println(result[0]);
		if (result != null && result.length > 0) {
			String tk = result[0].getString("max_" + maxColumn);
			
			if(tk != "" && tk != null) {
				
				tk=tk.substring(tk.length()-n, tk.length());
				
				Integer inte = Integer.parseInt(tk, 10) + 1;
				
				tk = String.format("%0"+Integer.toString(n)+"d", inte);
				
				return tk;
				
			}else {
				
				return String.format("%0"+Integer.toString(n)+"d", 1);
				
			}
			
			
		} else {
			return null;
		}

	}
	
}
