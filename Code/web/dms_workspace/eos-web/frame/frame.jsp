<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
String title = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("frame_jsp.title");
String contextPath = request.getContextPath();
%>
<title><%=title%></title>
<link rel="shortcut icon" href="<%=contextPath%>/favicon.ico" type="image/x-icon">
<frameset rows="*,26" cols="*" frameborder="no" border="0" framespacing="0">
	<frame src="com.primeton.bps.workspace.frame.permission.TopMenu.flow" name="topframe" scrolling="no" id="top" />
	<!--<frame name="main" id="main" src="com.primeton.bps.workspace.frame.permission.RootMenu.flow" scrolling="auto" />-->
	<frame src="<%=contextPath%>/frame/foot.jsp" name="footframe" scrolling="auto" id="foot" /> 
</frameset>