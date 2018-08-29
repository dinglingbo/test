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
<title>套餐操作</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/packageList.js?v=1.2.9"></script>

</head>

<body>
	<div id="queryform" class="nui-form">
		<div class="nui-toolbar">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsapi.repair.data.rpb.RpbCardStored">
			<table id="table1">
				<tr>
					<td>套餐名称: <input class="nui-textbox"
						name="criteria/_expr[1]/name" /> <input class="nui-hidden"
						name="criteria/_expr[1]/_op" value="like"> <input
						class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
						<a class="nui-button" onclick="search()" plain="true"> <span
							class="fa fa-search fa-lg"></span>&nbsp; 查询
					</a> <a id="selectBtn" class="nui-button" onclick="edit()" plain="true"><span
							class="fa fa-check fa-lg"></span>&nbsp;选择 </a>
													<a class="nui-button" onclick="look" plain="true"> <span
							class="fa fa-search fa-lg"></span>&nbsp; 查看详细信息
					</a>

					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="package1" class="nui-datagrid"
			pageSize="20" onDrawCell="onDrawCell"
			onrowclick="onLeftSeriesGridRowClick" allowSortColumn="true"
			style="width: 100%; height: 100%;">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn"></div>
				<div field="id" headerAlign="center" allowSort="true"
					visible="false">套餐ID</div>
				<div field="name" headerAlign="center" allowSort="true">套餐名称</div>
				<div field="serviceTypeId"  headerAlign="center" allowSort="true">
													
					套餐类型</div>
				<div field="total" headerAlign="center" allowSort="true">市场金额</div>
				<div field="amount" headerAlign="center" allowSort="true">
					套餐金额</div>
				<div field="isShare" renderer="onstatus" headerAlign="center"
					allowSort="true">是否共享</div>
				<div field="isDisabled" renderer="onstatus" headerAlign="center"
					allowSort="true">状态</div>
		</div>
	</div>
	<input class="nui-combobox" visible="false" name="serviceTypeId" id="serviceTypeId"
										   valueField="id" allowInput="true" valueFromSelect="true"
										   textField="name"/>
</body>
</html>
