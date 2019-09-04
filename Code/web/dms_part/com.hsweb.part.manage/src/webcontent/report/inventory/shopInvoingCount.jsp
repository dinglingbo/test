<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 16:51:28
  - Description:
-->
<head>
    <title>门店进销存统计</title>
    <script src="<%=webPath + contextPath%>/manage/js/report/shopInvoingCount.js?v=1.0.5"></script>
    <style type="text/css">
    .title {
      width: 60px;
      text-align: right;
  }

  .form_label {
    width: 72px;
    text-align: right;
}

.required {
    color: red;
}
</style>
</head>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style=" width:10%;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>
                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                   <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                   <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                   <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                   <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
               </ul>
               <span class="separator"></span>
       		 创建日期 从:
                 <input class="nui-datepicker" id="startDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
				至:
    
                <input class="nui-datepicker" id="endDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid" visible="false"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

            <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 
        </td>
    </tr>
</table>
</div>

<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="false"
    dataField="list"
    idField="partId"
    sortMode="client"
    pageSize="100"
    totalField="page.count" 
    sizeList=[50,100,500,1000] 
     onrowdblclick=""
     showSummaryRow="true" 
     allowCellWrap = true
    frozenStartColumn="0"
    frozenEndColumn="0">
    <div property="columns">
        <div type="indexcolumn" width="50">序号</div>
        <div header="配件信息" headerAlign="center">
            <div property="columns">
<!--                 <div allowSort="true" field="partId" width="100" headerAlign="center" header="配件内码"></div> -->
                <div allowSort="true" field="partCode" width="100" headerAlign="center" summaryType="count" header="配件编码"></div>
                <div allowSort="true" field="partName" width="150" headerAlign="center" header="配件名称"></div>
   				<div allowSort="true" field="oemCode" width="150" headerAlign="center" header="OEM码"></div>
   				<div allowSort="true" field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
            </div>
        </div>
        
         <div header="期初" headerAlign="center">
            <div property="columns">
                <div  summaryType="sum" allowSort="true" datatype="float" field="qcQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div  summaryType="sum" allowSort="true" datatype="float" field="qcAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="采购入库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseEnterQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseEnterAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="采购退货" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseOutQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseOutAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="工单归库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="repairEnterQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="repairEnterAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="工单出库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="repairOutQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="repairOutAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="工单退货" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="returnOutQty" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="returnOutAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="移仓入库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftEnterQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftEnterAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        
         <div header="移仓出库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftOutQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftOutAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="精品入库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="精品出库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="耗材入库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableEnterQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableEnterAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="耗材出库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableOutQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableOutAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="盘盈" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" field="inventoryProfitQty" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" field="inventoryProfitAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
       <div header="盘亏" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" field="inventoryLossQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" field="inventoryLossAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
        <div header="结存" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" field="balaQty" width="60" headerAlign="center" header="数量"  align="right"></div>
                <div summaryType="sum" field="balaAmt" headerAlign="center" header="金额"  align="right"></div>
            </div>
        </div>
    </div>
</div>
</div>

<div id="exportDiv" style="display:none">  

</div> 
</html>
