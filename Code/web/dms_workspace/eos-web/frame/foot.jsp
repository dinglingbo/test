<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<%
String contextPath = request.getContextPath();
%>
<style type="text/css">
	html{
		overflow: hidden;
	}
</style>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%"  cellspacing="0" cellpadding="0" border="0">
  <tr>
    <td height="25" background="<%=contextPath%>/images/bottom_bg.gif" align="center">(c) Copyright Primeton 2011. All Rights Reserved. <%=com.primeton.ext.common.l7e.ImprimaturMgr.getImprimatur().getEditionInfo(com.eos.data.datacontext.DataContextManager.current().getCurrentLocale())%></td>
  </tr>
</table> 
</BODY>