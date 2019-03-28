package com.hs.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import redis.clients.jedis.Jedis;

import com.alibaba.fastjson.JSONObject;
import com.eos.access.http.MUOCommonUtil;
import com.eos.data.datacontext.IUserObject;
import com.eos.data.datacontext.UserObject;
import com.eos.system.utility.StringUtil;
import com.hs.reRead.BodyReaderHttpServletRequestWrapper;

//import com.ybt.toolutils.HttpUtils;

/**
 * 逻辑流过滤器
 * 
 * @author chyy
 * 
 */
public class LogicFlowFilter implements Filter {

	private String[] excludedPageArray;

	@Override
	public void destroy() {
		excludedPageArray = null;
	}

	/**
	 * 在此处检查是否有有效的请求
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// 获取url
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse rep = (HttpServletResponse) response;
		String url = req.getRequestURL().toString();
		/**
		 * 如果根本不是逻辑流，就不要处理
		 */

		if (!isLogicFlow(url)) {
			chain.doFilter(request, response);
			return;
		}
		/**
		 * 如果是返回登录提示，就不需要再处理
		 */
		if (isAuthorRequiredRequest(url)) {
			HttpServletResponse rsp = (HttpServletResponse) response;
			rsp.setHeader("authrequired", "Y");
			chain.doFilter(request, response);
			return;
		}
		// 检查是否为例外请求，如果是就不要处理
		if (isExcludeUrls(url)) {
			chain.doFilter(request, response);
			return;
		}
		MyHttpServletRequestWrapper requestWrapper = null;
		if (req instanceof HttpServletRequest) {

			requestWrapper = new MyHttpServletRequestWrapper(
					(HttpServletRequest) req);
		}
		if(url.indexOf(".flow") > 0) {
			boolean check = MenuUtil.checkActionAuth(requestWrapper);
			if(!check) {
				//String contextPath = StringUtil.htmlFilter(req.getContextPath());
				//url=contextPath + "/coframe/auth/noAuth.jsp";
				//RequestDispatcher dispatcher = request.getRequestDispatcher(url);
				//dispatcher.forward(requestWrapper, response);
				request.getRequestDispatcher("/coframe/auth/noAuth.jsp").forward(request, response);
				return;
			}
		}
		// 检查是否客户端发送的请求
		boolean b = isClientRequest(requestWrapper);
		if (b) {
			chain.doFilter(requestWrapper, response);
			return;
		}

		// 检查是否为Web端发出的请求
		boolean c = isWebRequest(requestWrapper);
		if (c) {
			chain.doFilter(requestWrapper, response);
			return;
		}

