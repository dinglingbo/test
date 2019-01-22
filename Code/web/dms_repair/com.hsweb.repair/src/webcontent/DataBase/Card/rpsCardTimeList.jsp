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
<title>计次卡查询</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/rpsCardTimesList.js?v=1.1.2"></script>
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
						办卡日期: <input id="startDate" class="mini-datepicker" required="true" />-至-
						         <input id="endDate" class="mini-datepicker" required="true" /> 
						<a class="nui-button" onclick="search()" plain="true"> <span class="fa fa-search fa-lg"></span>&nbsp; 查询</a>
						<a class="nui-button" onclick="searchOne()" plain="true"> <span class="fa fa-search fa-lg"></span>&nbsp; 查看详情</a>	
	   					<a class="nui-button" onclick="dealtWithCard()" plain="true"> <span class="fa fa-address-card-o fa-lg"></span>&nbsp;次卡办理</a>
<!-- 						<a class="nui-button" onclick="refund()" plain="true"> <span class="fa fa-user-circle fa-lg"></span>&nbsp;退款</a> -->
				</td>			
			</tr>
		</table>
	</div>
</div>
</div>
<div class="nui-fit">
		<div id="datagrid1" dataField="params" class="nui-datagrid"
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
				<!-- <div type="indexcolumn"></div>-->
				<div type="checkcolumn" ></div> 
				
				
				<div field="fullName" headerAlign="center" allowSort="true"
					>姓名</div>
				<div field="carOn" headerAlign="center" allowSort="true">
					车牌号</div>
				<div field="mobile" headerAlign="center" allowSort="true"  >
					电话</div>

				 
				<div field="cardName" headerAlign="center" allowSort="true">
				  计次卡名称</div>
				
				 <div field="userTimes" headerAlign="center" allowSort="true">
					使用情况
				</div>
					<div field="periodValidity" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">
					有效期</div> 
				<div field="sellAmt" headerAlign="center" allowSort="true">
					充值金额</div>
				<div field="isRefund" headerAlign="center" allowSort="true">
				是否退款</div>
				<div field="refunder" headerAlign="center" allowSort="true">
				退款人</div>				
				<div field="refundDate" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">
					退款日期</div> 
			</div>
		</div>
	</div>
</body>
</html>
