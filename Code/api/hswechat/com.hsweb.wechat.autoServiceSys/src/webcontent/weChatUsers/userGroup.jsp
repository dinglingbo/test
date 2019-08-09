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
<title>用户标签</title>
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
					<input id="storeId" name="storeId" class="nui-combobox" style="margin-right: 30px;" textField="storeName" onvaluechanged="OnStore" value="" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >标签名称： </label>
					<input name="groupName"	class="nui-textbox inputLeft" style="margin-right: 30px;"/>&nbsp;&nbsp;
					<label class="labeltext" >用户姓名：</label>
					<input name="userName" class="nui-textbox inputLeft"  style="margin-right: 30px;"/>&nbsp;&nbsp;
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;添加标签</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑标签</a>
					<a class="nui-button" onclick="deleteUserGroup()" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除标签</a>
					<a class="nui-button" onclick="userAllot()" plain="true" ><span class="fa fa-clone fa-lg"></span>&nbsp;用户分配</a>
				</td>
			</tr>
		</table>
	</div>
		</div>	
			<div class="nui-fit"  >
	<div id="userGroup" class="nui-datagrid" style="width: 100%; height: 100%;" allowResize="true"
        idField="groupId" dataField="userGroupArrayData" pageSize="12" showPageInfo="true" onshowrowdetail="onShowRowDetail" onselect="onSelect" >
        <div property="columns">
        	<div type="checkcolumn" >选择</div>
        	<div type="expandcolumn" >用户详情</div>
        	<!-- <div field="groupTabId" headerAlign="center" align="center" width="30" >标签标识</div> -->
        	<div field="groupName" headerAlign="center" align="center">标签名称</div>
            <div field="storeName" headerAlign="center" align="center">门店名称</div>
            <div field="creator"  headerAlign="center" align="center" width="35"  >创建人</div>
            <div field="createDate" headerAlign="center" align="center" width="50" dateFormat="yyyy-MM-dd HH:mm:ss" >创建日期</div>
            <div field="modifier"  headerAlign="center" align="center" width="35"  >更改人</div>
            <div field="modifyDate" headerAlign="center" align="center" width="50" dateFormat="yyyy-MM-dd HH:mm:ss" >更改日期</div>
        </div>
    </div>
	
	<div id="userGroup_Form" style="display:none;">
	        <div id="boundUserInfo" class="nui-datagrid" style="width:100%;" dataField="boundUserData" pageSize="10" 
		      showPager="false"  showPageInfo="true" multiSelect="false">
            <div property="columns">
            	<div field="userMarke" headerAlign="center" align="center"  >微信服务号</div>
            	<div field="userOpid" headerAlign="center" align="left" width="160" >微信opId</div>
            	<div field="userName" headerAlign="center" align="center" >姓名</div>
            	<div field="userGender" headerAlign="center" align="center" renderer="onSex" >性别</div>
            	<div field="userPhone" headerAlign="center" align="center"  >电话</div>
            	<div field="userBirthday" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" >生日</div>
            	<div field="userBindingTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >绑定时间</div>
            	<div field="userLastOperationTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >最近使用时间</div>
            </div>
        </div>    
    </div>
</div>

	<script type="text/javascript">
    	nui.parse();
    	var userGroup = nui.get("#userGroup");
    	var boundUserInfo = nui.get("#boundUserInfo");
    	var userGroup_Form = document.getElementById("userGroup_Form");
    	var storeId = nui.get("storeId");
    	
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	
    	$(function(){
    		userGroup.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryUserGroup.biz.ext");
    		boundUserInfo.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryBoundUserGroup.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeId.select(0);
			initLoad();
		});
		
		//选中事件
		function onSelect(){
			var row = userGroup.getSelected();
			var formData = new nui.Form("#form1").getData(false, false);
        	formData.groupId=row.groupId;
            boundUserInfo.load({map:formData,token:token});
		}
		
		//选择门店自动查询
		function OnStore(){
			search();
		}
		
		//初始化表格
		function initLoad(){
        	userGroup.load({token:token});
        	search();
		}
    	
    	//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	userGroup.load({map:formData,token:token});
    	}
    	
    	//点击查看用户信息
    	function onShowRowDetail(e){
    		var grid = e.sender;
            var row = e.record;
            var td = userGroup.getRowDetailCellEl(row);
            td.appendChild(userGroup_Form);
            userGroup_Form.style.display = "block";
            
            var formData = new nui.Form("#form1").getData(false, false);
        	formData.groupId=row.groupId;
            boundUserInfo.load({map:formData,token:token});
    	}
    	
    	//清空
    	function reset(){
    		var storeValue=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
    	
    	//性别
    	function onSex(e){
    		return e.value == "1" ? "男" : "女";
    	}
    	
    	//删除
    	function deleteUserGroup(){
    		var row = userGroup.getSelected();
			if(row){
				var json=nui.encode({userGroup:row});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.deleteUserGroup.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							showMsg("删除成功","S");
							userGroup.reload();
						}else{
							showMsg("删除失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条数据","W");
			}
    	}
    	
    	//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatUsers/addUserGroup.jsp",
				title: "添加标签",
				width: 610,
				height: 300,
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
						userGroup.reload();
					}else if(action == "saveFail"){
						showMsg("添加失败","E");
					}
				}
			});
		}
    	
		//编辑
		function edit() {
			var row = userGroup.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatUsers/addUserGroup.jsp",
					title: "编辑标签",
					width: 610,
					height: 300,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							userGroupData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							showMsg("修改成功","S");
							userGroup.reload();
						}else if(action == "saveFail"){
							showMsg("修改失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条数据","W");
			}
			
		}
		
		//用户分配
		function userAllot(){
			var row = userGroup.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatUsers/userAllotGroup.jsp",
					title: "用户分配",
					width: 860,
					height: 500,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "allot",
							userAllotGroupData: row,
							userData:boundUserInfo.getData()
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							showMsg("分配成功","S");
							userGroup.reload();
						}else if(action == "saveFail"){
							showMsg("分配失败","E");
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