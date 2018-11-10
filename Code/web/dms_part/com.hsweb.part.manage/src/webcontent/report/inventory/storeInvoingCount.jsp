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
    <title>仓库进销存统计</title>
    <script src="<%=webPath + contextPath%>/manage/js/report/storeInvoingCount.js?v=1.0.4"></script>
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
               <td style="width:12%;">
               	仓库: <input  property="editor" enabled="true"  id="storehouse" name="storehouse" dataField="storehouse" allowInput="true" class="nui-combobox" valueField="id" textField="name" data="storehouse">
               </td>
               
               <td class="form_label" style="width:6%; text-align:left;">创建日期 从:</td>
               <td style="width:4%;">
                 <input class="nui-datepicker" id="startDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
             </td>
             <td class="" style="width:1%;">至:</td>
             <td  style="width:50px;">
                <input class="nui-datepicker" id="endDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>              
            </td>
            
        </td>
    </tr>
</table>
</div>

<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="true"
    dataField="list"
    idField="partId"
    sortMode="client"
    pageSize="100"
    totalField="page.count" 
    sizeList=[50,100,500,1000] 
     onrowdblclick="" 
     allowCellWrap = true
     showSummaryRow="true"
    frozenStartColumn="0"
    frozenEndColumn="0">
    <div property="columns">
        <div type="indexcolumn">序号</div>
        <div header="配件信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="partId" width="100" headerAlign="center" header="配件内码"></div>
                <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                <div allowSort="true" field="partName" width="150" headerAlign="center" header="配件名称"></div>
   				<div allowSort="true" field="oemCode" width="150" headerAlign="center" header="OEM码"></div>
   				<div allowSort="true" field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
            </div>
        </div>
        
         <div header="期初" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="qcQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="qcAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="采购入库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseEnterQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseEnterAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="采购退货" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseOutQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="purchaseOutAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="工单归库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="repairEnterQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div  summaryType="sum" allowSort="true" datatype="float" field="repairEnterAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="工单出库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="repairOutQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="repairOutAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="工单退货" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="returnOutQty" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="returnOutAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="移仓入库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftEnterQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftEnterAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        
         <div header="移仓出库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftOutQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="shiftOutAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="耗材入库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableEnterQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableEnterAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="耗材出库" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableOutQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="consumableOutAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="盘盈" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" field="inventoryProfitQty" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" field="inventoryProfitAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
       <div header="盘亏" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" field="inventoryLossQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" field="inventoryLossAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        <div header="结存" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" field="balaQty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div summaryType="sum" field="balaAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
    </div>
</div>
</div>


</html>
