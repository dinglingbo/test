<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<script language="javascript">

/*验证是否选中一条记录*/
function validate(actionName){

	if(document.forms['workItemList'].workItemID.length == undefined){
		if(document.forms['workItemList'].workItemID.checked){
			return isAllowDone(actionName,document.forms['workItemList'].workItemID.value);
		}
	}else{
		for(i = 0;i<document.forms['workItemList'].workItemID.length;i++)
		  	if(document.forms['workItemList'].workItemID[i].checked)
		  		return isAllowDone(actionName,document.forms['workItemList'].workItemID[i].value);
	}
	alert("<b:message key="all_workitem_list_jsp.select_workitem_record"/>");//请先选中一条工作项记录
	return false;
}

/*用Ajax验证工作项状态,在不同状态下可操作性*/
function isAllowDone(actionName,values){
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.WorkItemManger.getWorkItemState.biz');
	hs.addParam('workItemID',values);
	hs.submit();
	var currentState = hs.getProperty('currentState');
	if(actionName == 'btFinish' || actionName == 'btPress'||actionName =='btAnnotate'){
		if(currentState == 10){
			return true;
		}else{
			alert("<b:message key="all_workitem_list_jsp.workitem_is_running"/>");//工作项状态必须处于 "运行" 状态
			return false;
		}
	}else if(actionName == 'btReassign'){
		hs.submit();
		var currentState = hs.getProperty('currentState');
		if(currentState != 10 && currentState != 4){
			alert("<b:message key="all_workitem_list_jsp.workitem_is_running_tobereceive"/>");//工作项状态必须处于 "运行"或"待领取" 状态
			return false;
		}
	}
	return true;
}

/*提交执行*/
function doSubmit(actionName){
	if(validate(actionName)){
		if(actionName == 'btFinish')
			return finishWorkItem();
		else if(actionName == 'btReassign')
			return reassignWorkItem();
		else if(actionName == 'btPress')
			return pressWorkItem();
		else if(actionName == 'btAnnotate')
			return annotateWorkItem();
	}
	
}

function pressWorkItem() {
	showModalCenter(contextPath+"/workflow/wfmanager/instance/operate_msg.jsp"+"?"+"operateType=1",null,function(returnValue){
		
		if(!returnValue){
			return false;
		}
		
		if (returnValue != null && returnValue.length >=0) 
		{
			appendHiddenChild('workItemList','pressMessage',returnValue[0]);		
		}
		document.forms['workItemList'].action='com.primeton.workflow.manager.instance.pressWorkItem.flow?_eosFlowAction=pressWorkItem';
		document.forms['workItemList'].target = '_self';
		document.forms['workItemList'].submit();
		alert("<b:message key="all_workitem_list_jsp.press_success"/>");//催办成功
	},'550','300',"<b:message key="all_workitem_list_jsp.pressWorkItem"/>") ; //添加任务催办
}

function annotateWorkItem() {
	showModalCenter(contextPath+"/workflow/wfmanager/instance/operate_msg.jsp"+"?"+"operateType=2",null,function(returnValue){
		
		if(!returnValue){
			return false;
		}
		
		if (returnValue != null && returnValue.length >=0) 
		{
			appendHiddenChild('workItemList','annotationMessage',returnValue[0]);		
		}
		document.forms['workItemList'].action='com.primeton.workflow.manager.instance.annotateWorkItem.flow?_eosFlowAction=annotateWorkItem';
		document.forms['workItemList'].target = '_self';
		document.forms['workItemList'].submit();
		alert("<b:message key="all_workitem_list_jsp.annotation_success"/>");//批注成功
	},'550','300',"<b:message key="all_workitem_list_jsp.annotateWorkItem"/>") ; //添加任务批注
}
/*执行完成工作项功能*/
function finishWorkItem() {
	document.forms['workItemList'].action='com.primeton.workflow.manager.instance.finishWorkItem.flow?_eosFlowAction=finishWorkItemForProcessInst';
	document.forms['workItemList'].submit();
}

/*提交执行改派工作项操作*/
function reassignWorkItem(){
	selectParticipant ('selectparticipant','maxNum=',new FormElement('workItemList','participants','participantsHidden','PARTICIPANT'),function(returnValue){
			if(!returnValue){
				return false;
			}
			
			if(returnValue == ''||returnValue == null) {
				alert("<b:message key="all_workitem_list_jsp.assign_fail"/>");//改派工作项失败！
				return false ;
			}
			
			document.forms['workItemList'].action = 'com.primeton.workflow.manager.instance.reassignWorkItem.flow?_eosFlowAction=reassignWorkItemFromAllWorkItemList';
			document.forms['workItemList'].target = '_self';
			document.forms['workItemList'].submit();
		});
}

function editWorkItem(workItemID){
	var action = 'com.primeton.workflow.manager.instance.findWorkItemByID.flow?_eosFlowAction=findWorkItemByIDForAllWorkItem&workItemID='+workItemID;
		showModalCenter(action,null,function(returnValue){			
			doQuery(returnValue);
		},'650','370','<b:message key="all_workitem_list_jsp.workitem_details"/>');	//工作项详细信息
}

function doQuery(returnValue){
	document.forms['workItemList'].action = 'com.primeton.workflow.manager.instance.getAllWorkItemList.flow?_eosFlowAction=queryWithPage&nodelete='+returnValue;
	document.forms['workItemList'].submit();
}

