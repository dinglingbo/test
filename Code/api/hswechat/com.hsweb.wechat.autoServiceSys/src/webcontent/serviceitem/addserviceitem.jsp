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
<title>添加优惠劵</title>
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
	
	<div class="form" id="cardCouponInfoForm" name="cardCouponInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="couponId" id="couponId" visible="false"/>
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 14%;" >
					<label>门店选择：</label>
				</td>
				<td colspan="1">
					<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;" onvaluechanged="OnStoreIdchanged" textField="storeName" value="" url="com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext" valueField="storeId" dataField="wechatStoreData" />
				</td>
				<td class="nui-form-label couponPrice" colspan="1">
					<label>服务项目：</label>
				</td>
				<td colspan="1" class="couponPrice">
					<input id="serviceItemId" name="serviceItemId" class="nui-buttonedit" required="true" style="margin-right: 30px;" onbuttonclick="serviceItemIdclick" />
					<input id="serviceItemName" name="serviceItemName" class="nui-textbox" " style="margin-right: 30px;display:none;" />
				</td>
			</tr>
			
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 14%;" >
					<label>项目活动标题：</label>
				</td>
				<td colspan="1">
					<input id="itemactivitytitle" class="nui-textbox" required="true" style="margin-right: 30px;"/>
				</td>
				<td class="nui-form-label couponPrice" colspan="1">
					<label>项目活动描述：</label>
				</td>
				<td colspan="1" class="couponPrice" >
					<input id="itemactivitydescribe" class="nui-textarea" " style="margin-right: 30px;" />
				</td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	nui.parse();
    	
    	//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			if(infos.pageType == "edit"){
				
				
			}else{
				nui.get("pageType").setValue(infos.pageType);
			}
		}
		
		//门店选择改变事件
		function OnStoreIdchanged(){
			nui.get("serviceItemId").setValue("");
			nui.get("serviceItemId").setText("");
			nui.get("serviceItemName").setValue("");
		}
		
		//服务项目点击选择
		function serviceItemIdclick(){
			if(!nui.get("storeId").getValue()){
				nui.alert("请先选择门店");
				return;
			}
			nui.open({
				url: pathweb+"/autoServiceSys/weChatCardCoupon/itemsChoose.jsp",
				title: "项目选择",
				width: 960,
				height: 420,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						storeId:nui.get("storeId").getValue()
					};
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					var iframe = this.getIFrameEl();
					var data=iframe.contentWindow.getFormData();
					nui.get("serviceItemId").setValue(data.serviceItemId);
					nui.get("serviceItemId").setText(data.serviceItemName);
					nui.get("serviceItemName").setValue(data.serviceItemName);
				}
			});
		}
		
		//保存
		function save(){
			var form = new nui.Form("#cardCouponInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			
			var urlStr="";
			if( nui.get("pageType").getValue() == "add" ){
				urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.serviceitem.addserviceitem.biz.ext";
			}else if( nui.get("pageType").getValue() == "edit" ){
				urlStr=pathapi+"/";
			}
			var par = {};
				par.store_id = nui.get("storeId").getSelected().storeId;
				par.tenant_id = nui.get("storeId").getSelected().tenantId;
				par.service_item_id = nui.get("serviceItemId").value;
				par.item_activity_title = nui.get("itemactivitytitle").value;
				par.item_activity_describe = nui.get("itemactivitydescribe").value;
			nui.ajax({
				url: urlStr,
				type: 'POST',
				data: nui.encode({'par':par}),
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