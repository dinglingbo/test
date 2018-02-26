<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2018-01-23 09:46:46
  - Description:
-->
<head>
<title>班组定义</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/repair/js/DataBase/Team/TeamMain.js"></script>





</head>
<body>

	<div class="nui-toolbar" id="form1" style="height: 30px; padding: 2px; border-bottom: 0;">
		<table class="table" id="table1" style="height: 100%">
			<tr style="width: 100%; height: 12%; line-height: 12%;">
				<td>
				<label style="font-family:Verdana;font-size: 12px;">快速查询：</label> <a
					class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(0)"><u>已启用</u></a> <a
					class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(1)"><u>已禁用</u></a> <a
					class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(2)"><u>全部</u></a></td>
			</tr>
		</table>
	</div>



	<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" showHandleButton="false">
		<div size="45%" showCollapseButton="false">
			<!-- 班组 -->
			<div class="nui-toolbar"
				style="padding: 2px; border-top: 0; border-left: 0; border-bottom: 0;">
				<table style="width: 100%">
					<tr>
						<td style="white-space: nowrap;">
							<a class="nui-button" id="add" iconCls="icon-add" onclick="addTeam()" plain="true">添加班组</a>
							<a class="nui-button" id="update" iconCls="icon-edit" onclick="editTeam()" plain="true">编辑班组</a> 
							<a class="nui-button" id="disabledLeft" iconCls="icon-no" onclick="disableTeam()" plain="true" >禁用班组</a>
							<a class="nui-button" plain="true" iconCls="icon-ok" onclick="enableTeam()" id="enabledLeft" visible="false">启用班组</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="leftGrid" dataField="rpbclass" class="nui-datagrid"
					style="width: 100%; height: 95%;" 
					url="" 
					showPageInfo="false" multiSelect="true" showPageIndex="false"showPagerButtonIcon="false" 
					 showPageSize="false" showReloadButton="false" allowSortColumn="true"
					
					ondrawcell="onDrawCell"
					onrowdblclick="editTeam"
					onrowclick="onLeftGridRowClick"
					selectOnLoad="true" 
				>

					<div property="columns">
						<div type="indexcolumn" headerAlign="center">序号</div>
						<div header="班组信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true">维修工种</div>
								<div  field="name" headerAlign="center" allowSort="true" visible="true">班组名称</div>
								<div  field="captainName" headerAlign="center" allowSort="true" visible="true">班组长名字</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" renderer="onIsDisabled">是否禁用</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div showCollapseButton="false" style="border-left: 0">
			<!-- 班组成员-->
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">

				<table style="width: 100%">
					<tr>
						<td style="white-space: nowrap;"><a class="nui-button"
							plain="true" iconCls="icon-add" onclick="addTeamMember()">添加成员</a>
							<a class="nui-button" plain="true" iconCls="icon-no"
							onclick="disableTeamMember()" id="disabledRight">禁用成员</a></td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="rightGrid" dataField="members" class="nui-datagrid"
					style="width: 100%; height: 95%;"
					url="" 
					showPageInfo="false" multiSelect="true" showPageIndex="false"
					showPageSize="false" showReloadButton="false"
					showPagerButtonIcon="false" totalCount="total"
					allowSortColumn="true" selectOnLoad="true"
					
					ondrawcell="onDrawCell"
					onrowdblclick="editTeamMember"
					selectOnLoad="true" 
					>
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" visible="true" width="30px">序号</div>
						<div header="成员信息" headerAlign="center">
							<div property="columns">
								<div  field="code" headerAlign="center" allowSort="true" visible="true">成员编号</div>
								<div  field="name" headerAlign="center" allowSort="true">班组成员</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true">是否禁用</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




</body>
</html>