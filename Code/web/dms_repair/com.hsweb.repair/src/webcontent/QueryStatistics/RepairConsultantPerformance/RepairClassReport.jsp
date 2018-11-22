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
<title>维修班组业绩报表</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairConsultantPerformance/RepairConsultantPerformanceMain.js?v=1.0.4"></script>
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
	                <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">本日</a>
	                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
	                   <li iconCls="" onclick="quickSearch(0)">本日</li>
						<li iconCls="" onclick="quickSearch(1)">昨日</li>
						<li iconCls="" onclick="quickSearch(2)">本周</li>
						<li iconCls="" onclick="quickSearch(3)">上周</li>
						<li iconCls="" onclick="quickSearch(4)">本月</li>
						<li iconCls="" onclick="quickSearch(5)">上月</li>
					    <li iconCls="" onclick="quickSearch(6)">本年</li>
						<li iconCls="" onclick="quickSearch(7)">上年</li>
	                </ul>
					<span class="separator"></span>
					<a class="nui-button" plain="true" iconCls="" onclick="print()"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
					<a class="nui-button" plain="true" iconCls="" onclick="export()"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</span>
				</td>
			</tr>
		</table>
	</div>
</div>
 <div class="nui-fit">
	<div id="datagrid1" class="nui-datagrid" style="width: 100%; height: 100%;"
		 dataField="list"
		 pageSize="20"
		 showPager="true"
		 totalCount="page.count" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
		 frozenStartColumn="0" >
		<div property="columns">
		    <div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
			<div field="mtAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">班组</div>
			<div field="cardTimesAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">人数</div>
			<div field="partManageExp" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">维修单数</div>
		    <div field="mtAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">项目金额</div>
			<div field="partManageExp" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">人均金额</div>
		    <div field="cardTimesAmt" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="float" align="right">项目提成</div>
		</div>
	</div>
</div>
</body>
</html>