/**
 * 
 */
package com.hsapi.cloud.part.common;

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
	
	@Bizlet("")
	public static Integer getColumnValueByString(String conColumn, String conContent,
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
	
}
	

