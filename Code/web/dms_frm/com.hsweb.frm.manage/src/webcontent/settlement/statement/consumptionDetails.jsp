<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>储值卡消费记录</title>
<script
	src="<%=request.getContextPath()%>/manage/settlement/js/consumptionDetails.js?v=1.1.9"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
	<div class="nui-splitter" vertical="true"
		style="width: 100%; height: 100%;" allowResize="true">
		<!-- 上 -->
		
		<div size="50%" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar" style="padding: 2px; height: 30px">
					<table id="table1">
						<tr>
							<td>
							<input name="serviceTypeId" id="serviceTypeId" visible="false" class="nui-combobox" textField="name" valueField="id"/>
								   <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
	                   			   <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="search()" />
									办卡日期: <input id="startDate" class="mini-datepicker" required="true" />—至—
									         <input id="endDate" class="mini-datepicker" required="true" /> 
									<a class="nui-button" onclick="search()" plain="true"> <span class="fa fa-search fa-lg"></span>&nbsp; 查询</a>
							</td>
						</tr>
					</table>
				</div>
				<div class="nui-fit">
					<div id="datagrid1" dataField="data" class="nui-datagrid"
						pageSize="50" onDrawCell="onDrawCell"
						onselectionchanged="selectionChanged" onrowclick=""
						allowSortColumn="true" style="width: 100%; height: 100%;">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<div field="id" headerAlign="center" allowSort="true"
								visible="false">会员卡ID</div>
							<div field="fullName" headerAlign="center" align="center"
								allowSort="true">客户名称</div>
							<div field="mobile" headerAlign="center" align="center"
								allowSort="true">电话</div>
							<div field="cardName" headerAlign="center" align="center"
								allowSort="true">会员卡名称</div>
							<div field="rechargeAmt" headerAlign="center" align="center"
								allowSort="true">充值金额</div>
							<div field="giveAmt" headerAlign="center" align="center"
								allowSort="true">赠送金额</div>
							<div field="totalAmt" headerAlign="center" align="center"
								allowSort="true">总金额</div>
							<div field="useAmt" headerAlign="center" align="center"
								allowSort="true">已使用金额</div>
							<div field="packageRate" headerAlign="center" align="center"
								allowSort="true">套餐优惠率</div>
							<div field="itemRate" headerAlign="center" align="center"
								allowSort="true">工时优惠率</div>
							<div field="partRate" headerAlign="center" align="center"
								allowSort="true">配件优惠率</div>
							<div field="recordDate" renderer="onstatus" align="center"
								headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">充值日期</div>
							<div field="recorder" headerAlign="center" align="center"
								allowSort="true">操作人</div>
						</div>
					</div>
				</div>
			</div>
		</div>

   
         
		<!-- 下 -->
		<div showCollapseButton="false">
			<div class="nui-fit">
				<div id="datagrid2" dataField="data" class="nui-datagrid" 
					style="width: 100%; height: 100%;" 
					allowSortColumn="true" showPager="false" allowCellWrap=true>
					<div property="columns">
						<div type="indexcolumn" headerAlign="center" width="30">序号</div>
						<div field="carNo" headerAlign="center" allowSort="true" width="80px">车牌</div>
						<div field="carModel" headerAlign="center" allowSort="true" width="200px">品牌/车型</div>
						<div field="carVin" headerAlign="center" allowSort="true" width="130px">车架号(VIN)</div>
						<div field="serviceTypeName" name = "serviceTypeName" headerAlign="center" allowSort="true" width="80px">业务类型</div>
						<div field="mtAdvisor" headerAlign="center" allowSort="true" width="80px">服务顾问</div>
						<div field="serviceCode" headerAlign="center" allowSort="true" width="120px">工单号</div>
						<div field="consumeAmt" headerAlign="center" allowSort="true" width="80px">本次消费金额</div>
						<div field="cardAmt" headerAlign="center" allowSort="true" width="80px">储值卡余额
						</div>
						<div field="recorder" headerAlign="center" allowSort="true" width="80px">操作人
						</div>
						<div field="recordDate" headerAlign="center" allowSort="true"
							dateFormat="yyyy-MM-dd" width="110px">消费日期</div>							
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>