<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-22 15:47:35
  - Description:
-->
<head>
<title><b:message key="catalog_process_custom_tree_jsp.tree_title"/></title>
</head>
<frameset cols="200,*" border="1"  name="bizResMain" id="framesetMain">
  <noframes><b:message key="permission_common.noframes"/></noframes>
  <frame src="com.primeton.bps.web.composer.bizflowmgr.bizProcessConfigFrame.flow?_eosFlowAction=tree" name="left" id="left"   frameborder="0" scrolling="no" marginheight="0" marginwidth="0">
 
  <frame src="com.primeton.bps.web.composer.bizflowmgr.bizProcessConfigFrame.flow?_eosFlowAction=desc" name="right" id="right" scrolling="auto">
</frameset>
</html>