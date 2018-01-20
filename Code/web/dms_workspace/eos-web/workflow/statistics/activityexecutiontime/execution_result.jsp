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
		<td class="EOS_panel_head" valign="middle"><span id="path" style="float:right"></span>
		  <b:message key="activityexecutiontime_result_jsp.tbHeader1"/></td><!-- 活动执行时效分析 -->
	</tr>
	
	<tr>
		<td width="100%" valign="top">
		<form name="resultForm" action="" method="post">
             <h:hidden property="processID"/>
             <h:hidden property="processName"/>
             <h:hidden property="procVersionID"/>
             <h:hidden property="procVersionName"/>
             <h:hidden property="startTime"/>
             <h:hidden property="endTime"/>
             <h:hidden name="locale" property="locale" scope="session"/>
		
		<table border="0" class="EOS_table" width="100%">
			<tr>
		        <th colspan="4" nowrap="nowrap"><b:write property="caption" /></th>
	        </tr>
			<tr>
				<th width="40%" nowrap="nowrap" rowspan="2"><b:message key="executiontime_result_jsp.processDisplayName"/></th><!-- 流程显示名称 -->
				<th width="60%" nowrap="nowrap" colspan="3"><b:message key="executiontime_result_jsp.time"/></th><!-- 时间(分钟) -->
			</tr>
			<tr>
				<th nowrap="nowrap"><b:message key="executiontime_result_jsp.avgTime"/></th><!-- 平均执行时间 -->
				<th nowrap="nowrap"><b:message key="executiontime_result_jsp.minTime"/></th><!-- 最短执行时间 -->
				<th nowrap="nowrap"><b:message key="executiontime_result_jsp.maxTime"/></th><!-- 最长执行时间 -->

			</tr>
			<l:present property="resultList">
				<l:iterate id="item" property="resultList">
					<tr id="itemRow" name="itemRow" class="EOS_table_row">
						<td nowrap="nowrap">
						   <span title='<b:write iterateId="item" property="activityName" />'>
						   <a href="#" onclick="return doQuery('queryByVersion',{procVersionID:'<b:write iterateId="item" property="activityID" />', procVersionName:'<b:write iterateId="item" property="activityName" />'});"><b:write iterateId="item" property="activityName" maxLength="40" /></a>
						</td>
						<td nowrap="nowrap">
						   <span title='<b:write iterateId="item" property="avgHour" />'>
						   <b:write iterateId="item" property="avgTime" />
						</td>
						<td nowrap="nowrap">
						   <span title='<b:write iterateId="item" property="minHour" />'>
						   <b:write iterateId="item" property="minTime" />
					    </td>
						<td nowrap="nowrap">
						   <span title='<b:write iterateId="item" property="maxHour" />'>
						   <b:write iterateId="item" property="maxTime" />
						</td>
					</tr>
				</l:iterate>
			</l:present>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
			<tr>
				<td align="left" nowrap="nowrap">
				<td align="right" nowrap="nowrap">
					<b:set name="action" value="com.primeton.bps.web.statistics.queryActivityExecutionTime.flow?_eosFlowAction=query" />
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
		<td class="EOS_panel_head" valign="middle"><b:message key="activityexecutiontime_result_jsp.chartHeader1"/></td><!-- 活动执行时效分析图表 --></td>
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
