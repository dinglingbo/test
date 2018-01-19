<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String busi_operation = ResourcesMessageUtil.getI18nResourceMessage("global_domain_resource_index.busi_operation");
String manual_task = ResourcesMessageUtil.getI18nResourceMessage("global_domain_resource_index.manual_task");
String work_calendar = ResourcesMessageUtil.getI18nResourceMessage("global_domain_resource_index.work_calendar");
%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-24 17:58:51
  - Description:
-->
<head>
<title>global_resource_index</title>
</head>
<body>
<w:tabPanel defaultTab="bizoptmgr" height="" id="global_resource" titleStyle="" width="">
  <w:tabPage cache="true" id="bizoptmgr" tabType="iframe" title="<%=busi_operation%>" url="com.primeton.bps.web.composer.bizresouce.GlobalBizOptMgr.flow"/>
  <w:tabPage cache="true" id="bizhtaskmgr" tabType="iframe" title="<%=manual_task%>" url="com.primeton.bps.web.composer.bizresouce.GlobalBizHTaskMgr.flow"/>
  <w:tabPage cache="true" id="bizcalendarmgr" tabType="iframe" title="<%=work_calendar%>" url="com.primeton.bps.web.composer.bizresouce.GlobalBizCalendarMgr.flow"/>
</w:tabPanel>
</body>
</html>