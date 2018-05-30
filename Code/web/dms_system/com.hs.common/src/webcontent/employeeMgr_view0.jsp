<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>员工管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp"%>
    <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/common/js/employeeQuery.js?v=1.1" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
    body {
       margin: 0;
       padding: 0;
       border: 0;
       width: 100%;
       height: 100%;
       overflow: hidden;
   }

   .gridborder .mini-panel-border,.gridborder .mini-grid-border{
    border-top: 0px ;

}

.mini-toolbar
{
  font-weight:bold;
}

.mini-grid-headerCell, .mini-grid-topRightCell
{
  font-weight:bold;
}
.mini-checkbox-check {

    margin-right: 0px;
    
}
</style> 
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>						
						<label class="form_label" >姓名：</label>
						<input class="nui-textbox" id="name" name="meberName" onenter="" /> 
						<label class="form_label" >电话：</label>
						<input class="nui-textbox" id="mobile" name="mobile" onenter="" /> 
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询（Q）</a>
						<a class="nui-button"  onclick="onMore()" plain="true" style="color:#0000FF;"><u>更多</u></a>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-reload" onclick="reload()">刷新（R）</a> 
					<a class="nui-button" plain="true" iconCls="icon-add" onclick="edit('new')">新增（A）</a>
					<a class="nui-button" plain="true" iconCls="icon-edit" onclick="edit('edit')">修改（S）</a> 
					<a class="nui-button" plain="true" iconCls="" onclick="dimssion()">离职（S）</a> 
					<a class="nui-button" plain="true" iconCls="icon-undo" onclick="openSystemLoginName()">开通账号（B）</a> 
					<a class="nui-button" plain="true" iconCls="icon-print" onclick="closeSystemLoginName()">停用账号（P）</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div id="datagrid1" 
			dataField="rs" 
			class="nui-datagrid"
			style="width: 100%; height: 100%;"
			url="com.hsapi.system.employee.employeeMgr.employeeQuery.biz.ext"
			pageSize="50" showPageInfo="true" multiSelect="true"
			showReloadButton="true" showPagerButtonIcon="true"
			totalField="page.count"  onselectionchanged="selectionChanged" 
			allowSortColumn="true">

			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div header="基本信息" headerAlign="center"> 
					<div property="columns">
						<div id="Name" field="name" headerAlign="center" allowSort="true" visible="true" width="40px">姓名</div>
						<div id="Sex" field="sex" headerAlign="center" allowSort="true" visible="true" width="10px">性别</div>
						<div id="Dept" field="deptid" headerAlign="center" allowSort="true" visible="true" width="60px">部门</div>
						<div id="Duty" field="dutyid" headerAlign="center" allowSort="true" visible="true" width="60px">职务</div>
						<div id="Mobile" field="tel" headerAlign="center" allowSort="true" visible="true" width="40px">电话</div>
						<div id="RecordDate" field="recordDate" headerAlign="center" allowSort="true" visible="true" width="40px">入职日期</div>
					</div>
				</div>
				<div header="登陆信息" headerAlign="center">
					<div property="columns">
						<div id="userID" field="type" headerAlign="center" allowSort="true" visible="true" width="60px">系统用户ID</div>
						<div id="IsOpenAccount" field="type" headerAlign="center" allowSort="true" visible="true" width="10px">是否开通系统</div>
						<div id="SystemAccount" field="type" headerAlign="center" allowSort="true" visible="true" width="60px">系统账号</div>
					</div>
				</div>
				<div header="其它信息" headerAlign="center">
					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true" visible="true" width="100px">是否离职</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>