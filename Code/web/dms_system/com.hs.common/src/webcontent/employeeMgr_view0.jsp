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
    <%-- <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script> --%>
    <script src="<%=request.getContextPath()%>/common/js/employeeQuery.js?v=1.7" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">



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
					<a class="nui-button" plain="true" id="qy" namr="qy" iconCls="icon-undo" onclick="stoporstart()" visible="false">开通账号（B）</a> 
					<a class="nui-button" plain="true" id="jy" namr="jy" iconCls="icon-print" onclick="stoporstart()">停用账号（P）</a>
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
			pageSize="50" showPageInfo="true" multiSelect="true"
			showReloadButton="true" showPagerButtonIcon="true"
			totalField="page.count" onselectionchanged="changebutton"
			allowSortColumn="true">

			<div property="columns">
				
						<div type="checkcolumn" >选择</div>
						<div id="empid" field="empid" headerAlign="center" allowSort="true"  width="40px" visible="false">id</div>
						<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="40px">姓名</div>
						<div id="Sex" field="sex" headerAlign="center" allowSort="true" visible="true" width="20px">性别</div>
						<div id="idcardno" field="idcardno" headerAlign="center" allowSort="true" visible="true" >身份证</div>
						<div id="birthday" field="birthday" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd H:mm:ss">生日</div>
						<div id="tel" field="tel" headerAlign="center" allowSort="true" visible="true" width="40px">电话</div>
						<div id="isDimission" field="isDimission" headerAlign="center" allowSort="true" visible="true" width="60px">是否离职</div>
						<div id="isOpenAccount" field="isOpenAccount" headerAlign="center" allowSort="true" visible="true" width="60px">是否开通系统</div>
						<div id="systemAccount" field="systemAccount" headerAlign="center" allowSort="true" visible="true" width="60px">登入账号</div>
						<div id="recorder" field="recorder" headerAlign="center" allowSort="true" visible="true" width="60px">建档人</div>
						<div id="recordDate" field="recordDate" headerAlign="center" allowSort="true" visible="true" width="60px" dateFormat="yyyy-MM-dd H:mm:ss">建档日期</div>
		
				
			</div>
		</div>
	</div>
</body>
</html>