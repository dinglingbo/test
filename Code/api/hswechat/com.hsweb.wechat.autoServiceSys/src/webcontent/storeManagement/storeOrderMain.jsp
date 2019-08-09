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
<title>订单管理</title>
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
<body style="width: 100%; height:100%;padding:0px;margin:0px;">
	<div id="form1" class="nui-form">
		<table style="width: 100%; border: 1px solid #e3e3e3;padding-left:5px;">						
			<tr>
				<td style="font-size: 9pt;display: flex;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox" textField="storeName" onvaluechanged="OnStore" value="" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >用户昵称： </label>
					<input id="userNickname" name="userNickname"	class="nui-textbox inputLeft" />&nbsp;&nbsp;
					<label class="labeltext" >车牌号：</label>
					<input id="carNo" name="carNo" class="nui-textbox inputLeft"  />&nbsp;&nbsp;
					<label class="labeltext" >状态：</label>
					<input id="orderStatus" name="orderStatus" class="nui-combobox"  valueField="id" textField="text"  value=""  data='[{"id":0,"text":"未支付"},{"id":1,"text":"已支付"},{"id":2,"text":"服务中"},{"id":3,"text":"已完成"}]'  />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
				</td>
			</tr>
		</table>
	</div>
		
	<div id="orderMainData" class="nui-datagrid" style="width: 100%; height: 94%;" allowResize="true"
         dataField="orderMainDataArray" pageSize="12" showPageInfo="true" onshowrowdetail="onShowRowDetail" >
        <div property="columns">
        	<div type="expandcolumn" width="50">用户详情</div>
        	<div field="storeName" headerAlign="center" align="center"  >门店名称</div>
        	<div field="orderCode" headerAlign="center" align="center">订单号</div>
            <div field="userNickname" headerAlign="center" align="center">用户昵称</div>
            <div field="userName"  headerAlign="center" align="center" >用户姓名</div>
            <div field="carNo"  headerAlign="center" align="center">车牌号</div>
            <div field="orderAmount"  headerAlign="center" align="center">总金额</div>
            <div field="orderStatus"  headerAlign="center" align="center" renderer="onOrderStatus" >状态</div>
            <div field="orderTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >下单时间</div>
        </div>
    </div>
	
	<div id="orderDetail_Form" style="display:none;">
	        <div id="orderDetailData" class="nui-datagrid" style="width:100%;" dataField="orderDetailDataArray" pageSize="10" 
		      showPager="false"  showPageInfo="true" multiSelect="false">
            <div property="columns">
            	<div field="serviceTypeName" headerAlign="center" align="center"  >业务类型</div>
            	<div field="serviceItemName" headerAlign="center" align="center"  >服务项目</div>
            	<div field="serviceItemType" headerAlign="center" align="center" renderer="onServiceItemType" >项目类型</div>
            	<div field="itemPrice" headerAlign="center" align="center" >项目价格</div>
            	<div field="itemQty" headerAlign="center" align="center"  >项目数量</div>
            </div>
        </div>    
    </div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var orderMainData = nui.get("#orderMainData");
    	var orderDetailData = nui.get("#orderDetailData");
    	var orderDetail_Form = document.getElementById("orderDetail_Form");
    	var storeId = nui.get("storeId");
    	
    	
    	
    	$(function(){
    		orderMainData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.queryStoreOrder.biz.ext");
    		orderDetailData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.queryOrderDetail.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeId.select(0);
			initLoad();
		});
		
		
		//选择门店自动查询
		function OnStore(){
			search();
		}
		
		//初始化表格
		function initLoad(){
        	orderMainData.load({token:token});
        	search();
		}
    	
    	//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	orderMainData.load({map:formData,token:token});
    	}
    	
    	//点击查看用户信息
    	function onShowRowDetail(e){
    		var grid = e.sender;
            var row = e.record;
            var td = orderMainData.getRowDetailCellEl(row);
            td.appendChild(orderDetail_Form);
            orderDetail_Form.style.display = "block";
        	var formData={
        		orderId:row.orderId
        	};
            orderDetailData.load({map:formData,token:token});
    	}
    	
    	//清空
    	function reset(){
    		var storeValue=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
    	
    	//订单状态
    	function onOrderStatus(e){
    		switch (e.value) {
			case "0":
				return "未支付";
			case "1":
				return "已支付";
			case "2":
				return "服务中";
			case "3":
				return "已完成";
			}
    	}
    	
    	//项目类型
    	function onServiceItemType(e){
    		return e.value == "1" ? "普通服务项目" : "套餐卡项目";
    	}
    	
    	
		
    </script>
</body>
</html>