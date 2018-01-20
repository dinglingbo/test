<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title><b:message key="main_jsp.title"/></title><!-- BPS管理监控端 -->
</head>

<frameset rows="73,*,25" frameborder="no" border="0" framespacing="0">
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/main/top.jsp" name="top" scrolling="auto"  noresize="noresize" id="top" title="topFrame" style="height: 72px;"/>
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/definition/index.jsp" name="contentWin" id="contentWin" title="mainFrame" />
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/main/bottom.jsp" name="rootPages" scrolling="no" noresize="noresize" id="rootPages" title="bottomFrame" />
</frameset>
<noframes><body>
</body>
</noframes></html>
