<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>	
<%@include file="/autoServiceSys/common/wechatCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-02-12 14:47:54
  - Description:
-->
<head>
<title>维修汽车服务项目维护</title>
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
		<table style="width: 100%; border: 1px solid #e3e3e3;padding-left:5px;">						
			<tr>
				<td style="font-size: 9pt;display: flex;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox" style="margin-right: 30px;" onvaluechanged="OnStore" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >项目类型： </label>
					<input id="serviceItemType" name="serviceItemType" class="nui-combobox" style="margin-right: 30px;" textField="name" value="" valueField="id" dataField="data" required="true" data='[{"id":1,"name":"服务项目"},{"id":2,"name":"套餐卡项目"}]' />&nbsp;&nbsp;
					<label class="labeltext" >业务类型：</label>
					<input id="serviceTypeId" name="serviceTypeId" class="nui-combobox" style="margin-right: 30px;" textField="name" value="" valueField="id" dataField="data" required="true" />&nbsp;&nbsp;
					<label class="labeltext" >项目名称：</label>
					<input name="serviceItemName" class="nui-textbox inputLeft"  style="margin-right: 30px;"/>&nbsp;&nbsp;
					<label class="labeltext" >优惠：</label>
					<div id="isCoupon" name="isCoupon" class="nui-radiobuttonlist" style="margin-top: 3px;margin-left: 4px;" textField="text" valueField="id" repeatLayout="none" data='[{"id":1,"text":"是"},{"id":0,"text":"否"}]' />&nbsp;&nbsp;
				</td>
				<td>
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
				</td>
			</tr>
		</table>
		<table style="width: 100%; border: 1px solid #e3e3e3;padding-left:5px;border-top: 0px;">						
			<tr>
				<td style="font-size: 9pt;display: flex;">
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑</a>
					<a id="deleteItem" class="nui-button" onclick="deleteItem" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:95%;">
		<div id="serviceItemData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="autoServiceItemData" onrowclick="rowclick" pageSize="20" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="50" >选择</div>
            	<div field="storeName" headerAlign="center" align="left" >微信门店</div>
            	<div field="serviceTypeName" headerAlign="center" align="center" renderer="onServiceTypeName" >业务类型</div>
            	<div field="serviceItemName" headerAlign="center" align="center"  >项目名称</div>
            	<div field="couponTotalAmt" headerAlign="center" align="center" renderer="onCouponPrice" width="75" >项目金额</div>
            	<div field="serviceExtentPrice" headerAlign="center" align="center" renderer="onServiceExtentPrice" >项目的价格范围</div>
            	<div field="itemNumber" headerAlign="center" align="center" width="55" renderer="checkItemNumberStatus">库存量</div>
            	<div field="isCoupon" headerAlign="center" align="center" renderer="onIsCoupon" width="65" >是否优惠</div>
            	<div field="couponType" headerAlign="center" align="center" renderer="onCouponType" width="65" >优惠类型</div>
            	<div field="couponPercentage" headerAlign="center" align="center" renderer="onCouponPercentage" width="65" >优惠比例</div>
            	<div field="couponPrice" headerAlign="center" align="center" renderer="onCouponPrice" width="75" >优惠价格</div>
            	<div field="serviceItemType" headerAlign="center" align="center" renderer="onServiceItemType" >项目类型</div>
            	<div field="itemOnDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" >上架日期</div>
            	<div field="itemOffDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" >下架日期</div>
            	<div field="creator"  headerAlign="center" align="center"  width="70" >创建人</div>
            	<div field="createDate" headerAlign="center" align="center" width="140" dateFormat="yyyy-MM-dd HH:mm:ss" >创建日期</div>
            	<div field="modifier"  headerAlign="center" align="center" width="70"  >更改人</div>
            	<div field="modifyDate" headerAlign="center" align="center" width="140"  dateFormat="yyyy-MM-dd HH:mm:ss" >更改日期</div>
            </div>
        </div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var storeId = nui.get("storeId");
    	var serviceItemData = nui.get("serviceItemData");
    	//业务类型
    	var serviceTypeId=nui.get("serviceTypeId");
    	var systemApiUrl=apiPathUrl+sysApi;
    	
    	$(function(){
    		serviceItemData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.queryAutoServiceItem.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			serviceItemData.load({token:token});
			//设置业务类型的url
		    var serviceTypeUrl=systemApiUrl+"/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext?token="+token;
		    serviceTypeId.setUrl(serviceTypeUrl);
		    storeId.select(0);
    		search();
		});
		
		//删除门店
		function deleteItem(){
			var serviceItemDatass = nui.get("serviceItemData");
			var row = serviceItemDatass.getSelected();
			if(row){
				var serviceItemData={
					storeId:row.storeId,
					serviceItemId:row.serviceItemId
				};
				var json=nui.encode({serviceItemData:serviceItemData});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.deleteServiceItem.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							showMsg("删除成功","S");
							serviceItemDatass.reload();
						}else{
							showMsg("删除失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条数据","W");
			}
		}
		
		//选择行的时候触发
		function rowclick(e){
			var record=e.record;
			if(record.itemBool){
				$("#deleteItem").show();
			}else{
				$("#deleteItem").hide();
			}
		}
		
		//门店名称
		function OnStore(){
			search();
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
		
		//项目价格范围
		function onServiceExtentPrice(e){
			var record=e.record;
			return record.serviceExtentBeginPrice +" - "+ record.serviceExtentEndPrice;
		}
		//检车库存数量是否限制，并显示
		function checkItemNumberStatus(e){
			var record=e.record;
			if(record.itemNumberStatus == 0){
				return "不限";
			}else{
				return record.itemNumber;
			}
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
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	serviceItemData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var storeValue=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
		
    	//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/autoServiceProject/addWeChatAutoServicePro.jsp",
				title: "新增微信服务项目",
				width: 985,
				height: 670,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						pageType: "add",
						storeId:storeId.getValue(),
						storeName:storeId.getSelected().storeName
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					if(action == 'saveSuccess') {
						showMsg("添加成功","S");
						serviceItemData.reload();
					}else if(action == 'saveFail'){
						showMsg("添加失败","E");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = serviceItemData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/autoServiceProject/addWeChatAutoServicePro.jsp",
					title: "编辑微信服务项目",
					width: 985,
					height: 670,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							autoServiceProData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'editSuccess') {
							showMsg("编辑成功","S");
							serviceItemData.reload();
						}else if(action == 'editFail'){
							showMsg("编辑失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条数据","W");
			}
			
		}
		
    </script>
</body>
</html>