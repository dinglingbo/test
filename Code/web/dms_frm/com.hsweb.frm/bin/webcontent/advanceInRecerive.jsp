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
<title>预收账款管理</title>
<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
<script
	src="<%=webPath + contextPath%>/frm/js/arap/advanceInReceive.js?v=1.0"
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
					<li class="separator"></li> 往来单位： <input class="nui-textbox"
					name="gd" id="gd" enabled="true" />
					<li class="separator"></li> <input name="isPrimaryBusiness"
					id="isPrimaryBusiness" visible="false" class="nui-combobox width2"
					textField="text" valueField="value" data="const_yesno"
					emptyText="请选择..." allowInput="false" valueFromSelect="true"
					showNullItem="false" nullItemText="请选择..." /> <a
					class="nui-button" iconCls="icon-find" plain="true"
					onclick="query()" id="query" enabled="true">查询</a> <a href="">更多</a>
					<a class="nui-button" plain="true" id="dbbutton" enabled="true"
					onclick="db()">预收收款</a> <a class="nui-button" plain="true"
					id="dbbutton" enabled="true" onclick="db()">预收款录入</a> <a
					class="nui-button" plain="true" id="dbbutton" enabled="true"
					onclick="db()">预收款支出</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="tab1" class="nui-tabs" height="100%">

			<div title="待预收明细">
				<div class="nui-fit">
					<div id="dgGrid1" class="nui-datagrid"
						style="width: 100%; height: 100%;" showPager="true" pageSize="10"
						sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
						onselectionchanged="statuschange" virtualScroll="true"
						dataField="data" idField="id" treeColumn="name"
						parentField="parentId">
						<div property="columns" width="10">
							<div type="indexcolumn">序号</div>
							<div field="id" allowSort="true" headerAlign="center"
								visible="false" width="70"></div>
							<div header="客户信息" headerAlign="center">
								<div property="columns" width="10">


									<div field="serviceCode" allowSort="true" headerAlign="center"
										width="70">客服名称</div>
									<div field="guestFullName" allowSort="true"
										headerAlign="center" width="70">性别</div>
									<div field="serviceTypeId" allowSort="true"
										headerAlign="center" width="70">手机号码</div>
								</div>
							</div>
							<div header="费用信息" headerAlign="center">
								<div property="columns" width="10">


									<div field="rpAmt" allowSort="true" headerAlign="center"
										width="70">购车总费用</div>
									<div field="rpAmtYes" allowSort="true" headerAlign="center"
										width="70">提车合计</div>
								</div>
							</div>
							<div header="定金" headerAlign="center">
								<div property="columns" width="10">
									<div field="paySum" allowSort="true" headerAlign="center"
										width="70">应收月</div>
									<div field="paySum" allowSort="true" headerAlign="center"
										width="70">已收余额</div>
									<div field="paySum" allowSort="true" headerAlign="center"
										width="70">未收金额</div>
								</div>
							</div>
							<div header="订单信息" headerAlign="center">
								<div property="columns" width="10">


									<div field="billAmt" allowSort="true" headerAlign="center"
										width="70">订单号</div>
									<div field="recorder" allowSort="true" headerAlign="center"
										width="70">订单状态</div>
									<div field="recordDate" allowSort="true" headerAlign="center"
										dateFormat="yyyy-MM-dd HH:mm" width="70">销售顾问</div>
									<div field="recorder" allowSort="true" headerAlign="center"
										width="70">订车日期</div>
									<div field="recordDate" allowSort="true" headerAlign="center"
										dateFormat="yyyy-MM-dd HH:mm" width="70">预交车日期</div>


								</div>
							</div>
							<div header="车型信息" headerAlign="center">
								<div property="columns" width="10">


									<div field="billAmt" allowSort="true" headerAlign="center"
										width="70">品牌车型</div>
									<div field="recorder" allowSort="true" headerAlign="center"
										width="70">品牌</div>
									<div field="recordDate" allowSort="true" headerAlign="center"
										dateFormat="yyyy-MM-dd HH:mm" width="70">类别</div>
									<div field="recorder" allowSort="true" headerAlign="center"
										width="70">规格</div>
									<div field="recordDate" allowSort="true" headerAlign="center"
										dateFormat="yyyy-MM-dd HH:mm" width="70">外观颜色</div>
									<div field="recordDate" allowSort="true" headerAlign="center"
										dateFormat="yyyy-MM-dd HH:mm" width="70">内饰颜色</div>
									<div field="recordDate" allowSort="true" headerAlign="center"
										dateFormat="yyyy-MM-dd HH:mm" width="70">配置</div>


								</div>
							</div>
							<div header="其他信息" headerAlign="center">
								<div property="columns" width="10">


									<div field="billAmt" allowSort="true" headerAlign="center"
										width="70">备注</div>



								</div>
							</div>
						</div>

					</div>
				</div>

			</div>

			<div title="预收明细">
				<div class="nui-fit">

					<div id="dgGrid" class="nui-datagrid"
						style="width: 100%; height: 50%;" showPager="true" pageSize="10"
						sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
						url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext"
						onselectionchanged="statuschange" virtualScroll="true"
						dataField="data" idField="id" treeColumn="name"
						parentField="parentId">
						<div property="columns" width="10">
							<div type="indexcolumn">序号</div>
							<div field="id" allowSort="true" headerAlign="center"
								visible="false" width="70"></div>
							<div header="基本信息" headerAlign="center">
								<div property="columns" width="10">


									<div field="serviceCode" allowSort="true" headerAlign="center"
										width="70">收款单号</div>
									<div field="guestFullName" allowSort="true"
										headerAlign="center" width="70">客户名称</div>

								</div>
							</div>
							<div header="金额信息" headerAlign="center">
								<div property="columns" width="10">


									<div field="rpAmt" allowSort="true" headerAlign="center"
										width="70">收款金额</div>
									<div field="rpAmtYes" allowSort="true" headerAlign="center"
										width="70">已冲减</div>
									<div field="rpAmtYes" allowSort="true" headerAlign="center"
										width="70">未冲减</div>
								</div>
							</div>
							<div header="其他信息" headerAlign="center">
								<div property="columns" width="10">
									<div field="paySum" allowSort="true" headerAlign="center"
										width="70">收款方式</div>
									<div field="paySum" allowSort="true" headerAlign="center"
										width="70">收款人</div>
									<div field="paySum" allowSort="true" headerAlign="center"
										width="70">收款日期</div>
									<div field="paySum" allowSort="true" headerAlign="center"
										width="70">备注</div>
								</div>
							</div>



						</div>

					</div>


					<div id="dgGrid" class="nui-datagrid"
						style="width: 100%; height: 50%;" showPager="true" pageSize="10"
						sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
						url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext"
						onselectionchanged="statuschange" virtualScroll="true"
						dataField="data" idField="id" treeColumn="name"
						parentField="parentId">
						<div property="columns" width="10">
							<div type="indexcolumn">序号</div>
							<div field="paySum" allowSort="true" headerAlign="center"
										width="70">收款单号</div>
							<div field="paySum" allowSort="true" headerAlign="center"
										width="70">客户名称</div>
							<div field="paySum" allowSort="true" headerAlign="center"
										width="70">工单号</div>
							<div field="paySum" allowSort="true" headerAlign="center"
										width="70">冲减余额</div>
							<div field="paySum" allowSort="true" headerAlign="center"
										width="70">冲减人</div>
							<div field="paySum" allowSort="true" headerAlign="center"
										width="70">冲减日期</div>
							<div field="paySum" allowSort="true" headerAlign="center"
										width="70">备注</div>
					</div>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>