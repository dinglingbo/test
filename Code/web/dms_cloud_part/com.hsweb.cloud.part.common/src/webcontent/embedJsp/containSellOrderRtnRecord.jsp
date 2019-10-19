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
<title>销售退货记录</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containSellOrderRtnRecord.js?v=2.0.12"></script>
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
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="detailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         showReloadButton="false"
         url=""
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         showSummaryRow="false">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="销退单号"></div>
            <div field="guestFullName" width="150" headerAlign="center" header="供应商"></div>
            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
            <div allowSort="true"width="120" field="enterDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
            <div allowSort="true" field="storeId" width="80" headerAlign="center" header="仓库"></div>
            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
 			<div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
            <div allowSort="true" datatype="float" field="rtnPrice" width="60" headerAlign="center" header="退货单价"></div>
            <div allowSort="true" datatype="float" field="rtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可出库数量"></div>
            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
            <div allowSort="true" field="manualCode" width="150" headerAlign="center" header="手工单号"></div>
            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
        </div>
    </div>
</div>

</body>
</html>

<script>
    var partId = '<b:write property="partId"/>';
    var guestId = '<b:write property="guestId"/>';
</script>
