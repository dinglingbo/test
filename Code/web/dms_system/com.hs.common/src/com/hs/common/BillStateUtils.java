/**
 * 
 */
package com.hs.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
import commonj.sdo.Type;

/**
 * @author Administrator
 * @date 2017-07-12 12:08:27
 *
 */
@Bizlet("")
public class BillStateUtils {
	@Bizlet("")
	public static String getColumnValue(String conColumn, int conContent,
			String entityName, String resColumn, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		cond.set("_expr[1]/" + conColumn, conContent);
		
		cond.set("_select/_field", resColumn);

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		
		if (result != null && result.length > 0) {
			String tk = result[0].getString(resColumn);
			
			return tk;
		} else {
			return null;
		}

	}
	
	@Bizlet("")
	public static Date getColumnDateValue(String conColumn, int conContent,
			String entityName, String resColumn, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		cond.set("_expr[1]/" + conColumn, conContent);
		
		cond.set("_select/_field", resColumn);

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		
		if (result != null && result.length > 0) {
			Date tk = result[0].getDate(resColumn);
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			
			return tk;
		} else {
			return null;
		}

	}
	
	@Bizlet("")
	public static String importTimeLimit() {
		Date operateDate = new Date();
		int hours = operateDate.getHours();
		if((hours>=19&&hours<24)||(hours>=0&&hours<7)){
			return "S";
		}else{
			return "E";
		}

	}
	@Bizlet("")
	public static String administratorLimit(String administrator) {
		if(administrator.equals("sysadmin")||administrator.equals("sysqxy")||administrator.equals("sysqpy")){
			return "S";
		}else{
			return "E";
		}

	}
	
	@Bizlet("")
	public static Integer getColumnIntValue(String conColumn, int conContent,
			String entityName, String resColumn, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		cond.set("_expr[1]/" + conColumn, conContent);
		
		cond.set("_select/_field", resColumn);

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		
		if (result != null && result.length > 0) {
			Integer tk = result[0].getInt(resColumn);
			
			return tk;
		} else {
			return null;
		}

	}
	
	@Bizlet("查询实体数据")
	public static DataObject[] queryEntityByColumn(String conColumn, int conContent,
			String entityName, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		cond.set("_expr[1]/" + conColumn, conContent);
		
		//cond.set("_select/_field", resColumn);

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		
		return result;

	}
	
	@Bizlet("")
	public static boolean checkStrColumnExists(String conColumn, String conContent, String conColumn2, int conContent2,
			String conColumn3, int conContent3, String entityName, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		cond.set("_expr[1]/" + conColumn, conContent);
		cond.set("_expr[1]/_op", "=");
		
		if(conColumn2!=null && conColumn2!=""){
			cond.set("_expr[2]/" + conColumn2, conContent2);
			cond.set("_expr[2]/_op", "=");
		}
		
		if(conColumn3!=null && conColumn3!=""){
			cond.set("_expr[3]/" + conColumn3, conContent3);
			cond.set("_expr[3]/_op", "<>");
		}

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		
		if (result != null && result.length > 0) {
			//String tk = result[0].getString(resColumn);
			
			return true;
		} else {
			return false;
		}

	}
	
	@Bizlet("")
	public static boolean checkIntColumnExists(String conColumn, int conContent, String conColumn2, int conContent2,
			String conColumn3, int conContent3, String entityName, String dataSource) {

		DataObject cond = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
		cond.set("_entity", entityName);
		cond.set("_expr[1]/" + conColumn, conContent);
		cond.set("_expr[1]/_op", "=");//需要判断是否重复的字段
		
		if(conColumn2!=null && conColumn2!=""){
			cond.set("_expr[2]/" + conColumn2, conContent2);
			cond.set("_expr[2]/_op", "=");//只判断租户内不重复
		}
		
		if(conColumn3!=null && conColumn3!=""){
			cond.set("_expr[3]/" + conColumn3, conContent3);
			cond.set("_expr[3]/_op", "<>");//修改时应用
		}

		DataObject[] result = com.eos.foundation.database.DatabaseUtil
				.queryEntitiesByCriteriaEntity(dataSource, cond);
		
		if (result != null && result.length > 0) {
			//String tk = result[0].getString(resColumn);
			
			return true;
		} else {
			return false;
		}

	}
	
	@Bizlet("")
	public static String stringReplaceAll(String str){
		str = str.replaceAll("\\s*", "");
		return str;
	}
	
	@Bizlet("")
	public static int getMillisecond(Date startDate){
		double eMillis = new Date().getTime();
		double sMillis =  startDate.getTime(); 
		double millisecond = 0;
		millisecond = (eMillis - sMillis)/1000;
		int resultMillisecond = (int) millisecond;
		return resultMillisecond;
	}
	
}
	

