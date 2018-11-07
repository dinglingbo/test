<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<script language="javascript">
	
	/*检查是否选择的一条记录*/
	function validate(actionName){
		var length = 0;		
		if(document.forms['activityInstList'].elements['activityInstID'] != null)
			length = document.forms['activityInstList'].elements['activityInstID'].length;
		
		for(i = 0; i < length; i++){
			if(document.forms['activityInstList'].elements['activityInstID'][i].checked)
				return isAllowDone(actionName,document.forms['activityInstList'].elements['activityInstID'][i].value);
		}
		
		alert('<b:message key="all_activity_list_jsp.select_acttivity_inst_record"/>');//请先选择一条活动实例记录
		return;
	}
	
	/*用Ajax提交验证活动状态*/
	function isAllowDone(actionName,values){
		//验证活动状态
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.getActivityInstState.biz');
		hs.addParam('activityInstID',values);
		if(actionName == 'btTerminate'){
			hs.submit();
			var currentState = hs.getProperty('currentState');

			if(currentState != 2){
				alert('<b:message key="all_activity_list_jsp.running_canbe_terminate"/>');//只有运行状态下的活动才能被终止
				return false;
			}
		}else if(actionName == 'btRollBack'){
			hs.submit();
			var currentState = hs.getProperty('currentState');

			if(currentState != 2){
				alert('<b:message key="all_activity_list_jsp.running_canbe_roll_back"/>');//只有运行状态下的活动才能被回退
				return false;
			}
		}
		return values;
	}
	
	/*提交actionName指定的操作*/
	function doSubmit(actionName){
		var value = validate(actionName);
		if(value){
			if(actionName == 'btTerminate')
				doTerminateAction();
			else if(actionName == 'btRollBack')
				doRollbackActivity(value);
		}
	}
	
	function doTerminateAction(action) {
		if(!confirm('<b:message key="all_activity_list_jsp.sure_exec_operation"/>')){//您确定要执行该操作吗？
				      return false;
		}else{}	
		document.forms['activityInstList'].action='com.primeton.workflow.manager.instance.terminateActivityInstance.flow?_eosFlowAction=terminateActivityInst';
		document.forms['activityInstList'].submit();
	}
	
	function doRollbackActivity(activityInstID){		
		var processInstID = document.forms['activityInstList'].elements['processInstID'].value;
		var action = 'com.primeton.workflow.manager.instance.queryActivitDefByProcessDefID.flow?_eosFlowAction=queryActivityDefsByProcessInstID&processInstID='+processInstID+'&activityInstID='+activityInstID;
		showModalCenter(action,null,function(returnValue){
			if(returnValue == true)
				doQuery();
		},'500','300','<b:message key="all_activity_list_jsp.roll_back_activity_inst"/>') ;//回退活动实例
	}
	
	function doQuery(){
		document.forms['activityInstList'].action= 'com.primeton.workflow.manager.instance.getAllActivityInstList.flow?_eosFlowAction=queryWithPage';
		document.forms['activityInstList'].submit();
	}
	
	function openManualActivityDialog(processInstID, activityDefID, activityInstID){
		var action = 'com.primeton.workflow.manager.instance.editActivityInst.flow?_eosFlowAction=editActivityInst&processInstID='+processInstID+'&activityDefID='+activityDefID+'&activityInstID='+activityInstID;
		showModalCenter(action,null,function(arg){
			if(!arg) return ;
			
			if(arg == 'refreshGraph')
				window.location.href=location;},'620','400','<b:message key="all_activity_list_jsp.activity_inst_monitor"/>');//活动实例监控
		
	}
