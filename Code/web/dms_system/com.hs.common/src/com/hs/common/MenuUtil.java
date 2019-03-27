/**
 * 
 */
package com.hs.common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.data.datacontext.UserObject;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2019年1月23日 上午11:35:35 
 * 类说明 
 */
/**
 * @author Administrator
 * @date 2019-01-23 11:35:35
 *
 */
@Bizlet("")
public class MenuUtil {


	@Bizlet
	public static List  getMenuData(String userId, String type)throws Throwable  {
		if(userId == null || userId == "") {
			return null;
		}
		/*
		 * 1、获取用户对应的角色
		 * 2、获取角色对应的资源
		 * 3、取唯一资源ID
		 * 4、获取资源ID对应的详细资源信息
		 * 5、拼接并排序
		 * 6、根据type过滤输出菜单
		 * */
		try {
			//查询用户对应的角色
			DataObject[] roleArr = ResauthUtils.getUserRoles(userId);
			DataObject[] menuArr = ResauthUtils.getMenu();	
	    	if(roleArr.length <= 0 || menuArr.length <= 0) {
	    		return null;
	    	}
			List<DataObject> menuList = Arrays.asList(menuArr);
			
			List<DataObject> resList = new ArrayList<DataObject>();
	    	//查询角色对应的资源
			for(int i=0; i<roleArr.length; i++) {
				DataObject roleObj = roleArr[i];
				String roleId = roleObj.getString("roleId");
				DataObject[] resArr = ResauthUtils.getRoleRes(roleId);
				CollectionUtils.addAll(resList, resArr);
			}
			//取唯一资源ID			
			Set<DataObject> set = new HashSet<DataObject>();    //去重
			set.addAll(resList); 
			List<DataObject> resIdList = new ArrayList<DataObject>(set);
			//资源ID对应的详细资源信息
			List<DataObject> resInfoList = new ArrayList<DataObject>();
			HashMap ex = new HashMap();
			for(int j=0; j<resIdList.size(); j++) {
				DataObject resObj = resIdList.get(j);
				String resId = resObj.getString("resId");
				if(!ex.containsKey(resId)) {
					DataObject[] resInfo = ResauthUtils.getResInfo(resId);
					CollectionUtils.addAll(resInfoList, resInfo);
					ex.put(resId, resId);
				}
				
			}
			Set<DataObject> setAll = new HashSet<DataObject>();    //去重
			setAll.addAll(menuList);    
			setAll.addAll(resInfoList);  
	        List<DataObject> c = new ArrayList<DataObject>(setAll); 
			//拼接并排序
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
	        	
	        	String functype = d.getString("functype");
	        	if(functype == null || functype == "") {
	        		functype = "pc";
	        	}
	        	if(!functype.equals("app") && !functype.equals("menu")) {
	        		functype = "pc";
	        	}
	        	if(type != null && type != "") {
	        		if(functype.equals(type) || functype.equals("menu")) {
	        			String menuName = d.getString("menuname");
	    	        	String menuPrimeKey = d.getString("menuid");
	    	        	String imagePath = d.getString("imagepath");
	    	        	String linkAction = d.getString("funcaction");
	    	        	String linkResId = d.getString("funccode");
	    	        	String parentId = d.getString("parentsid");
	    	        	String imageColor = d.getString("expandpath");
	    	        	String appId = d.getString("appId");
	    	        	String params = d.getString("params");
	    	        	
	    	        	Menu menu=new Menu();
	    		        menu.setMenuPrimeKey(menuPrimeKey);
	    		        menu.setMenuName(menuName);
	    		        menu.setImagePath(imagePath);
	    		        menu.setLinkAction(linkAction);
	    		        menu.setLinkResId(linkResId);
	    		        menu.setParentId(parentId);
	    		        menu.setImageColor(imageColor);
	    		        menu.setAppId(appId);
	    		        menu.setParams(params);
	    		        list.add(menu);
	        		}
	        	}
	        	
	        }
	        
	        List<Menu> tree = TreeParser.getTreeList("", list);
	    	tree = TreeParser.clearTree(tree);
	    	return tree;
	    	
		}catch (Throwable ex) {
				ex.printStackTrace();
		}
		return null;

	}
	
	@SuppressWarnings("finally")
	@Bizlet
	public static boolean checkActionAuth(ServletRequest request) {
		boolean check = false;
		HttpServletRequest req = (HttpServletRequest) request;
		String actionUrl = req.getRequestURL().toString();
		try {
			/*IMUODataContext muo = DataContextManager.current().getMUODataContext();
			if(muo == null) {
				check = false;+
				return check;
			}*/ 
			HttpSession session = req.getSession(false);
			IUserObject u = null;
			if (session == null || session.getAttribute("userObject") == null) {
				check = false;
				return check;
			}else{
				u = (IUserObject) session.getAttribute("userObject");	
				if (u != null) {
					
				}else {
					check = false;
					return check;
				}
			}
			
	        String sysDomain = Env.getContributionConfig("system", "url", "webDomain", "SYS");
	        String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();  
	    	
			DataObject[] appArr = ResauthUtils.getAppFunction();
			if(appArr.length > 0) {
				boolean isExists = false;
				for(int k=0; k<appArr.length; k++) {
					DataObject appObj = appArr[k];
					String parentId = appObj.getString("parentsid");
		        	String linkAction = appObj.getString("funcaction");
		        	if(linkAction != null && actionUrl.indexOf(linkAction) > 0) {
		        		isExists = true;
		        		break;
		        	}else {
		        		isExists = false;
		        	}
				}
				if(!isExists) {
					check = true;
		    		return true;
				}
			}
	        //Map<String, Object> attrMap = muo.getUserObject().getAttributes();
	        String userId = (String) u.get("loginName");
			//查询用户对应的角色
			DataObject[] roleArr = ResauthUtils.getUserRoles(userId);
			DataObject[] menuArr = ResauthUtils.getMenu();	
	    	if(roleArr.length <= 0 || menuArr.length <= 0) {
	    		check = false;
	    		return false;
	    	}
			//List<DataObject> menuList = Arrays.asList(menuArr);
			
			List<DataObject> resList = new ArrayList<DataObject>();
	    	//查询角色对应的资源
			for(int i=0; i<roleArr.length; i++) {
				DataObject roleObj = roleArr[i];
				String roleId = roleObj.getString("roleId");
				DataObject[] resArr = ResauthUtils.getRoleRes(roleId);
				CollectionUtils.addAll(resList, resArr);
			}
			//取唯一资源ID
			//Set<DataObject> set = new HashSet<DataObject>();    //去重
			//set.addAll(resList); 
			//List<DataObject> resIdList = new ArrayList<DataObject>(set);
			//资源ID对应的详细资源信息
			List<DataObject> resInfoList = new ArrayList<DataObject>();
			for(int j=0; j<resList.size(); j++) {
				DataObject resObj = resList.get(j);
				String resId = resObj.getString("resId");
				DataObject[] resInfo = ResauthUtils.getFunctionInfo(resId);
				CollectionUtils.addAll(resInfoList, resInfo);
			}
			//Set<DataObject> setAll = new HashSet<DataObject>();    //去重
			//setAll.addAll(menuList);    
			//setAll.addAll(resInfoList);  
	        //List<DataObject> c = new ArrayList<DataObject>(setAll);
			int k = 0;
	        for(int i = 0; i<resInfoList.size(); i++) {
	        	DataObject d = resInfoList.get(i);
	        	String linkAction = d.getString("funcaction");
	        	k++;
	        	/*if(parentId != null && parentId != "") {
	        		linkAction = webPath + sysDomain + linkAction;
	        	} else {
	        		linkAction = webPath + linkAction;
	        	}
	        	if(actionUrl.equals(linkAction)) {
	        		check = true;
	        		break;
	        	}else {
	        		check = false;
	        	}*/
	        	if(linkAction != null && actionUrl.indexOf(linkAction) > 0) {
	        		check = true;
	        		break;
	        	}else {
	        		check = false;
	        	}
	        	
	        }
	        return check;
	    	
		}catch (Throwable ex) {
				ex.printStackTrace();
		}finally {
			return check;
		}
	}
	
	
	@Bizlet
	public static List getSameLevelRes(String userId, String resId)throws Throwable  {
		if(userId == null || userId == "" || resId == null || resId == "") {
			return null;
		}
		/*
		 * 1、获取用户对应的角色
		 * 2、获取角色对应的资源
		 * 3、取唯一资源ID
		 * 4、获取资源ID对应的详细资源信息
		 * 5、通过资源ID的输入参数PARAINFO进行排序
		 * */
		String funcgroupid = "";
		//查询用户对应的角色
		DataObject[] roleArr = ResauthUtils.getUserRoles(userId);
    	if(roleArr.length <= 0) {
    		return null;
    	}
    	List<DataObject> resList = new ArrayList<DataObject>();
    	//查询角色对应的资源
		for(int i=0; i<roleArr.length; i++) {
			DataObject roleObj = roleArr[i];
			String roleId = roleObj.getString("roleId");
			DataObject[] resArr = ResauthUtils.getRoleRes(roleId);
			CollectionUtils.addAll(resList, resArr);
		}
		
		//取唯一资源ID			
		Set<DataObject> set = new HashSet<DataObject>();    //去重
		set.addAll(resList); 
		List<DataObject> resIdList = new ArrayList<DataObject>(set);
		//资源ID对应的详细资源信息
		List<DataObject> resInfoList = new ArrayList<DataObject>();
		HashMap ex = new HashMap();
		for(int j=0; j<resIdList.size(); j++) {
			DataObject resObj = resIdList.get(j);
			String funccode = resObj.getString("resId");
			if(!ex.containsKey(funccode)) {
				DataObject[] resInfo = ResauthUtils.getComAppFunctionByFunccode(funccode);
				if(funccode.equals(resId)) {
					funcgroupid = resInfo[0].getString("funcgroupid");
				}
				CollectionUtils.addAll(resInfoList, resInfo);
				ex.put(funccode, funccode);
			}
		}
		
		List<DataObject> list=new ArrayList<DataObject>();
        for(int i = 0; i<resInfoList.size(); i++) {
        	DataObject d = resInfoList.get(i);
        	
        	String resfuncgroupid = d.getString("funcgroupid");
    		if(resfuncgroupid.equals(funcgroupid)) {
    			String funccode = d.getString("funccode");
    			String paramInfoStr = d.getString("parainfo");
    			String orderIndex = "";
    			String iconCls = "";
    			JSONObject jsonObj = JSONObject.fromObject(paramInfoStr);
    			
    			if(jsonObj.containsKey("orderIndex")) {
	    			orderIndex = (String) jsonObj.get("orderIndex");
    			}
    			if(jsonObj.containsKey("iconCls")) {
	    			iconCls = (String) jsonObj.get("iconCls");
    			}
    			d.set("orderIndex", orderIndex);
    			d.set("iconCls", iconCls);
    			if(!funccode.equals(resId)) {
    				list.add(d);
    			}
    		}
        	
        }
        
        Collections.sort(list, new Comparator<DataObject>() {
            public int compare(DataObject arg0, DataObject arg1) {
                int hits0 = arg0.getInt("orderIndex");
                int hits1 = arg1.getInt("orderIndex");
                if (hits0 > hits1) {
                    return 1;
                } else if (hits1 == hits0) {
                    return 0;
                } else {
                    return -1;
                }
            }
        });
		
		return list;

	}
	
}
