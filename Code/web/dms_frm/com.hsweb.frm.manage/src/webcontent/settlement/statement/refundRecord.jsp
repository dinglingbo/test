<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-08 09:53:27
  - Description:
-->
<head>
<title>退款记录</title>
<script
	src="<%=request.getContextPath()%>/manage/settlement/js/refundRecord.js?v=1.0.3"></script>
</head>

<body>
<div id="queryform" class="nui-form">	
<div class="nui-toolbar" style="border-bottom: 0;">
	<div id="queryForm">
		<table>
			<tr>
				<td>
				<input name="serviceTypeId" id="serviceTypeId" visible="false" class="nui-combobox" textField="name" valueField="id"/>
					   <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
           			   <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="search()" />
						退款日期: <input id="startDate" class="mini-datepicker" required="true" />-至-
						         <input id="endDate" class="mini-datepicker" required="true" /> 
						<a class="nui-button" onclick="search()" plain="true"> <span class="fa fa-search fa-lg"></span>&nbsp; 查询</a>

				</td>			
			</tr>
		</table>
	</div>
</div>
</div>
<div class="nui-fit">
		<div id="datagrid1" dataField="data" class="nui-datagrid"
			pageSize="50" onDrawCell="onDrawCell"  		
			     showPager="true"    
                    totalField="page.count"
                    sortMode="client"
                    allowCellSelect="true"
                    allowCellEdit="true"
                    showModified="false"
                   allowCellWrap = "true"
			      allowSortColumn="true" style="width: 100%;height:100% ">
			<div property="columns">
				<div type="checkcolumn" >序号</div> 
				
				<div field="fullName" headerAlign="center" allowSort="true" width="80px">
				姓名</div>
				
				<div field="mobile" headerAlign="center" allowSort="true"  width="90px">
					电话</div>

				<div field="refundAmt" headerAlign="center" allowSort="true" width="70px">
					退款金额</div>
				<div field="type" headerAlign="center" allowSort="true" width="90px">
					退款类型</div>
				<div field="recorder" headerAlign="center" allowSort="true" width="70px">
				退款人</div>				
				<div field="recordDate" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="110px">
					退款日期</div> 
			</div>
		</div>
	</div>
</body>
</html>
