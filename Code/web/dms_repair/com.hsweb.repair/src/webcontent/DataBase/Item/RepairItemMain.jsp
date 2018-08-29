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
<title>维修工时</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Item/RepairItemMain.js?v=1.1.6" type="text/javascript"></script>

</head>
<body>
<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
	<div class="form" id="queryForm">
		<table class="table" id="table1">
			<tr>
				<td>
					<label style="font-family: Verdana;font-size: 12px;">快速查询：</label>
					<!-- <label style="font-family: Verdana;;font-size: 12px;">工种：</label>
					<input id="itemKind"
						   name="itemKind"
						   class="nui-combobox width1"
						   textField="name"
						   valueField="customid"
						   emptyText="请选择..."
						   url=""
						   allowInput="false"
						   showNullItem="false"
						   nullItemText="请选择..."/> -->
						   
					<!-- <label style="font-family: Verdana;;font-size: 12px;">品牌：</label> -->
					<input id="carBrandId"
						   name="carBrandId"
						   class="nui-combobox width1"
						   visible="false"
						   textField="nameCn"
						   valueField="id"
						   emptyText="请选择..."
						   url=""
						   allowInput="false"
						   showNullItem="false"
						   nullItemText="请选择..."/>
                           
                    <!-- <input id="costType" visible="false"
						   name="costType"
						   class="nui-combobox width1"
						   textField="name"
						   valueField="customid"/> -->
				<label style="font-family: Verdana;;font-size: 12px;">工时编码：</label>
					<input class="nui-textbox" id="search-code" name="code"/>
					<label style="font-family: Verdana;;font-size: 12px;">工时名称：</label>
					<input class="nui-textbox" id="search-name" name="name" />
					<span class="separator"></span>
					<a class="nui-button" plain="true" iconCls="" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
					<a class="nui-button" plain="true" iconCls="" onclick="onClear()"><span class="fa fa-trash-o"></span>&nbsp;清空</a>
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="nui-toolbar"  style="border-bottom: 0; padding: 0px; height: 30px;">
	<table style="width: 100%">
		<tr>
			<td style="width: 100%">
				<a class="nui-button" id="add" iconCls="" onclick="add()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增工时</a>
				<a class="nui-button" id="update" iconCls="" onclick="edit()" plain="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改工时</a>
				<span class="separator" id="sep"></span>
				<a class="nui-button" id="addItemType" iconCls="" onclick="addItemType()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增类型</a>
				<a class="nui-button" id="editItemType" iconCls="" onclick="editItemType()" plain="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改类型</a>
				<a class="nui-button" id="selectBtn" iconCls="" onclick="onOk()" plain="true" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
			</td>
		</tr>
	</table>
</div>
<div class="nui-fit">
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		 showHandleButton="false">
		<div size="200" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar"
					 style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					<span>工时类型</span>
				</div>
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;"
						dataField="data"
						resultAsTree="false"
						showTreeIcon="true"
						textField="name" idField="id" parentField="dictid">
					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-fit">
				<div id="rightGrid"
					 dataField="list"
					 class="nui-datagrid"
					 style="width: 100%; height: 100%;"
					 url=""
					 borderStyle="border:0"
					 pageSize="50"
					 totalField="page.count"
					 sortMode="client"
					 multiSelect="true"
					 showPageSize="true"
					 allowSortColumn="true"
					 selectOnLoad="true"
					 allowCellSelect="true"
					 onDrawCell="onDrawCell"
					 showFilterRow="false">
					<div property="columns" >
						<div type="indexcolumn">序号</div>
						<div header="工时基本信息" headerAlign="center">
							<div property="columns">
								<div field="code" headerAlign="center" width="100px">工时编号</div>
								<div field="name" headerAlign="center" allowSort="true" width="150px">工时名称</div>
								<div field="type" headerAlign="center" allowSort="true" width="100px">工时类型</div>
								<div field="isShare" headerAlign="center" allowSort="true" width="100px">是否共享</div>
								<div field="isDisabled" headerAlign="center" allowSort="true" width="100px">是否禁用</div>
								<div field="orgid" headerAlign="center" allowSort="true" width="50px">所属</div>
							</div>
						</div>
						<div header="工时价格信息" headerAlign="center">
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
</div>

<div id="advancedAddWin" class="nui-window"
     title="工时类型" style="width:300px;height:160px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedAddForm" class="form">
        <input id="id" name="id" width="100%" class="nui-hidden" >
    	<input id="orgid" name="orgid" width="100%" class="nui-hidden" >
        <table class="tmargin" style="width:100%;margin-top:10px;">
            <tr class="htr">
                <td class=" right fwidtha required">类型名称:</td>
                <td ><input id="name" name="name" width="100%" class="nui-textbox" ></td>
            </tr>
            <tr class="htr">
                <td class=" right fwidtha required">上级类型:</td>
                <td ><input id="dictid" name="dictid" width="100%" class="nui-combobox" textField="name" valueField="id"     dataField="" url="" valueFromSelect="true" allowinput="true"></td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedAddOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedAddCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>

	
</body>
</html>