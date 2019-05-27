package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserFriendDao;
import com.chedao.websocket.webserver.user.dao.UserTypeDao;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.UserFriendService;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service("userFriendServiceImpl")
public class UserFriendServiceImpl implements UserFriendService {
    @Resource
    private UserFriendDao userFriendDao;
    @Resource
    private UserTypeDao  userTypeDao;
    @Autowired
    private JedisCache jedisCache;

    private static final String cacheName = "LAYIM_GROUP";
    private static final String cacheKey = "USERID_FRIEND_";

    //每个组存一个
    private String getCacheKey(String userId){
        return cacheKey + userId;
    }

    //将某个用户的好友信息存入缓存  key=》list  用于IM界面好友信息显示
    public boolean saveUserFriend(String userId, List<UserFriendTEntity> userFriendList) {

        String key = getCacheKey(userId);
        jedisCache.hashSet(cacheName,key,userFriendList);
        return true;
    }

    @Override
    public void save(UserFriendEntity userFriend) {
        userFriendDao.save(userFriend);
    }

    @Override
    public int update(UserFriendEntity userFriend) {
        return userFriendDao.update(userFriend);
    }

    @Override
    public int delete(Long id) {
        return userFriendDao.delete(id);
    }


    @Override
    public int delete(UserFriendEntity userFriend) {
        return userFriendDao.delete(userFriend);
    }

    @Override
    public int isFriend(String userId, String friendId){
        return userFriendDao.isFriend(userId,friendId);
    }

    //查找我的好友，包括分组信息，需要用到分组实体
    @Override
    public List<ImFriendUserData> queryFriend(UserInfoEntity user) {
        List<UserTypeEntity> type = new ArrayList<UserTypeEntity>();
        List<ImFriendUserData> friend = new ArrayList<ImFriendUserData>();
        UserTypeEntity temp = new UserTypeEntity();
        //查找分组
        type = userTypeDao.queryList(user.getUid());
        if(type.size()>0){
            for (int i = 0;i<type.size();i++){
                 ImFriendUserData imData = new ImFriendUserData();
                 temp = type.get(i);
                 imData.setId(temp.getId());
                 imData.setGroupname(temp.getName());
                 List<ImFriendUserInfoData > list =  userFriendDao.queryListUser(temp.getId());
                 imData.setList(list);
                 friend.add(imData);
            }
        }
        return friend;
    }

    //查找用户好友列表
    @Override
    public List<UserFriendTEntity> queryUserFriendList(String userId) {
        String key = getCacheKey(userId);
        //1、修改，删除好友分组需要更新缓存
        //2、修改，删除，移动好友需要更新缓存；删除好友需要更新自己和好友的缓存
        List<UserFriendTEntity> userFriendList = (List<UserFriendTEntity>)jedisCache.hashGet(cacheName,key);
        if (userFriendList == null || userFriendList.size() == 0) {
            System.out.println("缓存中没有数据，需要从数据库读取");
            userFriendList = userFriendDao.queryUserFriendList(userId);
            saveUserFriend(userId, userFriendList);
            return userFriendList;
        }
        return userFriendList;
    }

    //刷新好友列表缓存
    @Override
    public boolean refreshUserFriendListCache(String userId) {
        List<UserFriendTEntity> userFriendList = userFriendDao.queryUserFriendList(userId);
        return saveUserFriend(userId, userFriendList);
    }
}
