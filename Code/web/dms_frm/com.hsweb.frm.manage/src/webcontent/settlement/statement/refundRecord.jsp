<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-08 09:53:27
  - Description:
-->
<head>
<title>客户退款明细表</title>
	<%@include file="/common/sysCommon.jsp"%>
<script
	src="<%=request.getContextPath()%>/manage/settlement/js/refundRecord.js?v=1.0.0"></script>
	
	    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
</head>

<body>
<div id="queryform" class="nui-form">	
<div class="nui-toolbar" style="border-bottom: 0;">
	<div id="queryForm">
		<table>
			<tr>
				<td>
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
				<input name="serviceTypeId" id="serviceTypeId" visible="false" class="nui-combobox" textField="name" valueField="id"/>
					   <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
           			   <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="search()" />
						退款日期:                     
						<input id="sOutDate" name="sOutDate" class="nui-datepicker"/>
						至:
                   		 <input id="eOutDate" name="eOutDate" class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           showClearButton="false"/> 
						        <input class="nui-combobox" id="search-billType" width="100" textField="name" valueField="id" value="0" data="billType" onvalueChanged="onSearch()" allowInput="false" />
						<a class="nui-button" onclick="onSearch()" plain="true"> <span class="fa fa-search fa-lg"></span>&nbsp; 查询</a>
						<a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 
				</td>			
			</tr>
		</table>
	</div>
</div>
</div>
<div class="nui-fit">
		<div id="datagrid1" dataField="data" class="nui-datagrid"
			pageSize="500" onDrawCell="onDrawCell"  		
			     showPager="true"    
                    totalField="page.count" showSummaryRow = "true"
                    sortMode="client"
                    allowCellSelect="true" 
                    sizeList="[500,1000,2000]"
                    allowCellEdit="true"
                    showModified="false"
                   allowCellWrap = "true"
			      allowSortColumn="true" style="width: 100%;height:100% ">
			<div property="columns">
			<div type="indexcolumn">序号</div>
				<div field="code" name="code" headerAlign="center" allowSort="true" summaryType="count" width="120px">
				退款单号</div>		
				<div field="fullName" name="fullName" headerAlign="center" allowSort="true" width="80px"> 
				客户名称</div>
				<div field="carNo" name="carNo" headerAlign="center" allowSort="true" width="80px">
				车牌号</div>				
				<div field="mobile" name="mobile" headerAlign="center" allowSort="true"  width="90px">
					电话</div>

				<div field="refundAmt" headerAlign="center" allowSort="true" width="70px" summaryType="sum">
					退款金额</div>
				<div field="cutAmt" headerAlign="center" allowSort="true" width="70px" summaryType="sum">
					扣减金额</div>					
				<div field="type" headerAlign="center" allowSort="true" width="90px" >
					退款类型</div>
				<div field="remark" headerAlign="center" allowSort="true" width="70px">
				备注</div>			
				<div field="recorder" name="recorder" headerAlign="center" allowSort="true" width="70px">
				退款人</div>	
				<div field="recordDate" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="110px">
					退款日期</div> 
			</div>
		</div>
	</div>
	<div id="exportDiv" style="display:none">  

</div> 
</body>
</html>
