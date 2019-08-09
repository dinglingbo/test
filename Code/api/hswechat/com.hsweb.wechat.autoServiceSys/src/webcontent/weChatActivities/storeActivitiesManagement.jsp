<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-05-22 16:18:41
  - Description:
-->
<head>
<title>门店活动维护</title>
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
	<div id="form1" class="nui-form"  >
			<div class="nui-toolbar" style="padding:0px;">
       <table style="width: 100%;">						
			<tr>
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  onvaluechanged="OnStore" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >门店活动标题：</label>
					<input id="storeActivityTitle" name="storeActivityTitle" class="nui-textbox inputLeft"  />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
						<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;门店活动添加</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;门店活动编辑</a>
					<a id="deleteActivity" class="nui-button" onclick="deleteActivity" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;门店活动删除</a>
				</td>
			</tr>
		</table>
	</div>
		</div>
	<div class="nui-fit" >
		<div id="storeActivityData" class="nui-datagrid" style="height:100%;" allowResize="true"
	       	 dataField="storeActivityDataArray" pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" width="60" >门店名称</div>
            	<div field="storeActivityTitle" headerAlign="center" align="center" width="60" >门店活动标题</div>
            	<div field="storeActivityUrl" headerAlign="center"  width="40" align="center" >门店活动链接</div>
            	<div field="storeActivityIsStart" headerAlign="center" align="center" renderer="onStoreActivityIsStart" >是否启用</div>
            	<div field="creator" headerAlign="center"  width="40" align="center" >创建人</div>
            	<div field="createDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="60">创建时间</div>
            	<div field="modifier" headerAlign="center"  width="40" align="center" >更改人</div>
            	<div field="modifyDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="60">更改时间</div>
            </div>
        </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
		var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
		var storeId = nui.get("storeId");
		var storeActivityData = nui.get("storeActivityData");
    	
    	$(function(){
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeActivityData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreActivity.queryStoreActivityPage.biz.ext");
			storeId.select(0);
    		search();
		});
		
		//项目类型
    	function onStoreActivityIsStart(e){
    		return e.value == "0" ? "未启用" : "已启用";
    	}
		
		//删除
		function deleteActivity(){
			var row = storeActivityData.getSelected();
			if(row){
				var json=nui.encode({storeActivity:row});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreActivity.deleteStoreActivity.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							showMsg("删除成功","S");
							storeActivityData.reload();
						}else{
							showMsg("删除失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条活动项目数据","W");
			}
		}
		
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatActivities/addStoreActivities.jsp",
				title: "添加门店活动",
				width: 800,
				height: 550,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						pageType: "add"
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					if(action == 'saveSuccess') {
						showMsg("添加成功","S");
						storeActivityData.reload();
					}else if(action == 'saveFail'){
						showMsg("添加失败","E");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = storeActivityData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatActivities/addStoreActivities.jsp",
					title: "编辑门店活动",
					width: 800,
					height: 550,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							storeActivityData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'editSuccess') {
							showMsg("编辑成功","S");
							storeActivityData.reload();
						}else if(action == 'editFail'){
							showMsg("编辑失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条门店活动数据","W");
			}
			
		}
		
		//门店名称
		function OnStore(){
			search();
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	storeActivityData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var storeValue=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
    </script>
</body>
</html>