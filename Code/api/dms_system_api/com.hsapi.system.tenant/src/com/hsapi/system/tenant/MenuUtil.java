/**
 * 
 */
package com.hsapi.system.tenant;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.hs.common.Menu;
import com.hs.common.TreeParser;

import commonj.sdo.DataObject;
import commonj.sdo.helper.DataFactory;

/**
 * @author Administrator
 * @date 2018-11-28 09:43:07
 *
 */
@Bizlet("")
public class MenuUtil {
	
	@Bizlet
	public static List  getMenuData(String userId)throws Throwable  {
		try {
			//查询用户对应的角色
			DataObject criteria = com.eos.foundation.data.DataObjectUtil
					.createDataObject("com.primeton.das.criteria.criteriaType");
        	criteria.set("_entity", "com.hsapi.system.data.sys.ComCapPartyauth");
        	criteria.set("_expr[1]/partyId", userId);
        	criteria.set("_expr[1]/_op", "=");
	    	DataObject[] result = com.eos.foundation.database.DatabaseUtil
	    	.queryEntitiesByCriteriaEntity("default", criteria);
			
	    	if(result.length <= 0) {
	    		return null;
	    	}
			
	    	String roleIds = DataObjectUtil.concatPropertyValues(result, "roleId", null, ",", true);
	    	
	    	//查询菜单
	    	Object[] objs = DatabaseExt.queryByNamedSql("default","com.hsapi.system.tenant.permissionsMgr.queryMenu", null);
	    	List<DataObject> menuList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(menuList, objs);
	    	//查询角色对应的资源
	    	HashMap pr = new HashMap();
	    	pr.put("roleIds",roleIds);
	    	Object[] objr = DatabaseExt.queryByNamedSql("default","com.hsapi.system.tenant.permissionsMgr.queryMenuRes", pr);
	    	List<DataObject> menuResList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(menuResList, objr);
	    	
	    	Set<DataObject> set = new HashSet<DataObject>();    //去重
	        set.addAll(menuList);    
	        set.addAll(menuResList);  
	        List<DataObject> c = new ArrayList<DataObject>(set); 
	        
	        Collections.sort(c, new Comparator<DataObject>() {
	            public int compare(DataObject arg0, DataObject arg1) {
	                int hits0 = arg0.getInt("DISPLAYORDER");
	                int hits1 = arg1.getInt("DISPLAYORDER");
	                if (hits0 > hits1) {
	                    return 1;
	                } else if (hits1 == hits0) {
	                    return 0;
	                } else {
	                    return -1;
	                }
	            }
	        });
	        
	        List<Menu> list=new ArrayList<Menu>();
	        for(int i = 0; i<c.size(); i++) {
	        	DataObject d = c.get(i);
	        	
	        	/*
	        	 *  menuName: "预约管理"      ----------
					menuPrimeKey: "2081"      ----------
					imagePath: null            ----------
					linkAction: "/com.hsweb.RepairBusiness.BookingManagementList.flow"        ---------------
					linkResId: "dms_booking"*/
	        	String menuName = d.getString("menuname");
	        	String menuPrimeKey = d.getString("menuid");
	        	String imagePath = d.getString("imagepath");
	        	String linkAction = d.getString("funcaction");
	        	String linkResId = d.getString("funccode");
	        	String parentId = d.getString("parentsid");
	        	Menu menu=new Menu();
		        menu.setMenuPrimeKey(menuPrimeKey);
		        menu.setMenuName(menuName);
		        menu.setImagePath(imagePath);
		        menu.setLinkAction(linkAction);
		        menu.setLinkResId(linkResId);
		        menu.setParentId(parentId);
		        list.add(menu);
	        }
	        
	        List<Menu> tree = TreeParser.getTreeList("", list);
	    	tree = TreeParser.clearTree(tree);
	    	return tree;
	    	
		}catch (Throwable ex) {
				ex.printStackTrace();
		}
		return null;

	}
	
}
