package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserFriendDao;
import com.chedao.websocket.webserver.user.dao.UserTypeDao;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.UserFriendService;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    //每个组存一个
    private String getUserFriendCacheKey(String userId, String friendId){

        return "USERID_" + userId + "FRIEND_" + friendId;
    }

    //将某个用户的好友信息存入缓存  key=》list  用于查询好友信息；用于发消息时获取好友的昵称，标签，头像
    public boolean saveUserFriend(String userId, String friendId, UserInfoEntity userFriend) {

        String key = getUserFriendCacheKey(userId, friendId);
        jedisCache.hashSet(cacheName,key,userFriend);
        return true;
    }

    @Transactional
    @Override
    public void saveBatch(List<UserFriendEntity> list) {
        userFriendDao.saveBatch(list);
        for(int i=0; i<list.size(); i++) {
            UserFriendEntity userFriendEntity = list.get(i);
            String userId = userFriendEntity.getUserid().toString();
            refreshUserFriendListCache(userId);

            refreshUserFriendCache(userId, userFriendEntity.getFriendid().toString());
        }
    }

    @Override
    public void save(UserFriendEntity userFriend) {
        userFriendDao.save(userFriend);
    }

    @Override
    public int update(UserFriendEntity userFriend) {
        int i = userFriendDao.update(userFriend);
        refreshUserFriendListCache(userFriend.getUserid().toString());

        refreshUserFriendCache(userFriend.getUserid().toString(), userFriend.getFriendid().toString());

        return i;
    }

    @Override
    public int delete(Long id) {
        int i = userFriendDao.delete(id);
        UserFriendEntity userFriendEntity = (UserFriendEntity)userFriendDao.queryObject(id);
        refreshUserFriendListCache(userFriendEntity.getUserid().toString());

        refreshUserFriendCache(userFriendEntity.getUserid().toString(), id.toString());
        return i;
    }


    @Override
    public int delete(UserFriendEntity userFriend) {
        //删除好友需要删除自己的好友数据，也需要删除对方的好友数据，并刷新缓存
        int i = userFriendDao.delete(userFriend);

        refreshUserFriendListCache(userFriend.getUserid().toString());
        refreshUserFriendListCache(userFriend.getFriendid().toString());

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

    @Override
    public List<ImFriendUserInfoData> queryListUser(Long typeId) {return userFriendDao.queryListUser(typeId);}

    /**
     * 1、用于查看联系人信息
     * 2、用于发消息时获取好友的昵称，标签，头像
     * @param map
     * @return
     */
    @Override
    public UserInfoEntity queryUserFriend(Map<String, Object> map) {
        String userId = map.get("userid").toString();
        String friendId = map.get("friendid").toString();
        String key = getUserFriendCacheKey(userId,friendId);
        //1、修改个人资料时更新所有好友的缓存信息  friendId + userId 查询好友的信息；
        //2、修改好友昵称时更新对应好友的缓存信息  userId + friendId 查询好友的信息；
        //3、添加好友时更新对应好友的缓存信息 userId + friendId，friendId + userId
        UserInfoEntity userFriend = (UserInfoEntity)jedisCache.hashGet(cacheName,key);
        if (userFriend == null) {
            userFriend = userFriendDao.queryUserFriend(map);
            saveUserFriend(userId, friendId, userFriend);
            return userFriend;
        }
        return userFriend;
    }

    //刷新用户好友信息缓存
    @Override
    public boolean refreshUserFriendCache(String userId, String friendId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userid",userId);
        map.put("friendid",friendId);
        UserInfoEntity userFriend = userFriendDao.queryUserFriend(map);
        return saveUserFriend(userId, friendId, userFriend);
    }
}
