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
<title>仓库信息</title>
<script src="<%=webPath + cloudPartDomain%>/common/js/embed/containBottomStock.js?v=1.0.0"></script>
<style type="text/css">
.title {
    width: 90px;
    text-align: right;
}

.title.required {
    color: red;
}

.mini-panel-border {
    /*border-right: 0;*/
    
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
         dataField="detailList"
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
            <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
            <div allowSort="true" field="shelf" width="60" headerAlign="center" header="仓位"></div>
            <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
            <div allowSort="true" datatype="float" field="stockAmt" summaryType="sum" width="60" headerAlign="center" header="库存金额"></div>
            <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
            <div allowSort="true" datatype="float" field="occupyQty" summaryType="sum" width="60" headerAlign="center" header="占用数量"></div>
            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
            <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
            <div allowSort="true" field="lastEnterDate" headerAlign="center" header="最近入库日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
            <div allowSort="true" field="lastOutDate" headerAlign="center" header="最近出库日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
            <div allowSort="true" field="upLimit" width="60" headerAlign="center" header="库存上限"></div>
            <div allowSort="true" field="downLimit" width="60" headerAlign="center" header="库存下限"></div>
            <div allowSort="true" field="detailRemark" width="200" headerAlign="center" header="备注"></div>
        </div>
    </div>
</div>


</body>
</html>
