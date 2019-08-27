/**
 * 
 */
package com.hs.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

import redis.clients.jedis.Jedis;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.hs.utils.APIUtils;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;
import commonj.sdo.helper.DataFactory;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2019年1月22日 下午5:26:23 
 * 类说明 
 */
/**
 * @author Administrator
 * @date 2019-01-22 17:26:23
 * 菜单权限及页面流权限处理
 */
@Bizlet("")
public class ResauthUtils {
	
	@SuppressWarnings({ "finally", "unchecked" })
	@Bizlet("")
	public static HashMap genenCacheKey(String nameSqlId, HashMap params) {
		HashMap pm = new HashMap();
		try {
			String paramStr = Utils.obj2json(params);
			String cacheName = "cache_" + nameSqlId;
			int key = paramStr.hashCode();
			pm.put("cacheName", cacheName); 
			pm.put("key", key); 
		}finally{
			return pm;
		}
		
	}
	
	@Bizlet("")
	public static DataObject[] getRedisCache(String dsName, String nameSqlId, 
			HashMap params, String title, String fromDb, int expireTimes,
			boolean setDe, DataObject deData) {
		HashMap cachePm = genenCacheKey(nameSqlId, params);
		String cacheName = (String) cachePm.get("cacheName");
		String key = cachePm.get("key").toString();
		if(cacheName == null || cacheName.equals("")) {
			return null;
		}
		if(fromDb.equals("true")) {
			return queryAndSetCache(cacheName, key, dsName, nameSqlId, params, title, setDe, deData);
        	//List<DataObject> detailList = new ArrayList<DataObject>();
        	//CollectionUtils.addAll(detailList, objs);
		} else {
			boolean bool = hExists(cacheName, key);
			if(bool) {
				String cacheValue = hgetAndExtend(cacheName, key, -1);
				return (DataObject[]) Utils.gzipStr2Obj(cacheValue);
			} else {
				return queryAndSetCache(cacheName, key, dsName, nameSqlId, params, title, setDe, deData);
			}
		}
		
	}
	
	private static DataObject[] queryAndSetCache(String cacheName, String key, String dsName, String nameSqlId, 
			HashMap params, String title, boolean setDe, DataObject deData) {
		Object[] objs = DatabaseExt.queryByNamedSql(dsName,nameSqlId, params);
		List<DataObject> detailList = new ArrayList<DataObject>();
		CollectionUtils.addAll(detailList, objs);
		String cacheValue = null;
		int size = detailList.size();
		DataObject[] data = (DataObject[]) detailList.toArray(new DataObject[size]);
		if(objs.length == 0 && setDe) {
			cacheValue = Utils.obj2GzipStr(deData);
		} else {
			cacheValue = Utils.obj2GzipStr(data);
		}
    	hsetAndExtend(cacheName, key, cacheValue, -1);
    	
    	List<Object> p = new ArrayList<Object>();
		p.add(dsName);
		p.add(nameSqlId);
		p.add(params);
		p.add(title);
		
		try {
			Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveCacheKey", p.toArray(new Object[p.size()]));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
    	return data;
	}
	
	/**
	 * 检查HashMap是否存在某个字段
	 * 
	 * @param hsetName
	 * @param key
	 * @return
	 */
	@Bizlet("")
	public static boolean hExists(String hsetName, String key) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.hexists(hsetName, key);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}
	
