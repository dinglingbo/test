/**
 * 
 */
package com.hs.common;

import java.util.List;
import java.util.Map;

import redis.clients.jedis.Jedis;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chenyy
 * @date 2016-10-12 12:24:00
 * 
 */
@Bizlet("")
public class RedisUtils {

	// **************************************基本操作**************************************
	/**
	 * 检查是否存在某个Key
	 * 
	 * @param hsetName
	 * @param key
	 * @return
	 */
	@Bizlet("")
	public static boolean exists(String key) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.exists(key);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 删除某个键值
	 * 
	 * @param key
	 */
	@Bizlet("")
	public static void del(String key) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.del(key);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 设置键值过期时间，秒
	 * 
	 * @param key
	 */
	@Bizlet("")
	public static void expire(String key, int seconds) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.expire(key, seconds);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 监控状态
	 * 
	 * @return
	 */
	@Bizlet("")
	public static String info() {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.info();
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	// **************************************HASHSET操作**************************************

	/***
	 * 获取hset的属性值
	 * 
	 * @param hsetName
	 * @param key
	 * @return
	 */
	@Bizlet("")
	public static String hget(String hsetName, String key) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.hget(hsetName, key);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}
	
	/***
	 * 获取hset的属性值并延长过期时间
	 * 
	 * @param hsetName
	 * @param key
	 * @return
	 */
	@Bizlet("")
	public static String hgetAndExtend(String hsetName, String key) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.expire(hsetName, 3600);
			return jedis.hget(hsetName, key);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 设置haset的某个字段值
	 * 
	 * @param hsetName
	 * @param key
	 * @param value
	 * @return
	 */
	@Bizlet("")
	public static void hset(String hsetName, String key, Object value) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			if (value == null) {
				jedis.hdel(hsetName, key);
			} else {
				jedis.hset(hsetName, key, value.toString());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}
	
	/**
	 * 设置haset的某个字段值并设置过期时间（3600s）
	 * 
	 * @param hsetName
	 * @param key
	 * @param value
	 * @return
	 */
	@Bizlet("")
	public static void hsetAndExtend(String hsetName, String key, Object value) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			if (value == null) {
				jedis.hdel(hsetName, key);
			} else {
				jedis.hset(hsetName, key, value.toString());
				jedis.expire(hsetName, 3600);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 检查HashMap是否存在某个字段
	 * 
	 * @param hsetName
	 * @param key
	 * @return
	 */
	@Bizlet("")
	public static boolean hExists(String hsetName, String key) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.hexists(hsetName, key);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 删除HashMap中的某个字段
	 * 
	 * @param hsetName
	 * @param key
	 */
	@Bizlet("")
	public static void hDel(String hsetName, String key) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.hdel(hsetName, key);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 返回HashMap内所有的值
	 * 
	 * @param hsetName
	 * @return
	 */
	@Bizlet("")
	public static Map hGetAll(String hsetName) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();

			return jedis.hgetAll(hsetName);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 增加至
	 * 
	 * @param hsetName
	 * @return
	 */
	@Bizlet("")
	public static void hIncrement(String hsetName, String key, long value) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.hincrBy(key, key, value);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 获取长度
	 * 
	 * @param hsetName
	 */
	@Bizlet("")
	public static long hLen(String hsetName) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.hlen(hsetName);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 批量设置值
	 * 
	 * @param hsetName
	 * @param vals
	 */
	@Bizlet("")
	public static void hmSet(String hsetName, Map<String, String> vals) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.hmset(hsetName, vals);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	// **************************************List操作**************************************
	/**
	 * 检查List长度
	 * 
	 * @param hsetName
	 * @param vals
	 */
	@Bizlet("")
	public static long lLen(String listName) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.llen(listName);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	@Bizlet("")
	public static int lLen2Int(String listName) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			Long l = jedis.llen(listName);
			return l.intValue();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 获取指定序号的值
	 * 
	 * @param listName
	 * @param index
	 * @return
	 */
	@Bizlet("")
	public static String lIndex(String listName, long index) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.lindex(listName, index);

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 左队列出队
	 * 
	 * @param listName
	 * @return
	 */
	@Bizlet("")
	public static String lPop(String listName) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.lpop(listName);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 右队列出队
	 * 
	 * @param listName
	 * @return
	 */
	@Bizlet("")
	public static String rPop(String listName) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.rpop(listName);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 右队列入队
	 * 
	 * @param listName
	 * @param val
	 */
	@Bizlet("")
	public static void rPush(String listName, String val) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.rpush(listName, val);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 左队列入队
	 * 
	 * @param listName
	 * @param val
	 */
	@Bizlet("")
	public static void lPush(String listName, String val) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.lpush(listName, val);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 设置list中的某个元素
	 * 
	 * @param listName
	 * @param val
	 * @param index
	 */
	@Bizlet("")
	public static void lSet(String listName, String val, long index) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.lset(listName, index, val);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/***
	 * 保留队列从start到end之间的值
	 * 
	 * @param listName
	 * @param start
	 * @param end
	 */
	@Bizlet("")
	public static void lTrim(String listName, long start, long end) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.ltrim(listName, start, end);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 删除列表中值为value的元素
	 * 
	 * @param listName
	 * @param count
	 *            count > 0 : 从表头开始向表尾搜索，移除与 VALUE 相等的元素，数量为 COUNT <br/>
	 *            count < 0 :从表尾开始向表头搜索，移除与 VALUE 相等的元素，数量为 COUNT 的绝对值。 <br/>
	 *            count = 0 : 移除表中所有与VALUE 相等的值。
	 * @param value
	 */
	@Bizlet("")
	public static void lRem(String listName, long count, String value) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.lrem(listName, count, value);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	@Bizlet("")
	public static Object lrang(String listName, long begin, long end) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.lrange(listName, begin, end);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	@Bizlet("")
	public static Object lrang(String listName, DataObject page) {
		Jedis jedis = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			return jedis.lrange(listName, page.getLong("begin"),
					page.getLong("begin") + page.getLong("length") - 1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	@Bizlet("")
	public static DataObject[] list2DataObject(List<String> lists,
			String fieldName, String enity) {
		if (lists == null || lists.size() == 0) {
			return null;
		}

		int len = lists.size();
		DataObject[] result = new DataObject[len];

		for (int i = 0; i < len; i++) {
			DataObject dao = com.eos.foundation.data.DataObjectUtil
					.createDataObject(enity);

			dao.setString(fieldName, lists.get(i));
			result[i] = dao;
		}
		return result;
	}

	@Bizlet("")
	public static DataObject[] lrang2DataObject(String listName,
			DataObject page, String fieldName, String enity) {
		Jedis jedis = null;
		List<String> result = null;
		try {
			jedis = RedisPoolUtils.getJedis();
			result = jedis.lrange(listName, page.getLong("begin"),
					page.getLong("begin") + page.getLong("length") - 1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}

		return list2DataObject(result, fieldName, enity);
	}

}
