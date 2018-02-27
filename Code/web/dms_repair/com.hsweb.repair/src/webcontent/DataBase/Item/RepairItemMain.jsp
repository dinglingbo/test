<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 17:00:58
  - Description:
-->
<head>
<title>维修项目</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/repair/js/DataBase/Item/RepairItemMain.js" type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="form" id="queryForm">
		<div class="nui-toolbar" style="height: 30px; padding: 2px; border-bottom: 0;">
			<table class="table" id="table1" style="height: 100%">
				<tr>
					<td>
						<label style="font-family: Verdana;font-size: 12px;">快速查询：</label> 
						<label style="font-family: Verdana;;font-size: 12px;">工种：</label> 
						<input id="applyWorkTypeId"
                           name="applyWorkTypeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
						<label style="font-family: Verdana;;font-size: 12px;">品牌：</label> 
						<input id="applyCarBrandId"
                           name="applyCarBrandId"
                           class="nui-combobox width1"
                           textField="carBrandZh"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
						<label style="font-family: Verdana;;font-size: 12px;">项目编码：</label> 
						<input class="nui-textbox" id="search-code" name="code"/> 
						<label style="font-family: Verdana;;font-size: 12px;">项目名称：</label> 
						<input class="nui-textbox" id="search-name" name="name" /> 
						<!-- separator 分离器 -->
						<span class="separator"></span>
						<a class="nui-button" plain="true" iconCls="icon-search" onclick="onSearch()">查询（Q）</a> 
						<a class="nui-button" plain="true" onclick="onClean()">清空（C）</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar"  style="border-bottom: 0; padding: 0px; height: 30px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" id="add" iconCls="icon-add" onclick="add()" plain="true">新增项目（A）</a>
					<a	class="nui-button" id="update" iconCls="icon-edit" onclick="edit()"	plain="true">修改项目（E）</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		showHandleButton="false">
		<div size="20%" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar"
					style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					<span>项目类型</span>
				</div>
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;"
						dataField="dics" resultAsTree="false" parentField="parentId"
						showTreeIcon="true" textField="name" idField="id" 
						
						onrowclick="onRepairGridRowClick"
						contextMenu="#treeMenu"
					>
					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-fit">
				<div id="rightGrid" dataField="rpbItems" class="nui-datagrid"
					style="width: 100%; height: 91%;"
					url="" pageSize="50"
					multiSelect="true"
					showPageSize="false" 
					allowSortColumn="true"
					selectOnLoad="true"
					allowCellSelect="true"
					showFilterRow="false"
					
					
				>
					<div property="columns" >
						<div type="indexcolumn">序号</div>
						<div header="项目基本信息" headerAlign="center">
							<div property="columns">
								<div field="code" headerAlign="center" width="100px">项目编号</div>
								<div field="name" headerAlign="center" allowSort="true" width="150px">项目名称</div>
								<div field="itemKind" headerAlign="center" allowSort="true" width="40px">工种</div>
								<div field="type" headerAlign="center" allowSort="true" width="100px">项目类型</div>
								<div field="carBrandId" headerAlign="center" allowSort="true" width="60px">品牌</div>
								<div field="carModel" headerAlign="center" allowSort="true" width="60px">车型</div>
							</div>
						</div>
						<div header="项目价格信息" headerAlign="center">
							<div property="columns">
								<div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="70px">工时</div>
								<div field="unitPrice" headerAlign="center" allowSort="true" width="80px">工时单价</div>
								<div field="amt" headerAlign="center" allowSort="true" width="80px">工时费</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<ul id="treeMenu" class="nui-contextmenu" onbeforeopen="onBeforeOpen">
    <li name="add" iconCls="icon-add" onclick="onAddNode">新增同级</li>
    <li name="addChild" iconCls="icon-add" onclick="onAddChildNode">新增子级</li>
    <li name="edit" iconCls="icon-edit" onclick="onEditNode">修改</li>
</ul>

	
</body>
</html>