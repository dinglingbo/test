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
<title>绑定用户</title>
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
<body >
	<div id="form1" class="nui-form">
		<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%;">						
			<tr>
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox" onvaluechanged="onValuechangedStore"  textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >服务号： </label>
					<input name="userMarke"	class="nui-textbox inputLeft" />
					<label class="labeltext" >姓名：</label>
					<input name="userName" class="nui-textbox inputLeft"  />
					<label class="labeltext" >绑定日期：</label>
					<input id="userBindingTimeBegin" name="userBindingTimeBegin" onvaluechanged="dateBeginchanged" class="nui-datepicker" style="margin-right: 10px;" /> <label class="labeltext" style="margin-right: 10px;" >至</label> <input id="userBindingTimeEnd" name="userBindingTimeEnd" onvaluechanged="dateEndchanged" class="nui-datepicker" />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
				</td>
			</tr>
		</table>
	</div>
			</div>
	<div class="nui-fit" >
		<div id="usersGrid" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="boundUserData" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="true">
            <div property="columns">
            	<div field="storeName" headerAlign="center" align="center" >微信门店</div>
            	<div field="userMarke" headerAlign="center" align="center"  >微信服务号</div>
            	<div field="userOpid" headerAlign="center" align="left" width="160" >微信openId</div>
            	<div field="userNickname" headerAlign="center" align="center" >昵称</div>
            	<div field="userName" headerAlign="center" align="center" >姓名</div>
            	<div field="userGender" headerAlign="center" align="center" renderer="onSex" >性别</div>
            	<div field="userPhone" headerAlign="center" align="center"  >电话</div>
            	<div field="userBirthday" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" >生日</div>
            	<div field="userBindingTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >绑定时间</div>
            	<div field="userLastOperationTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >最近使用时间</div>
            </div>
        </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var storeId = nui.get("storeId");
    	var usersGrid = nui.get("usersGrid");
    	var pathapi=apiPath+wechatApi;
    	
    	$(function(){
    		usersGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryBoundUser.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeId.select(0);
			initLoad();
		});
		
		
		
		//初始化表格
		function initLoad(){
			var formData = new nui.Form("#form1").getData(false, false);
        	usersGrid.load({map:formData,token:token});
		}
    	
    	//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData(false, false);
			if( nui.get("userBindingTimeBegin").getText() != "" ) formData.userBindingTimeBegin = nui.get("userBindingTimeBegin").getText()+ " 00:00:00";
			if( nui.get("userBindingTimeEnd").getText() != "" ) formData.userBindingTimeEnd = nui.get("userBindingTimeEnd").getText()+ " 23:59:59";
        	usersGrid.load({map:formData,token:token});
    	}
    	
    	//清空
    	function reset(){
    		var storeValue=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
    	
    	//选择门店
    	function onValuechangedStore(){
    		search();
    	}
    	
    	//性别
    	function onSex(e){
    		return e.value == "1" ? "男" : "女";
    	}
    	
    	//开始关注日期改变事件
		function dateBeginchanged(){
			nui.get("userBindingTimeEnd").setMinDate(nui.get("userBindingTimeBegin").getValue());
		}
		//结束关注日期改变事件
		function dateEndchanged(){
			nui.get("userBindingTimeBegin").setMaxDate(nui.get("userBindingTimeEnd").getValue());
		}
		
    </script>
</body>
</html>