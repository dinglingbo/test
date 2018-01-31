<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-30 15:44:55
  - Description:
-->
<head>
<title>班组定义</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/DataBase/Team/team.js?v=1.0.1"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">

	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
		<table style="width: 100%;">
			<tr>
				<td style="white-space: nowrap;"><label
					style="font-family: Verdana;">快速查询：</label> <a class="nui-button"
					plain="true" onclick="onSearch(0)">已启用</a> <a class="nui-button"
					plain="true" onclick="onSearch(1)">已禁用</a> <a class="nui-button"
					plain="true" onclick="onSearch(2)">全部</a></td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div class="nui-splitter" id="splitter" allowResize="false"
			handlerSize="6" style="width: 100%; height: 100%;">
			<div size=40% " showCollapseButton="false" style="border-right: 0">
				<div class="nui-toolbar"
					style="padding: 2px; border-top: 0; border-left: 0; border-bottom: 0;">
					<table style="width: 100%;">
						<tr>
							<td style="white-space: nowrap;"><a class="nui-button"
								plain="true" iconCls="icon-add" onclick="addTeam()">新增班组</a> <a
								class="nui-button" plain="true" iconCls="icon-edit"
								onclick="editTeam()">修改班组</a> <a class="nui-button" plain="true"
								iconCls="icon-no" onclick="disableTeamQuality()"
								id="disabledLeft" visible="false">禁用班组</a></td>
						</tr>
					</table>
				</div>
				<div class="nui-fit">
					<div id="leftGrid" class="nui-datagrid"
						style="width: 100%; height: 100%;" dataField="rpbclass"
						showPager="false" onrowdblclick="editTeam" ondrawcell="onDrawCell"
						onrowclick="onLeftGridRowClick" selectOnLoad="true" url="">
						<div property="columns">
							<div type="indexcolumn" headerAlign="center">序号</div>
							<div header="班组信息" headerAlign="center">
								<div property="columns">
									<div field="name" width="60" headerAlign="center"
										allowSort="true">编码</div>
									<div field="captainName" headerAlign="center" allowSort="true">名称</div>
									<div field="isDisabled" width="60" allowSort="true"
										headerAlign="center">是否禁用</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false" style="border-left: 0">
				<div class="nui-toolbar"
					style="padding: 2px; border-top: 0; border-right: 0; border-bottom: 0;">
					<table style="width: 100%;">
						<tr>
							<td style="white-space: nowrap;"><a class="nui-button"
								plain="true" iconCls="icon-add" onclick="addTeamMember()">添加成员</a>

								<a class="nui-button" plain="true" iconCls="icon-no"
								onclick="disableTeamMember()" id="disabledRight" visible="false">禁用成员</a>

							</td>
						</tr>
					</table>
				</div>
				<div class="nui-fit">
					<div id="rightGrid" class="nui-datagrid"
						style="width: 100%; height: 100%;" showPager="false"
						ondrawcell="onDrawCell" dataField="rpbclass"
						onrowdblclick="disableTeamMember" selectOnLoad="true" url="">
						<div property="columns">
							<div type="indexcolumn" headerAlign="center">序号</div>
							<div header="成员信息" headerAlign="center">
								<div property="columns">
									<div field="code" width="60" headerAlign="center"
										allowSort="true">编码</div>
									<div field="name" width="100" headerAlign="center"
										allowSort="true">名称</div>
									<div field="isDisabled" width="60" allowSort="true"
										headerAlign="center">是否禁用</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>