<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 09:33:05
  - Description:
-->
<head>
<title>维修顾问业绩报表</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairConsultantPerformance/RepairConsultantPerformanceMain.js?v=1.0.1"></script>
<style type="text/css">
.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" id="mtType1" visible="false"/>
<input class="nui-combobox" id="mtType2" visible="false"/>
<input class="nui-combobox" id="guestSource" visible="false"/>
<input class="nui-combobox" id="carBrand" visible="false"/>
<input class="nui-combobox" id="insureComp" visible="false"/>
<input class="nui-combobox" id="orgId" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
	<div class="nui-form1" id="queryInfoForm">
		<table class="table">
			<tr>
				<td>
					<label style="font-family:Verdana;">快速查询：</label>
					<a class="nui-menubutton" plain="true" iconCls="icon-date" id="searchByDateBtn" menu="#popupMenu" >本日</a>
					<ul id="popupMenu" class="nui-menu" style="display:none;">
						<li iconCls="icon-date" onclick="quickSearch(0)">本日</li>
						<li iconCls="icon-date" onclick="quickSearch(1)">昨日</li>
						<li iconCls="icon-date" onclick="quickSearch(2)">本周</li>
						<li iconCls="icon-date" onclick="quickSearch(3)">上周</li>
						<li iconCls="icon-date" onclick="quickSearch(4)">本月</li>
						<li iconCls="icon-date" onclick="quickSearch(5)">上月</li>
						<li iconCls="icon-date" onclick="quickSearch(6)">本年</li>
						<li iconCls="icon-date" onclick="quickSearch(7)">上年</li>
					</ul>
					<span class="separator"></span>
					<a class="nui-button" onclick="advancedSearch()" plain="true">更多</a>
					<span class="separator"></span>
					<label style="font-family:Verdana;">快速分析：</label>
					<a class="nui-menubutton" plain="true" iconCls="icon-date" id="analysisByDateBtn" menu="#popupMenu1" >按维修顾问</a>
					<ul id="popupMenu1" class="nui-menu" style="display:none;">
						<li iconCls="icon-date" onclick="quickSearch1(1)">按维修顾问</li>
						<li iconCls="icon-date" onclick="quickSearch1(0)">按分店</li>
						<li iconCls="icon-date" onclick="quickSearch1(2)">按品牌</li>
						<li iconCls="icon-date" onclick="quickSearch1(3)">按客户来源</li>
						<li iconCls="icon-date" onclick="quickSearch1(4)">按业务类型</li>
						<li iconCls="icon-date" onclick="quickSearch1(5)">按维修类型</li>
						<li iconCls="icon-date" onclick="quickSearch1(6)">按来厂次数</li>
					</ul>
					<span class="separator"></span>
					<a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印</a>
					<a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出</a>
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="nui-fit">
	<div id="datagrid1" class="nui-datagrid" style="width: 100%; height: 100%;"
		 dataField="list"
		 pageSize="20"
		 showPager="false"
		 totalCount="page.count" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
		 frozenStartColumn="0" >
		<div property="columns">
			<div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
			<!-- <div header="维度" headerAlign="center">
				<div property="columns">
					<div field="groupName" name="groupName" headerAlign="center" allowSort="true" visible="true" width="150">按分店分析</div>
				</div>
			</div> -->
			
			<div header="基本信息" headerAlign="center">
				<div property="columns">
				    <div field="settlementGeust" headerAlign="center" allowSort="true" visible="true" width="90px" align="right">服务顾问</div>
					<div field="settlementGeust" headerAlign="center" allowSort="true" visible="true" width="70px" align="right">首次到店车辆数</div>
					<div field="settlementGeust" headerAlign="center" allowSort="true" visible="true" width="70px" align="right">结算车次</div>
				</div>
			</div>
			<div header="维修金额信息" headerAlign="center">
				<div property="columns">
					<div field="itemTotalAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">套餐小计</div>
					<div field="itemFreeAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">工时小计</div>
					<div field="itemAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">配件小计</div>
					<div field="itemSubtotal" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">实营金额</div>
				</div>
			</div>
			<div header="配件成本信息" headerAlign="center">
				<div property="columns">
					<div field="partTotalAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">销售金额</div>
					<div field="partFreeAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">配件成本</div>
					<div field="partAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">配件销售加点</div>
				</div>
			</div>
			<div header="毛利信息" headerAlign="center">
				<div property="columns">
					<div field="mtAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">毛利</div>
					<div field="partManageExp" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">毛利率</div>
				</div>
			</div>
			<div header="运营毛利信息" headerAlign="center">
				<div property="columns">
					<div field="mtAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">运营毛利</div>
					<div field="partManageExp" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">运营毛利率</div>
				</div>
			</div>
			<div header="其他信息" headerAlign="center">
				<div property="columns">
					<div field="mtAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">整单优惠率</div>
					<div field="partManageExp" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">单车产值</div>
				    <div field="partManageExp" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">预存抵扣</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="advancedSearchWin" class="nui-window"
	 title="高级查询" style="width:416px;height:280px;"
	 showModal="true"
	 allowResize="false"
	 allowDrag="false">
	<div id="advancedSearchForm" class="form">
		<table style="width:100%;">
			<tr>
				<td class="form_label">结算日期 从:</td>
				<td>
					<input name="startDate"
						   width="100%"
						   allowInput="false"
						   class="nui-datepicker"/>
				</td>
				<td class="form_label">至:</td>
				<td>
					<input name="endDate"
						   class="nui-datepicker"
						   format="yyyy-MM-dd"
						   timeFormat="H:mm:ss"
						   showTime="false"
						   allowInput="false"
						   showOkButton="false"
						   width="100%"
						   showClearButton="true"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">业务类型:</td>
				<td colspan="1">
					<input class="nui-combobox" name="serviceTypeId"
						   valueField="customid" textField="name"
						   id="serviceTypeId"/>
				</td>
				<td class="form_label">维修顾问:</td>
				<td colspan="1">
					<input class="nui-combobox" emptyText="请选择..." id="mtAdvisorId-ad" name="mtAdvisorId" valueField="empId" textField="empName"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">客户:</td>
				<td colspan="3">
					<input class="nui-buttonedit" emptyText="请输入..."
						   style="width: 100%"
						   showClose="false" onbuttonclick="selectCustomer('guestId-ad')" id="guestId-ad" name="guestId"
						   allowInput="false"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">工单号:</td>
				<td colspan="3">
					<textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" id="serviceCodeList" name="serviceCodeList"></textarea>
				</td>
			</tr>
		</table>
		<div style="text-align:center;padding:10px;">
			<a class="nui-button" onclick="onAdvancedSearchClear" style="width:60px;margin-right:20px;">清除</a>
			<a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
			<a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
		</div>
	</div>
</div>
</body>
</html>