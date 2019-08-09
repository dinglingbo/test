<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/autoServiceSys/common/wechatCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-01 15:57:44
  - Description:
-->
<head>
<title>项目选择</title>
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
	<div id="form1" class="nui-form">
		<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%; ">						
			<tr>
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  textField="storeName" value=""  valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >业务类型：</label>
					<input id="serviceTypeId" name="serviceTypeId" class="nui-combobox"  textField="name" value="" valueField="id" dataField="data" required="true" />
					<label class="labeltext" >项目名称：</label>
					<input name="serviceItemName" class="nui-textbox inputLeft"  />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					 <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
				</td>
			</tr>
		</table>
	</div>
		</div>
	<div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:95%;">
		<div id="serviceItemData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="autoServiceItemData" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="50" >选择</div>
            	<div field="storeName" headerAlign="center" align="left" >微信门店</div>
            	<div field="serviceTypeName" headerAlign="center" align="center" renderer="onServiceTypeName" >业务类型</div>
            	<div field="serviceItemName" headerAlign="center" align="center"  >项目名称</div>
            	<div field="serviceItemType" headerAlign="center" align="center" renderer="onServiceItemType" >项目类型</div>
            	<div field="isCoupon" headerAlign="center" align="center" renderer="onIsCoupon" width="65" >是否优惠</div>
            	<div field="couponType" headerAlign="center" align="center" renderer="onCouponType" width="65" >优惠类型</div>
            	<div field="couponPercentage" headerAlign="center" align="center" renderer="onCouponPercentage" width="65" >优惠比例</div>
            	<div field="couponPrice" headerAlign="center" align="center" renderer="onCouponPrice" width="75" >优惠价格</div>
            	<div field="itemOnDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" >上架日期</div>
            	<div field="itemOffDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" >下架日期</div>
            </div>
        </div>
	</div>
	

	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var serviceItemData = nui.get("serviceItemData");
    	var storeId = nui.get("storeId");
    	//业务类型
    	var serviceTypeId=nui.get("serviceTypeId");
    	var systemApiUrl=apiPathUrl+sysApi;
    	
    	$(function(){
    		serviceItemData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.queryAutoServiceItem.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			//设置业务类型的url
		    var serviceTypeUrl=systemApiUrl+"/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext?token="+token;
		    serviceTypeId.setUrl(serviceTypeUrl);
		});
		
		function setFormData(info){
			var data=nui.clone(info);
			nui.get("storeId").setValue(data.storeId);
			var formData = new nui.Form("#form1").getData();
        	serviceItemData.load({map:formData,token:token});
        	nui.get("storeId").setEnabled(false);
		}
		
		function getFormData(){
			return serviceItemData.getSelected();
		}
		
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	serviceItemData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var storeId=nui.get("storeId").getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			nui.get("storeId").setValue(storeId);
    	}
    	
    	//优惠价格
		function onCouponPrice(e){
			return Boolean(e.value) ? e.value+"元" : e.value;
		}
		
		//优惠比例
		function onCouponPercentage(e){
			return Boolean(e.value) ? e.value+"%" : e.value;
		}
		
		//业务类型
		function onServiceTypeName(e){
			return e.value == null ? "套餐" : e.value;
		}
		
		//是否优惠
    	function onIsCoupon(e){
    		return e.value == 0 ? "未优惠" : "已优惠";
    	}
    	
    	//优惠类型
    	function onCouponType(e){
    		if( e.value == 1 ){
    			return "固定优惠";
    		}else if( e.value == 2 ){
    			return "比例优惠";
    		}
    		return "";
    	}
    	
    	//项目类型
    	function onServiceItemType(e){
    		return e.value == "1" ? "服务项目" : "套餐卡项目";
    	}
    	
    	//确定
		function save(){
			if(!serviceItemData.getSelected()){
				nui.alert("请选择一条数据");
				return;
			}
			CloseWindow("save");//将选择的项目传入到输入框内
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