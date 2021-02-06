<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
<head>
<title>其他收支明细</title>
<script
	src="<%=request.getContextPath()%>/manage/settlement/js/otherIncomeAndExpenditure.js?v=1.0.1">
	</script>
	
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
</head>
<body>

	<!--footer-->


	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<div id="queryform" class="nui-form" align="center">             
			<table style="width: 100%;" id="table1">
				<tr> 		
				<td style="width: 100%;">
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
					<input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择往来单位..."  onvalueChanged="Search()" onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />	
					审核状态；<input class="nui-combobox" id="auditSign" onvalueChanged="search()" width="80" textField="name" valueField="id" value="0" data="statusList1" allowInput="false"/>
						结算状态：<input class="nui-combobox" id="settleStatus" onvalueChanged="search()" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
						<input class="nui-combobox" id="search-date" width="80" textField="name" onvalueChanged="search()" valueField="id" value="0" data="statusList2" allowInput="false"/>
							 从<input id="sDate" name="" class="nui-datepicker" value=""/>
         					   至 <input id="eDate" name="" class="nui-datepicker" value=""/>
					<input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
				<a class="nui-button" onclick="search()" plain="true">
						<span class="fa fa-search fa-lg"></span> 查询 </a> 
					<a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="list" class="nui-datagrid" 
			style="width: 100%; height: 100%;" pageSize="500" sizeList="[500,1000,2000]" showPageInfo="true" totalField="page.count" allowCellWrap="true"
			onDrawCell="onDrawCell" onselectionchanged="selectionChanged" sortMode="client" showSummaryRow = "true" >
			<div property="columns">
				<div type="indexcolumn"  header="序号" width="20px"></div>
				<div field="guestName" name="guestName" headerAlign="center" allowSort="true" width="120px">往来单位名称</div>
				<div field="billServiceId" name="billServiceId" headerAlign="center" allowSort="true" width="170px">业务单号</div>
				<div field="carNo" name="carNo" headerAlign="center" allowSort="true" width="110px">车牌号</div>
				<div field="billTypeId" name="billTypeId" headerAlign="center" allowSort="true" width="80px">
					收支项目</div>
				<div field="rpAmt" name="rpAmt" headerAlign="center" allowSort="true" width="80px" summaryType="sum" dataType="float">
					应结金额</div>
				<div field="charOffAmt" name="charOffAmt" headerAlign="center" allowSort="true" width="80px" summaryType="sum" dataType="float">
					已结金额</div>
				<div field="remark" name="remark" headerAlign="center" allowSort="true" width="140px">
					备注</div>
				<div field="billDc" name="billDc" headerAlign="center" allowSort="true" width="80px">
					交易类型</div>

				<div field="createDate" name="createDate" headerAlign="center" allowSort="true" width="150px" dateFormat="yyyy-MM-dd HH:mm">发生日期</div>
				<div field="rpBillId" name="rpBillId" headerAlign="center" allowSort="true" width="170px" summaryType="count">
					收支单号</div>
				<div field="auditor" name="auditor" headerAlign="center" allowSort="true" width="70px">审核人</div>
				<div field="auditDate" name="auditDate" headerAlign="center" allowSort="true" width="150px" dateFormat="yyyy-MM-dd HH:mm">审核日期</div>
				<div field="auditSign" name="auditSign" headerAlign="center" allowSort="true" width="80px">审核状态</div>
				<div field="settleStatus" name="settleStatus" headerAlign="center" allowSort="true" width="80px">结算状态</div>
				<div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
			</div>
		</div>
	</div>

<div id="exportDiv" style="display:none">  
</div>
</body>
</html>
