package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.GroupInfoDao;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.GroupInfoService;
import com.chedao.websocket.webserver.user.service.GroupUserService;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("GroupInfoServiceImpl")
public class GroupInfoServiceImpl implements GroupInfoService {
    @Resource
    private GroupInfoDao groupInfoDao;
    @Autowired
    private JedisCache jedisCache;
    @Autowired
    private GroupUserService groupUserServiceImpl;

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
    public GroupInfoEntity queryObject(Long id){
        return groupInfoDao.queryObject(id);
    }


    @Override
    public int addGroupInfo(GroupInfoEntity groupInfo) {
        //创建群聊时，不需要初始化缓存（缓存的参数为用户ID），第一次读数据会从缓存取
        int i = groupInfoDao.addGroupInfo(groupInfo);
        return  groupInfo.getId();
    }
    @Override
    public int updateGroup(GroupInfoEntity groupInfo) {
        //修改群聊时（群公告，群昵称，群图片等），需要循环群聊中的成员，然后逐个更新缓存
        int i = groupInfoDao.updateGroup(groupInfo);
        if(i > 0) {
            List<GroupUserEntity> list = groupUserServiceImpl.queryGroupUsers(groupInfo.getId());
            for(int j=0; j<list.size(); j++) {
                GroupUserEntity user = list.get(j);
                refreshUserGroupCache(user.getUserId());
            }
        }
        return i;
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

    public void refreshUserGroupCache(Integer userId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId",userId);
        List<GroupInfoTEntity> userGroupList = groupInfoDao.queryUserGroupList(map);
        saveUserGroup(userId.toString(), userGroupList);
    }

}
