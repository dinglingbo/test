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
<title>销售记录</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containSellOrderRecord.js?v=1.0.12"></script>
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
	<div  class="nui-splitter" style="width:100%;height:100%;" style="border:0;" handlerSize="0">
        <div size="130px" showCollapseButton="false">
        	<input class="nui-checkbox"  id="nowGuest" trueValue="1" falseValue="0" text="当前客户" value="1" oncheckedchanged="nowGuestChange()"/>
        	<br>
        	<input class="nui-checkbox"  id="chainGuest" trueValue="1" falseValue="0" text="连锁所有客户" oncheckedchanged="chainChange()"/>
        </div>
   		<div showCollapseButton="false">
		    <div id="sellOrderRecordGrid" class="nui-datagrid" style="width:100%;height:100%;"
		         showPager="true"
		         dataField="detailList"
		         sortMode="client"
		         showReloadButton="false"
		         pageSize="50"
		         sizeList="[50,100,200]">
		        <div property="columns">
		            <div type="indexcolumn">序号</div>
		            <div allowSort="true" field="serviceId" width="120" summaryType="count" headerAlign="center" header="单号"></div>
		            <div field="guestShortName" width="120" headerAlign="center" header="客户"></div>
		            <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="出库日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
		            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
		            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
		            <div allowSort="true" datatype="float" width="60" field="orderQty" name="orderQty" headerAlign="center" header="销售数量"></div>
		            <div field="orderPrice" width="55px" headerAlign="center" allowSort="true" header="销售单价"></div>
		            <div field="orderAmt" width="55px" headerAlign="center" allowSort="true" header="销售金额"></div>
		            <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
		            <div field="settleTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="结算方式"></div>
		            <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
		            <div field="comOemCode" name="comOemCode" width="100" headerAlign="center" header="OEM码"></div>
		            <!-- <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div> -->
		            <div field="applyCarModel" name="applyCarModel" width="150" headerAlign="center" header="品牌车型"></div>
		            <div field="outUnitId" width="30" headerAlign="center" header="单位"></div>
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
     </div>
</div>

</body>
</html>
<script>
    var partId = '<b:write property="partId"/>';
</script>
