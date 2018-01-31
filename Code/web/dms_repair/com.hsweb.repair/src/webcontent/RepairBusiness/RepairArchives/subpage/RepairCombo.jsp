<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 16:21:17
  - Description:
-->
<head>
<title>维修套餐</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
			style="width: 100%; height: 270px;"
			url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
			pageSize="20" showPageInfo="true" multiSelect="true"
			showPageIndex="false" showPage="true" showPageSize="false"
			showReloadButton="false" showPagerButtonIcon="false"
			totalCount="total" onselectionchanged="selectionChanged"
			allowSortColumn="true">

			<div property="columns">
				<div id="type" field="type" headerAlign="center" allowSort="true"
					visible="true" width="50px">序号</div>
				<div id="name" field="name" headerAlign="center" allowSort="true"
					visible="true" width="330px">套餐名称</div>
				<div id="captainName" field="captainName" headerAlign="center"
					allowSort="true" visible="true" width="70px">状态</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">套餐金额</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">优惠金额</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">小计金额</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">4S店金额</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="150px">备注</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>