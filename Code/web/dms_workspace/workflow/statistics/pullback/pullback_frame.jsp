<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/workflow/statistics/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String pullBackStatistics = ResourcesMessageUtil.getI18nResourceMessage("pullback_frame_jsp.pullback_statistics");
 %>
<b:set name="title1" value="<%=pullBackStatistics %>"/><!-- 退回统计 -->
<%@ include file="/workflow/statistics/common/head.jsp"%>
	<iframe id="versionFrame" name="versionFrame" width="100%" marginHeight="0" 
		frameBorder="0" marginWidth="0"  
		src="<%=request.getContextPath() %>/workflow/statistics/pullback/pullback_query.jsp" 
		frameborder="0" scrolling="no"></iframe>
<form name="hiddenForm" id="hiddenForm" action="" method="post">
</form>
<%@ include file="/workflow/statistics/common/tail.jsp"%>