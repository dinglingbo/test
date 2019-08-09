<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-02-21 09:11:16
  - Description:
-->
<head>
<title>优惠劵管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
        body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
    </style>
</head>
<body>
	<div id="form1" class="nui-form">
	    <div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%;">						
			<tr>
				<td style="font-size:12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  textField="storeName" value="" url="com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >卡劵标题： </label>
					<input id="couponTitle" name="couponTitle" class="nui-textbox inputLeft" />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑</a>
					<a class="nui-button" onclick="deleteCoupon()" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
				</td>
			</tr>
		</table>
			</div>
	</div>
	
	<div class="nui-fit" >
		<div id="cardCouponData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="wxbCouponData" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="50" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" >微信门店</div>
            	<div field="couponCode" headerAlign="center" align="center" width="150" >卡劵编码</div>
            	<div field="couponTitle" headerAlign="center" align="center"  >卡劵标题</div>
            	<div field="couponNumber" headerAlign="center" align="center" width="65" >库存量</div>
            	<div field="couponDiscountsPrice" headerAlign="center" renderer="onCouponDiscountsPrice" align="center" width="65" >优惠价格</div>
            	<div field="couponType" headerAlign="center" align="center" renderer="onCouponType" width="65" >优惠劵类别</div>
            	<div field="couponBeginDate" headerAlign="center" align="center" width="90" dateFormat="yyyy-MM-dd" >有效开始日期</div>
            	<div field="couponEndDate" headerAlign="center" align="center" width="90" dateFormat="yyyy-MM-dd" >有效结束日期</div>
            	<div field="isCarUse" headerAlign="center" align="center" renderer="onIsCarUse" width="65" >只限车辆下使用</div>
            	<div field="isStoreUse" headerAlign="center" align="center" renderer="onIsStoreUse" width="65" >只限门店下使用</div>
            	<div field="isTenantUse" headerAlign="center" align="center" renderer="onIsTenantUse" width="65" >只限租户下使用</div>
            	<div field="creator"  headerAlign="center" align="center"  width="70" >创建人</div>
            	<div field="createDate" headerAlign="center" align="center" width="140" dateFormat="yyyy-MM-dd HH:mm:ss" >创建时间</div>
            	<div field="modifier"  headerAlign="center" align="center" width="70"  >更改人</div>
            	<div field="modifyDate" headerAlign="center" align="center" width="140"  dateFormat="yyyy-MM-dd HH:mm:ss" >更改时间</div>
            </div>
        </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var cardCouponData = nui.get("cardCouponData");
    	
    	$(function(){
    		cardCouponData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryCardCoupon.biz.ext");
			cardCouponData.load({token:token});
		});
		
		//优惠价格
		function onCouponDiscountsPrice(e){
			return Boolean(e.value) ? e.value+"元" : e.value;
		}
		
		//优惠劵类别
		function onCouponType(e){
			return e.value == 1 ?  "通用劵" : "专属劵" ;
		}
		
		//只限车辆下使用
		function onIsCarUse(e){
			return e.value == 0 ?  "是" : "否" ;
		}
		
		//只限门店下使用
		function onIsStoreUse(e){
			return e.value == 0 ?  "是" : "否" ;
		}
		
		//只限租下使用
		function onIsTenantUse(e){
			return e.value == 0 ?  "是" : "否" ;
		}
		
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatCardCoupon/addCardCoupon.jsp",
				title: "添加优惠劵",
				width: 916,
				height: 530,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						pageType: "add"
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					console.log(action);
					if(action == 'saveSuccess') {
						nui.alert("添加成功", "系统提示");
						cardCouponData.reload();
					}else if(action == 'saveFail'){
						nui.alert("添加失败", "系统提示");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = cardCouponData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatCardCoupon/addCardCoupon.jsp",
					title: "编辑优惠劵",
					width: 916,
					height: 530,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							cardCouponData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							nui.alert("编辑成功", "系统提示");
							cardCouponData.reload();
						}else if(action == 'saveFail'){
							nui.alert("编辑失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条数据");
			}
		}
		
		//删除优惠劵
		function deleteCoupon(){
			var row = cardCouponData.getSelected();
			if(row){
				row.couponDeleteStatus = 1;
				var json={cardCouponData:row};
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.editCardCoupon.biz.ext",
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.retures){
							nui.alert("删除成功", "系统提示");
							cardCouponData.reload();
						}else{
							nui.alert("删除失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条数据");
			}
		}
		
		
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	cardCouponData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
    	
		
		
    </script>
</body>
</html>