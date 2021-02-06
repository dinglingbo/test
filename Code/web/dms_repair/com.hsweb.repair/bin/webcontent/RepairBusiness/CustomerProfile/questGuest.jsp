<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 14:09:04
  - Description:
-->
<head>
<title>客户档案</title>
<script
	src="<%=webPath + contextPath%>/repair/js/RepairBusiness/CustomerProfile/questGuest.js?v=1.0.0"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.title {
	min-width: 80px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" id="insureComp" visible="false"/>
	<div class="nui-toolbar" style="border-bottom: 0;">
		<div class="nui-form" id="queryForm">
			<table class="table">
				<tr>
					<label>手机号码：</label>
						<input class="nui-textbox" name="mobile" onenter="onenterSearch(this.value)" id="mobile"/> 
						<a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search"></span>&nbsp;查询</a>
						<a class="nui-button" iconCls="" plain="true" onclick="onchoice()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="list" class="nui-datagrid"
			style="width: 100%; height: 100%;" pageSize="20" onselectionchanged="selectionChanged"
			allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="7" totalCount="page.count" 
			virtualScroll="true"
			totalField="page.count"
			 >
			<div property="columns">
				<div width="30" type="indexcolumn">序号</div>
				<div header="客户信息" headerAlign="center">
					<div property="columns">
						<div name="fullName" field="fullName"
							headerAlign="center" allowSort="true" visible="true"
							width="100px">客户名称</div>
						<div name="mobile" field="mobile"
							headerAlign="center" allowSort="true" visible="true"
							width="100px">客户电话</div>
						<div name="recordDate" field="recordDate" dateFormat="yyyy-MM-dd"
							headerAlign="center" allowSort="true" visible="true" width="100">建档日期
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>