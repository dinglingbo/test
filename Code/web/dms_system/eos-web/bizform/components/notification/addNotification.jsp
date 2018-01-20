<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bizform/bizformCommon.jsp" %>
<html>
<head>
	<title><%=I18nUtil.getMessage(request, "bps.bizform.sendNotification") %></title>
</head>
<body style="width: 100%; height: 100%">
	
	<div class="nui-fit" style="padding: 5px;">
		<div id="form1" class="nui-form" style="width:100%;height:100%;">
			<!-- 通知人策略 -->
			<input class="nui-hidden" name="workItemID"/>
			<input class="nui-hidden" name="isNotifyExt"/>
			<table style="width:100%;table-layout:fixed;" >
				<tr>
					<td class="form-label"><%=I18nUtil.getMessage(request, "bps.bizform.notification.title") %></td>
					<td><input class="nui-textbox" name="title"  required="true" maxLength="100" width="100%"/></td>
				</tr>
				<tr>
					<td class="form-label"><%=I18nUtil.getMessage(request, "bps.bizform.notification.content") %></td>
					<td><textarea class="nui-textarea" name="message" required="true" maxLength="400" height="60px" width="100%" ></textarea></td>
				</tr>
				<!-- <tr id="actionURL_ui">
					<td class="form-label"><input class="nui-checkbox" name="actionURLCombo" onvaluechanged="enableActionURL"/>
  					<%=I18nUtil.getMessage(request, "bps.bizform.notification.url") %></td>
					<td><input id="actionURL"  class="nui-textbox" name="actionURL" enabled="false"  required="true" width="100%"/></td>
				</tr> -->
				<tr>
					<td colspan="2"><input class="nui-checkbox" name="sendToPerson"/>
  					<%=I18nUtil.getMessage(request, "bps.bizform.notification.sendToPerson") %></td>
				</tr>
				<tr>
					<td class="form-label"><%=I18nUtil.getMessage(request, "bps.bizform.notification.receiverStrategy") %></td>
  					<td style="padding-top:3px">
  						<input id="receiverStrategy"  class="nui-combobox" name="receiverStrategy"  width="100%" textField="text" data="receiverStrategyList" 
  							onvaluechanged="enableRecipientUI" valueField="id" required="true" multiSelect="true" readonly="readonly"/>
  					</td>
				</tr>
				<tr id="recipient_ui" style="width:100%;">
					<td class="form-label"><%=I18nUtil.getMessage(request, "bps.bizform.notification.notificationRecipient") %></td>
					<td>
						<input id="recipient" class="nui-buttonedit" name="recipient" required="true" allowInput="false" width="100%" onbuttonclick="selectParticipant" />
					</td>
				</tr>
			</table>
		</div>
	</div>

    <table style="width:100%;margin-top: 10px;">
		<tr>
			<td style="text-align:center;" colspan="4">
			<a class="nui-button redBtn" onclick="saveData"><%=I18nUtil.getMessage(request, "bps.bizform.ok") %></a>
			<span style="display:inline-block;width:25px;"></span>
			<a class="nui-button redBtn" onclick="onCancel"><%=I18nUtil.getMessage(request, "bps.bizform.cancel") %></a>
		    </td>
		</tr>
    </table>

	<script type="text/javascript">
		
		var receiverStrategyList = [
			{id: "activityParticipants", text: "<%=I18nUtil.getMessage(request, "bps.bizform.notification.activityParticipants") %>"},
			{id: "appointParticipant", text: "<%=I18nUtil.getMessage(request, "bps.bizform.notification.appointParticipant") %>"}
		];
			
    	nui.parse();
    	
    	var form = new nui.Form("#form1");
    	
    	var defaultReceiverStrategy = "appointParticipant";
    	var recipientID = "recipient";
    	var actionURLID = "actionURL";
    	
    	function setData(data){
    		data = nui.clone(data);
    		if(!data["receiverStrategy"]){//没有通知人策略，默认指派参与者
    			data["receiverStrategy"] = defaultReceiverStrategy;
    		}
    		form.setData(data);
    		
    		if(data.isNotifyExt){//是否是知会，知会需要设置工作项固定的URL
    			notifyExtAction();
    		}
    		
    		//修改通知人的样式
    		var fields = form.getFields();                
            for(var i=0,len=fields.length;i<len;i++) {
            	var field = fields[i];
            	if(field["id"]=="receiverStrategy"){
	                if (field.setReadOnly) field.setReadOnly(true);
	                if (field.setIsValid) field.setIsValid(true);//去除错误提示
	                if (field.addCls) field.addCls("asLabel");//增加asLabel外观
            	}
            }
            document.getElementById("receiverStrategy").style.border="solid 1px #a5acb5";
            document.getElementById("receiverStrategy").style.background="white";
            document.getElementById("receiverStrategy").style.background="#FFFFE6";
            
    		
    		//触发值改变时间
    		enableRecipientUI({sender: nui.get("receiverStrategy")});
    		
    	}

		function getData(){
			return form.getData();
		}
		
		function enableActionURL(e){
			var sender = e.sender;
			var textbox = nui.get("actionURL");
			textbox.setIsValid();//清楚校验
			if(sender.getValue()=="true"){
				textbox.enable();
			}else{
				textbox.disable();
			}
		}
		
		function enableRecipientUI(e){
			var sender = e.sender;
			if(sender.getValue() && 
				sender.getValue().indexOf("appointParticipant")!=-1){//是否存在指派参与者
				nui.get(recipientID).enable();
				$("#"+recipientID+"_ui").show();
			}else{
				nui.get(recipientID).disable();
				$("#"+recipientID+"_ui").hide();
			}
		}
		
		function saveData(e){
			form.validate();
			if(!form.isValid()) return;
			
			CloseWindow("ok");
		}
		
		function selectParticipant(e){
			//选择参与者
			var selectedData = {};
			if(nui.get(recipientID).getValue()){
				selectedData = {
					ids: nui.get(recipientID).getValue(),
					texts: nui.get(recipientID).getText()
				};
			}
			bps.components.core.selectResource({
				title: "<%=I18nUtil.getMessage(request, "bps.bizform.notification.participant") %>"
			},{}, selectedData, function(){
				nui.get(recipientID).setValue(selectedData["ids"]);
				nui.get(recipientID).setText(selectedData["texts"]);
			});
		}
		
		function notifyExtAction(){//知会操作
			$("#actionURL_ui").hide();//隐藏
		}
		
		function onCancel(){
			CloseWindow("cancel");
		}
		
		//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if (window.confirm("<%=I18nUtil.getMessage(request, "bps.bizform.IsSavaDateModified") %>")) {
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