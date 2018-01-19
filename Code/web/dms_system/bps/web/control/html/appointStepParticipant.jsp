<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bps/web/control/html/common.jsp"%>
<html>
<head>
	<title></title>
    <style type="text/css">
		.mini-textboxlist ul {
		    padding: 5px 2px 0;
		}
	    .search .mini-textbox-input {
			background:url('../images/selector/search.gif') no-repeat right center;
		}
		body a.redBtn:hover{
			background-color:#dd301b;
			padding:0px 10px;
			color:#ffffff;
			background-image:none;
			border:none;
		}
		body a.redBtn{
			padding:0px 10px;
			background-color:#e73f22;
			color:#ffffff;
			background-image:none;
			border:none;
		}
		.bottomBtnDiv{
			width:97%;
			margin:0 auto;
			text-align:center;
			position:fixed;
			bottom:10px;
		}
     </style>
    
</head>
<body style="width: 97%; height: 95%">
	<div id="datagrid1" dataField="activites" class="nui-datagrid bpsDatagrid" style="width:100%;height:90%;"
		allowAlternating="true"   oncellbeginedit="begineditor"  oncellendedit="endeditor"  onload="onbeforeload(this)"
		allowSortColumn="false" allowCellEdit="true" allowCellSelect="true" showPager="false">
		<div property="columns">
		    <div field="processDefID" visible="false"><%=I18nUtil.getMessage(request, "bps.control.appointActivity.processDefId")%></div>
		    <div field="id" headerAlign="center" align="center" width="120px"><%=I18nUtil.getMessage(request, "bps.control.appointActivity.id")%></div>
		    <div field="name" headerAlign="center" align="center" width="140px"><%=I18nUtil.getMessage(request, "bps.control.appointActivity.name")%></div>
			<!-- @REVIEW 显示问题[liuxiang] -->
			<div field="appointedParticipants" headerAlign="center" align="center" renderer="doChageName" width="80px"><%=I18nUtil.getMessage(request, "bps.control.appointStepParticipant.action")%>
		  		<input property="editor"  class="nui-bps-select-participant" allowInput="false" onclick="beforSelectParticipant" onbuttonclick="buttonClick" onvaluechanged="valueChanged" />
		  	</div>
			<div field="participant" visible="false"></div>
		</div>
	</div>
	
	<table style="width:100%;">
		<tr>
			<td style="text-align:center;" colspan="4">
			<a class="nui-button" onclick="saveData"><%=I18nUtil.getMessage(request, "bps.control.common.save")%></a>
			<span style="display:inline-block;width:25px;"></span>
			<a class="nui-button" onclick="onCancel"><%=I18nUtil.getMessage(request, "bps.control.common.cancel")%></a>
		    </td>
		</tr>	
	</table>
    
	<script type="text/javascript">
		nui.parse();
		var workItemID;
		var currentrow;
		var datagrid = nui.get("datagrid1");
		datagrid.setUrl(bootPATH + "../../rest/services/bps/webcontrol/getActivitesNeedAppointParticipant");
		
		function setFormData(data) {
			var infos = nui.clone(data);
			workItemID = infos.workItemID;
			datagrid.load(infos);
		}	
		
		function onbeforeload(e){
			var datas=e.data;
			if(datas!=null){
				var length=datas.length;
				for(var i=0;i<length;i++){
					var part=datas[i].appointedParticipants;
					var len=part.length;
					var person=new Array(len);
					for(var j=0;j<len;j++){
						person[j]=part[j].userObject;
					}
					datas[i].participant=person;
				}
			}
		}
		
		
		function begineditor(e){
			currentrow=e.row;
			var control=e.column.editor;
			if(control){
				control.setData("");
			}
		}
		
		function endeditor(e){
			var control=e.column.editor;
			if(control){
				control.setData("");
			}
		}
		
		function buttonClick(e){
			var row = currentrow;
			var participants=row.participant;
			if(participants==""||participants==null){
				e.sender.setData(null);
			}else{
				e.sender.setData(participants);
			}
			e.sender.setActivityDefID(row.id);
			e.sender.setProcessDefID(row.processDefId);
			
		}
		
		function valueChanged(e){
			var row = currentrow;
			var data=e.sender.getData();
			if(data[0].name==""||data[0].id==""){
				row.participant="";
			}else{
				row.participant=data;
			}
		}
		
		
		function doChageName(data){
			var displayText = "";
			var activityDef = data.record;
			var part=activityDef.appointedParticipants;
			var type=judgeType(part);
			if(activityDef == null)
				return displayText;
			if(type=="array"){
				var participant=activityDef.appointedParticipants;
				if(participant == null || participant==0)
					return displayText;
				var length = participant.length;
				for(var i=0; i<length - 1; i++)
				{
					displayText = displayText + "," + activityDef.appointedParticipants[i].participantName;
				}
				displayText =activityDef.appointedParticipants[length-1].participantName + displayText;
			}else if(type=="string"){
				var control=data.column.editor;
				if (control.isValid) {
						var name=control.getText();
						displayText=name;
					}
			}

			return displayText;
		}
		
		function judgeType(obj){
			if(obj!=null){
				if((typeof obj=="string")&&obj.constructor==String){
					return "string";
				}else if( (typeof obj=='object')&&obj.constructor==Array){
					return "array";
				}
			}			
		}		

		
		function beforSelectParticipant(data){
			data.sender.setData(null);
		}

		function onCancel() {
			CloseWindow("cancel");
		}
		
		function saveData() {
			datagrid.validate();
			var datas = datagrid.getData();	
			var length=datas.length;
			for(var i=0;i<length;i++){
				if(datas[i].participants&&datas[i].participants.length>0){
					var participant=datas[i].appointedParticipants;
					if(judgeType(participant)=="array"){
						var len=participant.length;
						var partvalue=""
						for(var j=0;j<len-1;j++){
							partvalue=partvalue+","+participant[j].participantType+"|"+participant[j].participantID;
						}
						partvalue=participant[j].participantType+"|"+participant[j].participantID+partvalue;
						datas[i].appointedParticipants=partvalue;
					}
				}else{
					datas[i].appointedParticipants="";
				}
				
			}
			nui.ajax({
				url : bootPATH + "../../rest/services/bps/webcontrol/appointParticipants4StepActivity",
				type : 'POST',
				data : {workItemID: workItemID, defActivities: datas},
				cache : false,
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						CloseWindow("saveSuccess");
					} else {
						tfcToast.take('<%=I18nUtil.getMessage(request, "bps.control.common.saveFailed")%>', '<%=I18nUtil.getMessage(request, "bps.control.common.toastTitle")%>');
					}
				}
			});
		}
		
		//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && datagrid.isChanged()) {
				if (window.confirm('<%=I18nUtil.getMessage(request, "bps.control.appointActivity.windowConfirm")%>')) {
					saveData();
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				return window.close();
		}
	</script>
</body>
</html>