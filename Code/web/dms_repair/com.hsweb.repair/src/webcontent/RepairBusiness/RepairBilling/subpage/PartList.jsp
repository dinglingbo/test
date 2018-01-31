<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 13:52:54
  - Description:
-->
<head>
<title>辅料清单</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button" id="add"
					iconCls="icon-add" onclick="add()">新增</a> <a class="nui-button"
					id="edit" iconCls="icon-edit" onclick="edit()">修改</a> <a
					class="nui-button" id="remove" iconCls="icon-remove"
					onclick="remove()">删除</a></td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
			style="width: 100%; height: 240px;"
			url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
			pageSize="20" showPageInfo="true" multiSelect="true"
			showPageIndex="false" showPage="true" showPageSize="false"
			showReloadButton="false" showPagerButtonIcon="false"
			totalCount="total" onselectionchanged="selectionChanged"
			allowSortColumn="true">

			<div property="columns">
				<div id="type" field="type" headerAlign="center" allowSort="true"
					visible="true" width="120px">辅料编码</div>
				<div id="name" field="name" headerAlign="center" allowSort="true"
					visible="true" width="330px">辅料名称</div>
				<div id="captainName" field="captainName" headerAlign="center"
					allowSort="true" visible="true" width="70px">数量</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">单价</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">金额</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">优惠</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">小计</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>