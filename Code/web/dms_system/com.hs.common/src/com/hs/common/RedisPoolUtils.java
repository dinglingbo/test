package com.hs.common;

import java.util.Date;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisPoolUtils {

	// Redis服务器地址
	private static String ADDR_ARRAY = Env.getContributionConfig(
			"com.sys.cachemgr", "CacheCfg", "redisCfg", "address");

	// Redis服务器端口
	private static int PORT = Integer.parseInt(Env.getContributionConfig(
			"com.sys.cachemgr", "CacheCfg", "redisCfg", "port"));

	// 访问密码
	private static String AUTH = Env.getContributionConfig(
			"com.sys.cachemgr", "CacheCfg", "redisCfg", "password");

	// 可用连接实例的最大数目，默认值为8；
	// 如果赋值为-1，则表示不限制；如果pool已经分配了maxActive个jedis实例，则此时pool的状态为exhausted(耗尽)。
	private static int MAX_ACTIVE = Integer.parseInt(Env.getContributionConfig(
			"com.sys.cachemgr", "CacheCfg", "redisCfg", "maxActive"));

	// 控制一个pool最多有多少个状态为idle(空闲的)的jedis实例，默认值也是8。
	private static int MAX_IDLE = Integer.parseInt(Env.getContributionConfig(
			"com.sys.cachemgr", "CacheCfg", "redisCfg", "maxIdle"));

	// 等待可用连接的最大时间，单位毫秒，默认值为-1，表示永不超时。如果超过等待时间，则直接抛出JedisConnectionException；
	private static int MAX_WAIT = Integer.parseInt(Env.getContributionConfig(
			"com.sys.cachemgr", "CacheCfg", "redisCfg", "maxWait"));

	// 超时时间
	private static int TIMEOUT = Integer.parseInt(Env.getContributionConfig(
			"com.sys.cachemgr", "CacheCfg", "redisCfg", "timeout"));

	// 在borrow一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；
	private static boolean TEST_ON_BORROW = true;// "".equalsIgnoreCase(Env.getContributionConfig("com.sys.cachemgr",
													// "CacheCfg", "redisCfg",
													// "testOnBorrow"));

	private static JedisPool jedisPool = null;

	/**
	 * redis过期时间,以秒为单位
	 */
	public final static int EXRP_HOUR = 60 * 60; // 一小时
	public final static int EXRP_DAY = 60 * 60 * 24; // 一天
	public final static int EXRP_MONTH = 60 * 60 * 24 * 30; // 一个月

	/**
	 * 初始化Redis连接池
	 */
	private static void initialPool() {
		System.out.println("redis ip:" + ADDR_ARRAY + ", port:" + PORT
				+ ",AUTH:" + AUTH);

		try {
			JedisPoolConfig config = new JedisPoolConfig();
			config.setMaxTotal(MAX_ACTIVE);
			config.setMaxIdle(MAX_IDLE);
			config.setMaxWaitMillis(MAX_WAIT);
			config.setTestOnBorrow(TEST_ON_BORROW);
			if (AUTH != null && AUTH.trim().length() > 0) {
				jedisPool = new JedisPool(config, ADDR_ARRAY.split(",")[0],
						PORT, TIMEOUT, AUTH);
			} else {
				jedisPool = new JedisPool(config, ADDR_ARRAY.split(",")[0],
						PORT, TIMEOUT);
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				// 如果第一个IP异常，则访问第二个IP
				JedisPoolConfig config = new JedisPoolConfig();
				config.setMaxTotal(MAX_ACTIVE);
				config.setMaxIdle(MAX_IDLE);
				config.setMaxWaitMillis(MAX_WAIT);
				config.setTestOnBorrow(TEST_ON_BORROW);
				jedisPool = new JedisPool(config, ADDR_ARRAY.split(",")[1],
						PORT, TIMEOUT);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	/**
	 * 在多线程环境同步初始化
	 */
	private static synchronized void poolInit() {
		if (jedisPool == null) {
			initialPool();
		}
	}

	/**
	 * 同步获取Jedis实例
	 * 
	 * @return Jedis
	 */
	public synchronized static Jedis getJedis() {
		if (jedisPool == null) {
			poolInit();
		}
		Jedis jedis = null;
		try {
			if (jedisPool != null) {
				jedis = jedisPool.getResource();
			}
		} catch (Exception e) {
			// e.printStackTrace();
			System.out.println("Error：从连接池获取Redis失败！" + new Date());
		}
		return jedis;
	}

	/**
	 * 释放jedis资源
	 * 
	 * @param jedis
	 */
	public static void returnResource(Jedis jedis) {
		if (jedis != null && jedisPool != null) {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 当出现connectionBroken的时候，直接释放掉链接，而不是继续使用
	 * 
	 * @param jedis
	 * @param conectionBroken
	 */
	// public static void closeResource(Jedis jedis, boolean conectionBroken) {
	// try {
	// if (conectionBroken) {
	// jedisPool.returnBrokenResource(jedis);
	// } else {
	// jedisPool.returnResource(jedis);
	// }
	// } catch (Exception e) {
	//
	// JedisUtils.destroyJedis(jedis);
	// }
	// }

}
