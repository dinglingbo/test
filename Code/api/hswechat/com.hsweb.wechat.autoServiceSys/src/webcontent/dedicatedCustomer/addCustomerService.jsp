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
	
	<div class="form" id="cardCouponInfoForm" name="cardCouponInfoForm" style="left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="couponId" id="couponId" visible="false"/>
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
					
				<td class="nui-form-label couponPrice" colspan="1"  >
					<label>门店名称： </label>
				</td>
				<td colspan="1" class="couponPrice"  >
						<input id="storeId" name="storeId" class="nui-combobox" style="margin-right: 30px;" textField="storeName" value="" url="com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext" valueField="storeId" dataField="wechatStoreData" />
				</td>
				<td class="nui-form-label" colspan="1" style="width: 14%;" >
					<label>客服类型：</label>
				</td>
				<td colspan="1">
					<input id="storeId" name="storeId" class="nui-combobox" style="margin-right: 30px;" textField="text" value="" data='[{"id":1,"text":"客服"},{"id":2,"text":"技师"}]' valueField="id" dataField="wechatStoreData" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>客服选择：：</label>
				</td>
				<td >
					<input id="serviceItemName" name="serviceItemName" class="nui-textbox"  style="margin-right: 30px;display:none;" />
					<input id="serviceItemId" name="serviceItemId" class="nui-buttonedit" required="true" style="margin-right: 30px;" onbuttonclick="serviceItemIdclick" />
				</td>
				<td class="nui-form-label" colspan="1" >
					<label>最大管理人数：</label>
				</td>
				<td >
					<input class="nui-textbox tabwidth" name="couponDiscountsPrice" id="couponDiscountsPrice" required="true" />
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
				var data=infos.cardCouponData;
				var form = new nui.Form("#cardCouponInfoForm"); //将普通form转为nui的form
				form.setData(data);
				nui.get("pageType").setValue(infos.pageType);
				if( data.isCarUse == 0 ){
					nui.get("isUse").setValue(1);
				}else if( data.isStoreUse == 0 ){
					nui.get("isUse").setValue(2);
				}else if( data.isTenantUse == 0 ){
					nui.get("isUse").setValue(3);
				}
				if(data.couponType == 2){
					var serviceItemId=nui.get("serviceItemId");
					$(".couponPrice").show();
					serviceItemId.setRequired(true);
					serviceItemId.setValue(data.serviceItemId);
					serviceItemId.setText(data.serviceItemName);
					nui.get("serviceItemName").setValue(data.serviceItemName);
				}
				
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
		
		//客服点击选择
		function serviceItemIdclick(){
			nui.open({
				url: pathweb+"/autoServiceSys/dedicatedCustomer/queryItemEmployee.jsp",
				title: "客服选择",
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
		
		//卡劵类别
		function OnCouponTypechanged(e){
			var serviceItemId=nui.get("serviceItemId");
			if(e.value == 1){
				$(".couponPrice").hide();
				serviceItemId.setRequired(false);
				serviceItemId.setValue("");
				serviceItemId.setText("");
			}else if(e.value == 2){
				$(".couponPrice").show();
				serviceItemId.setRequired(true);
			}
		}
		
		//开始时间
		function dateBeginchanged(){
			nui.get("couponEndDate").setMinDate(nui.get("couponBeginDate").getValue());
		}
		
		//结束时间
		function dateEndchanged(){
			nui.get("couponBeginDate").setMaxDate(nui.get("couponEndDate").getValue());
		}
		
		//保存
		function save(){
			var form = new nui.Form("#cardCouponInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			
			var urlStr="";
			if( nui.get("pageType").getValue() == "add" ){
				urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.addCardCoupon.biz.ext";
			}else if( nui.get("pageType").getValue() == "edit" ){
				urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.editCardCoupon.biz.ext";
			}
			var data = form.getData(false, true);
			
			data.tenantId=nui.get("storeId").getSelected().tenantId;
			data.couponDeleteStatus=0;
			var isUse=nui.get("isUse").getValue();
			if( isUse == 1 ){
				data.isCarUse=0;
				data.isStoreUse=1;
				data.isTenantUse=1;
			}else if( isUse == 2 ){
				data.isStoreUse=0;
				data.isCarUse=1;
				data.isTenantUse=1;
			}else if( isUse == 3 ){
				data.isTenantUse=0;
				data.isStoreUse=1;
				data.isCarUse=1;
			}
			
			var json={cardCouponData:data};
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