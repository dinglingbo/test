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
<title>微信图文消息维护</title>
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
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  textField="storeName" value="" onvaluechanged="OnStore" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >标题： </label>
					<input id="imageTextTitle" name="imageTextTitle" class="nui-textbox inputLeft"  />&nbsp;&nbsp;

					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑</a>
					<a class="nui-button" onclick="pushUserList()" plain="true" ><span class="fa fa-toggle-right fa-lg"></span>&nbsp;推送</a>
					<a class="nui-button" onclick="delete()" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
				</td>
			</tr>
		</table>
	</div>
	</div>
	<div class="nui-fit"  >
		<div id="imageTextData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="ImageTextMainDataArray" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="50" >选择</div>
            	<div field="storeName" headerAlign="center" align="left" >微信门店</div>
            	<div field="textTitle" headerAlign="center" align="center"  >标题</div>
            	<div field="imageTextType" headerAlign="center" align="center" renderer="onImageTextType" width="65" >类型</div>
            	<!-- <div field="imageTextStatus" headerAlign="center" align="center" renderer="onImageTextStatus" width="65" >状态</div> -->
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
    	var storeId = nui.get("storeId");
    	var imageTextData = nui.get("imageTextData");
    	
    	$(function(){
    		imageTextData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.queryImageTextMessageMain.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			imageTextData.load({token:token});
			storeId.select(0);
    		search();
		});
		
		//门店名称
		function OnStore(){
			search();
		}
		
		//推送用户
		function pushUserList(){
			var row = imageTextData.getSelected();
			console.log(row);
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatMessage/pushUserList.jsp",
					title: "推送用户",
					width: 810,
					height: 420,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							imageTextData:row
						};
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'pushSuccess') {
							showMsg("推送成功","S");
							imageTextData.reload();
						}else if(action == "pushFail"){
							showMsg("推送失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条图文消息","W");
			}
		}
		
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatMessage/addWeChatImageTexr.jsp",
				title: "添加微信图文消息",
				width: 1490,
				height: 670,
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
						showMsg("添加成功","S");
						imageTextData.reload();
					}else if(action == 'saveFail'){
						showMsg("添加失败","E");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = imageTextData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatMessage/addWeChatImageTexr.jsp",
					title: "编辑微信图文消息",
					width: 1490,
					height: 670,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							imageTextData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							showMsg("编辑成功","S");
							imageTextData.reload();
						}else if(action == 'saveFail'){
							showMsg("编辑失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条图文消息","W");
			}
		}
		
		
		//消息类型
		function onImageTextType(e){
			switch (Number(e.value)) {
			case 1:
				return "文本";
			case 2:
				return "图片";
			case 3:
				return "单图文";
			case 4:
				return "多图文";
			}
			return "";
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	imageTextData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var storeValue=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
    	
		//消息状态
		function onImageTextStatus(e){
			return e.value == 0 ? "未推送" : "已推送";
		}
		
		
    </script>
</body>
</html>