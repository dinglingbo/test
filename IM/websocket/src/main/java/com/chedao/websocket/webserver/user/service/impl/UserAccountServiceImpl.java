package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserAccountDao;
import com.chedao.websocket.webserver.user.model.UserAccountEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.model.UserTypeEntity;
import com.chedao.websocket.webserver.user.service.UserAccountService;
import com.chedao.websocket.webserver.user.service.UserInfoService;
import com.chedao.websocket.webserver.user.service.UserTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("userAccountServiceImpl")
public class UserAccountServiceImpl implements UserAccountService {

	@Resource
	private UserAccountDao userAccountDao;
	@Autowired
	private UserInfoService userInfoServiceImpl;
	@Autowired
    private UserTypeService userTypeServiceImpl;
	
	@Override
	public UserAccountEntity queryObject(Long id){
		return userAccountDao.queryObject(id);
	}
	
	@Override
	public List<UserAccountEntity> queryList(Map<String, Object> map){
		return userAccountDao.queryList(map);
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return userAccountDao.queryTotal(map);
	}
	
	@Override
	public void save(UserAccountEntity userAccount){
		//判断用户是否已注册
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("account", userAccount.getAccount());
		UserAccountEntity  user = queryObjectByAccount(map);
		if(user==null||user.getId()<1){
			userAccountDao.save(userAccount);
			if(userAccount!=null&&userAccount.getId()!=null){
				//保存基本信息
				UserInfoEntity userInfo = userAccount.getUserInfo();
				userInfo.setUid(userAccount.getId());
				userInfoServiceImpl.save(userInfo);

				//生成默认分组：我的好友
                UserTypeEntity userTypeEntity = new UserTypeEntity();
                userTypeEntity.setBuildtime(new Date());
                userTypeEntity.setName("我的好友");
                userTypeEntity.setUserid(userAccount.getId());
                userTypeServiceImpl.save(userTypeEntity);
			}
		} 
	}
	
	@Override
	public int update(UserAccountEntity userAccount){
		return userAccountDao.update(userAccount);
	}
	
	@Override
	public int delete(Long id){
		return userAccountDao.delete(id);
	}
	
	@Override
	public int deleteBatch(Long[] ids){
		return userAccountDao.deleteBatch(ids);
	}

	@Override
	public UserAccountEntity queryObjectByAccount(Map<String, Object> map) {
		return userAccountDao.queryObjectByAccount(map);
	}

	@Override
	public UserAccountEntity validateUser(Map<String, Object> map) {
		UserAccountEntity  user = queryObjectByAccount(map);
		if(user!=null){
			String password = (String)map.get("password");
			if(password.equals(user.getPassword())){
				return user;
			}
		}
		return null;
	}
	
}
