<%@page import="java.util.Locale"%>
<%@page import="com.eos.access.http.LocaleHelper"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.eos.data.datacontext.ISessionMap"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.access.http.security.config.HttpSecurityConfig"%>
<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.gocom.bps.wfclient.login.Validate4Login"%>
<%@page import="com.eos.system.utility.StringUtil"%>
<%@page import="com.eos.system.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String url=contextPath + "/bps/wfclient/login/login.jsp";
	String domainID=request.getParameter("domainID");
	String userName=request.getParameter("userName");
	String pwd=request.getParameter("password");
	String language=request.getParameter("language");
	//用户名为空认为用户直接访问此页面；直接返回登录页面
	if(StringUtils.isEmpty(userName)){
		if(StringUtils.isNotBlank(language)){
			url +="?language="+language;
		}
		response.sendRedirect(url);
		return;
	}
	if(domainID.equals(I18nUtil.getMessage(request, "bps.wfclient.login.DomainID"))){
		domainID=null;
	}
	
	IUserObject userObject = null;
	ISessionMap sessionMap = DataContextManager.current().getSessionCtx();
	if (sessionMap != null) {
		userObject = sessionMap.getUserObject();
	}
	if (userObject == null) {
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		if (muo != null) {
			userObject = muo.getUserObject();
		}
	}
	
	int result=Validate4Login.validate4Login((UserObject)userObject, userName, pwd, domainID, language);
	if(result==1){
		url=contextPath + "/bps/wfclient/common/index.jsp";
		if(StringUtil.isNotNullAndBlank(language)){
			url = url + "?language="+language;
		}
		Locale locale = null;
		if (StringUtils.equals("zh", language)) {
			locale = new Locale("zh", "CN");
		}
		if (StringUtils.equals("en", language)) {
			locale = new Locale("en", "US");
		}
		session.setAttribute(LocaleHelper.LOCALE_ATTRIBUTE_NAME, locale);
		session.setAttribute(IUserObject.KEY_IN_CONTEXT, userObject);
	}else{
		url=contextPath + "/bps/wfclient/login/login.jsp?loginfail=true";
		if(StringUtil.isNotNullAndBlank(language)){
			url = url + "&language="+language;
		}
	}
	
	HttpSecurityConfig securityConfig = HttpSecurityConfig.INSTANCE;
   	boolean isOpenSecurity = securityConfig.isOpenSecurity();
   	if(isOpenSecurity){
   		boolean isAllInHttps = securityConfig.isAllInHttps();
   		if(!isAllInHttps){
   			String ip = securityConfig.getHost();
   			String http_port = securityConfig.getHttp_port();
   			url = "http://" + ip + ":" + http_port + url;
			String serverType = HttpSecurityConfig.INSTANCE.getServerType();
			if(!(StringUtils.equals(serverType, Constants.SERVER_TYPE_WEBLOGIC) || 
				StringUtils.equals(serverType, Constants.SERVER_TYPE_WEBSPHERE))){
				String sessionID = session.getId();
				Cookie cookie = new Cookie("JSESSIONID", sessionID);
				cookie.setPath(contextPath);
				response.addCookie(cookie);
	   		}
		}
   	}
	response.sendRedirect(url);
 %>
