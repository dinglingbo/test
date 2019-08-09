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
		<table style="width: 100%; border: 1px solid #e3e3e3;padding-left:5px;border-top: 0px;">						
			<tr>
				<td style="font-size: 9pt;display: flex;">
					<a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:95%;">
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
    	var imageTextData = nui.get("imageTextData");
    	
		
		//弹窗页面传输数据
		function setFormData(info){
			var data=nui.clone(info);
			var map = {storeId:data.storeId,imageTextType:data.imageTextType};
			imageTextData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.queryImageTextMessageMain.biz.ext");
			imageTextData.load({map:map,token:token});
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
		
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
    	
		//消息状态
		function onImageTextStatus(e){
			return e.value == 0 ? "未推送" : "已推送";
		}
		
		//传选中行信息
		function getRowData(){
			return imageTextData.getSelected();
		}
		
		//保存
		function save(){
			var rowData = imageTextData.getSelected();
			CloseWindow('S');
		}
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		
		
		//关闭窗口
		function CloseWindow(action) {
			if(window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close(action);
		}
		
    </script>
</body>
</html>