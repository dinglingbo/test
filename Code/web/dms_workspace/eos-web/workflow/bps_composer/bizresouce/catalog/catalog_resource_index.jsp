<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String busi_operation = ResourcesMessageUtil.getI18nResourceMessage("global_domain_resource_index.busi_operation");
String manual_task = ResourcesMessageUtil.getI18nResourceMessage("global_domain_resource_index.manual_task");
String busi_var = ResourcesMessageUtil.getI18nResourceMessage("global_domain_resource_index.busi_var");
String busi_rules = ResourcesMessageUtil.getI18nResourceMessage("global_domain_resource_index.busi_rules");
%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-24 18:00:03
  - Description:
-->
<head>
<title>catalog_resource_index</title>
</head>
<body>
<w:tabPanel bodyStyle="" defaultTab="bizoptmgr" height="" id="catalog_resource" titleStyle="" width="">
  <w:tabPage cache="true" id="bizoptmgr" tabType="iframe" title="<%=busi_operation%>" url="com.primeton.bps.web.composer.bizresouce.CatalogBizOptMgr.flow">
  	<h:param property="cid"/>
  	<h:param property="permType" name="pType"/>
  </w:tabPage>
  <w:tabPage cache="true" id="bizhtaskmgr" tabType="iframe" title="<%=manual_task%>" url="com.primeton.bps.web.composer.bizresouce.CatalogBizHTaskMgr.flow">
  	<h:param property="cid"/>
  	<h:param property="permType" name="pType"/>
  </w:tabPage>
  <w:tabPage cache="true" id="bizvarmgr" tabType="iframe" title="<%=busi_var%>" url="com.primeton.bps.web.composer.bizresouce.CatalogBizVarMgr.flow">
	<h:param property="cid"/>
	<h:param property="permType" name="pType"/>
  </w:tabPage>
  <w:tabPage cache="true" id="bizrulemgr" tabType="iframe" title="<%=busi_rules%>" url="com.primeton.bps.web.composer.bizresouce.CatalogBizRuleMgr.flow">
	<h:param property="cid"/>
	<h:param property="permType" name="pType"/>
  </w:tabPage>
</w:tabPanel>
</body>
</html>