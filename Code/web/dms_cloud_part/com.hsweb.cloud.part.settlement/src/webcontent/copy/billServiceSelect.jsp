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
<title>业务单选择</title>
<script src="<%=webPath + contextPath%>/settlement/js/billServiceSelect.js?v=1.1.0"></script>
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
                  <input id="billServiceMan" width="60px" emptyText="业务员" class="nui-hidden"/>
                  <!-- <input id="searchGuestId" class="nui-buttonedit"
                         emptyText="请选择往来单位..."
                         onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" /> -->
                  <input class="nui-combobox" visible="false" name="accountSign" id="accountSign" value="0"
                       emptyText="单据状态" data="accountList" width="70px" />
                  <a class="nui-button" iconCls="" plain="true" onclick="searchBill()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                  
                  <span class="separator"></span>
                  <a class="nui-button" iconCls="" plain="true" onclick="addStatement()"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                  <input class="nui-combobox" name="billTypeId" id="billTypeId"
                       emptyText="票据类型" data="" width="60px" visible="false" />
                  <input class="nui-combobox" name="settleTypeId" id="settleTypeId" 
                       emptyText="结算方式" data="" width="60px" visible="false" />
              </td>
          </tr>
      </table>
  </div>
  <div class="nui-fit">
      <div id="notStatementGrid" class="nui-datagrid" style="width:100%;height:100%;"
           showPager="true"
           dataField="detailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           multiSelect="true"
           pageSize="10000"
           sizeList="[1000,5000,10000]"
           onshowrowdetail="onShowRowDetail"
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div type="checkcolumn" width="30"></div>
              <div type="expandcolumn" width="20" >#</div>
              <div field="fullName" width="150" headerAlign="center" header="往来单位名称"></div>
              <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
              <div field="enterTypeId" width="60" headerAlign="center" header="业务类型"></div>
              <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
              <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
              <div field="accountSign" width="60" headerAlign="center" header="对账状态"></div>
              <!-- <div field="accountor" width="60" headerAlign="center" header="对账人"></div>
              <div allowSort="true" field="accountDate" headerAlign="center" header="对账日期" dateFormat="yyyy-MM-dd HH:mm"></div> -->
              <div field="remark" width="120" headerAlign="center" header="备注"></div>
              <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>

          </div>
      </div>
  </div>

  <div id="editFormPchsEnterDetail" style="display:none;">
      <div id="innerPchsEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjEnterDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="采购数量"></div>
              <div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="采购单价"></div>
              <div allowSort="true" datatype="float" field="enterAmt" summaryType="sum" width="60" headerAlign="center" header="采购金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
              <!-- 
              <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可出库数量"></div>
              <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
              <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
              <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
              <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
              <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
              <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
              <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div> -->
          </div>
      </div>
  </div>

  <div id="editFormPchsRtnDetail" style="display:none;">
      <div id="innerPchsRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjSellOutDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
              <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="退货单价"></div>
              <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
              <!-- <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
              <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
              <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
              <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
              <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
              <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
              <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
              <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
              <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div> -->
          </div>
      </div>
  </div>

  <div id="editFormSellOutDetail" style="display:none;">
      <div id="innerSellOutGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjSellOutDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
              <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="销售单价"></div>
              <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
              <!-- <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
              <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
              <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
              <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
              <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
              <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
              <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
              <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
              <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div> -->
          </div>
      </div>
  </div>

  <div id="editFormSellRtnDetail" style="display:none;">
      <div id="innerSellRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjEnterDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
              <div allowSort="true" datatype="float" field="rtnPrice" width="60" headerAlign="center" header="退货单价"></div>
              <div allowSort="true" datatype="float" field="rtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
              <!-- <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
              <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
              <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
              <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
              <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
              <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
              <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
              <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
              <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div> -->
          </div>
      </div>
  </div>
</div>


</body>
</html>
