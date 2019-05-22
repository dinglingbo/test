package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.GroupInfoDao;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.GroupInfoService;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("GroupInfoServiceImpl")
public class GroupInfoServiceImpl implements GroupInfoService {
    @Resource
    private GroupInfoDao groupInfoDao;
    @Autowired
    private JedisCache jedisCache;

    private static final String cacheName = "LAYIM_GROUP";
    private static final String cacheKey = "USERID_GROUP_";

    //每个组存一个
    private String getCacheKey(String userId){
        return cacheKey + userId;
    }

    //将某个用户的好友信息存入缓存  key=》list  用于IM界面好友信息显示
    public boolean saveUserGroup(String userId, List<GroupInfoTEntity> userGroupList) {

        String key = getCacheKey(userId);
        jedisCache.hashSet(cacheName,key,userGroupList);
        return true;
    }

    @Override
    public int addGroupInfo(GroupInfoEntity groupInfo) {
        groupInfoDao.addGroupInfo(groupInfo);
       return  groupInfo.getId();
    }
    @Override
    public int updateGroup(GroupInfoEntity groupInfo) {
       return groupInfoDao.updateGroup(groupInfo);
    }
    @Override
    public List<GroupInfoEntity> queryGroupInfo(List groupIds){
        return groupInfoDao.queryGroupInfo(groupIds);
    }

    @Override
    public List<GroupInfoTEntity> queryUserGroupList(Map<String, Object> map) {
        String userId = (String)map.get("userId");
        String key = getCacheKey(userId);
        List<GroupInfoTEntity> userGroupList = (List<GroupInfoTEntity>)jedisCache.hashGet(cacheName,key);
        if (userGroupList == null || userGroupList.size() == 0) {
            System.out.println("缓存中没有数据，需要从数据库读取");
            userGroupList = groupInfoDao.queryUserGroupList(map);
            saveUserGroup(userId, userGroupList);
            return userGroupList;
        }
        return userGroupList;
    }

}
