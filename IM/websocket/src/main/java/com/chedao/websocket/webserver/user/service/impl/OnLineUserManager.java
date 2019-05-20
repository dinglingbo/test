package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.service.IOnLineUserManager;
import com.chedao.websocket.webserver.util.JedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service("onLineUserManager")
public class OnLineUserManager implements IOnLineUserManager {

    @Autowired
    private JedisCache jedisCache;

    static final String cacheName = "LAYIM";
    static final String cacheKey = "ONLINE_USER";

    //private static OnLineUserManager manager = new OnLineUserManager();

    //public static OnLineUserManager getInstance(){
    //    return manager;
    //}

    @Override
    public void addUser(String userId){
        Map map = (Map)jedisCache.hashGet(cacheName, cacheKey);
        if(map == null){
            map = new ConcurrentHashMap();
        }
        map.put(userId,"online");
        jedisCache.hashSet(cacheName, cacheKey, map);
    }

    @Override
    public void removeUser(String userId){
        Map map = (Map)jedisCache.hashGet(cacheName, cacheKey);

        if (map == null){ return; }

        map.remove(userId);
        jedisCache.hashSet(cacheName, cacheKey, map);
    }

    @Override
    public Map getOnLineUsers(){
        Map map = (Map)jedisCache.hashGet(cacheName, cacheKey);
        return map;
    }

    @Override
    public void clearOnLineUsers(){
        Map map = new ConcurrentHashMap();
        jedisCache.hashSet(cacheName, cacheKey, map);
        System.out.println("清除缓存中的在线用户数据");
    }
}
