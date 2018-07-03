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
	src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/CustomerProfileMain.js?v=1.0.10"></script>
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
					<td><label style="font-family: Verdana;">快速查询：</label> <a
						class="nui-button" plain="true" onclick="quickSearch(0)"
						id="type0">本日来厂</a> <a class="nui-button" plain="true"
						onclick="quickSearch(1)" id="type1">昨日来厂</a> <a class="nui-button"
						plain="true" onclick="quickSearch(2)" id="type2">本日新客户</a> <a
						class="nui-button" plain="true" onclick="quickSearch(3)"
						id="type3">本月新客户</a> <a class="nui-button" plain="true"
						onclick="quickSearch(4)" id="type4">本月所有来厂客户</a> <a
						class="nui-button" plain="true" onclick="quickSearch(5)"
						id="type5">本月流失回厂</a> <a class="nui-button" plain="true"
						onclick="quickSearch(6)" id="type6">上月流失回厂</a></td>
				</tr>
				<tr>
					<td><label>车牌号</label> <input class="nui-textbox" name="" /> <label>手机号码：</label>
						<input class="nui-textbox" name="" /> <a class="nui-button"
						iconCls="icon-search" plain="true" onclick="onSearch()">查询</a> <a
						class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" style="border-bottom: 0;">
		<table>
			<tr>
				<td>
                    <a class="nui-button" iconCls="icon-add" onclick="addSimple()" plain="true">快速新增</a> 
                    <a class="nui-button" iconCls="icon-add" onclick="add()" plain="true">新增</a> 
                    <a class="nui-button" iconCls="icon-edit"
					onclick="edit()" plain="true">修改</a> <a class="nui-button"
					iconCls="icon-date" onclick="amalgamate()" plain="true">资料合并</a> <a
					class="nui-button" iconCls="icon-date" onclick="split()"
					plain="true">资料拆分</a> <a class="nui-button" iconCls="icon-node"
					onclick="history()" plain="true">维修历史</a>
                </td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="list" class="nui-datagrid"
			style="width: 100%; height: 100%;" pageSize="20"
			allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="7">
			<div property="columns">
				<div width="30" type="indexcolumn">序号</div>
				<div header="车辆信息" headerAlign="center">
					<div property="columns">
						<div field="carNo" headerAlign="center" allowSort="true"
							visible="true" width="80">车牌号</div>
						<div field="carBrandId" headerAlign="center" allowSort="true"
							visible="true" width="80">品牌</div>
						<div field="carModel" headerAlign="center" allowSort="true"
							visible="true" width="80px">车型</div>
						<div field="underpanNo" headerAlign="center" allowSort="true"
							visible="true" width="120px">VIN</div>
						<div field="annualInspectionDate" headerAlign="center"
							dateFormat="yyyy-MM-dd" allowSort="true" visible="true"
							width="80px">保险到期</div>
						<div field="annualVerificationDueDate" headerAlign="center"
							dateFormat="yyyy-MM-dd" allowSort="true" visible="true"
							width="80px">年审日期</div>
						<div field="insureCompCode" headerAlign="center" allowSort="true"
							visible="true" width="80px">投保公司</div>
					</div>
				</div>
				<div header="客户信息" headerAlign="center">
					<div property="columns">
						<div name="type" field="type" headerAlign="center"
							allowSort="true" visible="true" width="60px">档案号</div>
						<div name="guestFullName" field="guestFullName"
							headerAlign="center" allowSort="true" visible="true"
							width="100px">客户名称</div>
						<div name="addr" field="addr" headerAlign="center"
							allowSort="true" visible="true" width="100px">地址</div>
						<div name="lastComeDate" field="lastComeDate"
							dateFormat="yyyy-MM-dd" headerAlign="center" allowSort="true"
							visible="true" width="100px">最后来厂日期</div>
						<div name="lastLeaveDate" field="lastLeaveDate"
							dateFormat="yyyy-MM-dd" headerAlign="center" allowSort="true"
							visible="true" width="100px">最后离厂日期</div>
						<div name="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="50px">营销员</div>
						<div name="recorder" field="recorder" headerAlign="center"
							allowSort="true" visible="true" width="50px">建档人</div>
						<div name="recordDate" field="recordDate" dateFormat="yyyy-MM-dd"
							headerAlign="center" allowSort="true" visible="true" width="100">建档日期
						</div>
						<div field="chainComeTimes" headerAlign="center"
							allowSort="true" visible="true" width="70px">来厂次数</div>
						<div name="leaveDay" field="leaveDay" headerAlign="center"
							allowSort="true" visible="true" width="70px">离厂天数</div>
					</div>
				</div>
				<div header="其他信息" headerAlign="center">
					<div property="columns">
						<div name="engineNo" field="engineNo" headerAlign="center"
							allowSort="true" visible="true" width="120px">发动机号</div>
						<div name="produceDate" field="produceDate"
							dateFormat="yyyy-MM-dd" headerAlign="center" allowSort="true"
							visible="true" width="80px">生产年份</div>
						<div name="color" field="color" headerAlign="center"
							allowSort="true" visible="true" width="50px">颜色</div>
					</div>
				</div>

			</div>
		</div>
	</div>


	<div id="advancedSearchWin" class="nui-window" title="高级查询"
		style="width: 420px; height: 310px;" showModal="true"
		allowResize="false" allowDrag="false">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
					<td class="title"><label>最后来厂 从:</label></td>
					<td><input name="lastEnterStart" width="100%"
						class="nui-datepicker" /></td>
					<td class=""><label>至:</label></td>
					<td><input name="lastEnterEnd" class="nui-datepicker"
						format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false"
						showOkButton="false" width="100%" showClearButton="false" /></td>
				</tr>
				<tr>
					<td class="title"><label>第一次来厂 从:</label></td>
					<td><input name="firstEnterStart" width="100%"
						class="nui-datepicker" /></td>
					<td class=""><label>至:</label></td>
					<td><input name="firstEnterEnd" class="nui-datepicker"
						format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false"
						showOkButton="false" width="100%" showClearButton="false" /></td>
				</tr>
				<tr>
					<td class="title"><label>最后离厂 从:</label></td>
					<td><input name="lastOutStart" width="100%"
						class="nui-datepicker" /></td>
					<td class=""><label>至:</label></td>
					<td><input name="lastOutEnd" class="nui-datepicker"
						format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false"
						showOkButton="false" width="100%" showClearButton="false" /></td>
				</tr>
				<tr>
					<td class="title"><label>建档日期 从:</label></td>
					<td><input name="recordStart" width="100%"
						class="nui-datepicker" /></td>
					<td class=""><label>至:</label></td>
					<td><input name="recordEnd" class="nui-datepicker"
						format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false"
						showOkButton="false" width="100%" showClearButton="false" /></td>
				</tr>
				<tr>
					<td class="title"><label>客户名称:</label></td>
					<td colspan="3"><input name="guestId" id="guestId1"
						class="nui-buttonedit" emptyText="请选择客户..."
						onbuttonclick="selectCustomer('guestId1')" width="100%"
						allowInput="false" selectOnFocus="true" /></td>
				</tr>
				<tr>
					<td class="title"><label>品牌:</label></td>
					<td colspan="1"><input class="nui-combobox" name="carBrandId"
						width="100%" id="carBrandId" valueField="id"
						textField="nameCn" /></td>
					<td class="" width="30"><label>车型:</label></td>
					<td colspan="1"><input class="nui-combobox" name="carModelId"
						width="100%" id="carModelId" valueField="carModelId" textField="carModel" />
					</td>
				</tr>
				<tr>
					<td class="title"><label>手机号码:</label></td>
					<td colspan="3"><input class="nui-textbox" name="mobile"
						width="100%" /></td>
				</tr>
				<tr>
					<td class="title"><label>底盘号:</label></td>
					<td colspan="3"><input class="nui-textbox" name="mobile"
						width="100%" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk"
					style="width: 60px; margin-right: 20px;">确定</a> <a
					class="nui-button" onclick="onAdvancedSearchCancel"
					style="width: 60px;">取消</a>
			</div>
		</div>
	</div>

</body>
</html>