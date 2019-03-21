<%@page pageEncoding="UTF-8"%>
<%@page import="com.eos.system.utility.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): liuzn (mailto:liuzn@primeton.com)
  - Date: 2013-03-12 10:59:13
  - Description:
-->
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<head>
	<title>人员授权</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<style type="text/css">
		#employeeToolBar{
			width: 100%;
			margin: 0px;
			border: 0px none transparent;
			border-collapse: collapse;
		}
		#employeeToolBar td{
			padding: 0px;
			border: 1px solid transparent;
		}
	</style>
</head>
<body>
<div class="nui-fit" style="padding:10px;">
	<div id="employeeForm">
		<div class="nui-toolbar" style="text-align:left;line-height:30px;padding:5px 0px 5px 10px;" borderStyle="border-bottom:0;">
			<table id="employeeToolBar">
				<tr>
					<td style="width:1px;"></td>
					<td style="width:60px;"><a id="btn_save" class="nui-button" iconCls="" onclick="saving();"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a></td>
					<td></td>
					<td style="width:80px; text-align:right;">机构名称：</td>
					<td style="width:100px;">
						<input class="nui-textbox" id="orgname" name="orgname" emptyText="机构名称" style="width:100px;" />
					</td>
					<td style="width:80px; text-align:right;">员工姓名：</td>
					<td style="width:100px;">
						<input class="nui-textbox" id="empname" name="empname" emptyText="员工姓名" style="width:100px;" />
					</td>
					<td style="width:70px; text-align:right;"><input class="nui-button" iconCls="icon-search" text="查询" onclick="searchEmployee" /></td>
					<td style="width:10px;"></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="employeeGrid" class="nui-datagrid" style="width:100%;height:100%;"  onload="onGridLoad"
			url=""
			idField="empid" allowResize="false" allowCellEdit="true" sizeList="[10,20,30]" pageSize="20" multiSelect="true" dataField="empUserList" showPager="false" >
		    <div property="columns">
		        <div field="userId" width="120" headerAlign="center" >登录账号</div>
		        <div field="empName" width="120" headerAlign="center" >员工姓名</div>
		        <div field="shortName" width="120" headerAlign="center" allowSort="true">所属机构</div>
		        <div type="checkboxcolumn" field="isCheck" width="120" trueValue="1" falseValue="0">授权</div>
		    </div>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();
	var employeeGrid = nui.get("employeeGrid");
	var pageSize = employeeGrid.getPageSize();
	var loadUrl = apiPath + sysApi + "/com.hsapi.system.tenant.permissions.getRoleUserValue.biz.ext";
	var saveUrl = apiPath + sysApi + "/com.hsapi.system.tenant.permissions.savePartyAuths.biz.ext";
	<% if(null != request.getParameter("roleId") && !"".equals(request.getParameter("roleId"))){ %>
		var roleIdData = "<%= StringUtil.htmlFilter(request.getParameter("roleId")) %>";
		var sendData = {"roleId":roleIdData, token:token};
		employeeGrid.setUrl(loadUrl);
		employeeGrid.load(sendData);
	<% } %>

	function saving(){
		var addList = [];
		var deleteList = [];
		var employeeData = employeeGrid.getChanges("modified");
		for(var i = 0; i < employeeData.length; i++){
			var fieldNode = {
				partyId: employeeData[i].userId,
				partyType:'user',
				roleType:'role',
				roleId:"<%=request.getParameter("roleId") %>"
			};
			if(employeeData[i].isCheck == 1){
				addList.push(fieldNode);
			}else{
				deleteList.push(fieldNode);
			}
		}
		
		var roleList = [{
			id: "<%=request.getParameter("roleId") %>",
			code: "<%=request.getParameter("roleCode") %>",
			name: "<%=request.getParameter("roleName") %>",
			tenantID: "<%=request.getParameter("tenantId") %>"
		}];

		nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存中...'
	    });
	    
	    var json = nui.encode({
	    	roleId:"<%=request.getParameter("roleId") %>",
			addList:addList,
			deleteList:deleteList	
	    });
	    
	    nui.ajax({
	    	url: saveUrl,
	    	cache: false,
	    	async: false,
	    	data: json,
	    	type: 'POST',
	    	contentType:'text/json',
	    	success: function (text) {
	    		if(text.errCode == 'S'){
		    		nui.unmask();
		    		showMsg("权限设置成功","S");
					//nui.alert("权限设置成功");
	    		}else{
	    			nui.unmask();
	    			showMsg(text.errMsg||"权限设置失败","E");
					//nui.alert(text.errMsg||"权限设置失败");
	    		}
            },
            error: function () {
            }
	    });	
	}
	
	function searchEmployee(){
		var p = {};
		p.orgname = nui.get("orgname").getValue();
		p.empname = nui.get("empname").getValue();
        employeeGrid.load({roleId:"<%=request.getParameter("roleId") %>", p:p, token:token});
	}
	function onGridLoad(){
		var data = employeeGrid.getData();
		nui.get("btn_save").set({"enabled":(data.length>0)});
	}
</script>
