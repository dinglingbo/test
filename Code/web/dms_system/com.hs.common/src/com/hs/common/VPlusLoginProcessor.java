package com.hs.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import redis.clients.jedis.Jedis;

import com.eos.access.http.MUOCommonUtil;
import com.eos.data.datacontext.UserObject;
import com.primeton.ext.engine.core.IParameterSet;
import com.primeton.ext.engine.core.processor.HttpPageFlowProcessor;

public class VPlusLoginProcessor extends HttpPageFlowProcessor {

	private String errCode;
	private long userId;
	private String token;

	@Override
	public void doProcess(HttpServletRequest request,
			HttpServletResponse response, IParameterSet parameterSet)
			throws IOException, ServletException {
		response.setBufferSize(40960);

		HttpSession session = request.getSession(false);
		if (session == null) {
			session = request.getSession(true);
			System.out.println("VPlusLoginProcessor创建Session："
					+ session.getId());
		}
		String token = request.getParameter("token");
		;
		if (parameterSet != null) {
			token = parameterSet.getString("token");
		}

		if ("214e2f71-4237-4601-9a1a-538bf982b995".equals(token)) {
			// 存redis
			// ly01
			// String userKey = "user_ly01";
			// RedisUtils.hsetAndExtend("token_" + token, "userInfo",
			// userKey);
			// RedisUtils.hsetAndExtend(userKey, "userInfo", "user_ly01");

			/*
			 * UserObject u = (UserObject) session .getAttribute("userObject");
			 * if(u!=null){ u = new UserObject(); }else{ u = new UserObject(); }
			 * u.setUserId("1021"); u.setUserName("ly01"); u.setUserOrgId("1");
			 * u.setUserOrgName("SYS"); u.getAttributes().put("token", token);
			 * session.setAttribute("userObject", u);
			 */
			System.out.println("非系统用户，特殊不拦截：" + token);
			String key = "token_" + token;
			Boolean isLogin = false;
			if (RedisUtils.exists(key)) {// 已登录过
				System.out.println("已登录：" + key);
				String userKey = RedisUtils.hgetAndExtend(key, "userInfo");
				if (RedisUtils.exists(userKey)) {// userKey有效
					System.out.println("已获取userKey：" + userKey);
					setSessionFromRedis(session, key, userKey);
					// isLogin = true;
				}
			}
			if (!isLogin) {// 未登录
				System.out.println("自动登录ly01");
				Object[] result = null;

				String componentName = "com.hsapi.system.auth.LoginManager";//
				String operationName = "authApi2";// 逻辑流名称checkToken //
													// 逻辑流的输入参数
				int size = 2;
				Object[] params = new Object[size];
				params[0] = "ly01";
				params[1] = "sin263";
				try {
					result = MUOCommonUtil.invokeBizWithMUO(componentName,
							operationName, params, session);
					if ("1".equals(result[0])) {
						System.out.println("自动登录成功！");
						setSessionFromRedis(session, "token_" + token,
								"user_ly01");
					} else {
						System.out.println("自动登录失败！");
					}
				} catch (Throwable e) { //
					// TODO 自动生成的 catch 块 e.printStackTrace();
					e.printStackTrace();
					System.out.println("自动登录遇到错误！");
				}
			}
		}
		super.doProcess(request, response, parameterSet);
		setSessionFromRedis(session, "token_" + token, "user_ly01");
		System.out
				.println("flow.ext URL：" + request.getRequestURL().toString());
	}

	private void setSessionFromRedis(HttpSession session, String tokenKey,
			String userKey) {
		Jedis jedis = null;
		UserObject userObject = (UserObject) SerializeUtil
				.decompressUnserialize(RedisUtils.hgetAndExtend(userKey,
						"userInfo"));
		// 是否需要更新设置token?
		if (userObject != null) {
			session.setAttribute("userObject", userObject);
			System.out.println("已设置Session From Redis!");
		} else {
			System.out.println("userObject IS NUll!");
		}
		try {
			jedis = RedisPoolUtils.getJedis();
			jedis.hset(tokenKey, "userInfo", userKey);
			jedis.expire(tokenKey, 3600);
			jedis.expire(userKey, 3600);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	/*
	 * @Override public void write(IMarshallingNode node, JSONWriter writer)
	 * throws JSONException { // TODO 自动生成的方法存根
	 * 
	 * super.write(node, writer); String n = node.getName(); if
	 * ("errCode".equalsIgnoreCase(n)) { if (node.getValue() != null) { errCode
	 * = node.getValue().toString(); } } else if ("user".equalsIgnoreCase(n)) {
	 * if (node.getValue() != null) { Object o = node.getValue(); if (o != null
	 * && o instanceof DataObject) { DataObject u = (DataObject) o; userId =
	 * u.getLong("userId"); } } } }
	 */

}
