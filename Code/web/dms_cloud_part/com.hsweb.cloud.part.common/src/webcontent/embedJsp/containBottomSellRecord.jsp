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
<script src="<%=webPath + contextPath%>/common/js/embed/containBottomSellRecord.js?v=2.0.5"></script>
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
	<div  class="nui-splitter" style="width:100%;height:100%;" style="border:0;" handlerSize="0">
        <div size="100px" showCollapseButton="false">
        	<input class="nui-checkbox"  id="storeGuest" trueValue="1" falseValue="0" value="1" text="本店客户" oncheckedchanged="storeChange()"/>
        	<br>
        	<input class="nui-checkbox"  id="chainGuest" trueValue="1" falseValue="0" text="连锁客户" oncheckedchanged="chainChange()"/>
        </div>
   		<div showCollapseButton="false">
		    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
		         showPager="false"
		         dataField="detailList"
		         idField="detailId"
		         ondrawcell="onDrawCell"
		         sortMode="client"
		         url=""
		         pageSize="10000"
		         sizeList="[1000,5000,10000]"
		         showSummaryRow="false">
		        <div property="columns">
		            <div type="indexcolumn">序号</div>
		            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="销售单号"></div>
		            <div field="guestFullName" width="150" headerAlign="center" header="客户"></div>
		            <div allowSort="true" field="outDate" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
		            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
		            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
		            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
		            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
		            <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
		            <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
		            <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
		            <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="销售单价"></div>
		            <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
		            <div allowSort="true" datatype="float" field="rtnableQty" summaryType="sum" width="60" headerAlign="center" header="可退货数量"></div>
		            <div field="orderMan" width="60" headerAlign="center" header="销售员"></div>
		            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
		            <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
		            <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
		            <div field="lossPrice" width="60" headerAlign="center" header="损益"></div>
		            <div field="maoLi" width="60" summaryType="sum" headerAlign="center" header="毛利"></div>
		            <div field="costRate" width="60" headerAlign="center" header="成本率"></div>
		            <div field="maoLiRate" width="60" headerAlign="center" header="毛利率"></div>
		            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
		            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
		            <div field="expEnterPrice" width="60" headerAlign="center" header="人进单价"></div>
		            <div field="expEnterAmt" width="60" headerAlign="center" summaryType="sum" header="人进金额"></div>
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
	</div>
</div>


</body>
</html>