	@Bizlet("")
	public static String hgetAndExtend(String hsetName, String key, int expireTime) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			//如果expireTime<0，则不设置过期时间，永久有效
			if(expireTime >= 0) {
				jedis.expire(hsetName, expireTime);
			}
			return jedis.hget(hsetName, key);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}
	
	@Bizlet("")
	public static void hsetAndExtend(String hsetName, String key, Object value, int expireTime) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			boolean bool = hExists(hsetName, key);
			if(bool) {
				jedis.hdel(hsetName, key);
			}
			
			if(value != null) {
				jedis.hset(hsetName, key, value.toString());
				//如果expireTime<0，则不设置过期时间，永久有效
				if(expireTime >= 0) {
					jedis.expire(hsetName, expireTime);
				}
			}
			/*if (value == null) {
				jedis.hdel(hsetName, key);
			} else {
				jedis.hset(hsetName, key, value.toString());
				//如果expireTime<0，则不设置过期时间，永久有效
				if(expireTime >= 0) {
					jedis.expire(hsetName, expireTime);
				}
			}*/

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}
	
	@Bizlet("根据用户ID获取用户对应角色ID")
	public static DataObject[] getUserRoles(String userId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("userId", userId);
		DataObject deData = DataFactory.INSTANCE.create(DataObject.class);

		//DataObject deData = DataObjectUtil
		//		.createDataObject("commonj.sdo.DataObject");
		deData.set("roleId","-10000");
		return getRedisCache("default", "com.hs.common.orga.queryUserRoles", 
				pm, "用户角色数据", "false", -1, true, deData);
	}
	
	@Bizlet("根据角色ID获取角色对应资源ID")
	public static DataObject[] getRoleRes(String roleId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("roleId", roleId);
		
		return getRedisCache("default", "com.hs.common.orga.queryRoleRes", 
				pm, "角色资源数据", "false", -1, false, null);
	}
	
	@Bizlet("根据资源ID获取资源对应的资源详情")
	public static DataObject[] getFunctionInfo(String resId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("resId", resId);
		
		return getRedisCache("default", "com.hs.common.orga.queryAppFunctionInfo", 
				pm, "资源function详情数据", "false", -1, false, null);
	}
	
	@Bizlet("根据资源ID获取资源对应的资源详情")
	public static DataObject[] getResInfo(String resId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("resId", resId);
		
		return getRedisCache("default", "com.hs.common.orga.queryResInfo", 
				pm, "资源详情数据", "false", -1, false, null);
	}
	
	@Bizlet("获取菜单结构")
	public static DataObject[] getMenu() throws Throwable {
		HashMap pm = new HashMap();
		
		return getRedisCache("default", "com.hs.common.orga.queryMenu", 
				pm, "菜单数据", "false", -1, false, null);
	}
	
	@Bizlet("获取资源数据表数据")
	public static DataObject[] getAppFunction() throws Throwable {
		HashMap pm = new HashMap();
		
		return getRedisCache("default", "com.hs.common.orga.queryAppFunction", 
				pm, "资源数据表数据", "false", -1, false, null);
	}
	
	@Bizlet("获取所有资源信息")
	public static DataObject[] getComAppFunction() throws Throwable {
		HashMap pm = new HashMap();
		
		return getRedisCache("default", "com.hs.common.orga.queryComAppFunction", 
				pm, "资源数据", "false", -1, false, null);
	}
	
	@Bizlet("获取所有资源信息")
	public static DataObject[] getComAppFunctionByFunccode(String resId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("resId", resId);
		
		return getRedisCache("default", "com.hs.common.orga.queryAppFunctionInfo", 
				pm, "资源数据明细详情", "false", -1, false, null);
	}
	
	@Bizlet("清除并重新设置缓存")
	public static boolean clearAndResetCache(String dsName, String nameSqlId, 
			HashMap params, String title, String fromDb, int expireTimes,
			boolean setDe, DataObject deData) throws Throwable {
		HashMap cachePm = genenCacheKey(nameSqlId, params);
		String cacheName = (String) cachePm.get("cacheName");
		String key = cachePm.get("key").toString();
		if(cacheName == null || cacheName.equals("")) {
			return false;
		}
		
		Object[] objs = DatabaseExt.queryByNamedSql(dsName,nameSqlId, params);
		List<DataObject> detailList = new ArrayList<DataObject>();
		CollectionUtils.addAll(detailList, objs);
		String cacheValue = null;
		int size = detailList.size();
		DataObject[] data = (DataObject[]) detailList.toArray(new DataObject[size]);
		if(objs.length == 0 && setDe) {
			cacheValue = Utils.obj2GzipStr(deData);
		} else {
			cacheValue = Utils.obj2GzipStr(data);
		}
    	hsetAndExtend(cacheName, key, cacheValue, -1);
    	
    	List<Object> p = new ArrayList<Object>();
		p.add(dsName);
		p.add(nameSqlId);
		p.add(params);
		p.add(title);
		
		try {
			Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveCacheKey", p.toArray(new Object[p.size()]));
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		return true;
	}
	
	@Bizlet("方法调用API")
	public static Object[] callLogicFlowMethd(String componentName,
			String operationName, Object... params) throws Throwable {
		int len = params == null ? 0 : params.length;
		ILogicComponent logicComponent = LogicComponentFactory
				.create(componentName);
		Object[] ps = new Object[len];
		int idx = 0;
		for (Object o : params) {
			ps[idx] = o;
			idx++;
		}
		return logicComponent.invoke(operationName, ps);
	}
	
	
	@Bizlet("根据公司ID获取公司对应的公司详情")
	public static DataObject[] getOrgInfo(String orgid) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("orgid", orgid);
		
		return getRedisCache("common", "com.hs.common.orga.queryOrgInfo", 
				pm, "公司详情数据", "false", -1, false, null);
	}
	
	@Bizlet("根据员工ID获取员工对应机构ID")
	public static DataObject[] getEmpOrg(String empId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("empId", empId);
		
		return getRedisCache("default", "com.hs.common.orga.queryEmpOrg", 
				pm, "员工兼职数据", "false", -1, false, null);
	}
	
	@Bizlet("根据页面流全称获取对应的产品ID")
	public static DataObject[] getProductIdByResUrl(String resUrl) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("resUrl", resUrl);
		
		return getRedisCache("common", "com.hsapi.system.data.productMgr.queryProductIdByResUrl", 
				pm, "页面流对应的产品数据", "false", -1, false, null);
	}
	
	@Bizlet("根据产品ID获取资源列表")
	public static DataObject[] getProductRes(String productId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("productId", productId);
		
		return getRedisCache("common", "com.hsapi.system.data.productMgr.queryProductRes", 
				pm, "产品对应的资源数据", "false", -1, false, null);
	}
	
	@Bizlet("根据租户ID和产品ID获取租户产品的有效期")
	public static DataObject[] getTenantProductValidity(String tenantId, String productId) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("tenantId", tenantId);
		pm.put("productId", productId);
		
		return getRedisCache("common", "com.hsapi.system.data.productMgr.queryTenantProductByTenantAndProduct", 
				pm, "租户产品信息", "false", -1, false, null);
	}
	
	@Bizlet("根接口地址获取单次请求需要扣减的链车币数量")
	public static DataObject getProUrlCoin(String proUrl) throws Throwable {
		HashMap pm = new HashMap();
		pm.put("proUrl", proUrl);
				
		HashMap cachePm = genenCacheKey("com.hsapi.system.data.productMgr.queryProductByProUrl", pm);
		String cacheName = (String) cachePm.get("cacheName");
		String key = cachePm.get("key").toString();
		if(cacheName == null || cacheName.equals("")) {
			return null;
		}
		
		String cacheValue = hgetAndExtend(cacheName, key, -1);
		return (DataObject) Utils.gzipStr2Obj(cacheValue);
	}
	
}
