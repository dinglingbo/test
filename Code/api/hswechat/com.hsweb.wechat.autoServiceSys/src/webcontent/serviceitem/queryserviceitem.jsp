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
<body>
	<div id="form1" class="nui-form">
	<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%; ">						
			<tr>
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  textField="storeName" value="" url="com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >项目活动标题： </label>
					<input id="itemactivitytitle"	class="nui-textbox inputLeft" />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;添加项目活动</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑项目活动</a>
					<a class="nui-button" onclick="del()" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除项目活动</a>
				</td>
			</tr>
		</table>
	</div>
		</div>	
		<div class="nui-fit">
	<div id="itemdata" class="nui-datagrid" style="width: 100%; height: 100%;" allowResize="true"
        idField="item_activity_id" url="com.hsapi.wechat.autoServiceBackstage.serviceitem.queryserviceitem.biz.ext" dataField="out1" pageSize="12" showPageInfo="true">
        <div property="columns">
        	<div type="checkcolumn" >选择</div>
        	<div field="item_activity_id" headerAlign="center" align="center">id</div>
        	<div field="storeName" headerAlign="center" align="center">门店名称</div>
            <div field="serviceName" headerAlign="center" align="center">项目名称</div>
            <div field="item_activity_title"  headerAlign="center" align="center" width="35">项目活动标题</div>
            <div field="create_date" headerAlign="center" align="center" width="50" dateFormat="yyyy-MM-dd HH:mm:ss" >创建日期</div>
            <div field="creator"  headerAlign="center" align="center" width="35">创建人</div>
            <div field="modify_date" headerAlign="center" align="center" width="50" dateFormat="yyyy-MM-dd HH:mm:ss" >更改日期</div>
            <div field="modifier"  headerAlign="center" align="center" width="35">更改人</div>
        </div>
    </div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var pathweb=webPath+wechatDomain;
    	var itemGroup = nui.get("#itemdata");
    	itemGroup.load();
    	//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/serviceitem/addserviceitem.jsp",
				title: "添加标签",
				width: 610,
				height: 300,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						pageType: "add"
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					if(action == 'saveSuccess') {
						nui.alert("添加成功", "系统提示");
						itemGroup.reload();
					}else if(action == "saveFail"){
						nui.alert("添加失败", "系统提示");
					}
				}
			});
		}
    	
		//编辑
		function edit() {
			var row = itemGroup.getSelected();
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
							nui.alert("修改成功", "系统提示");
							userGroup.reload();
						}else if(action == "saveFail"){
							nui.alert("修改失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条数据", "系统提示");
			}
			
		}
		
		function del(){
			
		}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
    	
    	//搜索
    	function search(){
    		var par = {};
    		par.storeId = nui.get("storeId").value;
    		par.itemactivitytitle = nui.get("itemactivitytitle").value;
        	itemGroup.load({par:par,token:token});
    	}
    </script>
</body>
</html>