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
<title>关键字回复</title>
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
					<input id="storeId" name="storeId" class="nui-combobox" style="margin-right: 30px;" onvaluechanged="OnStore" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >标题： </label>
					<input id="keywordReplyTitle" name="keywordReplyTitle"	class="nui-textbox inputLeft" />
					<label class="labeltext" >关键字： </label>
					<input id="keyword" name="keyword"	class="nui-textbox inputLeft" />

					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;添加关键字</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;编辑关键字</a>
					<a id="deleteReplyMain" class="nui-button" onclick="deleteReplyMain" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除关键字</a>
				</td>
			</tr>
		</table>
	</div>
		</div>	
	<div class="nui-fit" >
		<div id="keywordReplyData" class="nui-datagrid" style="height:100%;" allowResize="true"
	       	 dataField="keywordReplyDataArray"  pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" width="60" >门店</div>
            	<div field="keywordReplyTitle" headerAlign="center" align="center" width="60" >标题</div>
            	<div field="keyword" headerAlign="center" align="center" width="60" >关键字</div>
            	<div field="matchingType" headerAlign="center"  width="50" align="center" renderer="onMatchingType" >匹配类型</div>
            	<div field="triggerType" headerAlign="center"  width="50" align="left" renderer="onTriggerType" >触发类型</div>
            	<div field="replyType" headerAlign="center" align="center"  width="60" renderer="onReplyType" >回复类型</div>
            	<div field="isStartUsing" headerAlign="center" align="center" width="60" renderer="onIsStartUsing" >状态</div>
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
		var keywordReplyData = nui.get("keywordReplyData");
    	var storeId = nui.get("storeId");
    	
    	$(function(){
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
    		keywordReplyData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatKeywordReply.queryKeywordReply.biz.ext");
			keywordReplyData.load({token:token});
			search();
		});
		
		//门店名称
		function OnStore(){
			search();
		}
		
		
		//匹配类型
		function onMatchingType(e){
			return e.value == 1 ? "模糊匹配" : "完全匹配";
		}
		
		//触发类型
		function onTriggerType(e){
			return e.value == 1 ? "文本消息回复" : "菜单点击";
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
		
		
		//状态
		function onIsStartUsing(e){
			return e.value == 0 ? "未启用" : "启用";
		}
		
		//删除关键字
		function deleteReplyMain(){
			var row = keywordReplyData.getSelected();
			if(row){
				row.pageType = 'delete';
				var json=nui.encode({param:row});
				keywordReplyData.loading("正在删除中,请稍等...");
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.saveKeyReply.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						keywordReplyData.unmask();
						if(text.result.code == "S"){
							nui.alert("删除成功", "系统提示");
							keywordReplyData.reload();
						}else{
							nui.alert("删除失败", "系统提示");
						}
					}
				});
			}else{
				keywordReplyData.unmask();
				nui.alert("请选择一条员工数据", "系统提示");
			}
		}
		
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/weChatServicer/replyMainForm.jsp",
				title: "添加关键字",
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
					url: pathweb+"/autoServiceSys/weChatServicer/replyMainForm.jsp",
					title: "编辑关键字",
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
				nui.alert("请选择一条关键字数据", "系统提示");
			}
			
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