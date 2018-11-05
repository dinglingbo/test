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
	<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/CustomerProfile/CustomerProfileMain.js?v=1.4.8"></script>
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
	<input class="nui-combobox" id="insureComp" visible="false" />
	<div class="nui-toolbar" style="border-bottom: 0;">
		<div class="nui-form" id="queryForm">
			<table class="table">
				<tr>
					<td>
						<label style="font-family: Verdana;">快速查询：</label>
						<a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">所有</a>
						<ul id="popupMenuStatus" class="nui-menu" style="display:none;">
							<li iconCls="" onclick="quickSearch(6)" id="type6">所有</li>
							<li iconCls="" onclick="quickSearch(0)" id="type0">本日来厂</li>
							<li iconCls="" onclick="quickSearch(1)" id="type1">昨日来厂</li>
							<li iconCls="" onclick="quickSearch(2)" id="type2">本日新客户</li>
							<li iconCls="" onclick="quickSearch(3)" id="type3">本月新客户</li>
							<li iconCls="" onclick="quickSearch(4)" id="type4">本月所有来厂客户</li>
						</ul>
						<td>
							<label>车牌号:</label>
							<input class="nui-textbox" name="carNo" onenter="onSearch()" />
							<label>手机号码：</label>
							<input class="nui-textbox" name="mobile" onenter="onSearch()" />
							<a class="nui-button" iconCls="" plain="true" onclick="onSearch()">
								<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
							<a class="nui-button" plain="true" onclick="advancedSearch()">
								<span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
						</td>
						<td>
							<a class="nui-button" iconCls="" onclick="add()" plain="true">
								<span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
							<a class="nui-button" iconCls="" id="updateBtn" onclick="edit()" plain="true">
								<span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
							<a class="nui-button" iconCls="icon-date" id="mergeBtn" onclick="amalgamate()" plain="true">资料合并</a>
							<a class="nui-button" iconCls="icon-date" onclick="split()" id="splitBtn" plain="true">资料拆分</a>
							<!-- 					<a class="nui-button" plain="true" iconCls="" onclick="importGuest()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;客户导入</a>
					<a class="nui-button" plain="true" iconCls="" onclick="importTimesCard()" id="importTimesCardBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;客户计次卡导入</a>
					<a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT"  ><span class="fa fa-level-down fa-lg"></span>&nbsp;客户储值卡导入</a>
                    <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                    	<li iconCls="" onclick="importCardByMobile()" id="importCardByMobile">电话号码导入</li>
                    	<li iconCls="" onclick="importCardByCarNo()" id="importCardByCarNo">车牌号导入</li>
                    </ul> -->
							<a class="nui-button" iconCls="" id="carChangeBtn" onclick="carChange()" plain="true">
								<span class="fa fa-edit fa-lg"></span>&nbsp;车辆变更</a>
						</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-fit">
		<div id="datagrid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" allowcellwrap="true"
		 onselectionchanged="selectionChanged"  frozenStartColumn="0" frozenEndColumn="6" totalCount="page.count"
		 virtualColumns="true">
			<div property="columns">
				<div width="30" type="indexcolumn">序号</div>
				<div header="车辆信息" headerAlign="center">
					<div property="columns">
						<div field="carNo" headerAlign="center"  align="center" visible="true" width="80">车牌号</div>
						<div field="carModel" headerAlign="center" align="center" width="200px">品牌/车型</div>
						<div field="vin" headerAlign="center" align="center"  visible="true" width="130px">车架号（VIN）</div>
						<div field="annualInspectionDate" align="center" headerAlign="center" dateFormat="yyyy-MM-dd"  visible="true"
						 width="80px">保险到期</div>
						<div field="annualVerificationDueDate" align="center" headerAlign="center" dateFormat="yyyy-MM-dd"  visible="true"
						 width="80px">年审日期</div>
						<div field="insureCompName" align="center" headerAlign="center"  visible="true" width="80px">保险公司</div>
					</div>
				</div>
				<div header="客户信息" headerAlign="center">
					<div property="columns">
						<div name="guestFullName" align="center" field="guestFullName" headerAlign="center"  visible="true" width="70px">客户名称</div>
						<div name="mobile" field="mobile" align="center" headerAlign="center"  visible="true" width="100px">客户电话</div>
						<div name="addr" field="addr" align="center" headerAlign="center"  visible="true" width="200px">地址</div>
						<div name="lastComeDate" field="lastComeDate" align="center" dateFormat="yyyy-MM-dd" headerAlign="center" 
						 visible="true" width="100px">最后来厂日期</div>
						<div name="lastLeaveDate" field="lastLeaveDate" align="center" dateFormat="yyyy-MM-dd" headerAlign="center" 
						 visible="true" width="100px">最后离厂日期</div>
						<div name="isDisabled" field="isDisabled" headerAlign="center" align="center"  visible="true" width="70px">营销员</div>
						<div name="recorder" field="recorder" headerAlign="center" align="center"  visible="true" width="70px">建档人</div>
						<div name="recordDate" field="recordDate" dateFormat="yyyy-MM-dd" align="center" headerAlign="center"  visible="true"
						 width="100">建档日期
						</div>
						<div field="chainComeTimes" headerAlign="center" align="center"  visible="true" width="70px">来厂次数</div>
						<div name="leaveDay" field="leaveDay" headerAlign="center" align="center"  visible="true" width="70px">离厂天数</div>
					</div>
				</div>
				<div header="其他信息" headerAlign="center">
					<div property="columns">
						<div name="engineNo" field="engineNo" headerAlign="center" align="center"  visible="true" width="120px">发动机号</div>
						<div name="produceDate" field="produceDate" align="center" dateFormat="yyyy-MM-dd" headerAlign="center" 
						 visible="true" width="80px">生产年份</div>
						<div name="color" field="color" headerAlign="center" align="center"  visible="true" width="50px">颜色</div>
					</div>
				</div>

			</div>
		</div>
	</div>


	<div id="advancedSearchWin" class="nui-window" title="高级查询" style="width: 420px; height: 310px;" showModal="true" allowResize="false"
	 allowDrag="false">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
					<td class="title">
						<label>最后来厂 从:</label>
					</td>
					<td>
						<input name="lastEnterStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="lastEnterEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>第一次来厂 从:</label>
					</td>
					<td>
						<input name="firstEnterStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="firstEnterEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>最后离厂 从:</label>
					</td>
					<td>
						<input name="lastOutStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="lastOutEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>建档日期 从:</label>
					</td>
					<td>
						<input name="recordStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="recordEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>客户名称:</label>
					</td>
					<td colspan="3">
						<input name="guestId" id="guestId1" class="nui-buttonedit" emptyText="请选择客户..." onbuttonclick="selectCustomer('guestId1')"
						 width="100%" allowInput="false" selectOnFocus="true" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>品牌:</label>
					</td>
					<td colspan="1">
						<input class="nui-combobox" name="carBrandId" width="100%" id="carBrandId" valueField="id" onvaluechanged="onCarBrandChange"
						 textField="nameCn" />
					</td>
					<td class="" width="30">
						<label>车型:</label>
					</td>
					<td colspan="1">
						<input class="nui-combobox" name="carModelId" width="100%" id="carModelId" valueField="carModelId" textField="carModel"
						/>
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>手机号码:</label>
					</td>
					<td colspan="3">
						<input class="nui-textbox" name="mobile" id="tel" width="100%" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>车架号(VIN):</label>
					</td>
					<td colspan="3">
						<input class="nui-textbox" name="vin" width="100%" />
					</td>
				</tr>
			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk" style="width: 60px; margin-right: 20px;">确定</a>
				<a class="nui-button" onclick="onAdvancedSearchCancel" style="width: 60px;">取消</a>
			</div>
		</div>
	</div>

</body>

</html>