<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%> 
  <%@include file="/common/sysCommon.jsp"%>
<link href="<%=webPath + contextPath %>/common/nui/res/fonts/font-awesome/css/font-awesome.min.css?v=1.0.0" rel="stylesheet">

<script type="text/javascript">
	var currentTimeMillis =
<%=System.currentTimeMillis()%>
	;
</script>
	<script type="text/javascript">
	function getRoot() {
		var hostname = location.hostname;
		var pathname = location.pathname;
		var contextPath = pathname.split("/")[1];
		var port = location.port;
		var protocol = location.protocol;
		return protocol + "//" + hostname + ":" + port + "/" + contextPath
		+ "/";
	}

	//window._rootUrl = getRoot();
	window._rootRepairUrl = apiPath + repairApi + "/";
	window._rootPartUrl = apiPath + partApi + "/";
	window._rootSysUrl = apiPath + sysApi + "/";
	window._rootCrmUrl = apiPath + crmApi + "/";
	window._rootFrmUrl = apiPath + frmApi + "/";

	window._rootUrl = window._rootPartUrl;

	window._webCrmUrl = webPath + crmDomain + "/";
	window._webRepairUrl = webPath + contextPath + "/";
	//console.log(window._rootUrl);
	</script>
<script src="<%=request.getContextPath()%>/common/js/partUtil.js?v=1.1.3" type="text/javascript"></script>
<%-- <link href="<%=webPath + contextPath%>/common/nui/themes/bootstrap/skin.css" rel="stylesheet"	type="text/css" />  --%>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

table {
	font-size: 12px;
}
</style>