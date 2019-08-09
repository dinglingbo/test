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
		<input class="nui-textbox" name="distributePeopleNumber" id="distributePeopleNumber" visible="false"/>
		<input class="nui-textbox" name="sharePeopleNumber" id="sharePeopleNumber" visible="false"/>
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="couponId" id="couponId" visible="false"/>
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 14%;" >
					<label>门店选择：</label>
				</td>
				<td colspan="1">
					<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;" onvaluechanged="OnStoreIdchanged" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
				</td>
				<td class="nui-form-label" colspan="1" style="width: 14%;" >
					<label>优惠劵标题：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox tabwidth" name="couponTitle" id="couponTitle" required="true" maxLength="10" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>优惠劵类别：</label>
				</td>
				<td colspan="3">
					<div id="couponType" name="couponType" class="nui-radiobuttonlist" textField="text" onvaluechanged="OnCouponTypechanged" valueField="id" repeatLayout="none" value="1" data='[{"id":1,"text":"通用劵"},{"id":2,"text":"专属劵"}]' />
				</td>
			</tr>
			
			<tr>
				<td class="nui-form-label couponPrice" colspan="1" style="display:none;" >
					<label>服务项目：</label>
				</td>
				<td colspan="1" class="couponPrice" style="display:none;" >
					<input id="serviceItemId" name="serviceItemId" class="nui-buttonedit" required="true" style="margin-right: 30px;" onbuttonclick="serviceItemIdclick" />
					<input id="serviceItemName" name="serviceItemName" class="nui-textbox" " style="margin-right: 30px;display:none;" />
				</td>
				<td class="nui-form-label couponCondition" colspan="1" >
					<label>优惠条件价格：</label>
				</td>
				<td colspan="1" class="couponCondition" >
					<input class="nui-textbox tabwidth" name="couponConditionPrice" id="couponConditionPrice" required="true" vtype="float" />
				</td>
				<td class="nui-form-label" colspan="1" >
					<label>优惠价格：</label>
				</td>
				<td colspan="1" >
					<input class="nui-textbox tabwidth" name="couponDiscountsPrice" id="couponDiscountsPrice" required="true" vtype="float" onvalidation="onCouponDiscountsPriceValidation" />
				</td>
			</tr>
			
			<tr >
				<td class="nui-form-label" colspan="1"  >
					<label>优惠劵数量：</label>
				</td>
				<td colspan="3">
					<input class="nui-spinner" name="couponNumber" id="couponNumber" required="true" minValue="1" onvalidation="onCouponNumber" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1"  >
					<label>使用范围：</label>
				</td>
				<td colspan="3">
					<div id="isUse" name="isUse" class="nui-radiobuttonlist" textField="text" valueField="id" repeatLayout="none" required="true" value="1" data='[{"id":1,"text":"只能本车使用"},{"id":2,"text":"只能本店使用"},{"id":3,"text":"只能本租户使用"}]' />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>是否可分享：</label>
				</td>
				<td colspan="3">
					<input  id="isShareUse" name="isShareUse" class="mini-checkbox"  trueValue="0" falseValue="1" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1">
					<label>有效开始日期:</label>
				</td>
				<td colspan="1">
					<input id="couponBeginDate" name="couponBeginDate" onvaluechanged="dateBeginchanged" class="nui-datepicker" required="true" />
				</td>
				<td class="nui-form-label" colspan="1">
					<label>有效结束日期:</label>
				</td>
				<td colspan="1">
					<input id="couponEndDate" name="couponEndDate" onvaluechanged="dateEndchanged" class="nui-datepicker" required="true" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>优惠劵说明：</label>
				</td>
				<td colspan="3">
					<input class="nui-textarea" name="couponDescribe" id="couponDescribe" required="true" style="width:400px;height:100px;" />
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
				
				//是否可分享
				if( data.isShareUse == 0 ){
					nui.get("isShareUse").setChecked(true);
				}else if( data.isShareUse == 1 ){
					nui.get("isShareUse").setChecked(false);
				};
				
				if(data.couponType == 2){
					var serviceItemId=nui.get("serviceItemId");
					$(".couponPrice").show();
					serviceItemId.setRequired(true);
					serviceItemId.setValue(data.serviceItemId);
					serviceItemId.setText(data.serviceItemName);
					nui.get("serviceItemName").setValue(data.serviceItemName);
					
					var couponConditionPrice=nui.get("couponConditionPrice");
					$(".couponCondition").hide();
					couponConditionPrice.setRequired(false);
				}
				nui.get("couponEndDate").setMinDate(nui.get("couponBeginDate").getValue());
				nui.get("couponBeginDate").setMaxDate(nui.get("couponEndDate").getValue());
			}else{
				nui.get("pageType").setValue(infos.pageType);
			}
		}
		
		//优惠价格要小于等于优惠条件价格
		function onCouponDiscountsPriceValidation(e){
			if(e.isValid && nui.get("couponType").getValue() == "1" ){
               if( Number(e.value) > Number(nui.get("couponConditionPrice").getValue()) ){
               		e.errorText = "优惠价格不能大于优惠条件价格";
                    e.isValid = false;
               }
            }
		}
		
		//库存量不能少于已经派发和已经领取的优惠劵数量
		function onCouponNumber(e){
			if(e.isValid && nui.get("pageType").getValue() == "edit" ){
				var distributePeopleNumber = nui.get("distributePeopleNumber").getValue();
				var sharePeopleNumber = nui.get("sharePeopleNumber").getValue();
               	if( Number(e.value) < Number( distributePeopleNumber ) + Number( sharePeopleNumber )  ){
               		e.errorText = "优惠劵的库存量，不能小于已经派发的和已经领用分享的优惠劵的数量";
                    e.isValid = false;
               	}
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
				showMsg("请先选择门店","W");
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
		
		//卡劵类别
		function OnCouponTypechanged(e){
			var serviceItemId=nui.get("serviceItemId");
			var couponConditionPrice=nui.get("couponConditionPrice");
			if(e.value == 1){
				$(".couponPrice").hide();
				$(".couponCondition").show();
				serviceItemId.setRequired(false);
				couponConditionPrice.setRequired(true);
				serviceItemId.setValue("");
				serviceItemId.setText("");
			}else if(e.value == 2){
				$(".couponCondition").hide();
				$(".couponPrice").show();
				serviceItemId.setRequired(true);
				couponConditionPrice.setRequired(false);
				couponConditionPrice.setValue("");
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