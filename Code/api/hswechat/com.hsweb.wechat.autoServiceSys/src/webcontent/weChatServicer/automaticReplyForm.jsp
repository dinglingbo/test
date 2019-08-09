<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/autoServiceSys/common/wechatCommon.jsp"%>
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
<title>添加关注回复</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
	    table{
	    	font-size: 12px;
	    }
	    label{
	    	font-size: 13px;
	    }
    </style>
</head>
<body>
	<div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
	</div>
	
	<div class="form" id="storeEmpInfoForm" name="storeEmpInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="automaticReplyId" id="automaticReplyId" visible="false"/>
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>门店：</label>
				</td>
				<td colspan="1">
					<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;"  textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>微信响应类型 ：</label>
				</td>
				<td colspan="1">
					<input name="automaticReplyType" class="nui-combobox" textField="text" value="1" data='[{"id":1,"text":"纯文本消息"}]' valueField="id"/>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>标题：</label>
				</td>
				<td colspan="1">
					<input  name="automaticReplyTitle" class="nui-textbox" required="true" style="margin-right: 30px;" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>微信响应回复：</label>
				</td>
				<td colspan="1">
					<input  name="imageTextContent" class="nui-textarea" required="true" style="margin-right: 30px;" value="[服务号]"/>
					<span style="color:red">内容必须包含占位符：[服务号]</span>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>是否启用：</label>
				</td>
				<td colspan="1">
					<div name="isStartUsing" class="nui-radiobuttonlist" textField="text" valueField="id" repeatLayout="none" value="0" data='[{"id":1,"text":"启用"},{"id":0,"text":"不启用"}]' />
				</td>
			</tr>
		</table>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
		var urlString=apiPathUrl+sysApi;
		var storeId = nui.get("storeId");
    	
    	$(function(){
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
		});
		
		//传输数据
		function setFormData(info){
			var data=nui.clone(info);
			nui.get("pageType").setValue(data.pageType);
			if(data.pageType == "edit"){
				var form = new nui.Form("#storeEmpInfoForm"); //将普通form转为nui的form
				form.setData(data.storeEmpData);
				nui.get("pageType").setValue(data.pageType);
				nui.get("automaticReplyId").setValue(data.storeEmpData.automaticReplyId);
			}
		}
		
		
		//保存
		function save(){
			var form = new nui.Form("#storeEmpInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			var tempCount = data.imageTextContent.split("[服务号]");
			if(tempCount.length != 2){
				showMsg("回复内容必须包含占位符且只能有一个","E");
				return;
			}
			var json = nui.encode({param:data});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.operationAutoReply.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(res){
					if(res.result.code == 'S'){
					 	CloseWindow("saveSuccess");
					}else if(res.result.code == 'E' && res.result.msg != null){
						showMsg(res.result.msg,"E");
					}else{
						CloseWindow("saveFail");
					}
				}
			});
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