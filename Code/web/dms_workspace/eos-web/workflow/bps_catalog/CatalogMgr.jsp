<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<html>
<%-- 
  - Author(s): Administrator
  - Date: 2009-06-25 11:44:21
  - Description:
--%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CatalogMgr</title>
</head>
<frameset cols="200,*" border="1" name="catalogMain" id="framesetMain">
  <noframes><b:message key="secatalog_mgr_jsp.use_frames_browser "/></noframes><!-- 请使用提供FRAMES功能的浏览器 -->
  <frame src="com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=tree" name="catalogleft" id="catalogleft" frameborder="0" scrolling="no" marginheight="0" marginwidth="0">

  <frame src="com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=desc" name="catalogright" id="catalogright" scrolling="auto">
  <!--frame src="com.primeton.workflow.manager.def.getProcessPackages.flow" name="middle" id="middle" scrolling="auto"-->
</frameset>
</html>
