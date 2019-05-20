package com.chedao.websocket.webserver.util;


import com.chedao.websocket.util.SerializerUtil;
import com.jfinal.plugin.redis.IKeyNamingPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Component
@SuppressWarnings("static-access")
public class JedisCache {

    @Autowired
    private JedisPool jedisPool;

    @Autowired
    private IKeyNamingPolicy keyNamingPolicy;

    //@Autowired
    //private SerializerUtil serializer;

    // 给某个key设值
    public void set(String key, Object value) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            byte[] valueBytes = SerializerUtil.serializeValue(value);
            client.set(keyBytes, valueBytes);
        } finally {
            returnJedis(client);
        }

    }

    // 根据key获取value
    public Object get(String key) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            byte[] valueBytes = client.get(keyBytes);
            return SerializerUtil.deserializeValue(valueBytes);
        } finally {
            returnJedis(client);
        }
    }

    // 根据键值获取value
    public Object hashGet(String key, String field) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            byte[] fieldBytes = SerializerUtil.serializeKey(field);
            byte[] valueBytes = client.hget(keyBytes, fieldBytes);
            return SerializerUtil.deserializeValue(valueBytes);
        } finally {
            returnJedis(client);
        }

    }

    public void hashSet(String key, String field, Object value) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            byte[] fieldBytes = SerializerUtil.serializeKey(field);
            byte[] valueBytes = SerializerUtil.serializeValue(value);
            client.hset(keyBytes, fieldBytes, valueBytes);
        } finally {
            returnJedis(client);
        }

    }

    public void hashDel(String key, String field) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            byte[] fieldBytes = SerializerUtil.serializeKey(field);
            client.hdel(keyBytes, fieldBytes);
        } finally {
            returnJedis(client);
        }
    }

    public Map<String, Object> hashAllGet(String key) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            Map<byte[], byte[]> map = client.hgetAll(keyBytes);
            Map<String, Object> valueMap = new HashMap<>();
            Set<Map.Entry<byte[], byte[]>> valueSet = map.entrySet();
            for (Map.Entry<byte[], byte[]> entry : valueSet) {
                valueMap.put(SerializerUtil.deserializeKey(entry.getKey()), SerializerUtil.deserializeValue(entry.getValue()));
            }
            return valueMap;
        } finally {
            returnJedis(client);
        }

    }

    // 判断key是否存在
    public boolean existKey(String key) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            return client.exists(keyBytes);
        } finally {
            returnJedis(client);
        }
    }

    // 删除
    public void delKey(String key) {
        Jedis client = getJedis();
        try {
            byte[] keyBytes = SerializerUtil.serializeKey(keyNamingPolicy.getKeyName(key));
            client.del(keyBytes);
        } finally {
            returnJedis(client);
        }
    }

    // 获取jedis链接
    private Jedis getJedis() {
        Jedis jedis = jedisPool.getResource();
        jedis.auth("000000");
        return jedis;
    }

    // 关闭jedis
    public void returnJedis(Jedis jedis) {
        if (jedis != null) {
            jedis.close();
        }
    }

}
