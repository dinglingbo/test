<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/workflow/statistics/common/common.jsp"%>
<%
String ctxPath = request.getContextPath();
String jsonData = (String) request.getAttribute("jsonData");
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
	var isSucc=<b:write property="isSuccess" />
	
	var rcpath=ctxPath+'/workflow/statistics/js/result-common.js?'+new Date();
	document.write('<script type="text/javascript" src="'+rcpath+'"><\/script>');
	
	if(!isSucc){	
		var ec='<b:write property="errorCode" />';
		var em='<b:write property="errorMessage" />';
		alert(ec+':'+em);
	}
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
		<td class="EOS_panel_head" valign="middle"><b:message key="pullback_frame_jsp.tbHeader1"/><span id="path" style="float:right;"></td><%-- 退回统计结果 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<form id="resultForm" name="resultForm" action="" method="post">
             <h:hidden property="processName"/>
             <h:hidden property="processID" />
             <h:hidden property="startTime"/>
             <h:hidden property="endTime"/>
             <h:hidden name="locale" property="locale" scope="session"/>
		
		<table border="0" class="EOS_table" width="100%">
			<%-- 条件 --%>
			<tr>
				<th colspan="4" nowrap="nowrap" align="center"><b:write property="caption" /></th>
			</tr>
			<tr>
				<th width="20%" nowrap="nowrap" rowspan="2"><b:message key="pullback_frame_jsp.processDisplayName"/></th><!-- 流程显示名称 -->
				<th width="20%" nowrap="nowrap" rowspan="2"><b:message key="pullback_frame_jsp.createTimes"/></th><!-- 发起次数 -->
				<th width="20%" nowrap="nowrap" colspan="2"><b:message key="pullback_frame_jsp.pullBack"/></th><!-- 退回统计 -->
				</tr>
				<tr>
				<th width="20%" nowrap="nowrap"><b:message key="pullback_frame_jsp.backTimes"/></th><!-- 退回次数 -->
				<th width="20%" nowrap="nowrap"><b:message key="pullback_frame_jsp.backRate"/></th><!-- 退回率 -->
			</tr>
			<l:present property="resultList">
				<l:iterate id="item" property="resultList">
					<tr id="itemRow" name="itemRow" class="EOS_table_row">
						<td nowrap="nowrap">
						  <span title='<b:write iterateId="item" property="procVersionName" />'>
						  <a href="#" onclick="return doQuery('QueryActivity',{processID:<b:write iterateId="item" property="procVersionID"/>,processName:'<b:write iterateId="item" property="procVersionName"/>'});"><b:write iterateId="item" property="procVersionName" maxLength="40" /></a></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="totalTimes" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="giveBackTimes" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="giveBackRate" />%</td>
					</tr>
				</l:iterate>
			</l:present>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
			<tr>
				<td align="left" nowrap="nowrap">
				<td align="right" nowrap="nowrap">
					<b:set name="action" value="com.primeton.bps.web.statistics.queryPullBack.flow?_eosFlowAction=query" />
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
		<td class="EOS_panel_head" valign="middle"><b:message key="pullback_frame_jsp.chart1Header"/></td>
	</tr>
	<tr>
		<td width="100%">
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
