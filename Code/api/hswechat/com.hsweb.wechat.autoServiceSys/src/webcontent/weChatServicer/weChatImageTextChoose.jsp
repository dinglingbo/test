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
<title>微信图文选择</title>
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
    <</style>
</head>
<body>
	<div id="form1" class="nui-form">
		<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%;">						
			<tr>
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox" textField="storeName" value="" onvaluechanged="OnStore" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >标题： </label>
					<input id="imageTextTitle" name="imageTextTitle" class="nui-textbox inputLeft"  />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
				</td>
			</tr>
		</table>
	</div>
		</div>
	<div class="nui-fit" >
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
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.select(0);
    	}
    	
		//消息状态
		function onImageTextStatus(e){
			return e.value == 0 ? "未推送" : "已推送";
		}
		
		
    </script>
</body>
</html>