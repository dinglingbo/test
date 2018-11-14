<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>	
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>员工管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />	
    <script src="<%=webPath + contextPath%>/common/js/employeeQuery.js?v=2.1.1" type="text/javascript"></script>    
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		<input class="nui-hidden" name="criteria/_entity" value="" />
		<table id="form1" style="width:100%;">
			<tr>
				<td style="white-space:nowrap;">
					<label style="font-family:Verdana;">姓名：</label>
					<input class="nui-textbox" id="name" name="meberName" onenter="search()"/>
					<label style="font-family:Verdana;">电话：</label>
					<input class="nui-textbox" id="mobile" name="mobile" onenter="search()" />
					<a class="nui-button"  iconCls="" onclick="search()" plain="true"><span class="fa fa-search"></span>&nbsp;查询</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="" onclick="edit('new')"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
					<a class="nui-button" plain="true" iconCls="" onclick="edit('edit')"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
					<a class="nui-button" plain="true" iconCls="" id="btnisDimission" name="btnisDimission" onclick="dimssion()"><span class="fa fa-user-times"></span>&nbsp;离职</a>
					<a class="nui-button" plain="true" id="btnisOpenAccount" name="btnisOpenAccount" iconCls="" onclick="stoporstart()" ><span class="fa fa-key"></span>&nbsp;开通账号</a>
					<a class="nui-button" plain="true" id="resetPasswordBtn" name="resetPasswordBtn" iconCls="" onclick="resetPassword()" ><span class="fa fa-key"></span>&nbsp;重置密码</a>
					<a class="nui-button" plain="true" iconCls="" onclick="importGuest()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div id="datagrid1" 
			dataField="rs" 
			class="nui-datagrid"
			style="width: 100%; height: 100%;"
			url=""
			showModified="false" onrowdblclick="edit('edit')"
			pageSize="50" showPageInfo="true" multiSelect="false"
			showReloadButton="true" showPagerButtonIcon="true"
			totalField="page.count" onselectionchanged="changebutton" 
			allowSortColumn="true">

			<div property="columns">
				
						<div type="checkcolumn">选择</div>
						<div id="empid" field="empid" headerAlign="center" allowSort="true"  width="40px" visible="false">id</div>
						<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="40px">姓名</div>
						<div id="compShortName" field="compShortName" headerAlign="center" allowSort="true" visible="true" width="60px">所属机构</div>
						<div id="sex" field="sex" headerAlign="center" allowSort="true" visible="true" width="20px">性别</div>
						<div id="idcardno" field="idcardno" headerAlign="center" allowSort="true" visible="true" width="80px">身份证</div>
						<div id="birthday" field="birthday" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="60px">生日</div>
						<div id="tel" field="tel" headerAlign="center" allowSort="true" visible="true" width="60px">电话</div>
						<div id="isDimission" field="isDimission" headerAlign="center" allowSort="true" visible="true" width="40px">是否离职</div>
						<div id="isOpenAccount" field="isOpenAccount" headerAlign="center" allowSort="true" visible="true" width="50px">是否开通系统</div>
						<div id="systemAccount" field="systemAccount" headerAlign="center" allowSort="true" visible="true" width="50px">登陆账号</div>
						<div id="recorder" field="recorder" headerAlign="center" allowSort="true" visible="true" width="60px">建档人</div>
						<div id="recordDate" field="recordDate" headerAlign="center" allowSort="true" visible="true" width="60px" dateFormat="yyyy-MM-dd hh:MM">建档日期</div>
		
				
			</div>
		</div>
	</div>
</body>
</html>