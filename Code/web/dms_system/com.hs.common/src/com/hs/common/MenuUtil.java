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
	public static List  getMenuData(String userId, String type, boolean showBill)throws Throwable  {
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
			
			/*
			 * 20190716修改
			 * 判断有没有综合开单  dms_multiple_bill ，洗美开单 dms_wash_bill，理赔开单 dms_claim_bill，波箱开单 waveBox，工单；
			 * 如果有工单  1026 则 添加计次卡销售，储值卡充值
			 * */
			boolean zhBillCheck = false;
			boolean xcBillCheck = false;
			boolean lpBillCheck = false;
			boolean gbBillCheck = false;
			boolean billCheck = false;
	        
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
	    		        
	    		        if(showBill) {
		    		        if(menuPrimeKey.equals("1026")) {
		    		        	billCheck = true;
		    		        }
		    		        if(linkResId != null && linkResId.equals("dms_multiple_bill")) {
		    		        	zhBillCheck = true;
		    		        }
		    		        if(linkResId != null && linkResId.equals("dms_wash_bill")) {
		    		        	xcBillCheck = true;
		    		        }
		    		        if(linkResId != null && linkResId.equals("dms_claim_bill")) {
		    		        	lpBillCheck = true;
		    		        }
		    		        if(linkResId != null && linkResId.equals("waveBox")) {
		    		        	gbBillCheck = true;
		    		        }
	    		        }
	    		        
	        		}
	        	}
	        	
	        }
	        
	        if(showBill) {
		        if(zhBillCheck) {
		        	Menu menu=new Menu();
			        menu.setMenuPrimeKey("2000");
			        menu.setMenuName("综合开单详情");
			        menu.setImagePath(null);
			        menu.setLinkAction("/com.hsweb.RepairBusiness.repairBill.flow");
			        menu.setLinkResId(null);
			        menu.setParentId("1026");
			        menu.setImageColor(null);
			        menu.setAppId(null);
			        menu.setParams(null);
			        list.add(menu);
		        }
		        
		        if(xcBillCheck) {
		        	Menu menu=new Menu();
			        menu.setMenuPrimeKey("3000");
			        menu.setMenuName("洗美开单详情");
			        menu.setImagePath(null);
			        menu.setLinkAction("/com.hsweb.RepairBusiness.carWashBill.flow");
			        menu.setLinkResId(null);
			        menu.setParentId("1026");
			        menu.setImageColor(null);
			        menu.setAppId(null);
			        menu.setParams(null);
			        list.add(menu);
		        }
		        
		        if(lpBillCheck) {
		        	Menu menu=new Menu();
			        menu.setMenuPrimeKey("4000");
			        menu.setMenuName("理赔开单详情");
			        menu.setImagePath(null);
			        menu.setLinkAction("/com.hsweb.RepairBusiness.claimDetail.flow");
			        menu.setLinkResId(null);
			        menu.setParentId("1026");
			        menu.setImageColor(null);
			        menu.setAppId(null);
			        menu.setParams(null);
			        list.add(menu);
		        }
		        
		        if(gbBillCheck) {
		        	Menu menu=new Menu();
			        menu.setMenuPrimeKey("8000");
			        menu.setMenuName("波箱开单详情");
			        menu.setImagePath(null);
			        menu.setLinkAction("/com.hsweb.bx.waveBoxDetail.flow");
			        menu.setLinkResId(null);
			        menu.setParentId("1026");
			        menu.setImageColor(null);
			        menu.setAppId(null);
			        menu.setParams(null);
			        list.add(menu);
		        }
		        
		        if(billCheck) {
		        	Menu menu=new Menu();
			        menu.setMenuPrimeKey("timesCard");
			        menu.setMenuName("计次卡销售");
			        menu.setImagePath(null);
			        menu.setLinkAction("/com.hsweb.frm.manage.cardTimesSettlement.flow");
			        menu.setLinkResId(null);
			        menu.setParentId("1026");
			        menu.setImageColor(null);
			        menu.setAppId(null);
			        menu.setParams(null);
			        list.add(menu);
			        
			        Menu menu1=new Menu();
			        menu1.setMenuPrimeKey("card");
			        menu1.setMenuName("储值卡充值");
			        menu1.setImagePath(null);
			        menu1.setLinkAction("/com.hsweb.frm.manage.cardSettlement.flow");
			        menu1.setLinkResId(null);
			        menu1.setParentId("1026");
			        menu1.setImageColor(null);
			        menu1.setAppId(null);
			        menu1.setParams(null);
			        list.add(menu1);
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
	
	@Bizlet
	public static Map checkActionProductAuth(ServletRequest request) {
		Map map = new HashMap();
		boolean check = true;
		HttpServletRequest req = (HttpServletRequest) request;
		String actionUrl = req.getRequestURL().toString();
		try {
			HttpSession session = req.getSession(false);
			IUserObject u = null;
			if (session == null || session.getAttribute("userObject") == null) {
				check = false;
				map.put("check", check);
				return map;
			}else{
				u = (IUserObject) session.getAttribute("userObject");	
				if (u != null) {
					
				}else {
					check = false;
					map.put("check", check);
					return map;
				}
			}
			
	        Map attr = u.getAttributes();
	        String tenantId = (String) attr.get("tenantId");
	        if(tenantId == null || tenantId == "") {
	        	check = false;
	        	map.put("check", check);
				return map;
	        }
	        
	        //20190823 根据页面地址查询产品ID，根据产品ID和租户ID查询是否在有效期内
	        //如果根据页面地址查询不到产品ID，则说明此功能不属于某一产品，不受有效期的控制
	        //产品对应功能中，产品直接对应页面地址，如果页面地址有变，则需要修改产品对应功能中的页面地址
	        //页面地址 + 产品ID 缓存， 产品ID、租户ID + 租户产品有效期  缓存， 产品ID 对应  功能列表 缓存  key + value
	        //取第一个 / 到最后一个 ？ 之间的内容，作为页面流的地址
	        String actionFlowUrl = actionUrl.substring(actionUrl.lastIndexOf("/"));
	        int inx = actionFlowUrl.indexOf("?");
	        if(inx > 0) {
	        	actionFlowUrl = actionFlowUrl.substring(0,inx);
	        }
	        
	        DataObject[] productIds = ResauthUtils.getProductIdByResUrl(actionFlowUrl);
	        if(productIds != null && productIds.length > 0) {
	        	String productId = productIds[0].getString("productId");
	        	//根据租户ID和产品ID查询产品是否有效
	        	if(productId != null) {
	        		DataObject[] productObjs = ResauthUtils.getTenantProductValidity(tenantId, productId);
	        		if(productObjs != null && productObjs.length > 0) {
	        			DataObject productObj = productObjs[0];
	        			int status = productObj.getInt("status");
	        			//status 0正常，1已过期
	        			if(status == 1) {
	        				check = false;
	        			}else {
	        				check = true;
	        			}
	        		}else {
	        			check = false;
	        		}

        			map.put("check", check);
        			map.put("productId", productId);
        			return map;
	        	}
	        }
	        
	        map.put("check", true);
	        return map;
	    	
		}catch (Throwable ex) {
				ex.printStackTrace();
		}finally {
			return map;
		}
	}
	
	//checkActionAuth 20190823前判断是否有功能权限
	//20190823修改：先判断产品是否在有效期，然后再判断是否有功能权限，过了有效期根据产品编码跳转对应充值，没有权限跳转/coframe/auth/noAuth.jsp	
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
		        	String linkAction = appObj.getString("funcaction");
		        	String funcType = appObj.getString("funcType");
		        	if(funcType.equalsIgnoreCase("app")) {
		        		isExists = false;
		        	} else {
			        	if(linkAction != null && actionUrl.indexOf(linkAction) > 0 && actionUrl.indexOf(".flow") > 0) {
			        		isExists = true;
			        		break;
			        	}else {
			        		isExists = false;
			        	}
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
