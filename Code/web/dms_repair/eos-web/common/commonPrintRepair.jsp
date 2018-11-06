
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/sysPrintCommon.jsp"%>

<script type="text/javascript">
	<% IMUODataContext muo = DataContextManager.current()
					.getMUODataContext();
			String currUserName = "";
			String currOrgid = "";
			String currOrgName = "";
			String currUserId = "";
			if (muo != null) {
				IUserObject userobject = muo.getUserObject();
				if (userobject != null) {
					//String ip = userobject.getUserRemoteIP();
					currUserName = userobject.getUserRealName();
					currOrgid = userobject.getUserOrgId();
					currOrgName = userobject.getUserOrgName();
					currUserId = userobject.getUserId();
				}
			}%>
	var currUserName =
		<%="'" + currUserName + "'"%>;
	var currOrgid =
		<%="'" + currOrgid + "'"%>;
	var currOrgName =
		<%="'" + currOrgName + "'"%>;
	var currentTimeMillis =
		<%=System.currentTimeMillis()%>;
	var currUserId =
		<%="'" + currUserId + "'"%>;
</script>
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
<script src="<%=webPath + contextPath%>/common/js/repairUtil.js?v=1.1.3" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/repairSvrUtil.js?v=3.0.13" type="text/javascript"></script>
