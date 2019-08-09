<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-04 17:11:14
  - Description:
-->
<head>
<title>推送优惠劵</title>
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
	     label{
	    	font-size: 12px;
	    }
	    body .mini-tabs-plain .mini-tabs-scrollCt{
	    	background-color: DEEDF7;
	    }
	    .mini-tabs-position-top .mini-tabs-plain .mini-tabs-header{
	    	margin-top: 4px;
	    }
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px;
	    }
    </style>
</head>
<body>
	<div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;display:flex;">
                	<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox" style="margin-right: 30px;" textField="storeName" value="" onvaluechanged="OnStoreIdchanged" valueField="storeId" dataField="wechatStoreData" />
                    <div id="isUser" name="isUser" class="nui-radiobuttonlist" textField="text"  valueField="id" repeatLayout="none" value="0" data='[{"id":0,"text":"全部用户"},{"id":1,"text":"单个用户"}]' /></div>
                    <span class="separator"></span>
                	<a class="nui-button" onclick="push()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;推送</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
	</div>
	
	<div  class="nui-tabs" style="width:100%;height:92%;" activeIndex="0" onactivechanged="activechanged">
		 <div title="优惠劵">
	    
	       <div id="cardCouponData" class="nui-datagrid" style="height:100%;" allowResize="true"
		        dataField="wxbCouponData" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="true">
	            <div property="columns">
	            	<div type="checkcolumn" width="50" >选择</div>
	            	<div field="couponCode" headerAlign="center" align="center" width="150" >卡劵编码</div>
	            	<div field="couponTitle" headerAlign="center" align="center"  >卡劵标题</div>
	            	<div field="couponNumber" headerAlign="center" align="center" width="65" >库存量</div>
	            	<div field="distributePeopleNumber" headerAlign="center" align="center" width="105"renderer="onDistributePeopleNumber" >已派发优惠劵数量</div>
	            	<div field="sharePeopleNumber" headerAlign="center" align="center" width="105"renderer="onDistributePeopleNumber" >分享领用优惠劵数量</div>
	            	<div field="couponDiscountsPrice" headerAlign="center" renderer="onCouponDiscountsPrice" align="center" width="65" >优惠价格</div>
	            	<div field="couponType" headerAlign="center" align="center" renderer="onCouponType" width="65" >优惠劵类别</div>
	            	<div field="couponBeginDate" headerAlign="center" align="center" width="90" dateFormat="yyyy-MM-dd" >有效开始日期</div>
	            	<div field="couponEndDate" headerAlign="center" align="center" width="90" dateFormat="yyyy-MM-dd" >有效结束日期</div>
	            	<div field="isCarUse" headerAlign="center" align="center" renderer="onIsCarUse" width="65" >只限车辆</div>
	            	<div field="isStoreUse" headerAlign="center" align="center" renderer="onIsStoreUse" width="65" >只限门店</div>
	            	<div field="isTenantUse" headerAlign="center" align="center" renderer="onIsTenantUse" width="65" >只限租户</div>
	            </div>
	        </div>

	    </div>
	    <div title="全部用户">
	    
	        <div id="datagridAll"  class="nui-datagrid" dataField="boundUserData" style="width:100%;height:100%;" showPager="false" >
			    <div property="columns">
			        <div field="storeName" headerAlign="center" align="center" >微信门店</div>
	            	<div field="userMarke" headerAlign="center" align="center"  >用户服务号</div>
	            	<div field="userNickname" headerAlign="center" align="center"  >用户昵称</div>
	            	<div field="userName" headerAlign="center" align="center" >用户姓名</div>
	            	<div field="userPhone" headerAlign="center" align="center"  >用户电话</div>
			    </div>
			</div>

	    </div>
	    <div title="单个用户">
	    
	        <div id="form1" class="nui-form">
				<table style="width: 100%;padding-left:5px;">						
					<tr>
						<td style="font-size: 9pt;display: flex;">
							<label class="labeltext" >服务号： </label>
							<input name="userMarke"	class="nui-textbox inputLeft" style="margin-right: 30px;"/>&nbsp;&nbsp;
						</td>
						<td>
							<label class="labeltext" >用户昵称： </label>
							<input name="userName" class="nui-textbox inputLeft"  style="margin-right: 30px;"/>&nbsp;&nbsp;
						</td>
						<td>
							<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
							<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
						</td>
					</tr>
				</table>
			</div>
			
			<table style="width:100%;height:280px ;">
				<input class="nui-textbox" name="groupId" id="groupId" visible="false"/>
		        <tr>
		            <td style="height:100%;">
		            	<div class="nui-fit">
		               <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" dataField="boundUserData"
			    		multiSelect="true" onrowdblclick="adds" sizeList="[10,20,50,100]">
							    <div property="columns">
							    	<div field="userOpid" headerAlign="center" align="center" >用户openid</div>
							        <div type="checkcolumn"></div> 
							        <div field="storeName" headerAlign="center" align="center" >微信门店</div>
					            	<div field="userMarke" headerAlign="center" align="center"  >用户服务号</div>
					            	<div field="userNickname" headerAlign="center" align="center"  >用户昵称</div>
					            	<div field="userName" headerAlign="center" align="center" >用户姓名</div>
					            	<div field="userPhone" headerAlign="center" align="center"  >用户电话</div>
							     </div>
							</div>
							</div>
		            </td>
		            <td style="width:60px;text-align:center;">
						 <a class="nui-button" onclick="adds()"  style="width:40px;"  onclick="ok">></a><br />
						 <a class="nui-button" onclick="removes()"  style="width:40px;"  onclick="ok">&lt;</a><br />
						 <a class="nui-button" onclick="removeAll()" style="width:40px;"  onclick="ok">&lt;&lt;</a>
		            </td>
		           <td style="width:125px;height:100%;">
		           	<div class="nui-fit">
		                <div id="datagrid2" class="nui-datagrid" style="width:100%;height:100%;" multiSelect="true" onrowdblclick="removes" showPager="false">
						    <div property="columns">
						    	<div field="userId" width="60" headerAlign="center" allowSort="true"></div>
						    	<div field="userOpid" headerAlign="center" align="center" >用户openid</div>
						    	<div type="checkcolumn"></div>
						        <div field="userMarke" width="60" headerAlign="center" allowSort="true">用户服务号</div>
						        <div field="userNickname" width="60" headerAlign="center" allowSort="true">用户昵称</div>
						     </div>
						</div>
						</div>
		            </td>
		        </tr>
		    </table>  
		     
	    </div>
	    
	</div>

	<div class="nui-fit" style="padding:5px;">
		
	</div>


	<script type="text/javascript">
    	nui.parse();
    	nui.parse();
    	var form = new mini.Form("#form1");
    	var datagridAll = mini.get("datagridAll");
		var grid1 = mini.get("datagrid1");
		var grid2 = mini.get("datagrid2");
		var storeId = nui.get("storeId");
		var cardCouponData = nui.get("cardCouponData");
		
		var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	
		$(function(){
			cardCouponData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryPushCardCouponList.biz.ext");
			storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			datagridAll.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryAllBoundUser.biz.ext");
    		grid1.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryBoundUser.biz.ext");
			grid1.hideColumn(0);
			grid2.hideColumn(0);
			grid2.hideColumn(1);
		});
		
		//选择门店
		function OnStoreIdchanged(e){
			var data={
				storeId:e.value
			}
        	cardCouponData.load({map:data,token:token});
        	datagridAll.load({map:data,token:token});
        	grid1.load({map:data,token:token});
		}
		
		//选择面板事件
		function activechanged(e){
			if(e.index == 1){
				var items = grid2.getData();
				grid2.removeRows(items);
			}
			console.log(e);
		}
		
		//传入弹窗的数据
		function setFormData(data){
			var infos = nui.clone(data);
			storeId.setValue(infos.storeId);
			var data={
				storeId:infos.storeId
			}
        	cardCouponData.load({map:data,token:token});
        	datagridAll.load({map:data,token:token});
        	grid1.load({map:data,token:token});
		}
		
		//派送
		function push(){
			var couponArray=cardCouponData.getSelecteds();
			if(couponArray.length < 1){
				nui.alert("请选择优惠劵!");
				return;
			}
			if( datagridAll.getData() < 1 ){
				nui.alert("此门店没有用户!");
				return;
			}
			if( nui.get("isUser").getValue() == 1 && grid2.getData() < 1 ){
				nui.alert("请选择用户!");
				return;
			}
			
			var userDataArray=null;
			if( nui.get("isUser").getValue() == 0 ){//全部用户
				userDataArray=datagridAll.getData();
			}else if( nui.get("isUser").getValue() == 1 ){//单个用户
				userDataArray=grid2.getData();
			}
			
			
			for(var a=0;a<couponArray.length;a++){
				var peopleNumber = Number( couponArray[a].distributePeopleNumber ? couponArray[a].distributePeopleNumber : 0 ) + Number( couponArray[a].sharePeopleNumber ? couponArray[a].sharePeopleNumber : 0 );
				var couponNumbers = Number(couponArray[a].couponNumber);
				
				if( couponNumbers < userDataArray.length ){
					nui.alert("优惠劵的库存量不够派发用户");
					return;
				}else if( ( couponNumbers - peopleNumber ) < userDataArray.length ){
					nui.alert("优惠劵剩余库存不够派发用户");
					return;
				}
				if( a == couponArray.length-1 ){
					var json=nui.encode({userDataArray:userDataArray,couponDataArray:couponArray,distributePeopleNumber:userDataArray.length});
					nui.ajax({
						url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.pushCardCoupon.biz.ext?token="+token,
						type: 'POST',
						data: json,
						cache: false,
						async: false,
						contentType: 'text/json',
						success: function(text) {
							if(text.errCode == "S"){
								CloseWindow("saveSuccess");
							}else{
								CloseWindow("saveFail");
							}
						}
					});
				}
			}
			
			
		}
		
		//已派发人数
		function onDistributePeopleNumber(e){
			return e.value ? e.value : 0 ;
		}
		
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
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData(false, false);
    		formData.storeId=nui.get("storeId").getValue();
        	grid1.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
		
		// 添加到右边 
		function adds() {
			var items = grid1.getSelecteds();
			doAddItems(items);
		}
		
		// 添加到右边 做重复数据判断
		function doAddItems(items) {
			items = mini.clone(items);
	
			//根据empid判断，去除重复的item
			for (var i = items.length - 1; i >= 0; i--) {
				var item = items[i];
				var item2 = grid2.findRow(function(row) {
					if (row.userId == item.userId)
						return true;
				});
				if (item2) {
					items.removeAt(i);
				}
			}
	
			grid2.addRows(items);
		}
		
		//删除全部
		function removeAll() {
			var items = grid2.getData();
			grid2.removeRows(items);
		}
		
		//删除一个
		function removes() {
			var items = grid2.getSelecteds();
			grid2.removeRows(items);
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