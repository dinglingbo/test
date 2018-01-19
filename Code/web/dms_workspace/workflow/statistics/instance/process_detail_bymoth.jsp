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
<title>
   <b:message key="workload_frame_jsp.workload_result"/>
</title>
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
		<td class="EOS_panel_head" valign="middle"><span id="path" style="float:right"></span><b:message key="process_result_jsp.tbHeader2"/></td><%-- 流程实例详细按月统计结果 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<form name="resultForm" action="" method="post">
             <h:hidden property="catalogID"/>
             <h:hidden property="startTime"/>
             <h:hidden property="endTime"/>
             <h:hidden property="catalogName"/>
             <h:hidden name="locale" property="locale" scope="session"/>
             
		<table border="0" class="EOS_table" width="100%">
			<%-- 条件 --%>
			<tr>
			    <th colspan="4" nowrap="nowrap"><b:write property="caption" /></th>				
			</tr>
			<tr>
				<th width="25%" nowrap="nowrap"><b:message key="process_result_jsp.month"/></th><!-- 月份 -->
				<th width="20%" nowrap="nowrap"><b:message key="process_result_jsp.startNum"/></th><!-- 启动 -->
				<th width="20%" nowrap="nowrap"><b:message key="process_result_jsp.finishNum"/></th><!-- 完成 -->
				<th width="20%" nowrap="nowrap"><b:message key="process_result_jsp.stopNum"/></th><!-- 已终止 -->

			</tr>
			<l:present property="resultList">
				<l:iterate id="item" property="resultList">
					<tr id="itemRow" name="itemRow" class="EOS_table_row">
						<td nowrap="nowrap"><b:write iterateId="item" property="timeName" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="startNum" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="finishNum" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="stopNum" /></td>
					</tr>
				</l:iterate>
			</l:present>
		</table>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
			<tr>
				<td align="right" nowrap="nowrap">
					<b:set name="action" value="com.primeton.bps.web.statistics.queryProcessInstance.flow?_eosFlowAction=queryProcessByID" />
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
		<td class="EOS_panel_head" valign="middle"><b:message key="process_result_jsp.chart2Header"/></td>
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
