package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserInfoDao;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.model.UserInfoExtendEntity;
import com.chedao.websocket.webserver.user.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("userInfoServiceImpl")
public class UserInfoServiceImpl implements UserInfoService {

	@Resource
	private UserInfoDao userInfoDao;
	
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
	}
	
	@Override
	public int update(UserInfoEntity userInfo){
		return userInfoDao.update(userInfo);
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
	public UserInfoEntity queryByUid(Long uid) { return userInfoDao.queryByUid(uid);}

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
