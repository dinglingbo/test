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
<title>门店标签</title>
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
	
	<div class="form" id="storeLabelInfoForm" name="storeLabelInfoForm" style="height:50%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="tabId" id="tabId" visible="false"/>
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 15%;" >
					<label>门店选择：</label>
				</td>
				<td colspan="1" style="width: 35%;">
					<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
				</td>
				<td class="nui-form-label" colspan="1" style="width: 20%;" >
					<label>门店标签名称：</label>
				</td>
				<td colspan="1" style="width: 30%;">
					<input class="nui-textbox tabwidth" name="tabContent" id="tabContent" required="true" maxLength="6" />
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
				var form = new nui.Form("#storeLabelInfoForm"); //将普通form转为nui的form
				form.setData(infos.storeLabelData);
				nui.get("pageType").setValue(infos.pageType);
			}else{
				nui.get("storeId").setValue(infos.storeId);
				nui.get("storeId").setText(infos.storeName);
				nui.get("pageType").setValue(infos.pageType);
			}
		}
		
		//保存
		function save(){
			var form = new nui.Form("#storeLabelInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			//检验门店是否重复
			var json=nui.encode({storeId:data.storeId,tabContent:data.tabContent});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreLabel.judgeStoreLabel.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text){
					if( ( text.resturns && nui.get("pageType").getValue() == "add" ) || ( text.resturns && nui.get("pageType").getValue() == "edit" ) || ( !text.resturns && nui.get("pageType").getValue() == "edit" && text.tabId == data.tabId ) ){
						var urlStr="";
						if( nui.get("pageType").getValue() == "add" ){
							urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreLabel.addStoreLable.biz.ext";
						}else if( nui.get("pageType").getValue() == "edit" ){
							urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreLabel.editStoreLable.biz.ext";
						}
						
						var json=nui.encode({storeLabelDate:data});
						nui.ajax({
							url: urlStr,
							type: 'POST',
							data: json,
							cache: false,
							async: false,
							contentType: 'text/json',
							success: function(text) {
								if( nui.get("pageType").getValue() == "add" ){
									if(text.errCode == "S"){
										CloseWindow("saveSuccess");
									}else{
										CloseWindow("saveFail");
									}
								}else if( nui.get("pageType").getValue() == "edit" ){
									if(text.errCode == "S"){
										CloseWindow("editSuccess");
									}else{
										CloseWindow("editFail");
									}
								}
							}
						});
					}else{
						nui.alert("门店下已有此标签,请重新选择");
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