/**
 * 
 */
package com.hsapi.repair.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.UserObject;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2019年1月8日 上午10:49:53 
 * 类说明 
 */
/**
 * @author Administrator
 * @date 2019-01-08 10:49:54
 *
 */
@Bizlet("")
public class ReportQuery {
	@Bizlet("业务产值汇总表")
	public static HashMap[] queryOutputValueByServiceType(HashMap[] data) {
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
			Integer workerId =  (Integer) m.get("workerId");
			m.put("groupId", null);
			m.put("groupName", null);
			for (DataObject obj : memList) {
				Integer empId = obj.getInt("empId");
				Integer groupId = obj.getInt("groupId");
				String groupName = obj.getString("groupName");
				if(workerId.equals(empId)) {
					m.put("groupId", groupId);
					m.put("groupName", groupName);
				}
			}
			
		}
		
		return data;
	}
}
