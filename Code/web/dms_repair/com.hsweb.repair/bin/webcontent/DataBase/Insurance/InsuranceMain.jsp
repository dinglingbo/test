<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:45:50
  - Description:
-->
<head>
<title>保险公司</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Insurance/InsuranceMain.js?v=1.0.6"></script>
<style type="text/css">
table {
	width: 100%;
}
</style>
</head>
<body>


<div class="nui-toolbar" style="border-bottom:0;">
	<div class="nui-form1" id="form1">
		<table class="table" id="table1">
			<tr>
<!-- 				<td>
					<label style="font-family:Verdana;font-size: 12px;">快速查询：</label>
					<a class="nui-button" plain="true" onclick="onSearch(0)" id="type0">已启用</a>
					<a class="nui-button" plain="true" onclick="onSearch(1)" id="type1">已禁用</a>
					<a class="nui-button" plain="true" onclick="onSearch(2)" id="type2">全部</a>
				</td> -->
				<td>
				  <label style="font-family:Verdana;">快速查询：</label>
				  	<a class="nui-menubutton " menu="#popupMenuStatus" id="type0">已启用</a>
                    <!-- <a class="nui-button" plain="true" onclick="onSearch(0)" id="type0">已启用</a> -->
                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="onSearch(0)" id="type0">已启用</li>
                        <li iconCls="" onclick="onSearch(1)" id="type0">已禁用</li>
                        <li iconCls="" onclick="onSearch(2)" id="type1">全部</li>
                    </ul>
                </td>
			</tr>
		</table>
	</div>
</div>
<div class="nui-toolbar" style="border-bottom:0;">
	<table>
		<tr>
			<td>
				<a class="nui-button" iconCls="" onclick="add()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
				<a class="nui-button" iconCls="" onclick="edit()" plain="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
				<a class="nui-button" iconCls="" onclick="disableComeguest()" id="disableBtn"
				   plain="true"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
				<a class="nui-button" iconCls="" onclick="enableComeguest()" id="enableBtn" plain="true"
				   visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;启用</a>
			</td>
		</tr>
	</table>
</div>
<div class="nui-fit">
	<div id="datagrid1" dataField="list" class="nui-datagrid" style="width:100%;height:100%;"
		 pageSize="20" showPageInfo="true" multiSelect="true" showPageIndex="true" showPage="true" showPageSize="true"
		 showReloadButton="true" showPagerButtonIcon="true" totalField="page.count"
		 ondrawcell="onDrawCell"
		 selectOnLoad="true"
		 sortMode="client"
		 allowSortColumn="true">
		<div property="columns">
			<div type="indexcolumn">序号</div>
			<div header="保险公司信息" headerAlign="center">
				<div property="columns">
					<div id="code" field="code" headerAlign="center" allowSort="true" width="15%">保险公司代码</div>
					<div id="fullName" field="fullName" headerAlign="center" allowSort="true" visible="true"
						 width="200">保险公司名称
					</div>
					<div id="contactor" field="contactor" headerAlign="center" allowSort="true" width="10%">联系人</div>
					<div id="contactorTel" field="contactorTel" headerAlign="center" allowSort="true" width="20%">
						联系人电话
					</div>
					<div id="orderIndex" field="orderIndex" headerAlign="center" allowSort="true" width="8%"
						 dataType="int">排序号
					</div>
					<div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" width="12%"
						 renderer="onIsDisabled">是否禁用
					</div>

				</div>
			</div>
		</div>
	</div>
</div>
	
</body>
</html>