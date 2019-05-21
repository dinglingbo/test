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
    private static final String memCacheKey = "GROUPID_MEM";

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
/*        Integer groupId = Integer.valueOf(id);
        if (groupList == null || groupList.size() == 0) {
            System.out.println("缓存中没有数据，需要从数据库读取");
            List<GroupUserEntity> mm = groupUserDao.queryGroupUsers(groupId);
            for(int i=0;i<mm.size();i++) {
                GroupUserEntity groupUserEntity = mm.get(i);
                groupList.add(groupUserEntity.getId().toString());
            }
            saveGroupMemeberIds(id, groupList);
            return groupList;
        }*/
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
//        }else{
//            System.out.println("直接从缓存中读取出来");
//        }
        return groupUserList;
    }
}
