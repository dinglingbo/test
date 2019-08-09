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
<title>关注用户</title>
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
		<table style="width: 100%;">						
			<tr>
				<td style="font-size: 12px;">
					<!-- <label style="font-family:Verdana;">门店：</label>
					<input id="restaurantId" name="restaurantId" class="nui-combobox" onvaluechanged="onValuechangedMeal" style="margin-right: 30px;" required="true" textField="restaurantName" value="1" url="com.sfy.orderingMealSystem.orderingMealSysRestaurant.queryRestaurantName.biz.ext" valueField="restaurantId" dataField="restaurant" />
					 -->
					<label class="labeltext" >昵称：</label>
					<input name="userNickname" class="nui-textbox inputLeft"  />
					<label class="labeltext" >省份： </label>
					<input name="userProvince"	class="nui-textbox inputLeft" />
					<label class="labeltext" >城市：</label>
					<input name="userCity"	class="nui-textbox inputLeft"  />
					<label class="labeltext" >关注日期：</label>
					<input id="userAttentionTimeBegin" name="userAttentionTimeBegin" onvaluechanged="dateBeginchanged" class="nui-datepicker" /> <label class="labeltext" style="" >至</label> <input id="userAttentionTimeEnd" name="userAttentionTimeEnd" onvaluechanged="dateEndchanged" class="nui-datepicker"/>

					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					<div id="userSubscribe" name="userSubscribe" class="nui-checkboxlist" textField="text" valueField="id" data='[{"id":0,"text":"取消关注"}]'   style="display:inline-block;top: 5px"/>
					<!-- <li class="separator"></li>
					<a class="nui-button" onclick="usersSynchronizationWechat()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;同步微信</a> -->
				</td>
			</tr>
		</table>
	</div>
		</div>	
	<div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:95%;">
		<div id="usersGrid" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="usersData" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="true">
            <div property="columns">
            	<div field="userMarke" headerAlign="center" align="center" >微信服务号</div>
            	<div field="userOpid" headerAlign="center" align="left" width="150" >微信openId</div>
            	<div field="userNickname" headerAlign="center" align="center" >昵称</div>
            	<div field="userGender" headerAlign="center" align="center" renderer="onSex" >性别</div>
            	<div field="userProvince" headerAlign="center" align="center" >省份</div>
            	<div field="userCity" headerAlign="center" align="center" >城市</div>
            	<div field="userAttentionTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >关注时间</div>
            	<div field="userNotAttentionTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >取消关注时间</div>
            </div>
        </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var usersGrid = nui.get("usersGrid");
    	var pathapi=apiPath+wechatApi;
    	$(function(){
    		usersGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryWechatUser.biz.ext");
			initLoad();
		});
		
		
		//初始化表格
		function initLoad(){
			var formData = new nui.Form("#form1").getData(false, false);
			formData.storeId = 1;
			formData.userSubscribe = nui.get("userSubscribe").getValue() == "" ? 1 : nui.get("userSubscribe").getValue();
        	usersGrid.load({map:formData,token:token});
		}
    	
    	//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData(false, false);
			formData.userSubscribe = nui.get("userSubscribe").getValue() == "" ? 1 : nui.get("userSubscribe").getValue();
			if( nui.get("userAttentionTimeBegin").getText() != "" ) formData.userAttentionTimeBegin = nui.get("userAttentionTimeBegin").getText()+ " 00:00:00";
			if( nui.get("userAttentionTimeBegin").getText() != "" ) formData.userAttentionTimeEnd = nui.get("userAttentionTimeEnd").getText()+ " 23:59:59";
        	usersGrid.load({map:formData,token:token});
    	}
    	
    	//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
    	
    	//性别
    	function onSex(e){
    		return e.value == "1" ? "男" : "女";
    	}
    	
    	//开始关注日期改变事件
		function dateBeginchanged(){
			nui.get("userAttentionTimeEnd").setMinDate(nui.get("userAttentionTimeBegin").getValue());
		}
		//结束关注日期改变事件
		function dateEndchanged(){
			nui.get("userAttentionTimeBegin").setMaxDate(nui.get("userAttentionTimeEnd").getValue());
		}
		
    </script>
</body>
</html>