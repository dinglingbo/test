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
<title>客服管理</title>
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

	    .labeltext{
	    	font-family:Verdana;
	    	line-height: 25px;
	    }
	    .inputLeft{
	    	margin-right: 6px;
	    }
	    
	    .divImg{
	    	width: 120px;
    		margin: auto;
	    }
	    .imgStyle{
	    	border: none;
		    max-width: 100%;
		    height: auto;
		    vertical-align: middle;
	    }
	    .windowsss{
	    	z-index: 100;
	    	margin: auto;
	    	position: absolute;
	    	top: 0;
	    	left: 0;
	    	right: 0;
	    	bottom: 0;
	    }
	    .imgList{
	    	overflow: auto;
	    	border: 1px solid #B8B8B8;
		    border-radius: 5%;
		    height: 500px;
		    width: 315px;
		    padding: 10px;
	    }
	    .imgListA{
	    	display: flex;
	    	border-bottom: 2px solid #f2f5f7;
	    }
	    .imgListOneDiv{
	    	background: none repeat scroll 0 0 rgba(229, 229, 229, 0.85);
    		position: absolute;
    		width: 278px;
    		
    		height: 182px;
    		padding-top: 50px;
	    }
	    .imgListone{
		    width: 28px;
    		height: 28px;
    		position: relative;
    		margin-left: 35%;
    		cursor: pointer;
	    }
	    .imgListtwo{
		   	width: 28px;
    		height: 28px;
    		position: relative;
    		margin-left: 5%;
    		cursor: pointer;
	    }

	    
	    
    </style>
</head>
<body>
	<!-- 员工选择 -->
		<div id="advancedOrgWin" class="nui-window windowsss"
		     title="客服管理用户" style="width:530px;height:400px;margin: 10% 30%;"
		     showModal="true"
		     showHeader="false"
		     allowResize="false"
		     allowDrag="true">
		 
		     <div class="nui-toolbar" style="width:100%;text-align: right;padding:2px 0px;border:0px;">
		             <a class="nui-button" onclick="hiddenWin()" plain="true" ><span class="fa fa-remove fa-lg"></span></a>
		     </div>
		   <div class="nui-fit" >
		        <div id="moreOrgGrid" class="nui-datagrid " allowResize="false" showHeader="true" title="客服管理用户"
			       	 dataField="userData" pageSize="12" style="height:93%" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
		            <div property="columns">
		            	<div field="userMarke" headerAlign="center" align="center" width="60" >服务号</div>
		            	<div field="userNickname" headerAlign="center"  width="50" align="center" >用户昵称</div>
		            	<div field="userName" headerAlign="center" align="center""  width="60" >用户姓名</div>
		            </div>
		        </div>
		    </div>
		</div>

	<div id="form1" class="nui-form" >
	<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%; ">						
			<tr>
				<td style="font-size: 9pt;display: flex;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  onvaluechanged="OnStore" textField="storeName" value=""  valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >员工姓名： </label>
					<input id="employeName" name="employeName"	class="nui-textbox inputLeft" />&nbsp;&nbsp;
					<label class="labeltext" >客服类别： </label>
					<div id="serviceType" name="serviceType" class="nui-radiobuttonlist" style="display: inline-table;" textField="text" valueField="id" repeatLayout="none"  data='[{"id":1,"text":"服务客服"},{"id":2,"text":"技术客服"}]' /></div>
					
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;客服添加</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;客服编辑</a>
					<a id="deleteEmp" class="nui-button" onclick="deleteEmp" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
					<a id="queryUser" class="nui-button" onclick="queryUser" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查看客服管理用户</a>
				</td>
			</tr>
		</table>
	</div>
	</div>
	<div class="nui-fit" >
		<div id="storeEmployeGrid" class="nui-datagrid" style="height:100%;" allowResize="true"
	       	 dataField="customeerServiceEmpDataArray" onrowclick="rowclick" pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" width="60" >微信门店</div>
            	<div field="employeName" headerAlign="center" align="center" width="60" >员工姓名</div>
            	<div field="employePosition" headerAlign="center" align="center" renderer="onEmployePosition"  width="60" >职务</div>
            	<div field="serviceType" headerAlign="center" align="center" renderer="onServiceType" width="60" >客服</div>
            	<div field="manageNumber" headerAlign="center" align="center" width="60" >用户管理人数</div>
            	<div field="serviceMaxNumber" headerAlign="center" align="center" width="60" >最大管理人数</div>
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
		var storeEmployeGrid = nui.get("storeEmployeGrid");
    	var moreOrgGrid = nui.get("moreOrgGrid");
    	
    	$(function(){
    		moreOrgGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.queryCustomerServiceManagerUser.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
    		storeEmployeGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.queryCustomerServiceEmp.biz.ext");
			storeEmployeGrid.load({token:token});
			storeId.select(0);
    		search();
		});
		
		//查看其下管理用户serviceId
		function queryUser(){
			var row = storeEmployeGrid.getSelected();
			if(row){
				$("#advancedOrgWin").show();
				moreOrgGrid.load({serviceId:row.serviceId,token:token});
			}else{
				showMsg("请选择一条客服数据","W");
			}
		}
		function hiddenWin(){
			$("#advancedOrgWin").hide();
			moreOrgGrid.setData([]);
		}
		
		//选择行的时候触发
		function rowclick(e){
			var record=e.record;
			if(record.empBool){
				$("#deleteEmp").show();
			}else{
				$("#deleteEmp").hide();
			}
		}
		
		//删除员工
		function deleteEmp(){
			var row = storeEmployeGrid.getSelected();
			if(row){
				var json=nui.encode({
					customerServiceEmp:{
						serviceId:row.serviceId,
						isDelete:1
					}
				});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.editCustomerServiceEmp.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							showMsg("删除成功","S");
							storeEmployeGrid.reload();
						}else{
							showMsg("删除失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条客服数据","W");
			}
		}
		
		//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/storeEmploye/addStoreCustomerService.jsp",
				title: "添加客服",
				width: 600,
				height: 520,
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
						storeEmployeGrid.reload();
					}else if(action == 'saveFail'){
						showMsg("添加失败","E");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = storeEmployeGrid.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/storeEmploye/addStoreCustomerService.jsp",
					title: "编辑客服",
					width: 600,
					height: 520,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							customeerServiceEmpDataArray:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'editSuccess') {
							showMsg("编辑成功","S");
							storeEmployeGrid.reload();
						}else if(action == 'editFail'){
							showMsg("编辑失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条客服数据","W");
			}
			
		}
		
		
		
		//从业经验
		function onServiceType(e){
			return e.value == 1 ? "服务客服" : "技术客服";
		}
		
		//职务
		function onEmployePosition(e){
			return e.value == 1 ? "客服" : "技师";
		}
		
		//门店名称
		function OnStore(){
			search();
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	storeEmployeGrid.load({map:formData,token:token});
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