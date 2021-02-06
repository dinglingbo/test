<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>销售出库记录选择</title>
<script src="<%=webPath + contextPath%>/common/js/sellOrderOutSelect.js?v=1.0.4"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.title.tip {
  color: blue;
}

.title.wide {
	width: 100px;
}

.mini-panel-border {
	border: 0;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>


<div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table style="width:100%;">
          <tr>
              <td style="white-space:nowrap;">
                  <label style="font-family:Verdana;">审单日期 从：</label>
                  <input class="nui-datepicker" id="sBillAuditDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                  <label style="font-family:Verdana;">至</label>
                  <input class="nui-datepicker" id="eBillAuditDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                  <span class="separator"></span> 
                  <input id="searchBillGuestId" class="nui-buttonedit"
                         emptyText="请选择往来单位..." visible="false"
                         onbuttonclick="selectSupplier('searchBillGuestId')" selectOnFocus="true" />
                  <input id="billServiceId" width="120px" emptyText="业务单号" class="nui-textbox"/>
                  <input id="partCode" width="120px" emptyText="配件编码" class="nui-textbox"/>
                  <input id="billServiceMan" width="60px" emptyText="业务员" class="nui-hidden"/>
                  <!-- <input id="searchGuestId" class="nui-buttonedit"
                         emptyText="请选择往来单位..."
                         onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" /> -->
                  <input class="nui-combobox" visible="false" name="accountSign" id="accountSign" value="0"
                       emptyText="单据状态" data="accountList" width="70px" />
                  <a class="nui-button" iconCls="" plain="true" onclick="searchBill()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                  
                  <span class="separator"></span>
                  <a class="nui-button" iconCls="" plain="true" onclick="addStatement()"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                  <a class="nui-button" iconCls="" plain="true" onclick="onClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                  <input class="nui-combobox" name="billTypeId" id="billTypeId"
                       emptyText="票据类型" data="" width="60px" visible="false" />
                  <input class="nui-combobox" name="settleTypeId" id="settleTypeId" 
                       emptyText="结算方式" data="" width="60px" visible="false" />
                  <input class="nui-combobox" visible="false" name="orgCarBrandId" id="orgCarBrandId"/>
              </td>
          </tr>
      </table>
  </div>
  <div class="nui-fit">
      <div id="innerPchsRtnGrid" class="nui-datagrid" style="width:100%;height:100%;"
           dataField="partlist"
           idField="detailId" pageSize="20"
           ondrawcell="onDrawCell" showPager="true"
           sortMode="client"
           url=""
           multiSelect="true" 
           allowCellSelect="true"
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div type="checkcolumn"></div>
              <div allowSort="true" field="code" width="160" headerAlign="center" header="订单号" textAlign="left"></div>
              <div allowSort="true" field="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="orgCarBrandId" width="60" headerAlign="center" header="厂牌"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="70" headerAlign="center" header="可退货数量"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="销售单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
              <div allowSort="true" datatype="float" field="showPrice" width="60" headerAlign="center" header="开单单价"></div>
              <div allowSort="true" datatype="float" field="showAmt" summaryType="sum" width="60" headerAlign="center" header="开单金额"></div>
              <div allowSort="true" field="mainRemark" width="60" headerAlign="center" header="备注"></div>
              <div allowSort="true" field="serviceId" width="160" headerAlign="center" header="出库单号"></div>
              <div field="guestFullName" width="150" headerAlign="center" header="客户名称"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
          </div>
      </div>
  </div>


</div>


</body>
</html>
