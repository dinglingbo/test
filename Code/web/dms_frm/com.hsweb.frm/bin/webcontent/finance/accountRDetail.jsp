<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->

	<head>
		<title>收款明细</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<%@include file="/common/sysCommon.jsp"%>
			<script src="<%=webPath + contextPath%>/frm/js/finance/accountRDetail.js?v=1.0.2"></script>
			<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
			<script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
			<style type="text/css">
				body {
					margin: 0;
					padding: 0;
					border: 0;
					width: 100%;
					height: 100%;
					overflow: hidden;
					font-family: "微软雅黑";
				}
			</style>
	</head>

	<body>
		<div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
			<label style="font-family:Verdana;">快速查询：</label>
			<a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>
			<ul id="popupMenuDate" class="nui-menu" style="display:none;">
				<li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
				<li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
				<li class="separator"></li>
				<li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
				<li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
				<li class="separator"></li>
				<li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
				<li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
				<li class="separator"></li>
				<li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
				<li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
			</ul>
			<span class="separator"></span>
			<label style="font-family:Verdana;">开始日期 从：</label>
			<input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false"
			 showClearButton="false" />
			<label style="font-family:Verdana;">至</label>
			<input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false"
			 showClearButton="false" />

			<input id="accountId" width="100px" textField="name" valueField="id" emptyText="结算账户" onvalueChanged="onSearch()" class="nui-combobox"
			 allowinput="true" valueFromSelect="true" />
			<input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择客户..." onvalueChanged="onSearch()" onbuttonclick="selectSupplier('advanceGuestId')"
			 allowInput="false" width="150px" selectOnFocus="true" />

			<input id="isMain" width="100px" data="pList" textField="text" valueField="id" emptyText="是否主营业务" onvalueChanged="onSearch()" visible="false"
			 class="nui-combobox" allowinput="true" valueFromSelect="true" />
			<input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList"  allowInput="false"/>
			<input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"  onenter="onSearch(this.value)" />
			<input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid" emptyText="公司选择" url=""
			 allowInput="true" showNullItem="false" width="130" valueFromSelect="true" />
			<a class="nui-button" iconCls="" plain="true" onclick="onSearch()">
				<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
			<a class="nui-button" iconCls="" plain="true" onclick="print()">
				<span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
			<a class="nui-button" iconCls="" plain="true" onclick="openOrderDetail()" visible="false">
				<span class="fa fa-search fa-lg"></span>&nbsp;详情</a>
			<a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn">
				<span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
		</div>
		<div class="nui-splitter" vertical="true" style="width: 100%; height: 100%;" allowResize="true">
			<!-- 上 -->

			<div size="65%" showCollapseButton="false">
				<div class="nui-fit">
					<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" ondrawcell="onDrawCell" showPager="true" dataField="list"
					 url="" sortMode="client" pageSize="500" sizeList="[500,1000,2000]" showSummaryRow="true" multiSelect="true" onrowclick="queryFrm()">
						<div property="columns">
							<div type="indexcolumn" headeralign="center" width="40">序号</div>
							<div field="rpAccountId" name="rpAccountId" width="170" headeralign="center" summaryType="count" allowsort="true">财务单号</div>
							<div field="guestName" name="guestName" width="100" headeralign="center" allowsort="true">客户简称</div>
							<div field="settAccountName" name="settAccountName" width="110" headeralign="center" allowsort="true">收款账户 </div>
							<div field="balaTypeCode" name="balaTypeCode" width="110" headeralign="center" allowsort="true">收款方式 </div>
							<div field="settCharOffAmt" name="settCharOffAmt" width="80" summaryType="sum" headeralign="center" allowsort="true" dataType="float">收款金额</div>
							<div field="remark" name="remark" width="180" headeralign="center" allowsort="true">收款备注</div>
							<div field="auditor" name="auditor" width="80" headeralign="center" allowsort="true">收款人</div>
							<div field="auditDate" name="auditDate" width="150" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" allowsort="true">收款日期</div>
							<div field="orgid" name="orgid" width="130" headerAlign="center" header="所属公司" allowsort="true"></div>
						</div>
					</div>
				</div>
			</div>
				<!-- 下 -->
				<div showCollapseButton="false">
					<div class="nui-fit">
						<div id="datagrid2" dataField="data" ondrawcell="onDrawCell1" class="nui-datagrid" style="width: 100%; height: 100%;" sortMode="client" allowSortColumn="true"
						 showPager="false" allowCellWrap=true>
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div allowSort="true" field="guestName" name="guestName" width="150" headerAlign="center" header="结算单位"></div>
								<div allowSort="true" field="carNo" name="carNo" width="80" headerAlign="center" header="车牌号"></div>
								<div allowSort="true" summaryType="count" field="billServiceId" name="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
								<div allowSort="true" field="billTypeId" name="billTypeId" width="90" headerAlign="center" header="收支项目"></div>
								<div allowSort="true" field="remark" name="remark" width="120" headerAlign="center" header="业务备注"></div>
								<div allowSort="true" field="rpAmt" width="70" headerAlign="center" align="right" numberFormat="0.0000" dataType="float" summaryType="sum" header="应收金额"></div>
								<div allowSort="true" field="charOffAmt" width="70" headerAlign="center" align="right" numberFormat="0.0000" dataType="float" summaryType="sum" header="已结金额"></div>
								<div allowSort="true" field="creator" name="settleStatus" width="60" headerAlign="center" header="转单人"></div>
								<div allowSort="true" field="createDate" headerAlign="center" header="转单日期" width="120" dateFormat="yyyy-MM-dd HH:mm"></div>
								<div allowSort="true" field="settleStatus" name="settleStatus" width="50" headerAlign="center" header="结算状态"></div>
								<div allowSort="true" field="auditSign" name="auditSign" width="50" headerAlign="center" header="审核状态"></div>
							</div>
						</div>
					</div>
				</div>
		</div>
		<div id="exportDiv" style="display:none">
		</div>
	</body>

	</html>