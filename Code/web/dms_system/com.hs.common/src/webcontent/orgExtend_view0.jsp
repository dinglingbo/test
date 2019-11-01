<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
	<title>门店管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%=webPath + contextPath%>/common/js/orgExtendQuery.js?v=1.9.8" type="text/javascript"></script>
	<link href="<%=webPath + contextPath%>/common/js/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/common/js/HeaderFilter.js" type="text/javascript"></script>
	<style type="text/css">
		body {
			margin: 0;
			padding: 0;
			border: 0;
			width: 100%;
			height: 100%;
			overflow: hidden;
		}

		.gridborder .mini-panel-border,
		.gridborder .mini-grid-border {
			border-top: 0px;
		}

		.mini-toolbar {
			font-weight: bold;
		}

		.mini-grid-headerCell,
		.mini-grid-topRightCell {
			font-weight: bold;
		}

		.mini-checkbox-check {
			margin-right: 0px;
		}
	</style>
</head>

<body>
	<div class="nui-fit">
		<div style="width: 100%; height: 100%; left: 0; right: 0; margin: 0 auto;">
			
			<div class="nui-toolbar">
				<input class="nui-combobox" id="provinceId" visible="false" textField="name" url="" valueField="code" />
				<input class="nui-combobox" id="cityId" visible="false" textField="name" url="" valueField="code" />
				<input id="name" name="name" class="mini-textbox" emptytext="输入公司名称查询" width="200" onenter="search()"/>
				<a class="nui-button" onclick="search()" plain="true" enabled="">
					<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
				<a class="nui-button "  margin-right: 10px;" iconcls="" plain="true" onclick="edit('new')">
					<span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
				<a class="nui-button "  margin-right: 10px;" iconcls="" plain="true" onclick="edit('edit')">
					<span class="fa fa-pencil fa-lg"></span>&nbsp;修改</a>
				<a class="nui-button "  iconcls="" plain="true" onclick="stoporstart('1')"
				 id="jy" name="jy">
					<span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
				<a class="nui-button "  iconcls="" plain="true" onclick="stoporstart('2')"
				 visible="false" id="qy" name="qy">
					<span class="fa fa-check fa-lg"></span>&nbsp;启用</a>
				<a class="nui-button "  margin-right: 10px;" iconcls="" plain="true" onclick="openEle">
				<span class="fa fa-pencil fa-lg"></span>&nbsp;开通电子档案</a>
			</div>

			<div class="nui-fit">
				<div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height: 100%;" url="" idField="id" allowResize="true" onrowdblclick="edit('edit')"
				 dataField="rs" onselectionchanged="changebutton" sizeList="[20,30,50,100]" pageSize="20" allowCellWrap="true" totalField="page.count">
					<div property="columns">
						<div type="checkcolumn">选择</div>
						<div field="orgid" width="120" headerAlign="center" align="center" visible="false">企业ID</div>
						<div field="code" name="code" width="90" headerAlign="center" align="center">企业号</div>
						<div field="name" name="name" width="100" align="center" headerAlign="center" align="center">公司全称</div>
						<div field="shortName" name="shortName" width="90" align="center" headerAlign="center" align="center">公司简称</div>
						<div field="tel" headerAlign="center" width="60" align="center">电话</div>
						<div field="provinceId" width="50" headerAlign="center" align="center">省份</div>
						<div field="cityId" width="50" headerAlign="center" align="center">城市</div>
						<div field="address" width="100" headerAlign="center" align="center">地址</div>
						<div field="isOpenSystem" width="40" headerAlign="center" align="center">状态</div>
						<div field="softOpenDate" width="60" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" allowSort="true">开店日期</div>
						<div field="recorder" name="recorder" width="90" headerAlign="center" align="center">建档人</div>
						<div field="recordDate" width="60" headerAlign="center" align="center" dateFormat="yyyy-MM-dd" allowSort="true">建档日期</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>