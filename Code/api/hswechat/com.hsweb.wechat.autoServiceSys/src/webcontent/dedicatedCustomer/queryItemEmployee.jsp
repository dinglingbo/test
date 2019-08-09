<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-01 15:57:44
  - Description:
-->
<head>
<title>项目选择</title>
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
    </style>
</head>
<body>
	<div id="form1" class="nui-form">
	<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%; ">				
			<tr>
				<td  style="font-size:12px;">
					<label class="labeltext" >门店名称： </label>
					<input id="storeId" name="storeId" class="nui-combobox"  textField="storeName" value="" url="com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext" valueField="storeId" dataField="wechatStoreData" />
					<label class="labeltext" >员工姓名：</label>
					<input name="employeName" class="nui-textbox inputLeft"  />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					<span class="separator"></span>
					 <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
				</td>
			</tr>
		</table>
	</div>
		</div>
	<div class="nui-fit" >
		<div id="serviceItemData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="wxbStoreEmploye" pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="50" >选择</div>
            	<div field="storeId" headerAlign="center" align="left" renderer="onStoreId">门店</div>
            	<div field="employeName" headerAlign="center" align="center" >员工姓名</div>
            	<div field="employePhone" headerAlign="center" align="center"  >员工手机</div>
            	<div field="employeWechat" headerAlign="center" align="center"  >员工微信</div>
            	<div field="employePosition" headerAlign="center" align="center" renderer="onEmployePosition" width="65" >职务</div>
            </div>
        </div>
	</div>
	

	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var serviceItemData = nui.get("serviceItemData");
    	
    	$(function(){
    		serviceItemData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryStoreEmploye.biz.ext");
			serviceItemData.load({token:token});
		});
		
		function setFormData(info){
			var data=nui.clone(info);
			nui.get("storeId").setValue(data.storeId);
			var formData = new nui.Form("#form1").getData();
        	serviceItemData.load({map:formData,token:token});
//         	nui.get("storeId").setEnabled(false);
		}
		
		function getFormData(){
			return serviceItemData.getSelected();
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData();
        	serviceItemData.load({map:formData,token:token});
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
    	
    
		
		//职务
		function onEmployePosition(e){
			return e.value == 1 ? "客服" : '技师';
		}
		
		//门店
		function onStoreId(e){
			return e.value;
		}
		
	
    	
    
    	
    	//确定
		function save(){
			if(!serviceItemData.getSelected()){
				nui.alert("请选择一条数据");
				return;
			}
			CloseWindow("save");//将选择的项目传入到输入框内
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