function editParticipant(workItemID){
	var action = 'com.primeton.workflow.manager.instance.findParticipantDetail.flow?_eosFlowAction=action0&workItemID='+workItemID;
		showModalCenter(action,null,function(returnValue){			
			if(returnValue){
				
			}
		},'550','270','<b:message key="all_workitem_list_jsp.participant_details"/>');	//参与者详细信息
}

</script>
</head>
<body style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<form name="workItemList" method="post" target="_self">
   <h:hidden name="participants"/>
   <h:hidden id="pressMessage"/>
   <h:hidden id="annotationMessage"/>
   <h:hidden name="queryCriteria/_entity" value="com.eos.workflow.data.WFWorkItem"/>
   <h:hidden name="queryCriteria/_expr[1]/processInstID" property="queryCriteria/_expr[1]/processInstID"/>
   		<h:hidden name="queryCriteria/_orderby[1]/_property" value="workItemID"/>
   		<h:hidden name="queryCriteria/_orderby[1]/_sort" value="desc"/>
   <table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="all_workitem_list_jsp.workitem_list"/></h3></td><%-- 工作项列表 --%>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%">
			 <tr> 
			   <td width="100%"  height="440"  valign="top">
					<table border="0" cellpadding="0" cellspacing="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th width="7%"><b:message key="all_workitem_list_jsp.operation"/></th><%-- 操作 --%>
				  <th width="7%"><b:message key="all_workitem_list_jsp.workitem_id"/></th><%-- 工作项ID --%>
				  <th width="10%"><b:message key="all_workitem_list_jsp.workitem_name"/></th><%-- 工作项名称 --%>
				  <th width="6%"><b:message key="all_workitem_list_jsp.state"/></th><%-- 状态 --%>
				  <th width="10%"><b:message key="all_workitem_list_jsp.owner_pro_inst"/></th><%-- 所属流程实例 --%>
				  <th width="10%"><b:message key="all_workitem_list_jsp.is_out_time"/></th><%-- 是否超时 --%>
				  <th width="10%"><b:message key="all_workitem_list_jsp.priotity"/></th><%-- 优先级 --%>
				  <th width="10%"><b:message key="all_workitem_list_jsp.participant_id"/></th><%-- 参与者ID --%>
				  <th width="10%"><b:message key="all_workitem_list_jsp.participant_name"/></th><%-- 参与者名称 --%>
				  <th width="13%"><b:message key="all_workitem_list_jsp.start_time"/></th><%-- 开始时间 --%>
				  <th width="13%"><b:message key="all_workitem_list_jsp.end_time"/></th><%-- 完成时间 --%>
				</tr>
				<% int flag =0; String cls = "";%>
				<l:iterate id="list" property="workItemList">
				<%if(flag%2==0){cls="";}else{cls="EOS_table_row";}%>
					<tr class="<%=cls %>"  onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
						<td><h:radio iterateId="list" name="workItemID" property="workItemID"/></td>
					    <td><b:write iterateId="list" property="workItemID"/></td>
						<td>
						<a href='javascript:void(editWorkItem(<b:write iterateId="list" property="workItemID"/>))'><b:write iterateId="list" property="workItemName"/></a>
						</td>
						<td>
						  <d:write iterateId="list" dictTypeId="WFDICT_WorkItemState" property="currentState"/>
						  <h:hidden iterateId="list" name="currentState" property="currentState"/>
						</td>
						<td><b:write iterateId="list" property="processChName"/></td>
						<td><d:write iterateId="list" dictTypeId="WFDICT_YN" property="isTimeOut"/></td>
						<td><d:write iterateId="list" dictTypeId="WFDICT_Priority" property="priority"/></td>
						<td><b:write iterateId="list" property="participant"/></td>
						<td>
							<a href='javascript:void(editParticipant(<b:write iterateId="list" property="workItemID"/>))'><b:write iterateId="list" property="partiName"/>
						</td>
						<td><b:write iterateId="list" property="startTime" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyyMMddHHmmss"/></td>
						<td><b:write iterateId="list" property="endTime" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyyMMddHHmmss"/></td>
					</tr>
					<%flag++;  %>
				</l:iterate>
				
			  </table>
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                  <input type="button" id="btFinish" name="btFinish" onClick="doSubmit('btFinish')" value="<b:message key="all_workitem_list_jsp.finish"/>" class="button"><%-- 完成 --%>
				  <input type="button" id="btReassign" name="btReassign" onClick="doSubmit('btReassign')" value="<b:message key="all_workitem_list_jsp.assign"/>" class="button"><%-- 改派 --%>
				  <input type="button" id="btPress" name="btPress" onClick="doSubmit('btPress')" value='<b:message key="all_workitem_list_jsp.press"/>' class="button"><%-- 催办 --%>
				  <input type="button" id="btAnnotate" name="btAnnotate" onClick="doSubmit('btAnnotate')" value='<b:message key="all_workitem_list_jsp.annotate"/>' class="button"><%-- 批注 --%>
                </td>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="50">
                    <tr>
                      <td align="right" >
                	    <b:set name="action" value="com.primeton.workflow.manager.instance.getAllWorkItemList.flow?_eosFlowAction=queryWithPage"/>
					    <b:set name="target" value="_self"/>
				        <%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
			 </td>
			 </tr>
		</table>
		</td>
		</tr>
</table> 
</form>
</body>
</html>

<script>	
	var cnt = 0;
	<l:present property="workItemList">
	cnt = <b:size property="workItemList"/>
	</l:present>
	if (cnt==0){
		$name("btFinish").disabled=true;
		$name("btReassign").disabled=true;
		$name("btPress").disabled=true;
		$name("btAnnotate").disabled=true;
	}
</script>
