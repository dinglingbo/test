<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bizform/bizformCommon.jsp" %>
<html>
<head>
	<title><%=I18nUtil.getMessage(request, "bps.bizform.addApproval") %></title>
</head>
<body>
	
	<div class="nui-fit" style="padding: 5px;">
		<div id="form1" class="nui-form" style="height: 100%;">
			<input id="messageID" class="nui-hidden" name="messageID" />
			<textarea id="approvalMsg" style="width:100%;height:100%;" class="nui-textarea" name="approvalMsg" maxLength="400" required="true"></textarea>
		</div>
	</div>

    <table style="width:100%;margin-top: 5px;">
		<tr>
			<td style="text-align:center;" colspan="4">
			<a class="nui-button redBtn" onclick="saveData"><%=I18nUtil.getMessage(request, "bps.bizform.ok") %></a>
			<span style="display:inline-block;width:25px;"></span>
			<a class="nui-button redBtn" onclick="onCancel"><%=I18nUtil.getMessage(request, "bps.bizform.cancel") %></a>
		    </td>
		</tr>
    </table>

	<script type="text/javascript">
    		
    	nui.parse();
    	
    	var form = new nui.Form("#form1");
    	
    	
    	function setData(data){
    		data = nui.clone(data);
    		//直接从前端加载，如果存在的话
    		if(data.approvalMsg){
	    		form.setData(data.approvalMsg);
    		}else{
    			nui.ajax({
    				url: "org.gocom.bps.web.bizform.components.approval.approvalManager.getApprovalMsg.biz.ext",
    				data: {workItemID: data.workItemID},
    				cache: false,
    				type: "POST",
    				success: function(ret){
    					if(ret.exception){
    						nui.alert("<%=I18nUtil.getMessage(request, "bps.bizform.ajaxErrorMsg") %>");
    						return;
    					}
    					var approval = nui.decode(ret)["approvalMsg"];
    					if(approval){
    						form.setData({
    							messageID: approval.messageID,
    							approvalMsg: approval.content
    						});
    					}
    				},
    				fail: function(err){
    					nui.alert("<%=I18nUtil.getMessage(request, "bps.bizform.ajaxErrorMsg") %>");
    				}
    			});
    		}
    	}

		function getData(){
			var data = form.getData();
			return data;
		}
		
		function saveData(e){
			//校验
			form.validate();
            if (form.isValid() == false) return;

			CloseWindow("ok");
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