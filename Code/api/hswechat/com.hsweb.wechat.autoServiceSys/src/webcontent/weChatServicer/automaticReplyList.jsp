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
<title>关注回复</title>
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
	<div id="form1" class="nui-form" style="padding: 3px;" >
		<table style="width: 100%; border: 1px solid #e3e3e3;padding-left:5px;">						
			<tr>
				<td style="font-size: 9pt;display: flex;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox" style="margin-right: 30px;" onvaluechanged="OnStore" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >标题： </label>
					<input id="automaticReplyTitle" name="automaticReplyTitle"	class="nui-textbox inputLeft" style="margin-right: 30px;"/>&nbsp;&nbsp;
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
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;添加关注回复</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑关注回复</a>
					<a id="deleteReplyMain" class="nui-button" onclick="deleteReplyMain" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除关注回复</a>
				</td>
			</tr>
		</table>
	</div>
		
	<div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:95%;">
		<div id="keywordReplyData" class="nui-datagrid" style="height:100%;" allowResize="true"
	       	 dataField="keywordReplyDataArray"  pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" width="60" >门店</div>
            	<div field="automaticReplyTitle" headerAlign="center" align="center" width="60" >标题</div>
            	<div field="automaticReplyType" headerAlign="center" align="center" width="60" renderer="onReplyType">响应类型</div>
            	<!-- <div field="imageTextContent" headerAlign="center"  width="50" align="left">回复文本内容</div> -->
            	<div field="isStartUsing" headerAlign="center"  width="50" align="center" renderer="showStatus">启用状态</div>
            	<!-- <div field="imageTextId" headerAlign="center"  width="50" align="left"  >回复内容（图文消息维护表外键）</div> -->
            </div>
        </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
		var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
		var keywordReplyData = nui.get("keywordReplyData");
    	var storeId = nui.get("storeId");
    	
    	$(function(){
    		keywordReplyData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatKeywordReply.queryAutomaticReply.biz.ext");
			keywordReplyData.load({token:token});
			storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
			search();
		});
		
		//点击改变状态
		function changeStatus(){
			var row = keywordReplyData.getSelected();
			if(row){
				var json=nui.encode({param:row});
				keywordReplyData.loading("正在修改中,请稍等...");
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.changeStatusReply.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						keywordReplyData.unmask();
						if(text.result.code == "S"){
							showMsg("操作成功","S");
							keywordReplyData.reload();
						}else{
							nui.alert("操作失败", "系统提示");
						}
					}
				});
			}else{
				keywordReplyData.unmask();
				nui.alert("请选择一条数据", "系统提示");
			}
		}
		
		
		//删除关注回复
		function deleteReplyMain(){
			var row = keywordReplyData.getSelected();
			if(row){
				row.pageType = 'delete';
				var json=nui.encode({param:row});
				keywordReplyData.loading("正在删除中,请稍等...");
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.operationAutoReply.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
					debugger;
						keywordReplyData.unmask();
						if(text.result.code == "S"){
							nui.alert("删除成功", "系统提示");
							keywordReplyData.reload();
						}else if(text.result.code == 'E' && text.result.msg != null){
							showMsg(text.result.msg,"E");
						}else{
							nui.alert("删除失败", "系统提示");
						}
					}
				});
			}else{
				keywordReplyData.unmask();
				nui.alert("请选择一条数据", "系统提示");
			}
		}
		
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatServicer/automaticReplyForm.jsp",
				title: "添加关注回复",
				width: 700,
				height: 640,
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
						keywordReplyData.reload();
					}else if(action == 'saveFail'){
						nui.alert("添加失败", "系统提示");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = keywordReplyData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatServicer/automaticReplyForm.jsp",
					title: "编辑关注回复",
					width: 700,
					height: 640,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							storeEmpData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							nui.alert("编辑成功", "系统提示");
							keywordReplyData.reload();
						}else if(action == 'saveFail'){
							nui.alert("编辑失败", "系统提示");
						}
					}
				});
			}else{
				nui.alert("请选择一条关注回复数据", "系统提示");
			}
			
		}
		
		//回复类型
		function onReplyType(e){
			switch (e.value) {
			case "1":
				return "文本";
			case "2":
				return "图片";
			case "3":
				return "单图文";
			case "4":
				return "多图文";
			}
		}
		
		//启用状态
		function showStatus(e){
			switch (e.value) {
			case 1:
				return '<a title="点击停用" class="nui-button" onclick="changeStatus()" style="border:1px;background-color:#28FF28;padding:3px;cursor:pointer">启用</a>';
			case 0:
				return '<a title="点击启用" class="nui-button" onclick="changeStatus()" style="border:1px;background-color:#FF5809;padding:3px;cursor:pointer">停用</a>';
			default :
				return "";
			}
		}
		
		//门店名称
		function OnStore(){
			search();
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	keywordReplyData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var storeValue = storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
    </script>
</body>
</html>