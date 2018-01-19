<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/workflow/statistics/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String instanceStatistics = ResourcesMessageUtil.getI18nResourceMessage("process_frame_jsp.instance_statistics");
 %>
<b:set name="title1" value="<%=instanceStatistics %>"/><!-- 实例执行时效统计 -->
<%@ include file="/workflow/statistics/common/head.jsp"%>

	<iframe id="workloadFrame" name="workloadFrame" width="100%" marginHeight="0" 
		frameBorder="0" marginWidth="0"  
		src="<%=request.getContextPath() %>/workflow/statistics/instance/process_query.jsp" 
		frameborder="0" scrolling="no"></iframe>
<form name="hiddenForm" id="hiddenForm" action="" method="post">
</form>
<%@ include file="/workflow/statistics/common/tail.jsp"%>