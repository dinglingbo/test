<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String webcssPath = webPath + wechatDomain;
 %>
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-20 16:01:55
  - Description:
-->
<head>
<title>添加关键字</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px;
	    }
	    .labeltext{
	    	font-family:Verdana;
	    	line-height: 25px;
	    }
	    .inputLeft{
	    	margin-right: 6px;
	    }
	    .mini-panel{
	    	z-index: 99;
	    }
	    label{
	    	font-size: 13px;
	    }
    </style>
</head>
<body>
	
	<div class="form" id="keywordReplyInfoForm" name="keywordReplyInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="keywordReplyId" id="keywordReplyId" visible="false"/>
		<table style="width:100%;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>标题：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox tabwidth" name="keywordReplyTitle" id="keywordReplyTitle" required="true"/>
				</td>
				<td class="nui-form-label" colspan="1" >
					<label>关键字：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox tabwidth" name="keyword" id="keyword" required="true"/>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>匹配模式：</label>
				</td>
				<td colspan="1">
					<div id="matchingType" name="matchingType" class="nui-radiobuttonlist" textField="text" valueField="id" required="true" repeatLayout="none" value="1" data='[{"id":1,"text":"模糊匹配"},{"id":2,"text":"完全匹配"}]' />
				</td>
				<td class="nui-form-label" colspan="1"  >
					<label>类型：</label>
				</td>
				<td colspan="3">
					<input id="triggerType" name="triggerType" class="nui-combobox" required="true" style="margin-right: 30px;" textField="text" valueField="id" value=""  data='[{"id":1,"text":"文本消息回复"},{"id":2,"text":"菜单点击"}]'  />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1"  >
					<label>微信响应类型：</label>
				</td>
				<td colspan="3">
					<input id="replyType" name="replyType" class="nui-combobox" required="true" style="margin-right: 30px;" textField="text" valueField="id" value=""  data='[{"id":1,"text":"文本"},{"id":2,"text":"图片"},{"id":3,"text":"单图文"},{"id":4,"text":"多图文"}]'  />
				</td>
				<td class="nui-form-label" colspan="1" >
					<label>微信响应回复：</label>
				</td>
				<td colspan="1" >
					<input id="serviceItemId" name="serviceItemId" class="nui-buttonedit" required="true" style="margin-right: 30px;" onbuttonclick="serviceItemIdclick" />
					<input id="serviceItemName" name="serviceItemName" class="nui-textbox" " style="margin-right: 30px;display:none;" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>是否启用：</label>
				</td>
				<td colspan="1">
					<div id="isStartUsing" name="isStartUsing" class="nui-radiobuttonlist" textField="text" valueField="id" required="true" repeatLayout="none" value="0" data='[{"id":0,"text":"未启用"},{"id":1,"text":"启用"}]' />
				</td>
			</tr>
		</table>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
    	var storeId = nui.get("storeId");
    	var moreOrgGrid = nui.get("moreOrgGrid");
    	
    	$(function(){
    		moreOrgGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.queryStoreEmploye.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
			searchOrg();
		});
		
		
		//传输数据
		function setFormData(info){
			var data=nui.clone(info);
			nui.get("pageType").setValue(data.pageType);
			console.log(data);
			if(data.pageType == "edit"){
				var form = new nui.Form("#keywordReplyInfoForm"); //将普通form转为nui的form
				form.setData(data.customeerServiceEmpDataArray);
				nui.get("pageType").setValue(data.pageType);
				nui.get("employeName").setText(data.customeerServiceEmpDataArray.employeName);
				nui.get("employeName").setValue(data.customeerServiceEmpDataArray.employeName);
			}
		}
		
		//保存
		function save(){
			var form = new nui.Form("#keywordReplyInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			console.log(data);
			
			//检验员工下的客服是否重复
			var json=nui.encode({storeId:data.storeId,employeId:data.employeId});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.judgeCustomerServiceEmp.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text){
					if( ( text.resturns && nui.get("pageType").getValue() == "add" ) || ( text.resturns && nui.get("pageType").getValue() == "edit" ) || ( !text.resturns && nui.get("pageType").getValue() == "edit" && text.serviceId == data.serviceId ) ){
							saveCustomerServiceEmploye(data);
					}else{
						nui.alert("门店下已有此员工,请重新选择");
					}
				}
			});
			
		}
		
		//保存员工信息
		function saveCustomerServiceEmploye(data){
			if(nui.get("pageType").getValue() == "add"){
				var json=nui.encode({customerServiceEmp:data});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.addCustomerServiceEmp.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							CloseWindow("saveSuccess");
						}else{
							CloseWindow("saveFail");
						}
					}
				});
			}else if(nui.get("pageType").getValue() == "edit"){
				var json=nui.encode({customerServiceEmp:data});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.editCustomerServiceEmp.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							CloseWindow("editSuccess");
						}else{
							CloseWindow("editFail");
						}
					}
				});
			}
			
		}
		
		//选择门店
		function OnStoreId(){
			nui.get("employeName").setValue("");
			nui.get("employeName").setText("");
			nui.get("employeId").setValue("");
		}
		
		
		//取消
		function onOrgClose(){
			$("#advancedOrgWin").hide();
			nui.get("employeNamess").setValue("");
		}
		
		//选择车道系统员工
		function selectCustomer(){
			$("#advancedOrgWin").show();
	    	searchOrg();
	    }
		
		//查询车道系统员工信息
		function searchOrg(){
			var storeData=storeId.getSelected();
			var params = {};
		    params.employeName = nui.get("employeNamess").getValue();
		    params.storeId = storeData.storeId+"";
			moreOrgGrid.load({map:params,token:token});
		}
		
		//选择员工
		function addCustomerServiceEmp(){
			var row = moreOrgGrid.getSelected();
			if(row){
				nui.get("employeName").setValue(row.employeName);
				nui.get("employeName").setText(row.employeName);
				nui.get("employeId").setValue(row.employeId);
				
				nui.get("employeNamess").setValue("");
				$("#advancedOrgWin").hide();
			}else{
				nui.alert("请选择一条员工数据", "系统提示");
			}
		}
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		
		
		//关闭窗口
		function CloseWindow( action ) {
			if(action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if(window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
    </script>
</body>
</html>