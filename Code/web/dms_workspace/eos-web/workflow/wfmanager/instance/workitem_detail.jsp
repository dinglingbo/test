<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/instance/common.jsp"%>
<%
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
%>
<script type="text/javascript" language="javascript">

	/*验证不同工作项状态下,功能的可操作性*/
	function isAllowDone(actionName){
		var processInstID = document.forms['editWorkItem'].processInstID.value;
		if(checkProcessState(processInstID)){
			var workItemID = document.forms['editWorkItem'].workItemID.value;
			var hs = new HideSubmit('com.primeton.workflow.manager.instance.WorkItemManger.getWorkItemState.biz');
			hs.addParam('workItemID',workItemID);	
			
			if(actionName == 'btReceive'){
				
				hs.submit();
				var currentState = hs.getProperty('currentState');
				if(currentState != 4){
					alert("<b:message key="all_workitem_detail_jsp.item_mustbe_receive"/>");//工作项状态必须处于 "待领取" 状态
					enableButton();
					return false;
				}
			} else if(actionName == 'btFinish'|| actionName ==  'btDelegate'){
				
				hs.submit();
				var currentState = hs.getProperty('currentState');
				if(currentState != 10){
					alert("<b:message key="all_workitem_detail_jsp.item_mustbe_running"/>");//工作项状态必须处于 "运行" 状态
					enableButton();
					return false;
				}
			} else if(actionName == 'btReassign'){
				hs.submit();
				var currentState = hs.getProperty('currentState');
				if(currentState != 10 && currentState != 4){
					alert("<b:message key="all_workitem_detail_jsp.item_mustbe_running_receive"/>");//工作项状态必须处于 "运行"或"待领取" 状态
					enableButton();
					return false;
				}
			}
			return true;
		}
		return false;
	}
	
	/*提交执行动作*/
	function doSubmit(actionName){
		disableButton();
		if(isAllowDone(actionName)){
			if(actionName == 'btFinish')
				finishWorkItem();
			else if(actionName == 'btReassign')
				reasignWorkItem();
			else if(actionName == 'btCreate')
				createWorkItem();
			else if(actionName == 'btDelete')
				deleteWorkItem();
			else if(actionName == 'btDelegate')
				delegateWorkItem();
			else if(actionName == 'btSave')
				saveWorkItem();
			else if(actionName == 'btReceive')
				receiveWorkItem();
			else if(actionName == 'btBack')
				goBack();
		}
	}
	
	/*创建新工作项*/
	function createWorkItem(){		
		selectParticipant ('selectparticipant','maxNum=',new FormElement('editWorkItem','participants','participantsHidden','PARTICIPANT'),function(){
			if(document.forms['editWorkItem'].participantHidden){
				document.forms['editWorkItem'].action = 'com.primeton.workflow.manager.instance.addWorkItem.flow?_eosFlowAction=createWorkItem';
				document.forms['editWorkItem'].target = '_self';
				document.forms['editWorkItem'].submit();
				clearPrevenientHiddenElement('editWorkItem','participantsHidden');
				new DataCatchMgr().clearDataCatch('selectparticipant') ;
			}
		});
		enableButton();
		
	}
	
	/*删除工作项*/
	function deleteWorkItem(){
		if(!confirm("<b:message key="all_workitem_detail_jsp.sure_exec_op"/>")){//您确定要执行该操作吗？
			enableButton();
	      	return false;
		}else{}	
		document.forms['editWorkItem'].action = 'com.primeton.workflow.manager.instance.deleteWorkItem.flow?_eosFlowAction=deleteWorkItemByID';
		document.forms['editWorkItem'].target = '_self';
		document.forms['editWorkItem'].submit();
		
	}
	
	/*代办工作项*/
	function delegateWorkItem(){
		var workItemID = document.forms['editWorkItem'].workItemID.value;
		var action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=delegateWorkItem&workItemID='+workItemID;
		showModalCenter(action,null,null,'500','300','<b:message key="all_workitem_detail_jsp.assign_item"/>') ;//代办工作项
		enableButton()
	}
	
	/*领取工作项*/
	function receiveWorkItem(){

		selectParticipant ('selectparticipant','maxNum=1&selectTypes=<%=leafType %>',new FormElement('editWorkItem','participants','participantHidden','ID'),function(){
			if(document.forms['editWorkItem'].participantHidden){
				var workItemID = document.forms['editWorkItem'].workItemID.value;
				var participantID = document.forms['editWorkItem'].participantHidden.value;
				var hs = new HideSubmit('com.primeton.workflow.manager.instance.WorkItemManger.assignWorkItem.biz');
				hs.addParam('workItemID',workItemID);
				hs.addParam('participantID',participantID);
				
				hs.submit();
				var currentState = hs.getProperty('workItem/currentState');
				var participant = hs.getProperty('workItem/partiName');
				$id('workItemState').innerHTML = "<b:message key="all_workitem_detail_jsp.running"/>";//运行
				$id('workItemParticipant').innerHTML = participant;
				alert("<b:message key="all_workitem_detail_jsp.receive_seccess"/>");//领取成功
				clearPrevenientHiddenElement('editWorkItem','participantsHidden');
				new DataCatchMgr().clearDataCatch('selectparticipant') ;
			}
		});
		enableButton()
		
	}
	
	/*完成工作项*/
	function finishWorkItem(){
		document.forms['editWorkItem'].action ='com.primeton.workflow.manager.instance.finishWorkItem.flow?_eosFlowAction=finishWorkItemForActivityInst';
		document.forms['editWorkItem'].target = '_self';
		document.forms['editWorkItem'].submit();
	}
	
	/*改派工作项*/
	function reasignWorkItem(){
		
		selectParticipant ('selectparticipant','maxNum=',new FormElement('editWorkItem','participants','participantsHidden','PARTICIPANT'),function(returnValue){
			if(!returnValue){
				return false;
			}
			
			if(returnValue == ''||returnValue == null) {
				alert("<b:message key="all_workitem_detail_jsp.assign_fail"/>");//改派工作项失败！
				return false ;
			}
			if(returnValue.length > 0 ){
				var workItemID = document.forms['editWorkItem'].workItemID.value;
				var hs = new HideSubmit('com.primeton.workflow.manager.instance.WorkItemManger.reasignWorkItem.biz');
				hs.addParam('workItemID',workItemID);
				for(i = 0;i<document.forms['editWorkItem'].length;i++){
					if(document.forms['editWorkItem'].elements[i].name.indexOf('participantsHidden') >= 0){
						hs.addParam(document.forms['editWorkItem'].elements[i].name,document.forms['editWorkItem'].elements[i].value);
					}
				}

				hs.submit();
				var currentState = hs.getProperty('workItem/currentState');
				var participant = hs.getProperty('workItem/partiName');
				if(currentState==4)
					$id('workItemState').innerHTML = "<b:message key="all_workitem_detail_jsp.to_be_receive"/>";//待领取
				else
					$id('workItemState').innerHTML = "<b:message key="all_workitem_detail_jsp.running"/>";//运行
				$id('workItemParticipant').innerHTML = participant;
				alert("<b:message key="all_workitem_detail_jsp.assign_success"/>");//改派成功
				new DataCatchMgr().clearDataCatch('selectparticipant') ;
			}
		});
		enableButton();
	}
	
	/*保存工作项*/
	function saveWorkItem(){
		if(!checkInput($id("workItemName"))) {
			enableButton();
    		return false;
    	}
    	
    	if(!checkInput($id("actionURL"))) {
    		enableButton();
    		return false;
    	}
    	
		var workItemName = $name('workItemName').value;		
		if(trim(workItemName)==''){
			enableButton();
			alert("<b:message key="all_workitem_detail_jsp.item_name_not_null"/>");//工作项名称不为空
			return false;
		}
		var actionType = $name('actionType').value;
		var disabled = $name('actionURL').disabled;	
		if(disabled==false){
			var actionURL = $name('actionURL').value;			
			if(trim(actionURL)==''){
				enableButton();
				alert("<b:message key="all_workitem_detail_jsp.custom_url_not_null"/>");//该自定义URL不为空
				return false;
			}		
		}
		if(actionType=="F")
			if(actionURL.lastIndexOf(".flow")>0){
				$name('actionURL').value = actionURL.substring(0,actionURL.lastIndexOf(".flow")); 
			}		
		document.forms['editWorkItem'].action ='com.primeton.workflow.manager.instance.saveWorkItem.flow?_eosFlowAction=saveWorkItem';
		document.forms['editWorkItem'].target = '_self';
		document.forms['editWorkItem'].submit();
	}
	
	/*返回到工作项列表*/
	function goBack(){
		document.forms['editWorkItem'].action = 'com.primeton.workflow.manager.instance.queryWorkItemListByActivityInstID.flow?_eosFlowAction=queryWithPage';
		document.forms['editWorkItem'].target = '_self';
		document.forms['editWorkItem'].submit();
	}
	
	/*ActionURL为None则把'活动URL'输入框disabled掉*/
	function setActionURLEnabled(selectObj){
		if(selectObj.value == 'N')
			document.forms['editWorkItem'].actionURL.disabled = true;
		else
			document.forms['editWorkItem'].actionURL.disabled = false;			
	}

	function disableButton(){
		$name("btFinish").disabled=true;
		$name("btReassign").disabled=true;
		$name("btDelete").disabled=true;
		$name("btDelegate").disabled=true;
		$name("btSave").disabled=true;
		$name("btReceive").disabled=true;
		$name("btBack").disabled=true;
	}
	
	function enableButton(){
		$name("btFinish").disabled=false;
		$name("btReassign").disabled=false;
		$name("btDelete").disabled=false;
		$name("btDelegate").disabled=false;
		$name("btSave").disabled=false;
		$name("btReceive").disabled=false;
		$name("btBack").disabled=false;
	}
