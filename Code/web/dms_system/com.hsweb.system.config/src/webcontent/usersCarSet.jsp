<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-12 16:44:24
  - Description:
-->
<head>
<title>客户车辆设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   <%@include file="/common/sysCommon.jsp"%>
    
</head>
<body>

	<div id="tabs1" class="nui-tabs" activeIndex="0" style="width:95%;height:90%; margin-left: 3%; margin-top: 1% " plain="false">
	<div title="客户级别">
	 <div style="margin-left: 68%; margin-top: 1%; height: 3%;">
	 <input class="nui-button"onclick="isalter" iconCls="icon-add" text="新建">
	 <input class="nui-button"onclick="isalter" iconCls="icon-edit" text="修改" >
	 <input class="nui-button"onclick="isalter" iconCls="icon-remove" text="停用">
	 <input class="nui-button"onclick="isalter" iconCls="icon-addnew" text="启用">
	 </div>
	 <div style="margin-left: 5%; margin-top: 1%; height: 80%;">
 
	<div id="dgGrid" class="nui-datagrid" 
				style="width: 80%; height: 100%; margin-left: 1%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
				dataField="data" idField="id"
				treeColumn="name" parentField="parentId" showPager="false">
				<div property="columns" width="10">
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">客户级别</div>
							<div field="guestFullName" allowSort="true" headerAlign="center"
								width="120">工单折扣</div>
							<div field="serviceTypeId" allowSort="true" headerAlign="center"
								width="120">洗车单折扣</div>
							<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">零售单折扣</div>
							<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">理赔单折扣</div>
								<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">状态</div>
				</div>
			</div>
			</div>
	
	</div>
	<div title="客户来源">
	 <div style="margin-left: 68%; margin-top: 1%; height: 3%;">
	 <input class="nui-button"onclick="isalter" iconCls="icon-add" text="新建">
	 <input class="nui-button"onclick="isalter" iconCls="icon-edit" text="修改" >
	 <input class="nui-button"onclick="isalter" iconCls="icon-remove" text="停用">
	 <input class="nui-button"onclick="isalter" iconCls="icon-addnew" text="启用">
	 </div>
	 <div style="margin-left: 5%; margin-top: 1%; height: 80%;">
 
	<div id="dgGrid1" class="nui-datagrid" 
				style="width: 80%; height: 100%; margin-left: 1%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
				dataField="data" idField="id"
				treeColumn="name" parentField="parentId" showPager="false">
				<div property="columns" width="10">
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">客户来源</div>
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">状态</div>	
				</div>
			</div>
	</div>
	
	</div>
	<div title="车辆分类">
		 <div style="margin-left: 5%; margin-top: 5%; height: 80%;">
 
	<div id="dgGrid2" class="nui-datagrid" 
				style="width: 80%; height: 100%; margin-left: 1%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
				dataField="data" idField="id" 
				treeColumn="name" parentField="parentId" showPager="false">
				<div property="columns" width="10">
				<div type="indexcolumn">序号</div>
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">名称</div>
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">默认</div>	
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">启用</div>	
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">操作</div>	
				</div>
			</div>
	</div>
	
	</div>
	
	</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>