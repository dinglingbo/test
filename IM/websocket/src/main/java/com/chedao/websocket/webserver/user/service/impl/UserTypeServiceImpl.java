package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserTypeDao;
import com.chedao.websocket.webserver.user.model.UserTypeEntity;
import com.chedao.websocket.webserver.user.service.UserFriendService;
import com.chedao.websocket.webserver.user.service.UserTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("userTypeServiceImpl")
public class UserTypeServiceImpl implements UserTypeService {
    @Resource
    private UserTypeDao userTypeDao;

    @Autowired
    private UserFriendService userFriendServiceImpl;

    @Override
    public UserTypeEntity save(UserTypeEntity userType) {
        //更新好友列表缓存数据
        userTypeDao.save(userType);
        Long userid = userType.getUserid();
        userFriendServiceImpl.refreshUserFriendListCache(Long.toString(userid));

        return userType;
    }

    @Override
    public int update(UserTypeEntity userType) {
        //更新好友列表缓存数据
        int i = userTypeDao.update(userType);
        Long userid = userType.getUserid();
        userFriendServiceImpl.refreshUserFriendListCache(Long.toString(userid));
        return i;
    }

    @Override
    public int delete(Long id, String userId) {
        //更新好友列表缓存数据
        int i = userTypeDao.delete(id);
        userFriendServiceImpl.refreshUserFriendListCache(userId);
        return i;
    }

    @Override
    public List<UserTypeEntity> queryList(Map<String, Object> map) {
        return userTypeDao.queryList(map);
    }




}