</script>
</head>
<body  leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr>
    <td class="EOS_panel_head"><b:message key="workitem_detail_jsp.item_detail"/></td><%-- 工作项详细信息('*'表示可修改项) --%>
  </tr>
  <tr>
    <td width="100%">
      <form action="" method="post" name="editWorkItem">
      	<h:hidden name="queryCriteria/_entity" value="com.eos.workflow.data.WFWorkItem"/>
      	<h:hidden name="queryCriteria/_expr[1]/activityInstID" property="workItem/activityInstID"/>
   		<h:hidden name="queryCriteria/_orderby[1]/_property" value="workItemID"/>
   		<h:hidden name="queryCriteria/_orderby[1]/_sort" value="desc"/>
      	<h:hidden name="activityInstID" property="workItem/activityInstID"/>
		<h:hidden name="pageCond/begin" property="pageCond/begin"/>
		<h:hidden name="pageCond/length" property="pageCond/length"/>
		<h:hidden name="pageCond/isCount" property="pageCond/isCount"/>
		<h:hidden name="workItemID" property="workItem/workItemID"/>
		<h:hidden name="processInstID" property="processInstID"/>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td>
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
                <tr>
                  <td width="15%" class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.item_id"/></td><%-- 工作项ID --%>
                  <td width="35%"><%--<h:text name="workItemID" property="workItem/workItemID" readonly="true" title="@workItem/workItemID"/>--%>
                  <b:write property="workItem/workItemID"/>
                  </td>
                  <td width="15%" class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.item_name"/></td><%-- 工作项名称 --%>
                  <td width="35%" >
                  	<h:text id="workItemName" name="workItemName" property="workItem/workItemName" title="@workItem/workItemName"/><font style="color:red">*</font>
                  </td>
                </tr>
                <tr>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.process_cn_name"/></td><%-- 流程中文名称: --%>
                  <td nowrap="nowrap"><b:write property="workItem/processChName"/></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.process_def_name"/></td><%-- 流程定义名称: --%>
                  <td nowrap="nowrap"><b:write property="workItem/processDefName"/></td>
                </tr>
				<tr>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.process_inst_name"/></td><%-- 流程实例名称: --%>
                  <td style="table-layout:fixed;word-wrap: break-word"><b:write property="workItem/processInstName"/></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.process_inst_id"/></td><%-- 流程实例ID: --%>
                  <td nowrap="nowrap"> <b:write property="workItem/processInstID"/></td>
                </tr>
				<tr>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.activity_inst_name"/></td><%-- 活动实例名称: --%>
                  <td nowrap="nowrap"><b:write property="workItem/activityInstName"/></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.activity_inst_id"/></td><%-- 活动实例ID: --%>
                  <td nowrap="nowrap"><b:write property="workItem/activityInstID"/></td>
                </tr>
                <tr>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.current_state"/></td><%-- 当前状态: --%>
                  <td><span id="workItemState"><d:write property="workItem/currentState" dictTypeId="WFDICT_WorkItemState"/></span></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.participant"/></td><%-- 参与者: --%>
                  <td><span id="workItemParticipant"><b:write property="workItem/partiName"/></span></td>
                </tr>
                <tr>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.priority"/></td><%-- 优先级: --%>
                  <td><d:write property="workItem/priority" dictTypeId="WFDICT_Priority"/></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.is_outtime"/></td><%-- 是否超时: --%>
                  <td><d:write property="workItem/isTimeOut" dictTypeId="WFDICT_YN"/></td>
                </tr>
                <tr>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.limited_time"/></td><%-- 限制时间: --%>
                  <td><b:write property="workItem/limitNumDesc"/></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.timesout"/></td><%-- 超时时间: --%>
                  <td><b:write property="workItem/timeOutNumDesc"/></td>
                </tr>
                <tr >
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.start_time"/></td><%-- 启动时间: --%>
                  <td><b:write property="workItem/startTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.end_time"/></td><%-- 结束时间: --%>
                  <td><b:write property="workItem/endTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
                </tr>
                <tr >
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.url_type"/></td><%-- 自定义URL类型: --%>
                  <td>
				<d:select name="actionType" property="workItem/urlType" dictTypeId="WFDICT_WorkItemUrlType" onchange="javascript:setActionURLEnabled(this)" />                   
                  </td>
                  <td class="EOS_table_row" nowrap="nowrap"><b:message key="all_workitem_detail_jsp.custom_url"/></td><%-- 自定义URL: --%>
                  <td> 
                   <l:equal  property="workItem/urlType" targetValue="N">
							<h:text id="actionURL" name="actionURL" property="workItem/actionURL" disabled="true" validateAttr="type=bpscommxpath" onblur="checkInput(this)" />
				   </l:equal>
				   <l:equal  property="workItem/urlType" targetValue="F" >
							<h:text id="actionURL" name="actionURL" property="workItem/actionURL" disabled="false" validateAttr="type=bpscommxpath" onblur="checkInput(this)" /><font style="color:red">*</font>
				   </l:equal>
				   <l:equal  property="workItem/urlType" targetValue="W" >
							<h:text id="actionURL" name="actionURL" property="workItem/actionURL" disabled="false" validateAttr="type=bpscommxpath" onblur="checkInput(this)" /><font style="color:red">*</font>
				   </l:equal>
				   <l:equal property="workItem/urlType" targetValue="bfsform" >
							<h:text id="actionURL" name="actionURL" property="workItem/actionURL" disabled="false" validateAttr="type=bpscommxpath" onblur="checkInput(this)" /><font style="color:red">*</font>
				   </l:equal>
				   	<l:equal property="workItem/urlType" targetValue="O" >
							<h:text id="actionURL" name="actionURL" property="workItem/actionURL" disabled="false" validateAttr="type=bpscommxpath" onblur="checkInput(this)" /><font style="color:red">*</font>
				   </l:equal>
                  </td>
                </tr>
                <tr>
                  <td colspan="5" class="query_bottom" nowrap="nowrap" align="center" >                  
				  <input type="button" name="btFinish" value="<b:message key="all_workitem_detail_jsp.complete"/>" class="button" onclick="doSubmit('btFinish')"><%-- 完成 --%>
				  <input type="button" name="btReassign" value="<b:message key="all_workitem_detail_jsp.assign"/>" class="button" onclick="doSubmit('btReassign')"><%-- 改派 --%>
				  <!-- input type="button" name="btCreate" value="创建" class="button" onclick="doSubmit('btCreate')" --><%-- 创建 --%>
				  <input type="button" name="btDelete" value="<b:message key="all_workitem_detail_jsp.delete"/>" class="button" onclick="doSubmit('btDelete')"><%-- 删除 --%>
	              <input type="button" name="btDelegate" value="<b:message key="all_workitem_detail_jsp.delegate"/>" class="button" onclick="doSubmit('btDelegate')"><%-- 代办 --%>
	              <input type="button" name="btSave" value="<b:message key="all_workitem_detail_jsp.save"/>" class="button" onclick="doSubmit('btSave')"><%-- 保存 --%>
	              <input type="button" name="btReceive" value="<b:message key="all_workitem_detail_jsp.receive"/>" class="button" onclick="doSubmit('btReceive')"><%-- 领取 --%>
	              <input type="button" name="btBack" value="<b:message key="workitem_detail_jsp.back"/>" class="button" onclick="doSubmit('btBack')"><%-- 返回 --%>            
				  <input type=hidden name="participants" value="">				 
                  </td>
                </tr>
                <tr height="15"></tr>
              </table>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
