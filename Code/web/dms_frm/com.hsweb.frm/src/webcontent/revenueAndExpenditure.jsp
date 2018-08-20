<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>收支记录查询</title>
<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
<script
	src="<%=webPath + contextPath%>/frm/js/arap/revenueAndExpenditure.js?v=1.0"
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
						onclick="clearQueryForm()">快速查询：</span></label> <a href="">本日</a> <a
					href="">本周</a> <a href="">本月</a> <a href="">上月</a> <a href="">本年</a>
					<li class="separator"></li> <label style="font-family: Verdana;"
					title="点击清空条件"><span onclick="clearQueryForm()">收支类型：</span></label>
					<a href="">收</a> <a href="">支</a>
					<li class="separator"></li> <input name="isPrimaryBusiness"
					id="isPrimaryBusiness" visible="false" class="nui-combobox width2"
					textField="text" valueField="value" data="const_yesno"
					emptyText="请选择..." allowInput="false" valueFromSelect="true"
					showNullItem="false" nullItemText="请选择..." /> <a
					class="nui-button" iconCls="icon-find" plain="true"
					onclick="query()" id="query" enabled="true">查询</a> <a href="">更多</a>
				</td>
			</tr>
		</table>
	</div>


		<div class="nui-fit">
			<div id="treegrid1" class="mini-treegrid" showTreeIcon="true"
				treeColumn="taskname" idField="UID" parentField="ParentTaskUID"
				resultAsTree="false" allowResize="true" expandOnLoad="true"
				
				allowSortColumn="false" sortMode="client">
				<div property="columns">
					<div type="indexcolumn">序号</div>
					<div header="基本信息" headerAlign="center">
						<div property="columns" width="10">


							<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">首付款单号</div>
							<div field="guestFullName" allowSort="true" headerAlign="center"
								width="120">工单号</div>
							<div field="serviceTypeId" allowSort="true" headerAlign="center"
								width="120">客户名称</div>
							<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">业务类型</div>
							<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">收支方式</div>
						</div>
					</div>
					<div header="金额信息" headerAlign="center">
						<div property="columns" width="10">


							<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">收付金额</div>
							<div field="guestFullName" allowSort="true" headerAlign="center"
								width="120">已核销金额</div>
							<div field="serviceTypeId" allowSort="true" headerAlign="center"
								width="120">剩余金额</div>
						</div>
					</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns" width="10">


								<div field="serviceCode" allowSort="true" headerAlign="center"
									width="70">收支类型</div>
								<div field="guestFullName" allowSort="true" headerAlign="center"
									width="70">首付款人</div>
								<div field="serviceTypeId" allowSort="true" headerAlign="center"
									width="70">收支款日期</div>
								<div field="serviceTypeId" allowSort="true" headerAlign="center"
									width="70">创建日期</div>
								<div field="serviceTypeId" allowSort="true" headerAlign="center"
									width="70">备注</div>
							</div>
						</div>
						
					
				</div>
			</div>
		</div>
</body>
</html>