package com.hsapi.repair.repairService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.UserObject;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2018年12月29日 上午11:10:11 
 * 类说明 
 */
@Bizlet("")
public class ReportUtils {
	@Bizlet("给人员ID匹配工作组信息")
	public static HashMap[] add2Array(HashMap[] data) {
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
	    UserObject uo = (UserObject) muo.getUserObject();
        String 	orgid = uo.getUserOrgId();
		HashMap params = new HashMap();
		params.put("orgid", orgid);
		Object[] objs = DatabaseExt.queryByNamedSql("common",
				"com.hsapi.repair.repairService.query.queryMemGroup", params);
		List<DataObject> memList = new ArrayList<DataObject>();
		CollectionUtils.addAll(memList, objs);
		
		for(int i=0; i<data.length; i++) {
			HashMap m = data[i];
			String workerId = (String) m.get("workerId");
			for (DataObject obj : memList) {
				String empId = obj.getString("empId");
				String groupId = obj.getString("groupId");
				String groupName = obj.getString("groupName");
				if(workerId.equalsIgnoreCase(empId)) {
					m.put("groupId", groupId);
					m.put("groupName", groupName);
				}
			}
			
		}
		
		return data;
	}
	
	public static void main(String[] args) {
		add2Array(null);
   }
}
