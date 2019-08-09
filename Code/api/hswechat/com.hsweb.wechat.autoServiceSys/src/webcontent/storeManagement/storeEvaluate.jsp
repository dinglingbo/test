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
<title>评价管理</title>
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
					<input id="storeId" name="storeId" class="nui-combobox" textField="storeName" value="" onvaluechanged="OnStore" valueField="storeId" dataField="wechatStoreData" />&nbsp;&nbsp;
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<!--<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>-->
					<span class="separator"></span>
					<a class="nui-button" onclick="queryStoreCommentInfo()" plain="true" ><span class="fa fa-toggle-right fa-lg"></span>&nbsp;查看详情</a>
				</td>
			</tr>
		</table>
	</div>
		</div>
	<div class="nui-fit" ">
		<div id="storeCommentData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="storeCommentArray" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div type="indexcolumn" width="25" >序列</div>
            	<div field="storeName" headerAlign="center" align="center" >门店</div>
            	<div field="userNickname" headerAlign="center" align="center"  >用户昵称</div>
            	<div field="userName"  headerAlign="center" align="center"  >用户姓名</div>
            	<div field="carNo"  headerAlign="center" align="center"  >用户车牌号</div>
            	<div field="commentScore"  headerAlign="center" align="center"  >评分</div>
            	<div field="commentDate"  headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" >评分时间</div>
            </div>
        </div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var storeCommentData = nui.get("storeCommentData");
    	var storeId = nui.get("storeId");
    	
    	$(function(){
    		storeCommentData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryStoreComment.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeCommentData.load({token:token});
			storeId.select(0);
			search();
		});
		
		//门店名称
		function OnStore(){
			search();
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData(false, false);
        	storeCommentData.load({paramMap:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
			storeId.select(0);
    	}
		
		//点击查看详情
		function queryStoreCommentInfo(){
			var row = storeCommentData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/storeManagement/storeCommentInfo.jsp",
					title: "查看评分详情",
					width: 900,
					height: 600,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							storeCommentData:row
						};
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						
					}
				});
			}else{
				nui.alert("请选择一条评分数据");
			}
		}
		
    </script>
</body>
</html>