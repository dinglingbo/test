/**
 * 
 */
package com.hs.common;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2019年2月20日 下午4:43:08 
 * 类说明 
 */
/**
 * @author Administrator
 * @date 2019-02-20 16:43:08
 *
 */
@Bizlet("")
public class EmpUtils {
	@Bizlet("初始化机构缓存")
	public static boolean initOrgInfo() throws Throwable {
		DataObject criteria = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
    	criteria.set("_entity", "com.hs.common.com.ComCompany");
    	DataObject[] result = com.eos.foundation.database.DatabaseUtil
    	.queryEntitiesByCriteriaEntity("common", criteria);
    	
    	if(result.length > 0) {
    		for(int i=0; i<result.length; i++) {
    			DataObject dob = result[i];
    			String orgid = dob.getString("orgid");
    			ResauthUtils.getOrgInfo(orgid);
    		}
    	}

		return true;
	}
	
	@Bizlet("获取员工兼职公司信息  orgid字符串")
	public static String getEmpOrgs(String empId) throws Throwable {
		HashMap pm = new HashMap();
		
		DataObject[] dob = ResauthUtils.getEmpOrg(empId);
		
		if(dob.length>0) {
			return DataObjectUtil.concatPropertyValues(dob, "orgid", null, ",", true);
		}else {
			return "-1";
		}
		
	}
	
	@Bizlet("获取员工兼职公司信息")
	public static DataObject[] getEmpOrgArr(String empId) throws Throwable {
		HashMap pm = new HashMap();
		
		DataObject[] dob = ResauthUtils.getEmpOrg(empId);
		if(dob.length>0) {
			List<DataObject> resList = new ArrayList<DataObject>();
	    	//查询角色对应的资源
			for(int i=0; i<dob.length; i++) {
				DataObject roleObj = dob[i];
				String orgid = roleObj.getString("orgid");
				DataObject[] resArr = ResauthUtils.getOrgInfo(orgid);
				CollectionUtils.addAll(resList, resArr);
			}
			
			Collections.sort(resList, new Comparator<DataObject>() {
	            public int compare(DataObject arg0, DataObject arg1) {
	                int hits0 = arg0.getInt("orgid");
	                int hits1 = arg1.getInt("orgid");
	                if (hits0 > hits1) {
	                    return 1;
	                } else if (hits1 == hits0) {
	                    return 0;
	                } else {
	                    return -1;
	                }
	            }
	        });
			
			DataObject[] arrEmpOrg = new DataObject[resList.size()];
			arrEmpOrg = resList.toArray(arrEmpOrg);

			return arrEmpOrg;
			
		}else {
			return null;
		}
	}
}
