<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/instance/common.jsp"%>
<%
List workItemList = (List)request.getAttribute("workItemList");
 %>
<script language="javascript">
function initiFrame(){
	enableButton();
}

/*验证是否选中一条记录*/
function validate(actionName){
	disableButton();
	var processInstID = document.forms['workItemForm'].processInstID.value;
	if(checkProcessState(processInstID)){
		if(actionName == 'btCreate')
			return true;
			
		if(document.forms['workItemForm'].workItemID.length == undefined){
			if(document.forms['workItemForm'].workItemID.checked)
				return isAllowDone(actionName,document.forms['workItemForm'].workItemID.value);
		}else{
			for(i = 0;i<document.forms['workItemForm'].workItemID.length;i++)
			  	if(document.forms['workItemForm'].workItemID[i].checked)
			  		return isAllowDone(actionName,document.forms['workItemForm'].workItemID[i].value);
		}
		alert('<b:message key="workitem_list_jsp.select_item_record"/>');//请先选中一条工作项记录
		enableButton();
		return false;
	}
	enableButton();
	return false;
}

/*验证不同工作项状态下,功能的可操作性*/
function isAllowDone(actionName,values){
	
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.WorkItemManger.getWorkItemState.biz');
	hs.addParam('workItemID',values);
	
	if(actionName == 'btReceive'){
		hs.submit();
		var currentState = hs.getProperty('currentState');
		if(currentState != 2){
			enableButton();
			alert("<b:message key="all_workitem_detail_jsp.item_mustbe_receive"/>");//工作项状态必须处于 "待领取" 状态
			return false;
		}
		
	}else if(actionName == 'btDelegate'||actionName == 'btFinish'){
		hs.submit();
		var currentState = hs.getProperty('currentState');
		if(currentState != 10){
			alert("<b:message key="all_workitem_detail_jsp.item_mustbe_running"/>");//工作项状态必须处于 "运行" 状态
			enableButton();
			return false;
		}
		
	}else if(actionName == 'btReassign'){
		hs.submit();
		var currentState = hs.getProperty('currentState');
		if(currentState != 10 && currentState != 4){
			alert("<b:message key="all_workitem_detail_jsp.item_mustbe_running_receive"/>");//工作项状态必须处于 "运行"或"待领取" 状态
			enableButton();
			return false;
		}
	
	}else if(actionName == 'btEdit')
		return true;
		
	return values;
	
}

/*提交执行动作*/
function doSubmit(actionName){
	var value = validate(actionName);
	if(value){
		if(actionName == 'btFinish')
			finishWorkItem();
		else if(actionName == 'btReassign')
			reassignWorkItem();
		else if(actionName == 'btCreate')
			createWorkItem();
		else if(actionName == 'btDelete')
			deleteWorkItem();
		else if(actionName == 'btDelegate')
			delegateWorkItem(value);
		else if(actionName == 'btEdit')
			editWorkItem();
	}
}

/*提交执行完成工作项操作*/
function finishWorkItem(){
	document.forms['workItemForm'].action = 'com.primeton.workflow.manager.instance.finishWorkItem.flow?_eosFlowAction=finishWorkItemForActivityInst';
	document.forms['workItemForm'].target = '_self';
	document.forms['workItemForm'].submit();
}

/*提交执行改派工作项操作*/
function reassignWorkItem(){
	selectParticipant ('selectparticipant','maxNum=',new FormElement('workItemForm','participants','participantsHidden','PARTICIPANT'),function(returnValue){
			if(!returnValue){
				return false;
			}
			
			if(returnValue == ''||returnValue == null) {
				alert("<b:message key="all_workitem_detail_jsp.assign_fail"/>");//改派工作项失败！
				return false ;
			}
			document.forms['workItemForm'].action = 'com.primeton.workflow.manager.instance.reassignWorkItem.flow?_eosFlowAction=reassignWorkItem';
			document.forms['workItemForm'].target = '_self';
			document.forms['workItemForm'].submit();
		});
	enableButton();
}

/*提交执行创建工作项操作*/
function createWorkItem(){
	selectParticipant ('selectparticipant','maxNum=',new FormElement('workItemForm','participants','participantsHidden','PARTICIPANT'),function(returnValue){
			if(!returnValue){
				return false;
			}
			
			if(returnValue == ''||returnValue == null) {
				alert("<b:message key="workitem_list_jsp.create_item_fail"/>");//创建工作项失败！
				return false ;
			}
			document.forms['workItemForm'].action = 'com.primeton.workflow.manager.instance.addWorkItem.flow?_eosFlowAction=createWorkItem';
			document.forms['workItemForm'].target = '_self';
			document.forms['workItemForm'].submit();
		});
		
	enableButton();
}

/*提交执行删除工作项操作*/
function deleteWorkItem(){
	if(!confirm("<b:message key="all_workitem_detail_jsp.sure_exec_op"/>")){//您确定要执行该操作吗？
		enableButton();
      	return false;
	}else{}	
	document.forms['workItemForm'].action = 'com.primeton.workflow.manager.instance.deleteWorkItem.flow?_eosFlowAction=deleteWorkItemByID';
	document.forms['workItemForm'].target = '_self';
	document.forms['workItemForm'].submit();
}

/*提交执行代办工作项操作*/
function delegateWorkItem(workItemID){
	var action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=delegateWorkItem&workItemID='+workItemID;
	showModalCenter(action,null,null,'500','300','<b:message key="all_workitem_detail_jsp.assign_item"/>') ;//代办工作项
	enableButton();
}

