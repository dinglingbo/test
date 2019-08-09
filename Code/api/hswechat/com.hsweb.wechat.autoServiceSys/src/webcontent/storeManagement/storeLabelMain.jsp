<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-20 14:53:42
  - Description:
-->
<head>
<title>门店标签维护</title>
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
	<div id="form1" class="nui-form" >
		<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%;">						
			<tr>
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  onvaluechanged="OnStore" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<!--<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>-->
					<span class="separator"></span>
					<a id="addBut" class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;标签添加</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;标签编辑</a>
					<a id="deleteLabel" class="nui-button" onclick="deleteLabel" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;标签删除</a>
					<span id="tipShow" style="color:red;display:none;">每个门店的标签不能超过6个</span>
				</td>
			</tr>
		</table>
	</div>
			</div>
	<div class="nui-fit" >
		<div id="storeLabelData" class="nui-datagrid" style="height:100%;" allowResize="true"
	       	 dataField="storeLabelDataArray" pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" width="60" >门店名称</div>
            	<div field="tabContent" headerAlign="center" align="center" width="60" >标签名称</div>
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
		var storeLabelData = nui.get("storeLabelData");
    	
    	$(function(){
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeLabelData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreLabel.queryStoreLabel.biz.ext");
			storeLabelData.load({token:token});
			storeId.select(0);
    		search();
		});
		
		
		
		//删除员工
		function deleteLabel(){
			var row = storeLabelData.getSelected();
			if(row){
				var json=nui.encode({storeLableData:row});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreLabel.deleteStoreLable.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							nui.alert("删除成功", "系统提示");
							search();
						}else{
							nui.alert("删除失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条员工数据", "系统提示");
			}
		}
		
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/storeManagement/addStoreLabel.jsp",
				title: "添加标签",
				width: 650,
				height: 160,
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
					console.log(action);
					if(action == 'saveSuccess') {
						nui.alert("添加成功", "系统提示");
						search();
					}else if(action == 'saveFail'){
						nui.alert("添加失败", "系统提示");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = storeLabelData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/storeManagement/addStoreLabel.jsp",
					title: "编辑标签",
					width: 650,
					height: 160,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							storeLabelData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'editSuccess') {
							nui.alert("编辑成功", "系统提示");
							search();
						}else if(action == 'editFail'){
							nui.alert("编辑失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条员工数据", "系统提示");
			}
			
		}
		
		
		//门店名称
		function OnStore(){
			search();
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	storeLabelData.load({map:formData,token:token},function(){
        	  if(storeLabelData.getData().length >= 6){
        	  	nui.get("addBut").disable();
        	  	$("#tipShow").show();
        	  }else if(storeLabelData.getData().length < 6){
        	  	nui.get("addBut").enable();
        	  	$("#tipShow").hide();
        	  }
        	});
        	
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.select(0);
    	}
    </script>
</body>
</html>