<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	String contextPath = request.getContextPath();
%>
<head>
<title>应收账款管理</title>
<script src="<%=contextPath%>/common/nui/nui.js" type="text/javascript"></script>
<script src="<%=contextPath%>/common/js/sysCommon.js?v=1.0"
	type="text/javascript"></script>
<script src="<%=contextPath%>/common/js/constantDef.js?v=1.0"
	type="text/javascript"></script>
<script src="<%=contextPath%>/common/js/init.js?v=1.0"
	type="text/javascript"></script>
<script src="<%=contextPath%>/frm/js/arap/receiveFunds.js?v=1.0"
	type="text/javascript"></script>
</head>
<body>
	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;"
		id="queryForm">
		<table style="width: 100%;">
			<tr>
				<td>
					<!-- style="white-space:nowrap;"--> <label
					style="font-family: Verdana;" title="点击清空条件"><span
						onclick="clearQueryForm()">快速查询：</span></label> <label
					style="font-family: Verdana;">工单号：</label> <input
					class="nui-textbox" name="code" id="code" enabled="true" /> <input
					name="itemTypeId" id="itemTypeId" visible="false"
					class="nui-combobox width2" textField="name" valueField="customid"
					emptyText="请选择..." allowInput="false" valueFromSelect="true"
					showNullItem="false" nullItemText="请选择..." /> <input
					name="isPrimaryBusiness" id="isPrimaryBusiness" visible="false"
					class="nui-combobox width2" textField="text" valueField="value"
					data="const_yesno" emptyText="请选择..." allowInput="false"
					valueFromSelect="true" showNullItem="false" nullItemText="请选择..." />
					<a class="nui-button" iconCls="icon-find" plain="true"
					onclick="query()" id="query" enabled="true">查询</a>

					<li class="separator"></li> <a class="nui-button" plain="true"
					onclick="add()" id="add" enabled="true">单据审核</a> <a
					class="nui-button" plain="true" onclick="edit()" id="edit"
					enabled="true">收款</a> <a class="nui-button" plain="true"
					onclick="del()" id="del" enabled="true">担保挂账</a> <a
					class="nui-button" plain="true" onclick="del()" id="del"
					enabled="true"></a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-fit">
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
				url="<%=contextPath%>/com.hsapi.frm.setting.queryIncomeExpenItem.biz.ext"
				onselectionchanged="onDictTypeSelected"
				ondrawnode="onDictTypeDrawNode" onload="onDictTypeLoad"
				dataField="data" idField="id" treeColumn="name"
				parentField="parentId">
				<div property="columns" width="10">
					<div property="columns" width="50">


						<div field="name" allowSort="true" headerAlign="center" width="50">序号</div>
					</div>
					<div header="业务信息" headerAlign="center">
						<div property="columns" width="10">


							<div field="name" allowSort="true" headerAlign="center"
								width="20%">选择</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">工单号</div>
							<div field="name" allowSort="true" headerAlign="center"
								width="20%">往来单位</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">业务类型</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">业务状态</div>

						</div>
					</div>
					<div header="应收信息" headerAlign="center">
						<div property="columns" width="10">


							<div field="name" allowSort="true" headerAlign="center"
								width="20%">应收金额</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">已收金额</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">未收金额</div>

						</div>
					</div>
					<div header="     ">
						<div property="columns" width="10">


							<div field="name" allowSort="true" headerAlign="center"
								width="20%">应付金额</div>


						</div>
					</div>
					<div header="财务信息" headerAlign="center">
						<div property="columns" width="10">


							<div field="name" allowSort="true" headerAlign="center"
								width="20%">发票金额</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">结账人</div>
							<div field="name" allowSort="true" headerAlign="center"
								width="20%">结账日期</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">审核人</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">审核日期</div>
							<div field="name" allowSort="true" headerAlign="center"
								width="20%">挂账日期</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">挂账天书</div>
							<div field="name" allowSort="true" headerAlign="center"
								width="20%">挂账方式</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">担保人</div>
							<div field="code" allowSort="true" headerAlign="center"
								width="20%">备注</div>

						</div>
					</div>

				</div>

			</div>
		</div>
		<!--
    </div>
    -->
	</div>
</body>
</html>