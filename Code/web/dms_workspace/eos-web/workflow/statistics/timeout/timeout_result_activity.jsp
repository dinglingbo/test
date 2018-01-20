<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/workflow/statistics/common/common.jsp"%>
<%
String ctxPath = request.getContextPath();
%>
<html>
<head>
<title><b:message key="workload_frame_jsp.workload_result"/></title>
<h:script src="/workflow/statistics/js/json/json2.js"></h:script>
<h:script src="/workflow/statistics/js/result-common.js"></h:script>

<script type="text/javascript">
	var isSucc=<b:write property="isSuccess" />
	
	var ctxPath='<%=ctxPath %>';
	var rcpath=ctxPath+'/workflow/statistics/js/result-common.js?'+new Date();
	document.write('<script type="text/javascript" src="'+rcpath+'"><\/script>');
	
	if(!isSucc){	
		var ec='<b:write property="errorCode" />';
		var em='<b:write property="errorMessage" />';
		alert(ec+':'+em);
	}
</script>
</head>
<body onLoad="initiFrame()" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
<table class="workarea" width="100%">
<tr>
<td width="40%"  valign="top">
<table class="workarea" width="100%">
	<tr>
		<td class="EOS_panel_head" valign="middle"><span id="path" style="float:right"></span>
		  <b:message key="timeout_result_jsp.tbHeader3"/></td><!-- 超时活动的详细信息 -->
	</tr>
	<tr>
		<td width="100%" valign="top">
		<form id="resultForm" name="resultForm" action="" method="post">
              <h:hidden property="processID"/>
              <h:hidden property="processName"/>
              <h:hidden property="startTime"/>
              <h:hidden property="endTime"/>
              <h:hidden property="isLeaf"/>	
              <h:hidden property="timeID"/>	
              <h:hidden name="locale" property="locale" scope="session"/>	
		<table border="0" class="EOS_table" width="100%">
			<%-- 条件 --%>
			<tr>
			    <th width="26%" nowrap="nowrap" rowspan="1"><b:message key="timeout_result_jsp.processInstanceName"/></th><!-- 流程实例名称 -->
				<th colspan="1" nowrap="nowrap"><b:message key="timeout_result_jsp.activityName"/></th><!-- 活动名称 -->
				<th colspan="1" nowrap="nowrap"><b:message key="timeout_result_jsp.participant"/></th><!-- 参与人 -->
				<th colspan="1" nowrap="nowrap"><b:message key="timeout_result_jsp.createDate"/></th><!-- 创建时间 -->
				<th colspan="1" nowrap="nowrap"><b:message key="timeout_result_jsp.timeout"/></th><!-- 超时时长(m) -->
			</tr>
			
			<l:present property="resultList">
				<l:iterate id="item" property="resultList">
					<tr id="itemRow" name="itemRow" class="EOS_table_row">
						<td nowrap="nowrap"><b:write iterateId="item" property="processName" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="instanceName" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="originator" /></td>
						<td nowrap="nowrap"><b:write iterateId="item" property="timeName" /></td>
						<td nowrap="nowrap">
						   <span title='<b:write iterateId="item" property="timeHour" />'> <!-- tip message -->
						   <b:write iterateId="item" property="timeoutNum" />
						</td>
					</tr>
				</l:iterate>
			</l:present>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
			<tr>
				<td align="left" nowrap="nowrap">
				<td align="right" nowrap="nowrap">
					<b:set name="action" value="com.primeton.bps.web.statistics.queryTimeout.flow?_eosFlowAction=queryOuttimeActivity" />
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

</tr>
</table>
</body>
</html>
<script>
</script>
