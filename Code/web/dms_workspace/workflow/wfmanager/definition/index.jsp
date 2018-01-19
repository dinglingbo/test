<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><b:message key="index_jsp2.title"/></title><!-- 业务流程调整 -->
</head>
<frameset cols="200,*" border="1" name="middleMain" id="middleMain">
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/main/left.jsp" name="left" id="left" frameborder="0" scrolling="no" marginheight="0" marginwidth="0">
 
  <frame src="com.primeton.workflow.manager.def.getProcessCatalogsWithCount.flow" name="middle" id="middle" scrolling="auto">
</frameset>
<noframes>
<body>
<b:message key="index_jsp2.browser "/><!-- 请使用支持框架的浏览器 -->
</body>
</noframes>
</html>
