<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.primeton.workflow.governor.ProductInstallManager"%>
<html>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><b:message key="top_jsp.title"/></title><!-- 工作流管理监控端工具 -->

<script>
/**
*全局缓存变量，请勿修改或删除！！！
*该缓存变量保存流程图信息及各图元信息
*2008-5-7 guoxiong
*/
	var prcDataCatchPool = [] ;
</script>
	
<script>
    
    var cacheMgr = new FastDataCatchMgr ();
	cacheMgr.create("preChangedId","processdefmgr") ;
	
	function redirectLocation(id) {
	    preChangedId = cacheMgr.get("preChangedId") ;
	    
	    if(preChangedId != null && preChangedId !=id) {
	    //FIXME:document.getElementById --> $id
	    	
	    	$id(preChangedId).style.color="#00414E" ;
	    }
	    cacheMgr.set("preChangedId",id);
		$id(id).style.color="red" ;
		
		urlPath = "<%=request.getContextPath()%>" ;
		if(id == "processdefmgr") {
			urlPath+="/workflow/wfmanager/definition/index.jsp" ;
		} else if(id == "processinstmgr") {
			urlPath+="/workflow/wfmanager/instance/index.jsp" ;
		} else if(id == "agent") {
			urlPath+="/workflow/wfmanager/agent/index_agent.jsp" ;
		} else if(id == "delegate") {
			urlPath+="/workflow/wfmanager/delegate/delegateMgr.jsp" ;
		} else if(id == "handover") {
			urlPath+="/workflow/wfmanager/handover/handover_select_person.jsp" ;
		} else if(id == "queryinstance") {
			urlPath+="/workflow/wfmanager/query/query_instance.jsp" ;
		} else if(id == "auditlog") {
			urlPath+="/workflow/wfmanager/query/query_auditlog.jsp" ;
		} else if(id == "exception") {
			urlPath+="/workflow/wfmanager/supervision/query_exception_activity.jsp" ;
		} else if(id=="history"){
			urlPath+="/workflow/wfmanager/tranhistory/com.primeton.workflow.manager.tranhistory.queryTranHistoryStatus.flow" ;
			
		} else if(id=="governor"){
			urlPath+="/workflow/wfmanager/governor/wfconfig.jsp" ;
		}
		
		parent.frames['contentWin'].location=urlPath; 
	}
	
	function init() {
		initId = cacheMgr.get("preChangedId") ;
	    if(initId != null) 
	    //FIXME:document.getElementById --> $id
	    	$id(initId).style.color="red" ;
	}
</script>
</head>

<body style="height:100%;width:100%;overflow: hidden;overflow-y:auto;" leftmargin="0" rightmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td width="772" height="50" style="background:url('../images/BPSManager.jpg') no-repeat;"></td>
	<td valign="bottom" nowrap="nowrap" align="center" background="<%=request.getContextPath()%>/workflow/wfmanager/images/Banner_bg.gif">
	<font style="font-size:9pt; color:#FFFFFF">
		<b:message key="top_jsp.currentAccount"/><b:write property='<%=IUserObject.KEY_IN_CONTEXT+"/userId"%>' scope="session"/>&nbsp;|&nbsp;<!-- 当前登录帐号: -->
		<a href='<%=request.getContextPath()+"/workflow/wfmanager/main/logout.jsp" %>' target="_top" style="text-decoration:none; color:#ffffff"><b:message key="top_jsp.logout"/></a>&nbsp;<!-- 注销 -->
	</font>
	</td>
	</tr>
	<tr>
		<td valign="middle" style="table-layout:fixed"  colspan="2" height="22" background="<%=request.getContextPath()%>/workflow/wfmanager/images/MenuBg.gif">
				<a id="processdefmgr" href="javascript:redirectLocation('processdefmgr');"  style="text-decoration:none; color:#00414E">&nbsp;&nbsp;<b:message key="top_jsp.bizProcessManage"/></a><!-- 业务流程管理 -->
				&nbsp;|&nbsp;
				<a id="processinstmgr" href="javascript:redirectLocation('processinstmgr');" style="text-decoration:none; color:#00414E"><b:message key="top_jsp.ProcInstanceManage"/></a><!-- 流程实例管理 -->
				&nbsp;|&nbsp;
				<a id="agent" href="javascript:redirectLocation('agent');" style="text-decoration:none; color:#00414E"><b:message key="top_jsp.agentManage"/></a><!-- 代理管理 -->
				&nbsp;|&nbsp;
				<a id="delegate" href="javascript:redirectLocation('delegate');" style="text-decoration:none; color:#00414E"><b:message key="top_jsp.delegateManage"/></a><!-- 代办管理 -->
				&nbsp;|&nbsp;
				<a id="handover" href="javascript:redirectLocation('handover');" style="text-decoration:none; color:#00414E"><b:message key="top_jsp.workHandover"/></a><!-- 工作交接 -->
				&nbsp;|&nbsp;
				<a id="queryinstance" href="javascript:redirectLocation('queryinstance');"  style="text-decoration:none; color:#00414E"><b:message key="top_jsp.advanceQuery"/></a><!-- 高级查询 -->
				&nbsp;|&nbsp;
				<a id="auditlog" href="javascript:redirectLocation('auditlog');"  style="text-decoration:none; color:#00414E"><b:message key="top_jsp.auditMonitor"/></a><!-- 审计监控 -->
				&nbsp;|&nbsp;
				<a id="exception" href="javascript:redirectLocation('exception');"  style="text-decoration:none; color:#00414E"><b:message key="top_jsp.exceptionMonitor"/></a><!-- 异常监控 -->
				&nbsp;|&nbsp;
				<a id="history" href="javascript:redirectLocation('history');"  style="text-decoration:none; color:#00414E"><b:message key="top_jsp.hisDataTransfer"/></a><!-- 历史数据转移 -->
				<% if(ProductInstallManager.isEmbedded()){  %>
				&nbsp;|&nbsp;
				<a id="governor" href="javascript:redirectLocation('governor');"  style="text-decoration:none; color:#00414E"><b:message key="top_jsp.confManage"/></a><!-- 配置管理 -->
				<%} %>
		</td>
	</tr>
</table>
</body>
</html>
 