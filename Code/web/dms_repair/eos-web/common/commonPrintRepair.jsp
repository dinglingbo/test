
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/sysPrintCommon.jsp"%>

<script type="text/javascript">
	function getRoot() {
		var hostname = location.hostname;
		var pathname = location.pathname;
		var contextPath = pathname.split("/")[1];
		var port = location.port;
		var protocol = location.protocol;
		return protocol + "//" + hostname + ":" + port + "/" + contextPath +
			"/";
	}

	//window._rootUrl = getRoot();
	window._rootRepairUrl = apiPath + repairApi + "/";
	window._rootPartUrl = apiPath + partApi + "/";
	window._rootSysUrl = apiPath + sysApi + "/";
	window._rootCrmUrl = apiPath + crmApi + "/";
	window._rootFrmUrl = apiPath + frmApi + "/";

	window._rootUrl = window._rootRepairUrl;

	window._webCrmUrl = webPath + contextPath + "/";
	window._webRepairUrl = webPath + contextPath + "/";
	//console.log(window._rootUrl);
</script>
<script src="<%=webPath + contextPath%>/common/js/repairUtil.js?v=3.1.7" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/repairSvrUtil.js?v=4.1.18" type="text/javascript"></script>
