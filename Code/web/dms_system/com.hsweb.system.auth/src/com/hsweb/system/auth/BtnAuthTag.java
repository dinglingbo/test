/**
 * 
 */
package com.hsweb.system.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.collections.CollectionUtils;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.UserObject;
import com.eos.system.annotation.Bizlet;
import com.hs.common.Menu;
import com.hs.common.ResauthUtils;

import commonj.sdo.DataObject;

/**
 * @author dlb
 * @date 2019-08-28 20:22:30
 *
 */
@Bizlet("")
public class BtnAuthTag extends TagSupport{
	private String btnArea = "";
	public void setBtnArea(String btnArea) {
		this.btnArea = btnArea;
	}
		
	public int doStartTag() throws JspException {
		if(btnArea == null || btnArea == "") {
			return SKIP_BODY;
		}
		
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
	    UserObject uo = (UserObject) muo.getUserObject();		    
        String loginName = (String) uo.get("loginName");
        if(loginName == null || loginName == "") {
    		return SKIP_BODY;
    	}
        String domStr = "";
        
        //查询用户对应的角色
		try {
			DataObject[] roleArr = ResauthUtils.getUserRoles(loginName);

			//查询资源对应的功能  不用考虑资源对应的按钮为空
			//btnArea   dms_multiple_bill_1    
			if(roleArr.length <= 0) {
	    		return SKIP_BODY;
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
			
			//Set<DataObject> setAll = new HashSet<DataObject>();    //去重 
			//setAll.addAll(btnInfoList);  
	        //List<DataObject> c = new ArrayList<DataObject>(setAll); 
			//拼接并排序
			Collections.sort(btnInfoList, new Comparator<DataObject>() {
	            public int compare(DataObject arg0, DataObject arg1) {
	                int hits0 = arg0.getInt("displayorder");
	                int hits1 = arg1.getInt("displayorder");
	                if (hits0 > hits1) {
	                    return 1;
	                } else if (hits1 == hits0) {
	                    return 0;
	                } else {
	                    return -1;
	                }
	            }
	        });
			
	        for(int i = 0; i<btnInfoList.size(); i++) {
	        	DataObject d = btnInfoList.get(i);
	        	
	        	String tagContent = d.getString("tagContent");
	        	if(tagContent != null || tagContent != "") {
	        		domStr = domStr + tagContent;
	        	}
	        	
	        }
			
		} catch (Throwable e1) {
			// TODO 自动生成的 catch 块
			e1.printStackTrace();
		}
        
        JspWriter out = pageContext.getOut();
		//String username = (String)pageContext.getSession().getAttribute(name);
		if(domStr != ""){
			try {
				out.println(domStr);
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
			return EVAL_BODY_INCLUDE; //自动将标签体包含到输出流（因为顶级标签的标签体是一子标签，还要进行该子标签的标签处理）
		}else{
			return SKIP_BODY; //跳过标签体，不处理
		}
	}
}
