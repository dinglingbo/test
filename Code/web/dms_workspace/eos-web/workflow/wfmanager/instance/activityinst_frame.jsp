<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/workflow/wfmanager/instance/common.jsp"%>
<html>
<head>
<title><b:message key="activityinst_frame_jsp.activity_inst_details"/></title><%-- 活动实例详细信息 --%>
<script language="javascript">

	//windowOpener = parent.opener;
	function initIFrame(){
	//FIXME: document.getElementById  --> $id
		iFrameObj = $id('activityInstContent');
		//iFrameObj.height = iFrameObj.Document.body.offsetWidth;
		var activityInstID = document.forms['activityInstForm'].currentActivityInstID.value;
		switchActivityInst(activityInstID,'com.primeton.workflow.manager.instance.findActivityInstDetail.flow?_eosFlowAction=action0');
		
//		var oSelect = $id('activityInsts');
//		var arrOpt = oSelect.options;
		
//		var iLen = arrOpt.length;
//		for (var i = 0; i < iLen ; i++) {
//			var actInstID  = arrOpt[i].value;
//			if (activityInstID == actInstID) {
//				arrOpt[i].selected = true;
//				break;
//			}
//		}
	}
		
	//切换列表框选项后重定位iframe所链接的页面
	function switchIFram(selectObj){
		
		var activityInstID = document.forms['activityInstForm'].currentActivityInstID.value;
		if(selectObj.value == 'activityDetail'){
			switchActivityInst(activityInstID,'com.primeton.workflow.manager.instance.findActivityInstDetail.flow?_eosFlowAction=action0');
		}else if(selectObj.value == 'workitemList'){
			switchActivityInst(activityInstID,'com.primeton.workflow.manager.instance.queryWorkItemListByActivityInstID.flow?_eosFlowAction=queryWithoutPage');
		}else if(selectObj.value == 'subprocessinstList'){
			switchActivityInst(activityInstID,'com.primeton.workflow.manager.instance.getProcessInstList.flow?_eosFlowAction=querySubProcessWithPage');
		}else if(selectObj.value == 'exceptionStrategy'){			
			switchActivityInst(activityInstID,'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=exceptionStrategy');
		}
	}
	
	//切换活动实例后,重定位iframe所链接的页面,同时设置一个活动实例ID作为隐含变量,标识当前正在浏览哪个活动实例
	function switchActivityInst(activityInstID,action){
		var iframetype = document.forms['activityInstForm'].proItem.value;
		if(iframetype == 'activityDetail'){
			document.forms['activityInstForm'].currentActivityInstID.value = activityInstID
			var processInstID = document.forms['activityInstForm'].processInstID.value;;
			$id('activityInstContent').src = action+'&activityInstID='+activityInstID+'&processInstID='+processInstID;
		}
		else if(iframetype == 'workitemList'){
			document.forms['activityInstForm'].currentActivityInstID.value = activityInstID
			var processInstID = document.forms['activityInstForm'].processInstID.value;
			action = 'com.primeton.workflow.manager.instance.queryWorkItemListByActivityInstID.flow?_eosFlowAction=queryWithoutPage';
			$id('activityInstContent').src = action+'&activityInstID='+activityInstID+'&processInstID='+processInstID;
		}
		else if(iframetype == 'subprocessinstList'){
			document.forms['activityInstForm'].currentActivityInstID.value = activityInstID
			var processInstID = document.forms['activityInstForm'].processInstID.value;
			action = 'com.primeton.workflow.manager.instance.getProcessInstList.flow?_eosFlowAction=querySubProcessWithPage';
			$id('activityInstContent').src = action+'&activityInstID='+activityInstID+'&processInstID='+processInstID;
		}
		else if(iframetype == 'exceptionStrategy'){
			document.forms['activityInstForm'].currentActivityInstID.value = activityInstID
			var processInstID = document.forms['activityInstForm'].processInstID.value;
			action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=exceptionStrategy';
			$id('activityInstContent').src = action+'&activityInstID='+activityInstID+'&processInstID='+processInstID;
		}
	}
	
	function validate(actionName){
		if(actionName == 'btCreateAndStartActivityInst' || actionName == 'btReStart'){
			var processInstID = document.forms['activityInstForm'].processInstID.value;
			var currentActivityInstID = document.forms['activityInstForm'].currentActivityInstID.value;
			if(checkProcessState(processInstID) && checkActivityState(actionName, currentActivityInstID)){
				return true;
			}
			return false;
		}
	}
	
	function checkActivityState(actionName, currentActivityInstID) {
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.getActivityInstState.biz');
		hs.addParam('activityInstID',currentActivityInstID);
		try{
			hs.submit();
		}catch(e){
			alert('<b:message key="keyString"/>'+hs.getExceptionMessage());//出错:
			return false;
		}
		var currentState = hs.getProperty('currentState');

		if(actionName == 'btCreateAndStartActivityInst') {
			if(currentState != 7 && currentState != 8) {
				alert('<b:message key="activityinst_frame_jsp.create_condition"/>');//只有终止、完成状态下的活动才能创建新活动实例
				return false;
			}
			return true;
		}
		
		if(actionName == 'btReStart') {
			if(currentState != 7 && currentState != 8 && currentState != -1) {
				alert('<b:message key="activityinst_frame_jsp.restart_condition"/>');//只有终止、完成或异常状态下的活动才能重启活动实例
				return false;
			}
			return true;
		}
		
		return true;
	}
	
	function doSubmit(actionName){
		if(validate(actionName)){
			if(actionName == 'btCreateAndStartActivityInst')
				doCreateAndStartActivityInst();
			else if(actionName =='btReStart')
				doRestart();
		}
		
	}
	
	function doCreateAndStartActivityInst(){	
		
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.createAndStartActivityInst.biz');
		hs.addParam('processInstID',document.forms['activityInstForm'].processInstID.value);
		hs.addParam('activityDefID',document.forms['activityInstForm'].activityDefID.value);
		hs.submit();
		if(ajaxIsSuccess==false){
			//alert('只有完成、终止状态的活动才能创建活动实例');
			return;
		}
		var selectObj = $id('activityInsts');
		var activityInstID = hs.getProperty('activityInst/activityInstID');
		var activityInstName = hs.getProperty('activityInst/activityInstName');
		var option = new Option(activityInstID+'('+activityInstName+')',activityInstID);
		selectObj.options.add(option);
		alert('<b:message key="activityinst_frame_jsp.create_inst_success"/>'+activityInstID);//新建活动实例成功，新的活动实例ID为:		
		
	}
	
	function doRestart(){
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.reStartActivityInst.biz');
		hs.addParam('activityInstID',$id('activityInsts').value);
		hs.submit();
		var currentState = hs.getProperty('activityInst/currentState');
		if(currentState == null){
			alert('<b:message key="activityinst_frame_jsp.operation_failed"/>');//操作失败，已存在运行的活动实例！
			enableButton();
			return;
		}
		//$id('activityInstState').innerHTML = currentState;
		//要求关闭弹出窗口后,刷新图形显示页面
		alert('<b:message key="activityinst_frame_jsp.operation_success"/>');//操作成功
		window.location.href=location;
		window.returnValue = 'refreshGraph';
	}
