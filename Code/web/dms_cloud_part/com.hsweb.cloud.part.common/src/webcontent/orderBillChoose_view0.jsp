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
<script src="<%=webPath + contextPath%>/common/js/orderBillChoose.js?v=1.0.43"></script>
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
           dataField="list"
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
              <div field="guestFullName" width="150" headerAlign="center" header="往来单位名称"></div>
              <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
              <div field="orderTypeId" width="80" headerAlign="center" header="业务类型"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div field="orderAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
              <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
              <div field="remark" width="120" headerAlign="center" header="备注"></div>
              <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>

          </div>
      </div>
  </div>

  <div id="editFormPchsEnterDetail" style="display:none;">
      <div id="innerPchsEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjPchsOrderDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           multiSelect="true" 
           allowCellSelect="true"
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div type="checkcolumn"></div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="采购数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="采购单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="采购金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>

  <div id="editFormPchsRtnDetail" style="display:none;">
      <div id="innerPchsRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjSellOrderDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           multiSelect="true" 
           allowCellSelect="true"
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div type="checkcolumn"></div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
              <div allowSort="true" datatype="float" field="showPrice" width="60" headerAlign="center" header="退货单价"></div>
              <div allowSort="true" datatype="float" field="showAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  
  <div id="editFormAllotApplyDetail" style="display:none;">
      <div id="innerAllotApplyGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjAllotApplyDetails"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           multiSelect="true" 
           allowCellSelect="true"
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div type="checkcolumn"></div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  

</div>


</body>
</html>
