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
<title>推送用户</title>
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

	<div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="push()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;推送</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
	</div>

	<div class="nui-fit" style="padding:5px;">
		<input id="imageTextId" name="imageTextId"	class="nui-textbox inputLeft" style="display:none;"/>
		<input id="storeId" name="storeId"	class="nui-textbox inputLeft" style="display:none;"/>
		<div id="form1" class="nui-form">
			<table style="width: 100%;padding-left:5px;">						
				<tr>
					<td style="font-size: 9pt;display: flex;">
						<label class="labeltext" >服务号： </label>
						<input name="userMarke"	class="nui-textbox inputLeft" style="margin-right: 30px;"/>&nbsp;&nbsp;
					</td>
					<td>
						<label class="labeltext" >用户昵称： </label>
						<input name="userName" class="nui-textbox inputLeft"  style="margin-right: 30px;"/>&nbsp;&nbsp;
					</td>
					<td>
						<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
						<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					</td>
				</tr>
			</table>
		</div>
		
		<table style="width:100%;height:280px ;">
			<input class="nui-textbox" name="groupId" id="groupId" visible="false"/>
	        <tr>
	            <td style="height:100%;">
	            	<div class="nui-fit">
	               <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" dataField="boundUserData"
		    		multiSelect="true" onrowdblclick="adds" sizeList="[10,20,50,100]">
						    <div property="columns">
						    	<div field="userOpid" headerAlign="center" align="center" >用户openid</div>
						        <div type="checkcolumn"></div> 
						        <div field="storeName" headerAlign="center" align="center" >微信门店</div>
				            	<div field="userMarke" headerAlign="center" align="center"  >用户服务号</div>
				            	<div field="userNickname" headerAlign="center" align="center"  >用户昵称</div>
				            	<div field="userName" headerAlign="center" align="center" >用户姓名</div>
				            	<div field="userPhone" headerAlign="center" align="center"  >用户电话</div>
						     </div>
						</div>
						</div>
	            </td>
	            <td style="width:60px;text-align:center;">
					 <a class="nui-button" onclick="adds()"  style="width:40px;"  onclick="ok">></a><br />
					 <a class="nui-button" onclick="removes()"  style="width:40px;"  onclick="ok">&lt;</a><br />
					 <a class="nui-button" onclick="removeAll()" style="width:40px;"  onclick="ok">&lt;&lt;</a>
	            </td>
	           <td style="width:125px;height:100%;">
	           	<div class="nui-fit">
	                <div id="datagrid2" class="nui-datagrid" style="width:100%;height:100%;" multiSelect="true" onrowdblclick="removes" showPager="false">
					    <div property="columns">
					    	<div field="userId" width="60" headerAlign="center" allowSort="true"></div>
					    	<div field="userOpid" headerAlign="center" align="center" >用户openid</div>
					    	<div type="checkcolumn"></div>
					        <div field="userMarke" width="60" headerAlign="center" allowSort="true">用户服务号</div>
					        <div field="userNickname" width="60" headerAlign="center" allowSort="true">用户昵称</div>
					     </div>
					</div>
					</div>
	            </td>
	            <!-- <td  style="height:100%;">
	                <a class="nui-button" onclick="moveUp()" style="width:20px;"  >∧</a>
	                <a class="nui-button" onclick="moveDown()" style="width:20px;" >∨</a>
	            </td> -->
	        </tr>
	    
	    </table>   
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var form = new mini.Form("#form1");
		var grid1 = mini.get("datagrid1");
		var grid2 = mini.get("datagrid2");
		
		var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	
		$(function(){
    		grid1.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryBoundUser.biz.ext");
			grid1.load({token:token});
			grid1.hideColumn(0);
			grid2.hideColumn(0);
			grid2.hideColumn(1);
		});
		
		//传入弹窗的数据
		function setFormData(data){
			var infos = nui.clone(data);
			var formData={
				storeId:infos.imageTextData.storeId
			}
			nui.get("storeId").setValue(infos.imageTextData.storeId);
			nui.get("imageTextId").setValue(infos.imageTextData.imageTextId);
			grid1.load({map:formData,token:token});
		}
		
		//保存
		function push(){
			if( grid2.getData().length < 2 ){
				showMsg("至少要有两个用户！","W");
				return;
			}
			var data={
				imageTextId:nui.get("imageTextId").getValue(),
				storeId:nui.get("storeId").getValue(),
				openIdList:grid2.getData()
			}
			var json=nui.encode(data);
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.pushUserImageTextMessage.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					if(text.errCode == "S"){
						CloseWindow("pushSuccess");
					}else{
						CloseWindow("pushFail");
					}
				}
			});
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData(false, false);
    		formData.storeId=nui.get("storeId").getValue();
        	grid1.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
		
		// 添加到右边 
		function adds() {
			var items = grid1.getSelecteds();
			doAddItems(items);
		}
		
		// 添加到右边 做重复数据判断
		function doAddItems(items) {
			items = mini.clone(items);
	
			//根据empid判断，去除重复的item
			for (var i = items.length - 1; i >= 0; i--) {
				var item = items[i];
				var item2 = grid2.findRow(function(row) {
					if (row.userId == item.userId)
						return true;
				});
				if (item2) {
					items.removeAt(i);
				}
			}
	
			grid2.addRows(items);
		}
		
		//删除全部
		function removeAll() {
			var items = grid2.getData();
			grid2.removeRows(items);
		}
		
		//删除一个
		function removes() {
			var items = grid2.getSelecteds();
			grid2.removeRows(items);
		}
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		
		//关闭窗口
		function CloseWindow( action ) {
			if(action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if(window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
    </script>
</body>
</html>