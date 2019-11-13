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
<title>采购记录</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containPchsOrderRecord.js?v=1.0.13"></script>
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
    <div id="pchsOrderRecordGrid" class="nui-datagrid" style="width:100%;height:100%;"
            borderStyle="border:1;"
            selectOnLoad="true"
            showPager="true"
            totalField="page.count"
            ondrawcell="onDrawCell"
            pageSize="50"
            sizeList=[50,100,200]
            dataField="detailList"
            sortMode="client"
            showReloadButton="false"
            idField="id"
            totalField="page.count"
            allowCellSelect="true" allowCellEdit="false">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="serviceId" align="left" width="180px" headerAlign="center" allowSort="true" header="单号"></div>
            <div field="guestShortName" width="180px" headerAlign="center" allowSort="true" header="供应商"></div>  
            <div field="auditDate" allowSort="true" width="120px" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="入库日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" datatype="float" width="60" field="orderQty" name="orderQty" headerAlign="center" header="采购数量"></div>
            <div field="orderPrice" width="55px" headerAlign="center" allowSort="true" header="采购单价"></div>
            <div field="orderAmt" width="55px" headerAlign="center" allowSort="true" header="采购金额"></div>
            <div field="expEnterPrice" width="55px" headerAlign="center" allowSort="true" header="人进单价"></div>
            <div field="expEnterAmt" width="55px" headerAlign="center" allowSort="true" header="人进金额"></div>
            <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
            <div field="settelTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="结算方式"></div>
            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
            <div field="storeId" width="120" headerAlign="center" allowSort="true" header="仓库"></div>
            <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
            <div field="comOemCode" name="comOemCode" width="100" headerAlign="center" header="OE码"></div>
            <div field="partBrandId" name="partBrandId" width="80" headerAlign="center" header="品牌"></div>
            <div field="applyCarModel" name="applyCarModel" width="120" headerAlign="center" header="品牌车型"></div>
            <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
            <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
        </div>
    </div>
    <input name="billTypeId"
            id="billTypeId"
            class="nui-combobox"
            textField="name"
            valueField="customid"
            visible="false"/>

    <input name="settleTypeId"
            id="settleTypeId"
            class="nui-combobox"
            textField="name"
            valueField="customid"
            visible="false"/>
</div>

</body>
</html>
<script>
    var partId = '<b:write property="partId"/>';
</script>
