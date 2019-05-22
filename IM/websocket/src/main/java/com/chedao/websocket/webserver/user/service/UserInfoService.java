package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.model.UserInfoExtendEntity;

import java.util.List;
import java.util.Map;

/**
 * 用户信息表
 * 
 * @author qiqiim
 * @email 1044053532@qq.com
 * @date 2017-11-27 09:38:52
 */
public interface UserInfoService {
	
	UserInfoEntity queryObject(Long id);
	
	List<UserInfoEntity> queryList(Map<String, Object> map);
	
	int queryTotal(Map<String, Object> map);
	
	void save(UserInfoEntity userInfo);
	
	int update(UserInfoEntity userInfo);
	
	int delete(Long id);
	
	int deleteBatch(Long[] ids);

	UserInfoEntity queryByUid(Long uid);

	List<UserInfoExtendEntity> queryBoxUserInfoByUid(Map<String, Object> map);

	List<UserInfoEntity> queryUserInfo(String name);
}