</script>
</head>
<body onLoad="initIFrame();" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" >
<l:present property="activityInstList">
  <tr>
    <td colspan="3" class="workarea_title" valign="middle"><b:message key="activityinst_frame_jsp.select_activity"/>
          <select id="activityInsts" name="activityInsts" class="select" onChange="switchActivityInst(this.value,'com.primeton.workflow.manager.instance.findActivityInstDetail.flow?_eosFlowAction=action0')">
        	<l:iterate id="list" property="activityInstList">
        		<option value="<b:write iterateId="list" property="activityInstID"/>"><b:write iterateId="list" property="activityInstID"/>(<b:write iterateId="list" property="activityInstName"/>)</option>
        	</l:iterate>
	      </select>
	      <l:equal property="firstActivityInst/activityType" targetValue="finish">
            <input name="createAndStartActivity" id="createAndStartActivityBtn1" type="button" class="button" value="<b:message key="activityinst_frame_jsp.create_new_inst"/>" disabled="true">
            <input name="btReStart" type="button" id="btReStart1" class="button" value="<b:message key="activityinst_frame_jsp.restart_inst"/>" disabled="true">
          </l:equal>
          <l:notEqual property="firstActivityInst/activityType" targetValue="finish">
            <input name="createAndStartActivity" id="createAndStartActivityBtn2" type="button" class="button" value="<b:message key="activityinst_frame_jsp.create_new_inst"/>" onClick="doSubmit('btCreateAndStartActivityInst')">
             <input name="btReStart" type="button" id="btReStart2" class="button" value="<b:message key="activityinst_frame_jsp.restart_inst"/>" onClick="doSubmit('btReStart')">
          </l:notEqual>
          
    </td><%-- 选择活动:/创建新活动实例/重启活动实例 --%>
  </tr>
  </l:present>
  <tr valign="top">
    <td>
	  <form name="activityInstForm" action="com.primeton.workflow.manager.instance.createAndStartActivity.flow?_eosFlowAction=action0" method="post" target="middle">
	  	  <h:hidden name="processInstID" property="processInstID"/>
	  	  <h:hidden name="activityDefID" property="activityDefID"/>
	  	  <h:hidden name="currentActivityInstID" property="firstActivityInst/activityInstID"/>
		  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="background:#EAF0F1;"  >
	  		<tr>
			  <td width="20%" align="center" valign="top">
			  	<table cellpadding="0" cellspacing="0" border="0" style="margin-left:10px; margin-top:10px">
					<tr>
					  <td height="20" align="left" valign="top"><b:message key="activityinst_frame_jsp.set_option"/></td><%-- 设置选项: --%>
					</tr>
					<tr>
					  <td style="padding-bottom:12px;" valign="top">
						  <select  name="proItem" multiple="multiple" size="20" class="select;" style="width:120px;" onChange="javascript:switchIFram(this);">
							<option value="activityDetail" selected><b:message key="activityinst_frame_jsp.activity_inst_detail"/></option><%-- 活动实例信息 --%>
							<l:equal property="firstActivityInst/activityType" targetValue="manual">
							<option value="workitemList"><b:message key="activityinst_frame_jsp.activity_workitem_list"/></option><%-- 活动工作项列表 --%>
							</l:equal>
							<l:equal property="firstActivityInst/activityType" targetValue="subflow">
							<option value="subprocessinstList"><b:message key="activityinst_frame_jsp.subprocess_inst_list"/></option><%-- 子流程实例列表 --%>
							</l:equal>
							<l:equal property="firstActivityInst/activityType" targetValue="toolapp">
							<option value="exceptionStrategy"><b:message key="activityinst_frame_jsp.application_exception_handle"/></option><%-- 应用异常处理 --%>
							</l:equal>
							<l:equal property="firstActivityInst/activityType" targetValue="webservice">
							<option value="exceptionStrategy"><b:message key="activityinst_frame_jsp.application_exception_handle"/></option><%-- 应用异常处理 --%>
							</l:equal>
						  </select>
					  </td>
					</tr>
		    	</table>	  
		      </td>
			  <td width="2" background="../images/compartLine.gif"></td>
			  <td valign="top">
				  <table id="tableContent" width="100%" border="0" cellspacing="0" cellpadding="0" style="height:340px">
				    <tr height="100%" align="justify" >
					  <td><iframe id="activityInstContent" name="middle" width="100%"  height="100%" src="" frameborder="0" scrolling="auto" align="top" style="background:#EAF0F1;" marginheight="0" marginwidth="0"></iframe></td>
				    </tr>
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