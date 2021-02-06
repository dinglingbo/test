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
<title>配件价格</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containPartPrice.js?v=1.0.9"></script>
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
    <div id="priceGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="price"
         idField=""
         ondrawcell=""
         sortMode="client"
         url=""
         onrowdblclick=""
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         showSummaryRow="false">
        <div property="columns">
            <div allowSort="true" field="name" width="100" headerAlign="center" header="价格类型"></div>
            <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="售价"></div>
            <div allowSort="true" datatype="float" field="operator" width="60" headerAlign="center" header="创建人"></div>
            <div allowSort="true" field="operateDate" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm"></div>
        </div>
    </div>
</div>
<script>
    var partId = '<b:write property="partId"/>';
</script>


</body>
</html>