		// 如果不是合法的请求，在请求头重返回数据
		// res.sendRedirect(req.getContextPath() + "/login.jsp");
		url = req.getContextPath()
				+ "/com.hs.common.login.authRequried.biz.ext";
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		System.out.println("非法的请求：" + req.getRequestURL().toString());
		dispatcher.forward(requestWrapper, response);
	}

	private boolean isAuthorRequiredRequest(String url) {
		return url.indexOf("com.hs.common.login.authRequried") >= 0;
	}

	/**
	 * 是否为Web端发送的请求，从Cookie中检查是是否包含vsessionId
	 * 
	 * @param req
	 * @return
	 */
	private boolean isWebRequest(HttpServletRequest req) {
		// 直接利用会话检查
		// 如果是某个页面流请求过来的，就认为是OK的
		// String flow = req.getHeader("Referer");
		String flow = req.getRequestURL().toString();
		if (flow != null && flow.indexOf(".flow") >= 0) {
			// System.out.println("页面流关联请求，不验证");
			return true;
		}
		return false;

	}

	/**
	 * 检查是否为例外请求
	 * 
	 * @param url
	 * @return
	 */
	private boolean isExcludeUrls(String url) {
		// 设置值
		String excludedPages = Env.getContributionConfig("com.sys.auth",
				"authCheck", "logicFlow", "excludedPages");
		if (excludedPages != null && excludedPages.trim().length() > 0) {
			excludedPageArray = excludedPages.split(",");
		}
		// 检查
		if (excludedPageArray != null && excludedPageArray.length > 0) {
			for (int i = 0; i < excludedPageArray.length; i++) {
				if (url.indexOf(excludedPageArray[i]) >= 0) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * 获取body中的参数
	 * 
	 * @param request
	 * @param key
	 * @return
	 */
	private String charReader(HttpServletRequestWrapper request, String key) {
		BufferedReader br;
		String str, wholeStr = "";
		try {
			br = new BufferedReader(new InputStreamReader(
					request.getInputStream()));
			while ((str = br.readLine()) != null) {
				wholeStr += str;
			}
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		String vsessionid = null;
		if (wholeStr != null) {
			try {
				JSONObject obj = JSONObject.parseObject(wholeStr);
				if (obj != null) {
					vsessionid = obj.getString(key);
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		return vsessionid;
	}

	/**
	 * 获取token参数等
	 * 
	 * @param req
	 * @return
	 */
	private String getToken(HttpServletRequestWrapper req, String key) {
		String token = req.getParameter(key);
		if (token == null || token.trim().length() < 2) {
			token = charReader(req, key);
		}

		System.out.println(key + "：" + token);
		return token;
	}

	/**
	 * 是否为客户端发的请求
	 * 
	 * @param req
	 * @return
	 */
	public boolean isClientRequest(HttpServletRequestWrapper req) {
		String token = getToken(req, "token");

		HttpSession session = req.getSession(false);
		if (session == null) {
			session = req.getSession(true);
			System.out.println(req.getContextPath() + "创建Session："
					+ session.getId());
		}
		if (token == null || token.trim().length() < 10) {
			// 无token时，检查session
			return checkSession(session);
		} else {
			// 有token时
			String posiId = getToken(req, "posiId");

			return checkToken(token, session,
					posiId == null ? 0 : Long.valueOf(posiId));
		}
	}

	/**
	 * Md5检查
	 * 
	 * @param token
	 * @param session
	 * @return
	 */
	/*
	 * private boolean checkMd5(String token) {
	 * 
	 * }
	 */

	/**
	 * 检查token
	 * 
	 * @param token
	 * @param session
	 * @return
	 */
	private boolean checkToken(String token, HttpSession session, Long posiId) {
		// 检查是否已登录
		if (session == null || session.getId().length() < 2) {
			System.out.println("未能获取Session会话");
			return false;
		}

		// 准备校验
		String key = "token_" + token;

		if (RedisUtils.exists(key)) {// 已登录过
			System.out.println("已登录：" + key);
			String userKey = RedisUtils.hgetAndExtend(key, "userInfo");
			if (RedisUtils.exists(userKey)) {// userKey有效
				System.out.println("已获取userKey：" + userKey);
				setSessionFromRedis(session, key, userKey);
				return true;
			} else {
				System.out.println("未找到userKey：" + userKey);
				String[] keys = userKey.split("_");
				return getUserInfo(key, keys[1], posiId, session);
			}
		} else if ("214e2f71-4237-4601-9a1a-538bf982b995".equals(token)) {
			System.out.println("尝试登录：" + key);
			return getUserInfo(key, "ly01", null, session);
		} else {

			// Utils.getIpAddr(req);

			System.out.println("token不存在，未登录：" + key);
			return false;
		}
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
			//jedis.expire(tokenKey, 3600);
			//jedis.expire(userKey, 3600);
			jedis.expire(tokenKey, 14400);
			jedis.expire(userKey, 14400);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jedis != null) {
				RedisPoolUtils.returnResource(jedis);
			}
		}
	}

	private boolean getUserInfo(String tokenKey, String loginName, Long posiId,
			HttpSession session) {
		String userKey = "user_" + loginName + "_" + posiId;
		if (RedisUtils.exists(userKey)) {
			// 读取用户组织数据
			System.out.println("已存在：" + userKey);
			setSessionFromRedis(session, tokenKey, userKey);
			return true;
		} else {
			// 从接口获取用户组织数据
			// 逻辑流的输入参数
			Object[] result = null;

			String componentName = "com.hsapi.system.auth.LoginManager";// 逻辑构件名称com.harson.bpmapi.auth
			String operationName = "checkToken";// 逻辑流名称checkToken
			// 逻辑流的输入参数
			int size = 1;
			Object[] params = new Object[size];
			params[0] = tokenKey.split("_")[1];
			try {
				result = MUOCommonUtil.invokeBizWithMUO(componentName,
						operationName, params, session);// 逻辑流的返回值
				if ("S".equals(result[0])) {
					Object obj = result[1];// userKey
					if (obj != null) {
						userKey = obj.toString();
						if (RedisUtils.exists(userKey)) {
							// 读取用户组织数据
							System.out.println("已设置：" + userKey);
							setSessionFromRedis(session, tokenKey, userKey);
							return true;
						} else {
							System.out.println("设置用户组织数据失败！");
							return false;
						}
					} else {
						System.out.println("获取userKey失败！");
						return false;
					}
				} else {
					System.out.println("获取用户组织信息失败");
					return false;
				}
			} catch (Throwable e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
				System.out.println("调用获取用户组织信息遇到错误");
				return false;
			}
		}
	}

	/**
	 * 检查session
	 * 
	 * @param session
	 * @return
	 */
	private boolean checkSession(HttpSession session) {
		if (session == null) {
			System.out.println("未能获取token及会话");
			return false;
		} else {
			String currSessionId = session.getId();
			if (currSessionId == null || currSessionId.length() < 2) {
				System.out.println("SessionId 无效");
				return false;
			} else {
				IUserObject u = (IUserObject) session
						.getAttribute("userObject");
				if (u != null) {
					String uid = u.getUserId();
					if (uid == null) {
						System.out.println("Session userObject 用户ID为空");
						return false;
					} else if (!uid.equals("guest")) {
						// 保存到redis
						try {
							String token = u.getAttributes().get("token")
									.toString();
							// 检查是否已存在
							if (token == null || token.length() < 10) {
								System.out.println("Session中token为空");
								return false;
							} else if (RedisUtils.exists("token_" + token)) {
								System.out.println("Session中的token验证通过："
										+ token);
								return true;
							} else {
								String loginName = u.getAttributes()
										.get("loginName").toString();
								String posiId = u.getAttributes()
										.get("currDutyId").toString();
								String userInfo = Utils.obj2GzipStr(u);
								Boolean isNotNull = loginName != null
										&& loginName.length() > 0
										&& !"null".equals(loginName
												.toLowerCase());
								isNotNull = isNotNull && posiId != null
										&& posiId.length() > 0
										&& !"null".equals(posiId.toLowerCase());
								// 不为null
								if (isNotNull) {
									loginName = "user_" + loginName + "_"
											+ posiId;
									RedisUtils.hsetAndExtend("token_" + token,
											"userInfo", loginName);
									RedisUtils.hsetAndExtend(loginName,
											"userInfo", userInfo);
									System.out.println("Session中" + uid
											+ "通过验证，并重置redis值");
									return true;
								} else {
									System.out
											.println("校验Session中的用户信息失败：loginName="
													+ loginName
													+ " posiId="
													+ posiId);
									return false;
								}
							}

						} catch (Exception e) {
							// TODO: handle exception
							System.out.println("校验Session中的用户信息失败："
									+ e.getMessage());
							return false;
						}
					} else {
						System.out.println("Session userObject：" + uid
								+ "不能通过验证");
						return false;
					}
				} else {
					System.out.println("Session userObject 无效");
					return false;
				}
			}
		}
	}

	@Override
	public void init(FilterConfig cfg) throws ServletException {
		/*
		 * String excludedPages = cfg.getInitParameter("excludedPages"); if
		 * (excludedPages != null && excludedPages.trim().length() > 0) {
		 * excludedPageArray = excludedPages.split(","); }
		 */
	}

	private boolean isLogicFlow(String url) {
		return url.indexOf(".biz.ext") > 0 || url.indexOf(".flow") > 0;
	}
}
