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
<title>保养提醒</title>
<script
	src="<%=request.getContextPath()%>/query/stat/js/maintain.js?v=1.0.0">
	</script>
</head>
<body>

	<!--footer-->


	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<div id="queryform" class="nui-form" align="center">
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsapi.repair.data.rpb.RpbCardTimes">
			<!-- 排序字段 -->
 
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="list" class="nui-datagrid" 
			style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
			onDrawCell="onDrawCell" onselectionchanged="selectionChanged"
			allowSortColumn="false">
			<div property="columns">
				<div type="indexcolumn" header="序号" width="20px"></div>
				<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
				<div field="orgid" headerAlign="center" allowSort="true"
					visible="false">orgid</div>
				<div field="guestId" headerAlign="center" allowSort="true"
					visible="false">guestId</div>
				<div field="carId" headerAlign="center" allowSort="true"
					visible="false">carId</div>
				<div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
				<div field="carVin" headerAlign="center" allowSort="true" width="50px">
					车架号(VIN)</div>
				<div field="mtAdvisorName" headerAlign="center" allowSort="true" width="50px">
					维修顾问</div>
				<div field="dueDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
					下次保养日期</div>
			</div>
		</div>
	</div>


</body>
</html>
