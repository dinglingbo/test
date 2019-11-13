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
<title>本店库存</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containPartStock.js?v=1.0.0"></script>
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

<div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" allowResize="true">
    <div size="30%" showCollapseButton="false">
        <div class="nui-fit">
            <div id="storeStockGrid" class="nui-datagrid" style="width:100%;height:100%;"
                    showPager="false"
                    dataField="detailList"
                    ondrawcell=""
                    sortMode="client"
                    pageSize="10000"
                    sizeList="[1000,5000,10000]"
                    showSummaryRow="false">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="comPartName" width="100" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
                    <div allowSort="true" field="shelf" width="80" headerAlign="center" header="仓位"></div>
                    <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                    <div allowSort="true" datatype="float" field="stockAmt" summaryType="sum" width="60" headerAlign="center" header="库存金额"></div>
                    <div allowSort="true" datatype="float" field="expEnterAmt" summaryType="sum" width="60" headerAlign="center" header="人进金额"></div>
                    <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div><!-- 
                    <div allowSort="true" datatype="float" field="occupyQty" summaryType="sum" width="60" headerAlign="center" header="占用数量"></div> -->
                    <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                    <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                    <div allowSort="true" field="lastEnterDate"  width="120" headerAlign="center" header="最近入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="lastOutDate" width="120" headerAlign="center" header="最近出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="upLimit" width="60" headerAlign="center" header="库存上限"></div>
                    <div allowSort="true" field="downLimit" width="60" headerAlign="center" header="库存下限"></div>
                    <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
                    <div allowSort="true" field="applyCarModel" width="150" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="detailRemark" width="200" headerAlign="center" header="备注"></div>
                </div>
            </div>
            <input id="billTypeId" visible="false" class="nui-combobox" textField="name" valueField="customid" />
        </div>
    </div>
    <div showCollapseButton="false">
        <div class="nui-fit">
            <div id="enterGrid" class="nui-datagrid" style="width:100%;height:100%;"
                    borderStyle="border:1;"
                    selectOnLoad="true"
                    showPager="true"
                    pageSize="50"
                    showReloadButton="false"
                    sizeList=[20,50,100,200]
                    dataField="detailList"
                    url=""
                    showModified="false"
                    sortMode="client"
                    totalField="page.count"
                    allowCellSelect="true" allowCellEdit="false">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div header="库存批次" headerAlign="left">
                        <div property="columns">
                            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
                            <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
                            <div allowSort="true" datatype="float" width="60" field="outableQty" name="outableQty" headerAlign="center" header="库存数量"></div>
                            <div allowSort="true" datatype="float" width="80" field="preOutQty" headerAlign="center" header="待出库数量"></div>
                            <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
                            <div field="expEnterPrice" width="55px" headerAlign="center" allowSort="true" header="人进单价"></div>
                            <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
                            <div field="storeId" width="120" headerAlign="center" allowSort="true" header="仓库"></div>
                            <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
                            <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
                            <div field="comOemCode" name="oemCode" width="150" headerAlign="center" header="OE码"></div>
                            <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
                            <div field="enterDate" allowSort="true" width="120" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="入库日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
                            <div field="guestFullName" width="180px" headerAlign="center" allowSort="true" header="供应商"></div>  
                            <div field="manualCode" align="left" width="180px" headerAlign="center" allowSort="true" header="单号"></div>
                            <div field="comPartFullName" name="comPartFullName" width="200" headerAlign="center" header="配件全称"></div> 
                            <div field="detailRemark" name="detailRemark" width="200" headerAlign="center" header="备注"></div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>	

</body>
</html>
<script>
    var partId = '<b:write property="partId"/>';
</script>
