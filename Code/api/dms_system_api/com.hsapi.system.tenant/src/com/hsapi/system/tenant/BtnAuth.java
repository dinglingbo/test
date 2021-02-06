/**
 * 
 */
package com.hsapi.system.tenant;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.UserObject;
import com.eos.system.annotation.Bizlet;
import com.hs.common.ResauthUtils;

import commonj.sdo.DataObject;

/**
 * @author dlb
 * @date 2020-09-26 10:37:30
 *
 */
@Bizlet("")
public class BtnAuth {

	/*
	 * 匹配com_app_funcbtn中的code
	 * */
	@Bizlet("根据页面资源区域查询页面中的按钮和DIV标签权限")
	public static DataObject[] getBtnAuthByBtnArea(String btnArea){
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
	    UserObject uo = (UserObject) muo.getUserObject();		    
        String loginName = (String) uo.get("loginName");
        if(loginName == null || loginName == "") {
    		return null;
    	}
        
        try {
	        DataObject[] roleArr = ResauthUtils.getUserRoles(loginName);
	
			//查询资源对应的功能  
			if(roleArr.length <= 0) {
	    		return null;
	    	}
		
			List<DataObject> btnList = new ArrayList<DataObject>();
	    	//查询角色对应的资源
			for(int i=0; i<roleArr.length; i++) {
				DataObject roleObj = roleArr[i];
				String roleId = roleObj.getString("roleId");
				DataObject[] btnArr = ResauthUtils.getRoleResBtnAuth(roleId, btnArea);
				
				CollectionUtils.addAll(btnList, btnArr);
			}
			
			Map map = new HashMap();
			List<DataObject> btnInfoList = new ArrayList<DataObject>();
			for(int j=0; j<btnList.size(); j++) {
				DataObject resObj = btnList.get(j);
				String btnId = resObj.getString("btnId");
				if(!map.containsKey(btnId)) {
					DataObject[] btnInfo = ResauthUtils.getBtnInfo(btnId);
					map.put(btnId, true);
					CollectionUtils.addAll(btnInfoList, btnInfo);
				}
			}
			
			int size = btnInfoList.size();
			DataObject[] data = (DataObject[]) btnInfoList.toArray(new DataObject[size]);
			
			return data;
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
        
		return null;
	}
	
}
