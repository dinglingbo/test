package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.service.IGroupUserManager;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("groupUserManager")
public class GroupUserManager implements IGroupUserManager {

    @Autowired
    private JedisCache jedisCache;

    private static final String cacheName = "LAYIM_GROUP";
    private static final String cacheKey = "GROUPID_";

    //private static GroupUserManager manager = new GroupUserManager();

    //public static GroupUserManager getInstance(){
    //    return manager;
    //}
    //每个组存一个
    private String getCacheKey(String groupId){
        return cacheKey + groupId;
    }

    //将某个组的用户id存入缓存  key=》list
    @Override
    public boolean saveGroupMemeberIds(String groupId, List<String> userIds) {

        String key = getCacheKey(groupId);
        jedisCache.hashSet(cacheName,key,userIds);
        return true;
    }

    @Override
    public List<String> getGroupMembers(String groupId){
        String key = getCacheKey(groupId);
        List<String> groupList = (List<String>)jedisCache.hashGet(cacheName,key);
        if (groupList == null || groupList.size() == 0) {
            System.out.println("缓存中没有数据，需要从数据库读取");
//            LayIMDao dao = new LayIMDao();
//            List<String> memebers = dao.getMemberListOnlyIds(groupId);
            saveGroupMemeberIds(groupId, groupList);
            return groupList;
        }
//        }else{
//            System.out.println("直接从缓存中读取出来");
//        }
        return groupList;
    }
}
