<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><b:message key="agent_scope_frame_jsp.agent_scope"/></title><%-- 代理范围 --%>
</head>
<frameset cols="200,10,*" frameborder="no" border="0" framespacing="0" name="middleMain" id="middleMain">
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/agent/left.jsp" name="left" id="left" noresize="noresize" frameborder="0" scrolling="no" marginheight="0" marginwidth="0">
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/main/left_1.jsp" name="left_1" id="left_1" noresize="noresize" scrolling="no"/>
  <frame src="<%=request.getContextPath() %>/workflow/wfmanager/agent/mgr_agentscope.jsp" name="middle" id="middle" scrolling="auto" width="100%" height="100%" marginheight="0" marginwidth="0" align="top" frameborder="0">
</frameset>
<noframes>
<body>
<b:message key="agent_scope_frame_jsp.browser_condition"/>
</body><%-- 请使用支持框架的浏览器 --%>
</noframes>
</html>