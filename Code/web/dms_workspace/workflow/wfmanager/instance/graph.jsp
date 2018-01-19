<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<html>
<script language="javascript">
	function openActivityDialog(actObj){
		if(actObj.getAttribute('processInstID') == null)
			return;
		var action = 'com.primeton.workflow.manager.instance.editActivityInst.flow?_eosFlowAction=editActivityInst&processInstID='+actObj.getAttribute('processInstID')+'&activityDefID='+actObj.getAttribute('activityDefID');
		
		var modelArgs = getCurrentModalArguments();
		if (modelArgs == null) {
			showModalCenter(action,null,function(returnValue){
				if(returnValue == 'refreshGraph')
					window.location.href=location;
				},'620','400','<b:message key="graph_jsp.activity_inst_monitor"/>');//活动实例监控
		}
		else {
			var offset = 20;
			var modelLeft = Number(substringBefore(modelArgs.container.style.left,'px'));
			var modelTop = Number(substringBefore(modelArgs.container.style.top,'px'));
			var winLeft = modelLeft + offset;
			var winTop = modelTop + offset;
			showModal(action,null,function(returnValue){
				if(returnValue == 'refreshGraph')
					window.location.href=location;
				},'620','400',winLeft,winTop,'<b:message key="graph_jsp.activity_inst_monitor"/>');//活动实例监控
		}
		
		
	}
	
	
//	function openActivityDialog1(actObj){
//		if(actObj.getAttribute('processInstID') == null)
//			return;
//			
//		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.newbiz.biz');
//		var activityinstid = actObj.getAttribute('activityinstid');
//		hs.addParam('activityinstid',activityinstid);
//			hs.submit();
//			var subprcessinstid = hs.getProperty('subprcessinstid');
//		
//		var action = 'com.primeton.workflow.manager.instance.navigation.flow?_eosFlowAction=graphAction&processInstID='+subprcessinstid;
//		showModalCenter(action,null,function(returnValue){
//			if(returnValue == 'refreshGraph')
//				window.location.href=location;
//			},'620','400','活动实例监控');
//	}
</script>
<body style="background:#FFFFFF;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow:auto; overflow-y:auto; overflow-x: auto;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
		<wf:processGraph processInstID="@processInstID" zoomQuotiety="@zoomQuotiety">
				<wf:activityGraph activityType="manual" onclick="openActivityDialog(this)"/>
				<wf:activityGraph activityType="subflow" onclick="openActivityDialog(this)"/>
				<wf:activityGraph activityType="toolapp" onclick="openActivityDialog(this)"/>
				<wf:activityGraph activityType="finish" onclick="openActivityDialog(this)"/>
				<wf:activityGraph activityType="webservice" onclick="openActivityDialog(this)"/>
		</wf:processGraph>
	</td>
  </tr>
</table>
</body>
</html>