<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/workflow/statistics/common/common.jsp"%>
<%
String ctxPath = request.getContextPath();
String jsonData = (String)request.getAttribute("jsonData");
jsonData = URLDecoder.decode(jsonData, "UTF-8");
%>

<html>
<head>
<title><b:message key="workload_frame_jsp.workload_result"/></title>
<h:script src="/workflow/statistics/js/swfobject.js"></h:script>
<h:script src="/workflow/statistics/js/json/json2.js"></h:script>

<script type="text/javascript">
	var default_data = <%=jsonData %>;
	var ctxPath='<%=ctxPath %>';
	/*var isSucc=<b:write property="isSuccess" />*/
	var rcpath=ctxPath+'/workflow/statistics/js/result-common.js?'+new Date();
	document.write('<script type="text/javascript" src="'+rcpath+'"><\/script>');
	
	/*
	if(!isSucc){	
		var ec='<b:write property="errorCode" />';
		var em='<b:write property="errorMessage" />';
		alert(ec+':'+em);
	}
	*/

</script>
<h:script src="/workflow/statistics/js/result-common.js"></h:script>
<link href="../css/result_common.css" rel="stylesheet" type="text/css" />
</head>
<body onLoad="initiFrame()" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
<table class="workarea" width="100%">
<tr>
<td valign="top" id="left_area">
<table class="workarea" width="100%">
	<tr>
		<td class="EOS_panel_head" valign="middle"><span id="path" style="float:right;"><b:message key="version_result_jsp.version_result"/></td><%-- 版本统计 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<form name="resultForm" action="com.primeton.bps.web.statistics.queryVersion.flow" method="post">
		      <h:hidden name="processName" property="processName" />
              <h:hidden name="catalogID" property="catalogID" />
              <h:hidden name="locale" property="locale" scope="session"/>
		<table border="0" class="EOS_table" width="100%">
			<tr>
				<th colspan="6" width="20%" nowrap="nowrap"><b:message key="version_result_jsp.version_result"/></th><%-- 版本统计 --%>
			</tr>
			<tr>
				<th width="35%" nowrap="nowrap"><b:message key="version_result_jsp.process_define"/></th><%-- 组织名称 --%>
				<th width="10%" nowrap="nowrap"><b:message key="version_result_jsp.version_count"/></th><%-- 版本小计 --%>
				<th width="10%" nowrap="nowrap"><b:message key="version_result_jsp.version_changerate"/></th><%-- 版本变化率 --%>
				<th width="10%" nowrap="nowrap"><b:message key="version_result_jsp.version_current"/></th><%-- 当前版本号 --%>
				<th width="15%" nowrap="nowrap"><b:message key="version_result_jsp.version_currentcreate"/></th><%-- 当前版本创建时间 --%>
				<th width="15%" nowrap="nowrap"><b:message key="version_result_jsp.Version_firsttime"/></th><%-- 第一个版本创建时间 --%>
			</tr>
			<l:present property="versionList">
				<l:iterate id="item" property="versionList">
					<tr id="itemRow" name="itemRow" class="EOS_table_row" >
						<td nowrap="nowrap">
						<span title='<b:write iterateId="item" property="processDefName" />'><b:write iterateId="item" property="processDefName" maxLength="50"/></span></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="versionCount" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="versionRate" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="currentVersion" /></td>						
						<td nowrap="nowrap"><b:write iterateId="item" formatPattern="yyyy-MM-dd" property="currentCreateTime" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" formatPattern="yyyy-MM-dd" property="firstCreateTime" /></td>						
					</tr>
				</l:iterate>
				<l:equal  property="isSuccess" targetValue="false">
				<td nowrap="nowrap" colspan="6"><span style="color: #ff0000;"><b:message key="version_result_jsp.query_not_found"/></<span></span></td><!-- 未查到符合条件的流程 -->
				</l:equal>
			</l:present>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
			<tr>
				<td align="right" nowrap="nowrap">
					<b:set name="action" value="com.primeton.bps.web.statistics.queryVersion.flow?_eosFlowAction=query" />
					<b:set name="target" value="_self" /> 					
					<%@ include	file="/workflow/wfcomponent/web/common/pagination.jsp"%>

				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</table>
</td>
<td valign="middle" id="middle_area" nowrap="nowrap">
   <input type="button" value="" id="leftBtn" onclick="switchChartTable('left');">
   <input type="button" value="" id="rightBtn" onclick="switchChartTable();">
</td>
<td valign="top" id="right_area">
<table class="workarea" width="100%">
	<tr>
		<td class="EOS_panel_head" valign="middle"><b:message key="version_result_jsp.version_chart"/></td><%-- 工作量统计图表 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
						<div id="chart"></div>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
</body>
</html>
<script>
</script>
