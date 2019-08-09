<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2018-12-26 16:08:41
  - Description:
-->
<head>
<title>轮播图维护</title>
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
<style>

</style>
<body >
	<div id="form1" class="nui-form"  >
		<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%;">						
			<tr>
				<td style="font-size: 12px">
					<label class="labeltext" >门店：</label>
						<input id="storeId" name="storeId" class="nui-combobox" required="true"  onvaluechanged="OnStore" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
						<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
						<!--<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>-->
						<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;轮播图添加</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;轮播图编辑</a>
					<a id="deleteSlid" class="nui-button" onclick="deleteSlid()" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
				</td>
			</tr>
		</table>
	</div>
		</div>
	<div class="nui-fit" >
		<div id="slidGrid" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="storeSlideShowDataArray" onrowclick="rowclick" pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" width="60" >门店</div>
            	<div field="wxbTitle" headerAlign="center" align="center" width="60" >标题</div>
            	<div field="pictureUrl" headerAlign="center" align="center" width="60" >图片地址</div>
            	<div field="wxbOrder" headerAlign="center" align="center" width="60" >顺序</div>
            	<div field="slideshowState" headerAlign="center" align="center" width="60" renderer="onSlideshowState" >状态</div>
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
		var slidGrid = nui.get("slidGrid");
		var storeId = nui.get("storeId");
    	
    	//加载门店轮播图信息
    	$(function(){
    		slidGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatSlideShow.inquireInformation.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
			search();
		});
		
		//选择行的时候触发
		function rowclick(e){
			var record=e.record;
			if(record.slideshowState == 0){
				$("#deleteSlid").show();
			}else{
				$("#deleteSlid").hide();
			}
		}
		
		//状态
		function onSlideshowState(e){
			return e.value == 0 ? "未启用" : "启用";
		}
		
		//删除
		function deleteSlid(){
			var row = slidGrid.getSelected();
			if(row){
				var json=nui.encode({wxbSlideshowData:row,wxbSlideshowDetailArray:row.slideDetailArray});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatSlideShow.deleteSlideShow.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							showMsg("删除成功","S");
							slidGrid.reload();
						}else{
							showMsg("删除失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条数据","W");
			}
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData(false, false);
        	slidGrid.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var storeValue=storeId.getValue();
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.setValue(storeValue);
    	}
    	
    	//门店名称
		function OnStore(){
			search();
		}
    	
    	//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/slideShow/addSlideShow.jsp",
				title: "添加轮播图",
				width: 840,
				height: 640,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						pageType: "add",
						storeId:nui.get("storeId").getSelected().storeId,
						tenantId:nui.get("storeId").getSelected().tenantId
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					if(action == 'saveSuccess') {
						showMsg("添加成功","S");
						slidGrid.reload();
					}else if (action == "saveFail") {
						showMsg("添加失败","E");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = slidGrid.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/slideShow/addSlideShow.jsp",
					title: "编辑轮播图",
					width: 840,
					height: 640,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							slideShowData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							showMsg("编辑成功","S");
							slidGrid.reload();
						}else if (action == "saveFail") {
							showMsg("编辑失败","E");
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