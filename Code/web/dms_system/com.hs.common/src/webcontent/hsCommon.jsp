<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ page language="java" import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.IMUODataContext,com.eos.data.datacontext.UserObject,com.eos.data.datacontext.DataContextManager"%>
<%@page import="java.util.HashMap,java.util.Map"%>

<%
	Cookie cookie = new Cookie("miniuiSkin", "bootstrap");
	// 设置Cookie的生命周期,如果设置为负值的话,关闭浏览器就失效.
	cookie.setMaxAge(-1);
	response.addCookie(cookie);
%>
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://eos.sie.com/tags/i18n"  prefix="i18n"%>
<% String currentLanguage = request.getLocale().getLanguage().toLowerCase();%>
<style>
    html, body
    {
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }
</style>

<script src="common/nui/nui.js" type="text/javascript"></script>
<script type="text/javascript" src="common/nui/locale/zh_CN.js"></script>
<%-- <link href="css/style.css" rel="stylesheet" type="text/css" /> --%>

<script type="text/javascript">
	/* 配置不拦截的逻辑流路径 */
	var excludedFlows = ['com.ybt.develope.sqleditor.flow'];
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
	Object s_tmp_obj;
	String token = "";
	Map atrr = new HashMap();
	IMUODataContext muoobj = DataContextManager.current().getMUODataContext();
	if(muoobj!=null){
		UserObject uo = (UserObject) muoobj.getUserObject();
	    if(uo!=null){
			atrr = uo.getAttributes();
			s_tmp_obj = atrr.get("token");
			if(s_tmp_obj!=null)
			token = s_tmp_obj.toString();
	    }
	}
	
	
	HttpSession session = request.getSession(false);
	if (session == null || session.getAttribute("userObject") == null) {
		%>backToLogin();<%
	}else{
		IUserObject u = (IUserObject) session.getAttribute("userObject");
		if (u != null) {
			String orgId = u.getUserOrgId();
			if (orgId==null || orgId.trim().length()==0) {%>backToLogin();<%}
		}
	}
	%>
	/* 5分钟定时判断是否登录超时 */
	timer();
	function timer(){
		$.ajax({
			url: "com.vplus.login.svr.isTimeOut.biz.ext",
			type: "POST",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify({}),
			success: function(data)
			{
				if('E' == data.errCode){
					backToLogin();
				}
			},
			error: function (jqXHR, textStatus, errorThrown)
			{
				
			}
		});
		setTimeout("timer()",300000);
	}
</script>
