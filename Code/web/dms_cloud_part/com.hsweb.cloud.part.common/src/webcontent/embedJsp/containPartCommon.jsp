<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>替换件</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containPartCommon.js?v=1.0.0"></script>
<style type="text/css">
.title {
  width: 90px;
  text-align: right;
}

.title.required {
  color: red;
}

.mini-panel-body {
  padding: 0;
}
</style>
</head>
<body>
<div class="nui-fit">
    <div id="partCommonGrid" class="nui-datagrid" style="width:100%;height:100%;"
					dataField="parts"
					url=""
					idField="id"
					showPager="false"
					allowCellSelect="true"
					allowCellEdit="true"
					multiSelect="true"
					showModified="false"
					showLoading="true"
          selectOnLoad="true"
          sortMode="client"
					multiSelect="true"
					showSummaryRow="true"
					showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
			<div property="columns">
					<div field="partCode" width="150" headerAlign="center" allowSort="true" summaryType="count">编码</div>
					<div field="fullName" width="150" headerAlign="center" allowSort="true">全称</div>
					<div field="stockQty" width="40" headerAlign="center">库存</div>
					<div field="partBrandId" width="70" headerAlign="center">品牌</div>
					<div field="partName" width="80" headerAlign="center" allowSort="true">名称</div>
					<div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
					<div field="applyCarModel" width="120" headerAlign="center" allowSort="true">品牌车型</div>
					<div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
					<div field="qualityTypeId" width="60" headerAlign="center">品质</div>

			</div>
	</div>
</div>

</body>
</html>
<script>
    var partId = '<b:write property="partId"/>';
</script>
