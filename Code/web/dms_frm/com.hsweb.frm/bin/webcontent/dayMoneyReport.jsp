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
<title>每日资金报表</title>
<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
<script
	src="<%=webPath + contextPath%>/frm/js/arap/dayMoneyReport.js?v=1.0"
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
						onclick="clearQueryForm()">快速查询：</span></label> <a class="nui-menubutton "
					iconCls="icon-tip" menu="#popupMenu2" id="timeStatus"
					name="timeStatus">所有</a>

					<ul id="popupMenu2" class="nui-menu" style="display: none;">
						<li iconCls="icon-tip" onclick="setMenu2(this, timeStatus,'')">所有</li>
						<li iconCls="icon-tip"
							onclick="setMenu2(this, timeStatus, 'today')">本日</li>
						<li iconCls="icon-tip"
							onclick="setMenu2(this, timeStatus, 'week')">本周</li>
						<li iconCls="icon-tip"
							onclick="setMenu2(this, timeStatus, 'month')">本月</li>
						<li iconCls="icon-tip"
							onclick="setMenu2(this, timeStatus, 'year')">本年</li>
					</ul>
					<li class="separator"></li> <a class="nui-button"
					iconCls="icon-find" plain="true" onclick="query()" id="query"
					enabled="true">查询</a> <a href="">更多</a>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="tab1" class="nui-tabs" height="100%">

			<div title="收款记录">
				<div class="nui-fit">
					<div id="dgGrid1" class="nui-datagrid"
						style="width: 100%; height: 100%;" showPager="true" pageSize="10"
						sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
						url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.getDayMoneyReport1.biz.ext"
						onselectionchanged="statuschange" virtualScroll="true"
						dataField="data" idField="id" treeColumn="name"
						parentField="parentId">
						<div property="columns" width="10">
							<div type="indexcolumn">序号</div>
							<div field="id" allowSort="true" headerAlign="center"
								visible="false" width="70"></div>
							<div header="基本信息" headerAlign="center">
								<div property="columns" width="10">
									<div field="id" allowSort="true" headerAlign="center"
										visible="false" width="120"></div>
									<div field="code" allowSort="true" headerAlign="center"
										width="70">工单号</div>
									<div field="rpTypeId" allowSort="true"
										headerAlign="center" width="70">类型</div>
									<div field="rpModeId" allowSort="true"
										headerAlign="center" width="70">业务类型</div>
									<div field="rpMan" allowSort="true"
										headerAlign="center" width="70">收款人</div>
									<div field="rpDate" allowSort="true"
										headerAlign="center" width="70">收款日期</div>
								</div>
							</div>

							<div header="收款金额及方式" headerAlign="center">
								<div property="columns" width="10">


									<div field="XJ" allowSort="true" headerAlign="center"
										width="50">现金</div>
									<div field="SK" allowSort="true" headerAlign="center"
										width="50">刷卡</div>
									<div field="ZZ" allowSort="true" headerAlign="center"
										width="50">转账</div>
									<div field="DK" allowSort="true" headerAlign="center"
										width="50">卡抵</div>
									<div field="HZ" allowSort="true" headerAlign="center"
										width="50">坏账</div>
									<div field="QT" allowSort="true" headerAlign="center"
										width="70">其他</div>
								</div>
							</div>
							<div header="其他" headerAlign="center">
								<div property="columns" width="10">
									<div field="remark" allowSort="true" headerAlign="center"
										width="70">备注</div>

								</div>
							</div>

						</div>
					</div>
				</div>



			</div>





			<div title="预收冲减记录">
				<div class="nui-fit">

					<div id="dgGrid2" class="nui-datagrid"
						style="width: 100%; height: 100%;" showPager="true" pageSize="10"
						sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
						url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.getDayMoneyReport2.biz.ext"
						onselectionchanged="statuschange" virtualScroll="true"
						dataField="data" idField="id" treeColumn="name"
						parentField="parentId">
						<div property="columns" width="10">
						
							<div type="indexcolumn">序号</div>
							<div field="tid" allowSort="true" headerAlign="center"
								width="70">收款单号</div>
							<div field="guestFullName" allowSort="true" headerAlign="center"
								width="70">客户名称</div>
							<div field="serviceCode" allowSort="true" headerAlign="center"
								width="70">工单号</div>
							<div field="famount" allowSort="true" headerAlign="center"
								width="70">冲减余额</div>
							<div field="checkOffMan" allowSort="true" headerAlign="center"
								width="70">冲减人</div>
							<div field="checkOffDate" allowSort="true" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm"
								width="70">冲减日期</div>
							<div field="reamrk" allowSort="true" headerAlign="center"
								width="70">备注</div>
						</div>

					</div>
				</div>
			</div>


		</div>
	</div>


</body>
</html>