<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ page language="java" import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.IMUODataContext,com.eos.data.datacontext.UserObject,com.eos.data.datacontext.DataContextManager"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env"%>

<%
	//应用地址
	String contextPath=request.getContextPath();
	//api地址
	String apiPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort(); 
	//web地址
	String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();  
	
	String serverType = Env.getContributionConfig("system", "url", "api", "serverType");
	apiPath = Env.getContributionConfig("system", "url", "api", serverType) || apiPath;
	
	serverType = Env.getContributionConfig("system", "url", "web", "serverType");
	webPath = Env.getContributionConfig("system", "url", "web", serverType) || webPath;
	
	Cookie cookie = new Cookie("miniuiSkin", "bootstrap");
	// 设置Cookie的生命周期,如果设置为负值的话,关闭浏览器就失效.
	cookie.setMaxAge(-1);
	response.addCookie(cookie);
%>
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>
<% String currentLanguage = request.getLocale().getLanguage().toLowerCase();%>
<style>
    html, body
    {
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }
</style>

<script src="common/nui/nui.js" type="text/javascript"></script>
<script type="text/javascript" src="common/nui/locale/zh_CN.js"></script>
<script type="text/javascript">
	var contextPath = "<%=contextPath%>";
	var apiPath		= "<%=apiPath%>";
	var webPath		= "<%=webPath%>";
	
	$(function(){
		nui.context='<%=contextPath %>'
	})
	
	function backToLogin(){
		var url = window.location.pathname;
		for(var i=0;i<excludedFlows.length;i++){
			if(url && ''!=url
				&& -1!=url.lastIndexOf(excludedFlows[i])){//例外的不拦截
				return false;
			}
		}
		if(window.parent!=window
			&& ("function"==typeof window.parent.backToLogin)){//判断是否有父页面，有则调用父页面的方法		
			window.parent.backToLogin();
		}else{
		//	debugger;
			window.top.location.href = "com.vplus.login.timeout.flow";			
		}
	}
	<%
	HttpSession session = request.getSession(false);
	String token="";
	Map attr=new HashMap();
	if (session == null || session.getAttribute("userObject") == null) {
		%>backToLogin();<%
	}else{
		IUserObject u = (IUserObject) session.getAttribute("userObject");		
		if (u != null) {
			String orgId = u.getUserOrgId();
			try {
				attr = u.getAttributes();
				token = attr.get("token").toString();
			} catch (Exception e) {
			}
			if (orgId==null || orgId.trim().length()==0) {%>backToLogin();<%}
		}
	}
	%>
	
	var token = "<%=token %>";
</script>
