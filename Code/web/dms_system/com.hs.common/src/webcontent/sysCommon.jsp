<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ page language="java" import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.IMUODataContext,com.eos.data.datacontext.UserObject,com.eos.data.datacontext.DataContextManager"%>
<%@page import="java.util.HashMap,java.util.Map"%>

<%
	//应用地址
	String contextPath=request.getContextPath();
	//api地址
	String apiPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
	//web地址
	String webPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	
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
<script type="text/javascript">
	var contextPath = "<%=contextPath%>";
	var apiPath		= "<%=apiPath%>";
	var webPath		= "<%=webPath%>";
	var token		= "";
</script>
