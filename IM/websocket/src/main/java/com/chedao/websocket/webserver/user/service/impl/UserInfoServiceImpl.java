package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserInfoDao;
import com.chedao.websocket.webserver.user.model.UserFriendTEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.model.UserInfoExtendEntity;
import com.chedao.websocket.webserver.user.service.UserInfoService;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("userInfoServiceImpl")
public class UserInfoServiceImpl implements UserInfoService {

	@Resource
	private UserInfoDao userInfoDao;

	@Autowired
	private JedisCache jedisCache;

	private static final String cacheName = "LAYIM_USERINFO";
	private static final String cacheKey = "USERID_";

	//每个组存一个
	private String getCacheKey(String userId){
		return cacheKey + userId;
	}

	//将某个用户的好友信息存入缓存  key=》list  用于IM界面好友信息显示
	public boolean saveUserInfoCache(String userId, UserInfoEntity userInfo) {

		String key = getCacheKey(userId);
		jedisCache.hashSet(cacheName,key,userInfo);
		return true;
	}

	public boolean refreshUserInfoCache(String userId) {
		UserInfoEntity userInfo = userInfoDao.queryByUid(Long.parseLong(userId));
		return saveUserInfoCache(userId, userInfo);
	}
	
	@Override
	public UserInfoEntity queryObject(Long id){
		return userInfoDao.queryObject(id);
	}
	
	@Override
	public List<UserInfoEntity> queryList(Map<String, Object> map){
		return userInfoDao.queryList(map);
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return userInfoDao.queryTotal(map);
	}
	
	@Override
	public void save(UserInfoEntity userInfo){

		userInfoDao.save(userInfo);

		refreshUserInfoCache(userInfo.getUid().toString());
	}
	
	@Override
	public int update(UserInfoEntity userInfo){
		int i = userInfoDao.update(userInfo);
		refreshUserInfoCache(userInfo.getUid().toString());
		return i;
	}
	
	@Override
	public int delete(Long id){
		return userInfoDao.delete(id);
	}
	
	@Override
	public int deleteBatch(Long[] ids){
		return userInfoDao.deleteBatch(ids);
	}

	@Override
	public UserInfoEntity queryByUid(Long uid) {
		//将用户信息缓存起来
		//1、新增用户需要缓存；2、修改用户需要缓存；
		String key = getCacheKey(uid.toString());
		UserInfoEntity userInfo = (UserInfoEntity)jedisCache.hashGet(cacheName,key);
		if(userInfo == null || userInfo.getUid() == null) {
			return userInfoDao.queryByUid(uid);
		}
		return userInfo;
	}

	@Override
	public List<UserInfoExtendEntity> queryBoxUserInfoByUid(Map<String, Object> map) {
		return userInfoDao.queryBoxUserInfoByUid(map);
	}

	//好友查找
	@Override
	public List<UserInfoEntity> queryUserInfo(String name) {
		return userInfoDao.queryUserInfo(name);
	}

}
