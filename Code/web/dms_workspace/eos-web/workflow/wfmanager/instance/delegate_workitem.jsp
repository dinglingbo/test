<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/instance/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("delegate_workitem_jsp.select");
String itemrunning = ResourcesMessageUtil.getI18nResourceMessage("delegate_workitem_jsp.item_mustbe_running");
 %>
<html>
<head>
<title><b:message key="delegate_workitem_jsp.delegate_item"/></title><%-- 代办工作项 --%>
<script type="text/javascript">
	function validate(){
		if(!document.forms['delegateForm'].participant.value){
			alert('<b:message key="delegate_workitem_jsp.select_delegator"/>');//请先选择 代办人
			return false;
		}
		var workItemID = document.forms['delegateForm'].workItemID.value;
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.WorkItemManger.getWorkItemState.biz');
		hs.addParam('workItemID',workItemID);
		hs.submit();
		var currentState = hs.getProperty('currentState');
		if(currentState != 10){
			alert("<b:message key="all_workitem_detail_jsp.item_mustbe_running"/>");//工作项状态必须处于 "运行" 状态
			return false;
		}
			
		return true;
	}
	
	function delegateWorkItem(){
		if(validate()){
			var hs = new HideSubmit('com.primeton.workflow.manager.instance.WorkItemManger.delegateWorkItem.biz');
			var workItemID = document.forms['delegateForm'].workItemID.value;
			var delegateType = document.forms['delegateForm'].delegateType.value;
			var delegateReason = document.forms['delegateForm'].delegateReason.value;
			var participantsName = $id('participant').value;
			
			var n = participantsName.split(",").length;
			
			if(trim(delegateReason)=='')
		 	delegateReason="<b:message key="delegate_workitem_jsp.none"/>";//无
			
			hs.addParam('workItemID',workItemID);
			hs.addParam('delegateType',delegateType);
			hs.addParam('delegateReason',delegateReason);
			
			for(i=1; i <= n; i++){
			    var varName = 'participants['+ i +']';
				var participantID = $id(varName+'/id').value;
				var participantType = $id(varName+'/typeCode').value;
				var participantName = $id(varName+'/name').value;
							 			 
				hs.addParam(varName+'/id',participantID);
				hs.addParam(varName+'/name',participantName);
				hs.addParam(varName+'/typeCode',participantType);
				
			}
			
			hs.submit();
			if(ajaxIsSuccess==false){
				return false;
			}
			alert('<b:message key="delegate_workitem_jsp.delegate_success"/>');//代办成功
			window.returnValue = true;
			window.close();
		}
		
	}
</script>
</head>
<body marginheight="0" marginwidth="0" leftmargin="0" rightmargin="0" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<form action="" name="delegateForm">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="EOS_panel_body" height="100%">
<%--  <tr>
    <td class="EOS_panel_head" valign="middle" colspan="4">代办任务</td>
  </tr>--%>
  <tr>
    <td></td>
    <td class="EOS_table_row" nowrap="nowrap"><b:message key="delegate_workitem_jsp.delegator"/></td><%-- 代办人: --%>
    <td class="EOS_table_row">
    	<h:hidden name="workItemID" property="workItemID"/>
		<input id="participant" name="participant" type="text" style="width:190px" class="textbox">
		<wf:selectParticipant form="delegateForm" output="participant" root="" value="<%=select %>" hidden="participants" hiddenType="PARTICIPANT"/>
    </td><%-- 选择... --%>
    <td></td> 
   </tr>
   <tr>
    <td></td>
    <td nowrap="nowrap" class="EOS_table_row"><b:message key="delegate_workitem_jsp.delegate_style"/></td><%-- 代办方式: --%>
	<td nowrap="nowrap">
		<select name="delegateType">
			<option value="DELEG"><b:message key="delegate_workitem_jsp.delegates"/></option><%-- 代办 --%>
			<option value="HELP"><b:message key="delegate_workitem_jsp.help"/></option><%-- 协办 --%>
		</select>
	</td>
    <td></td> 
   </tr>
   <tr>
    <td width="5%"></td>
    <td class="EOS_table_row" nowrap="nowrap"><b:message key="delegate_workitem_jsp.delegate_reason"/></td><%-- 代办原因: --%>
    <td class="EOS_table_row">
		<textarea rows="5" cols="40" name="delegateReason" id="reason" class="textbox" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
    </td>
    <td width="100%"></td>
  </tr>
  <tr>
    <td class="EOS_table_row" align="center" colspan="4">
		<input type="button" id="okBtn" value="<b:message key="delegate_workitem_jsp.ok"/>" class="button" onclick="delegateWorkItem();"><%-- 确定 --%>
		<input type="button" id="cancelBtn" value="<b:message key="delegate_workitem_jsp.cancel"/>" class="button" onclick="window.close();"><%-- 取消 --%>
    </td>
  </tr>
</table>
</form>
</body>
</html>