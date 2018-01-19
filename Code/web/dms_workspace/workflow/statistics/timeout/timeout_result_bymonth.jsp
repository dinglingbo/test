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
		   <b:message key="timeout_result_jsp.tbHeader1"/>
		</td>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<form id="resultForm" name="resultForm" action="" method="post">
             <h:hidden property="processID"/>
             <h:hidden property="processName"/>
             <h:hidden property="startTime"/>
             <h:hidden property="endTime"/>
             <h:hidden property="timeID"/>
             <h:hidden property="isLeaf"/>
             <h:hidden name="locale" property="locale" scope="session"/>

		
		<table border="0" class="EOS_table" width="100%">
			<tr>
			    <th nowrap="nowrap" colspan="7"><b:write property="caption" /></th>
			</tr>
			<tr>
			    <th width="10%" nowrap="nowrap" rowspan="2"><b:message key="timeout_result_jsp.month"/></th><!-- 月份 -->
				<th colspan="3" width="45%" nowrap="nowrap"><b:message key="timeout_result_jsp.processTimeoutStatistics"/></th><!-- 流程超时统计 -->
				<th colspan="3" width="45%" nowrap="nowrap"><b:message key="timeout_result_jsp.taskTimeoutStatistics"/></th><!-- 任务超时统计 -->
			</tr>
			<tr>
				<th nowrap="nowrap"><b:message key="timeout_result_jsp.finish"/></th>
				<th nowrap="nowrap"><b:message key="timeout_result_jsp.timeoutNum"/></th>
				<th nowrap="nowrap"><b:message key="timeout_result_jsp.timeoutRate"/></th>
				<th nowrap="nowrap"><b:message key="timeout_result_jsp.finish"/></th>
				<th nowrap="nowrap"><b:message key="timeout_result_jsp.timeoutNum"/></th>
				<th nowrap="nowrap"><b:message key="timeout_result_jsp.timeoutRate"/></th>
			</tr>
			<l:present property="resultList">
				<l:iterate id="item" property="resultList">
					<tr id="itemRow" name="itemRow" class="EOS_table_row">
						<td nowrap="nowrap"><b:write iterateId="item" property="timeName" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="processFinishNum" /></td>
						<td nowrap="nowrap">
						<l:notEqual iterateId="item" property="processTimeoutNum" targetValue="0">
						  <a href="#" onclick="return doQuery('queryOuttimeInstance',{processID:'<b:write iterateId="item" property="processID" />',processName:'<b:write iterateId="item" property="processName"/>',timeID:'<b:write iterateId="item" property="timeID"/>',isLeaf:'Y'});">
						    <b:write iterateId="item" property="processTimeoutNum" /></a>
						 </l:notEqual>  
						    <l:equal iterateId="item" property="processTimeoutNum" targetValue="0"> 
						     <b:write iterateId="item" property="processTimeoutNum" />
						 </l:equal> 
						</td>
						<td nowrap="nowrap"><b:write iterateId="item" property="processTimeoutRate" />%</td>
						<td nowrap="nowrap"><b:write iterateId="item" property="taskFinishNum" /></td>
						<td nowrap="nowrap">
						<l:notEqual iterateId="item" property="taskTimeoutNum" targetValue="0">
						  <a href="#" onclick="return doQuery('queryOuttimeActivity',{processID:'<b:write iterateId="item" property="processID" />',processName:'<b:write iterateId="item" property="processName"/>',timeID:'<b:write iterateId="item" property="timeID"/>',isLeaf:'Y'});">
						   <b:write iterateId="item" property="taskTimeoutNum" /></a>
						 </l:notEqual>  
						 <l:equal iterateId="item" property="taskTimeoutNum" targetValue="0">
						   <b:write iterateId="item" property="taskTimeoutNum" />
						 </l:equal>
						</td>
						<td nowrap="nowrap"><b:write iterateId="item" property="taskTimeoutRate" />%</td>
					</tr>
				</l:iterate>
			</l:present>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
			<tr>
				<td align="left" nowrap="nowrap">
				<td align="right" nowrap="nowrap">
					<b:set name="action" value="com.primeton.bps.web.statistics.queryTimeout.flow?_eosFlowAction=queryByProcessID" />
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
		<td class="EOS_panel_head" valign="middle"><b:message key="timeout_result_jsp.chart3Header"/></td><%-- 统计图表 --%>
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