</script>
</head>
<body style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;" >
<form name="activityInstList" method="post" target="_self">
   <h:hidden name="queryCriteria/_entity" value="com.eos.workflow.data.WFActivityInst"/>
   <h:hidden name="queryCriteria/_expr[1]/processInstID" property="queryCriteria/_expr[1]/processInstID"/>   
   <h:hidden name="queryCriteria/_orderby[1]/_property" value="activityInstID"/>
   <h:hidden name="queryCriteria/_orderby[1]/_sort" value="desc"/>
   <h:hidden name="processInstID"  property="queryCriteria/_expr[1]/processInstID"/>
   <table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="all_activity_list_jsp.activiti_inst_list"/></h3></td><%-- 活动实例列表 --%>
	</tr>
	<tr> 
	  <td>
		<table border="0" cellpadding="0" cellspacing="0" class="EOS_panel_body" width="100%">
			 <tr> 
			   <td width="100%"  height="440"  valign="top">
					<table border="0" cellpadding="0" cellspacing="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th width="6%" align="center"><b:message key="all_activity_list_jsp.operation"/></th><%-- 操作 --%>
				  <th width="11%" align="center"><b:message key="all_activity_list_jsp.activity_inst_id"/></th><%-- 活动实例ID --%>
				  <th width="11%"><b:message key="all_activity_list_jsp.activity_inst_name"/></th><%-- 活动实例名称 --%>
				  <th width="11%"><b:message key="all_activity_list_jsp.type"/></th><%-- 类型 --%>
				  <th width="11%"><b:message key="all_activity_list_jsp.state"/></th><%-- 状态 --%>
				  <%--<th width="11%">是否超时</th>--%>
				  <th width="11%"><b:message key="all_activity_list_jsp.process_inst_id"/></th><%-- 流程实例ID --%>
				  <th width="13%" nowrap="nowrap"><b:message key="all_activity_list_jsp.start_time"/></th><%-- 开始时间 --%>
				  <th width="13%" nowrap="nowrap"><b:message key="all_activity_list_jsp.end_time"/></th><%-- 完成时间 --%>
				</tr>
				<% int flag =0; String cls = "";%>
				<l:iterate id="list" property="activityInstList">
					<%if(flag%2==0){cls="";}else{cls="EOS_table_row";}%>
					<tr  class="<%=cls %>"  onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
						<td><h:radio iterateId="list" property="activityInstID"/></td>
					    <td><b:write iterateId="list" property="activityInstID"/></td>
						<td>
						<l:equal iterateId="list" property="activityType" targetValue="manual">
							<a href="javascript:void(openManualActivityDialog(<b:write iterateId="list" property="processInstID"/>,'<b:write iterateId="list" property="activityDefID"/>','<b:write iterateId="list" property="activityInstID"/>'))"><b:write iterateId="list" property="activityInstName"/></a>
						</l:equal>
						<l:equal iterateId="list" property="activityType" targetValue="subflow">
							<a href="javascript:void(openManualActivityDialog(<b:write iterateId="list" property="processInstID"/>,'<b:write iterateId="list" property="activityDefID"/>','<b:write iterateId="list" property="activityInstID"/>'))"><b:write iterateId="list" property="activityInstName"/></a>
						</l:equal>
						<l:equal iterateId="list" property="activityType" targetValue="toolapp">
							<a href="javascript:void(openManualActivityDialog(<b:write iterateId="list" property="processInstID"/>,'<b:write iterateId="list" property="activityDefID"/>','<b:write iterateId="list" property="activityInstID"/>'))"><b:write iterateId="list" property="activityInstName"/></a>
						</l:equal>
						<l:equal iterateId="list" property="activityType" targetValue="webservice">
							<a href="javascript:void(openManualActivityDialog(<b:write iterateId="list" property="processInstID"/>,'<b:write iterateId="list" property="activityDefID"/>','<b:write iterateId="list" property="activityInstID"/>'))"><b:write iterateId="list" property="activityInstName"/></a>
						</l:equal>
						<l:equal iterateId="list" property="activityType" targetValue="start">
							<b:write iterateId="list" property="activityInstName"/>
						</l:equal>
						<l:equal iterateId="list" property="activityType" targetValue="finish">
							<a href="javascript:void(openManualActivityDialog(<b:write iterateId="list" property="processInstID"/>,'<b:write iterateId="list" property="activityDefID"/>','<b:write iterateId="list" property="activityInstID"/>'))"><b:write iterateId="list" property="activityInstName"/></a>
						</l:equal>
						<l:equal iterateId="list" property="activityType" targetValue="route">
							<b:write iterateId="list" property="activityInstName"/>
						</l:equal>
						</td>
						<td><d:write iterateId="list" property="activityType" dictTypeId="WFDICT_ActivityType"/></td>
						<td>
							<d:write iterateId="list" dictTypeId="WFDICT_ActivityState" property="currentState"/>
							<h:hidden iterateId="list" property="currentState"/>
						</td>
					<%--	<td><d:write iterateId="list" dictTypeId="WFDICT_YN" property="isTimeOut"/>						
						</td>--%>
						<td><b:write iterateId="list" property="processInstID"/></td>
						<td  nowrap="nowrap"><b:write iterateId="list" property="startTime" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
						<td  nowrap="nowrap"><b:write iterateId="list" property="endTime" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
					</tr>
						<%flag++;  %>
				</l:iterate>
				
			  </table>
				    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="50">
                      <tr>
                        <td width="23%" align="left" >
                            <input type="button" id="btRollBack" name="btRollBack" value="<b:message key="all_activity_list_jsp.roll_back"/>" class="button" onclick="doSubmit('btRollBack')"><%-- 回退 --%>
                            <input type="button" id="btTerminate" name="btTerminate" value="<b:message key="all_activity_list_jsp.terminate"/>" class="button" onclick="doSubmit('btTerminate')"><%-- 终止 --%>
                        </td>
                        <td width="77%" align="right" >
                        	 <b:set name="action" value="com.primeton.workflow.manager.instance.getAllActivityInstList.flow?_eosFlowAction=queryWithPage"/>
						     <b:set name="target" value="_self"/>
					         <%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
                        </td>
                      </tr>
                    </table>
			   </td>
			</tr>
		</table>
</td></tr>
</table> 
</form>
</body>
</html>
<script>
window.onload = function (){
	var cnt = 0;
	<l:present property="activityInstList">
	cnt = <b:size property="activityInstList"/>
	</l:present>
	if (cnt==0){
		$name("btRollBack").disabled=true;
		$name("btTerminate").disabled=true;
	}
}
</script>
