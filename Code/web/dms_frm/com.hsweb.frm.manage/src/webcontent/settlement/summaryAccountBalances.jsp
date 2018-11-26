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
<title>结算账户余额汇总表</title>
<script
	src="<%=request.getContextPath()%>/manage/settlement/js/summaryAccountBalances.js?v=1.0.9">
	</script>
</head>
<body>

	<!--footer-->


	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<div id="queryform" class="nui-form" align="center">             
			<table style="width: 100%;" id="table1"> 
				<tr> 
				<td style="width: 100%;">	
					结算账户；<input class="nui-combobox" id="auditSign" width="120" textField="name" valueField="id" value="0" onvaluechanged="search()" allowInput="false"/>
							 结算日期：<input id="sDate" name="" class="nui-datepicker" value="" allowInput="false"/>
         					   至 <input id="eDate" name="" class="nui-datepicker" value="" allowInput="false"/>
				<a class="nui-button" onclick="search()" plain="true">
						<span class="fa fa-search fa-lg"></span> 查询 </a> 
					
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="list" class="nui-datagrid" 
			style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true" totalField="page.count" allowCellWrap="true"
			onDrawCell="onDrawCell" onselectionchanged="selectionChanged"
			allowSortColumn="false">
			<div property="columns">
				<div type="indexcolumn" header="序号" width="20px"></div>
				<div field="rpAccountId" headerAlign="center" allowSort="true" width="120px">单号</div>
				<div field="guestName" headerAlign="center" allowSort="true" width="120px">往来单位</div>
				<div field="rpDc" headerAlign="center" allowSort="true" width="80px">
					应收/应付</div>
					<div field="settAccountName" headerAlign="center" allowSort="true" width="120px">结算账户</div>
				<div field="charOffAmt" headerAlign="center" allowSort="true" width="40px">
					金额</div>
				<div field="remark" headerAlign="center" allowSort="true" width="140px">
					备注</div>
				<div field="createDate" headerAlign="center" allowSort="true" width="80px" dateFormat="yyyy-MM-dd HH:mm">结算日期日期</div>
			</div>
		</div>
	</div>


</body>
</html>
