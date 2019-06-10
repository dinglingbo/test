package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.GroupInfoDao;
import com.chedao.websocket.webserver.user.dao.GroupUserDao;
import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.model.UserInfoExtendEntity;
import com.chedao.websocket.webserver.user.service.IGroupUserManager;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("groupUserManager")
public class GroupUserManager implements IGroupUserManager {

    @Resource
    private GroupUserDao groupUserDao;
    @Autowired
    private JedisCache jedisCache;

    private static final String cacheName = "LAYIM_GROUP";
    private static final String cacheKey = "GROUPID_";
    private static final String memCacheKey = "GROUPID_MEM_";

    //private static GroupUserManager manager = new GroupUserManager();

    //public static GroupUserManager getInstance(){
    //    return manager;
    //}
    //每个组存一个
    private String getCacheKey(String groupId){
        return cacheKey + groupId;
    }


    private String getMemCacheKey(String groupId){
        return memCacheKey + groupId;
    }

    private String getGroupMemCacheKey(String groupId, String userId){
        return memCacheKey + groupId +'_'+userId;
    }

    //将某个组的用户id存入缓存  key=》list
    @Override
    public boolean saveGroupMemeberIds(String groupId, List<String> userIds) {

        String key = getCacheKey(groupId);
        jedisCache.hashSet(cacheName,key,userIds);
        return true;
    }
    //将某个组的用户信息存入缓存  key=》list
    @Override
    public boolean saveGroupMemeberList(String groupId, List<UserInfoExtendEntity> userIds) {

        String key = getMemCacheKey(groupId);
        jedisCache.hashSet(cacheName,key,userIds);
        return true;
    }

    //将某个组的某个用户信息存入缓存  key=》list
    @Override
    public boolean saveGroupMemeber(String groupId, String userId, UserInfoExtendEntity groupUser) {

        String key = getGroupMemCacheKey(groupId, userId);
        jedisCache.hashSet(cacheName,key,groupUser);
        return true;
    }

    @Override
    public List<String> getGroupMembers(String groupId){
        String key = getCacheKey(groupId);
        List<String> groupList = (List<String>)jedisCache.hashGet(cacheName,key);
        if (groupList == null || groupList.size() == 0) {
            System.out.println("缓存中没有数据，需要从数据库读取");
            groupList = groupUserDao.queryGroupUserId(groupId);
            saveGroupMemeberIds(groupId, groupList);
            return groupList;
        }
        return groupList;
    }

    @Override
    public List<UserInfoExtendEntity> getGroupMemberList(String groupId){
        String key = getMemCacheKey(groupId);
        List<UserInfoExtendEntity> groupUserList = (List<UserInfoExtendEntity>) jedisCache.hashGet(memCacheKey,key);
        if (groupUserList == null || groupUserList.size() == 0) {
            System.out.println("缓存中没有数据，需要从数据库读取");
            groupUserList = groupUserDao.queryUserInfoExtend(groupId);
            saveGroupMemeberList(groupId, groupUserList);
            return groupUserList;
        }
        return groupUserList;
    }

    @Override
    public UserInfoExtendEntity getGroupMember(String groupId, String userId) {
        String key = getGroupMemCacheKey(groupId,userId);
        UserInfoExtendEntity groupUser = (UserInfoExtendEntity) jedisCache.hashGet(memCacheKey,key);
        if (groupUser == null) {
            //1、修改个人资料时更新所有群里面的缓存信息 groupId + userId；
            //2、修改我在本群的昵称时更新本群里面的缓存信息  groupId + userId;
            //3、添加到群聊时更新本群里面的缓存信息，因为不存在会自动处理，所以不需要单独处理
            groupUser = groupUserDao.queryGroupUserInfoExtend(groupId, userId);
            saveGroupMemeber(groupId, userId, groupUser);
            return groupUser;
        }
        return groupUser;
    }

    @Override
    public void refreshGroupMembersCache(String groupId) {
        List<String> groupList = groupUserDao.queryGroupUserId(groupId);
        saveGroupMemeberIds(groupId, groupList);
    }

    @Override
    public void refreshGroupMemberListCache(String groupId) {
        List<UserInfoExtendEntity> groupUserList = groupUserDao.queryUserInfoExtend(groupId);
        saveGroupMemeberList(groupId, groupUserList);
    }

    @Override
    public void refreshGroupMemberCache(String groupId, String userId) {
        UserInfoExtendEntity groupUser = groupUserDao.queryGroupUserInfoExtend(groupId, userId);
        saveGroupMemeber(groupId, userId, groupUser);
    }
}
