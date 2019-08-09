<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2018-12-28 17:10:29
  - Description:
-->
<head>  
<title>添加标签</title>
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
	
	<div class="form" id="userGroupInfoForm" name="basicInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="groupId" id="groupId" visible="false"/>
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 25%;" >
					<label>门店选择：</label>
				</td>
				<td colspan="1">
					<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
				</td>
				<td class="nui-form-label" colspan="1" style="width: 20%;" >
					<label>标签名称：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox tabwidth" name="groupName" id="groupName" required="true"/>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 25%;" >
					<label>标签说明：</label>
				</td>
				<td colspan="3">
					<input class="nui-textarea" name="groupDescribe" id="groupDescribe" required="true" style="width:400px;height:100px;" />
				</td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		nui.parse();
		var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var storeId = nui.get("storeId");
    	
    	
    	$(function(){
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeId.select(0);
		});
    	
    	//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			if(infos.pageType == "edit"){
				var form = new nui.Form("#userGroupInfoForm"); //将普通form转为nui的form
				form.setData(infos.userGroupData);
				nui.get("pageType").setValue(infos.pageType);
			}else{
				nui.get("pageType").setValue(infos.pageType);
				nui.get("storeId").setText(infos.storeName);
				nui.get("storeId").setValue(infos.storeId);
			}
		}
		
		//保存
		function save(){
			var form = new nui.Form("#userGroupInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			
			//检验用户标签是否重复
			var json=nui.encode({storeId:data.storeId,groupName:data.groupName});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.judgeUserGroup.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text){
					if( ( text.resturns && nui.get("pageType").getValue() == "add" ) || ( text.resturns && nui.get("pageType").getValue() == "edit" ) || ( !text.resturns && nui.get("pageType").getValue() == "edit" && text.groupId == data.groupId ) ){
						var urlStr="";
						if( nui.get("pageType").getValue() == "add" ){
							urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.addUserGroup.biz.ext?token="+token;
						}else if( nui.get("pageType").getValue() == "edit" ){
							urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.editUserGroup.biz.ext?token="+token;
						}
						var json=nui.encode({groupData:data});
						nui.ajax({
							url: urlStr,
							type: 'POST',
							data: json,
							cache: false,
							async: false,
							contentType: 'text/json',
							success: function(text) {
								if(text.retures){
									CloseWindow("saveSuccess");
								}else{
									CloseWindow("saveFail");
								}
							}
						});
					}else{
						showMsg("用户标签已重复","W");
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