<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 09:30:29
  - Description:
-->
<head>
<title>维修营业分析</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusinessAnalysis/RepairBusinessAnalysisMain.js?v=1.0.2"></script>
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
					<a class="nui-menubutton" plain="true" iconCls="icon-date" id="analysisByDateBtn" menu="#popupMenu1" >按分店</a>
					<ul id="popupMenu1" class="nui-menu" style="display:none;">
						<li iconCls="icon-date" onclick="quickSearch1(0)">按分店</li>
						<li iconCls="icon-date" onclick="quickSearch1(1)">按维修顾问</li>
						<li iconCls="icon-date" onclick="quickSearch1(2)">按品牌</li>
						<li iconCls="icon-date" onclick="quickSearch1(3)">按客户来源</li>
						<li iconCls="icon-date" onclick="quickSearch1(4)">按业务类型</li>
						<li iconCls="icon-date" onclick="quickSearch1(5)">按维修类型</li>
						<li iconCls="icon-date" onclick="quickSearch1(6)">按来厂次数</li>
						<li iconCls="icon-date" onclick="quickSearch1(7)">按投保公司</li>
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
		 frozenStartColumn="0" frozenEndColumn="1">
		<div property="columns">
			<div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
			<div header="维度" headerAlign="center">
				<div property="columns">
					<div field="groupName" name="groupName" headerAlign="center" allowSort="true" visible="true" width="150">按分店分析</div>
				</div>
			</div>
			<div header="车次信息" headerAlign="center">
				<div property="columns">
					<div field="newGeust" headerAlign="center" allowSort="true" visible="true" width="60px">新客户</div>
					<div field="settlementGeust" headerAlign="center" allowSort="true" visible="true" width="70px">结算车次</div>
				</div>
			</div>
			<div header="项目信息" headerAlign="center">
				<div property="columns">
					<div field="itemTotalAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">项目总额</div>
					<div field="itemFreeAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">免费项目</div>
					<div field="itemAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">收费项目</div>
					<div field="itemPrefRate" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right" numberFormat="p">优惠率</div>
					<div field="itemPrefAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">优惠金额</div>
					<div field="itemSubtotal" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">项目小计</div>
				</div>
			</div>
			<div header="材料信息" headerAlign="center">
				<div property="columns">
					<div field="partTotalAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">材料总额</div>
					<div field="partFreeAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">免费材料</div>
					<div field="partAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">收费材料</div>
					<div field="partPrefRate" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right" numberFormat="p">优惠率</div>
					<div field="partPrefAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">优惠金额</div>
					<div field="partSubtotal" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">材料小计</div>
					<div field="partTrueCost" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">材料成本</div>
				</div>
			</div>
			<div header="维修费用" headerAlign="center">
				<div property="columns">
					<div field="mtAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">维修金额</div>
					<div field="partManageExp" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">材料管理费</div>
					<div field="materialExp" headerAlign="center" allowSort="true" visible="true" width="50px" datatype="float" align="right">辅料费</div>
					<div field="allowanceAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">折让金额</div>
					<div field="otherExp" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">其他费用</div>
					<div field="totalPrefRate" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right" numberFormat="p">整单优惠率</div>
					<div field="totalPrefAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">总优惠金额</div>
					<div field="freePrefAllowanceAmt" headerAlign="center" allowSort="true" visible="true" width="90px" datatype="float" align="right">免费+优惠+折让</div>
					<div field="accuedEpensesAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">预提费用</div>
				</div>
			</div>
			<div header="提成数据" headerAlign="center">
				<div property="columns">
					<div field="elecAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">机电金额</div>
					<div field="elecDeduct" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">机电提成</div>
					<div field="metalAmt" headerAlign="center" allowSort="true" visible="true" width="50px" datatype="float" align="right">钣金金额</div>
					<div field="metalDeduct" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">钣金提成</div>
					<div field="paintAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">喷漆金额</div>
					<div field="paintDeduct" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">喷漆提成</div>
				</div>
			</div>
			<div header="出单信息" headerAlign="center">
				<div property="columns">
					<div field="outTurnUpAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">开大金额</div>
					<div field="outTurnUpTaxAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">开大税款</div>
					<div field="outRebateAmt" headerAlign="center" allowSort="true" visible="true" width="50px" datatype="float" align="right">返利</div>
					<div field="outTotalPrefAmt" headerAlign="center" allowSort="true" visible="true" width="90px" datatype="float" align="right">出单优惠合计</div>
					<div field="outBillBalaSubtotal" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">出单小计</div>
					<div field="outBillAllowAnce" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">出单折让</div>
				</div>
			</div>
			<div header="营业数据" headerAlign="center">
				<div property="columns">
					<div field="unitBalaAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">单产</div>
					<div field="balaAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">结算金额</div>
					<div field="cardAmt" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">储值卡付款</div>
					<div field="receivableAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">应收金额</div>
					<div field="incomeAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">营业收入</div>
					<div field="incomeRealAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">真实收入</div>
					<div field="billAmt" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">发票金额</div>
					<div field="planTaxAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">计划税款</div>
				</div>
			</div>
			<div header="毛利数据" headerAlign="center">
				<div property="columns">
					<div field="grossProfit" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right">毛利</div>
					<div field="grossProfitRate" headerAlign="center" allowSort="true" visible="true" width="60px" datatype="float" align="right" numberFormat="p">毛利率</div>
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