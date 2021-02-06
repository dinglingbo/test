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
<title>库存分布</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containBottomChainStock.js?v=1.0.11"></script>
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
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="list"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         onrowdblclick=""
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         showSummaryRow="false">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="compShortName" width="100" headerAlign="center" header="公司简称"></div>
            <div allowSort="true" field="storeName" width="100" headerAlign="center" header="仓库"></div>
  			<div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
        </div>
    </div>
</div>


</body>
</html>
<script>
    var partCode = '<b:write property="partCode"/>';
    var partId = '<b:write property="partId"/>';
</script>