/*提交执行编辑工作项操作*/
function editWorkItem(){
	document.forms['workItemForm'].action = 'com.primeton.workflow.manager.instance.findWorkItemByID.flow?_eosFlowAction=findWorkItemByID';
	document.forms['workItemForm'].target= '_self';	
	document.forms['workItemForm'].submit();
}

function disableButton(){
	$name("btFinish").disabled=true;
	$name("btReassign").disabled=true;
	$name("btDelete").disabled=true;
	$name("btDelegate").disabled=true;
	$name("btCreate").disabled=true;
	$name("btEdit").disabled=true;
}

function enableButton(){
	var count = <%=workItemList.size() %>;
	if (count <= 0) {
		$name("btFinish").disabled=true;
		$name("btReassign").disabled=true;
		$name("btDelete").disabled=true;
		$name("btDelegate").disabled=true;
		$name("btCreate").disabled=false;
		$name("btEdit").disabled=true;
	} else {
		$name("btFinish").disabled=false;
		$name("btReassign").disabled=false;
		$name("btDelete").disabled=false;
		$name("btDelegate").disabled=false;
		$name("btCreate").disabled=false;
		$name("btEdit").disabled=false;
	}
}
</script>
</head>
<body onLoad="initiFrame()" leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
   	<tr>
		<td class="EOS_panel_head" valign="middle"><b:message key="workitem_list_jsp.workitem_list"/></td><%-- 工作项列表 --%>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%">
		 <tr> 
		   <td width="100%"  style="height:280px"  valign="top">
		   <form name="workItemForm" action="" method="post">
		    <input type="hidden" name="participants">
		    <h:hidden name="processInstID" property="processInstID"/>
		    <h:hidden name="activityInstID" property="queryCriteria/_expr[1]/activityInstID"/>
		    <h:hidden name="queryCriteria/_entity" value="com.eos.workflow.data.WFWorkItem"/>
		    <h:hidden name="queryCriteria/_expr[1]/activityInstID" property="queryCriteria/_expr[1]/activityInstID"/>		
   		<h:hidden name="queryCriteria/_orderby[1]/_property" value="workItemID"/>
   		<h:hidden name="queryCriteria/_orderby[1]/_sort" value="desc"/>
			<table border="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th><b:message key="workitem_list_jsp.operation"/></th><%-- 操作 --%>
				  <th><b:message key="workitem_list_jsp.item_id"/></th><%-- 工作项ID --%>
				  <th><b:message key="workitem_list_jsp.item_name"/></th><%-- 工作项名称 --%>
				  <th><b:message key="workitem_list_jsp.state"/></th><%-- 状态 --%>
				  <th><b:message key="workitem_list_jsp.owner_pro_inst"/></th><%-- 所属流程实例 --%>
				  <th><b:message key="workitem_list_jsp.is_outtime"/></th><%-- 是否超时 --%>
				  <th><b:message key="workitem_list_jsp.participant"/></th><%-- 参与者 --%>
				</tr>
				<l:present property="workItemList">
				<% int flag =0; String cls = "";%>
					<l:iterate id="list" property="workItemList">
					<%if(flag%2==0){cls="";}else{cls="EOS_table_row";}%>
						<tr class="<%=cls %>"  onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
						  <td><h:radio iterateId="list" name="workItemID" property="workItemID"/></td>
						  <td><b:write iterateId="list" property="workItemID"/></td>
						  <td><b:write iterateId="list" property="workItemName"/></td>
						  <td><d:write iterateId="list" dictTypeId="WFDICT_WorkItemState" property="currentState"/></td>
						  <td><b:write iterateId="list" property="processInstID"/></td>
						  <td><d:write iterateId="list" dictTypeId="WFDICT_YN" property="isTimeOut"/></td>
					      <td><span id="workItemParticipant"><b:write iterateId="list" property="partiName"/></span></td>
						</tr>
						<%flag++;  %>
					</l:iterate>
				</l:present>
			 </table>
			<br>
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td nowrap="nowrap">
                  <input type="button" id="btFinish" name="btFinish" value="<b:message key="workitem_list_jsp.complete"/>" class="button" onClick="doSubmit('btFinish');"><%-- 完成 --%>
				  <input type="button" id="btReassign" name="btReassign" value="<b:message key="workitem_list_jsp.assign"/>" class="button" onClick="doSubmit('btReassign');"><%-- 改派 --%>
				  <input type="button" id="btCreate" name="btCreate" value="<b:message key="workitem_list_jsp.create"/>" class="button" onClick="doSubmit('btCreate');"><%-- 创建 --%>
                  <input type="button" id="btDelete" name="btDelete" value="<b:message key="workitem_list_jsp.delete"/>" class="button" onClick="doSubmit('btDelete');"><%-- 删除 --%>
                  <input type="button" id="btDelegate" name="btDelegate" value="<b:message key="workitem_list_jsp.delegate"/>" class="button" onClick="doSubmit('btDelegate');"><%-- 代办 --%>
                  <input type="button" id="btEdit" name="btEdit" value="<b:message key="workitem_list_jsp.edit"/>" class="button" onClick="doSubmit('btEdit');"><%-- 编辑 --%>
                </td>
              </tr>
              <tr>
                  <td align="right" nowrap="nowrap">
                  	<b:set name="action" value="com.primeton.workflow.manager.instance.queryWorkItemListByActivityInstID.flow?_eosFlowAction=queryWithPage"/>
					<b:set name="target" value="_self"/>
			      	<%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
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