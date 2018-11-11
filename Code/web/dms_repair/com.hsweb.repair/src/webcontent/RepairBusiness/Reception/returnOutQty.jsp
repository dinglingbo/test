<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 16:51:28
  - Description:
-->
<head>
    <title>退货归库查询</title>
    <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/returnOutQty.js?v=1.0.9"></script>
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
            <td style=" width:45%;">
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
             	<input class="nui-textbox" width="100px" id="partCodeOrName" name="partCodeOrNmae" selectOnFocus="true" enabled="true" emptyText="配件编码/名称"/>
                <input class="nui-textbox" width="100px" id="morePartId" emptyText="内码"  selectOnFocus="true" name="morePartID"/>
                <input class="nui-textbox" width="100px" id="guestName" emptyText="客户/供应商"  selectOnFocus="true" name="guestName"/>
                <input id="partBrandId"
	                name="partBrandId"
	                class="nui-combobox"
	                width="100px"
	                textField="name"
	                valueField="id"
	                valueFromSelect="true"
	                emptyText="品牌"
	                url=""
	                allowInput="true"
	                showNullItem="false"
	                nullItemText="品牌"/>
                
                <input class="nui-combobox" 
                  id="operatorId" 
                  name="operatorId" 
                  textField="empName"
                  valueField="empId"
                  emptyText="请选择操作员"
                  url=""
                  allowInput="true"
                  valueFromSelect="false"
                  width="100px">
                
               <td class="form_label" style="width:6%; text-align:left;">操作日期 从:</td>
               <td style="width:4%;">
                 <input class="nui-datepicker" id="OstartDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
             </td>
             <td class="" style="width:1%;">至:</td>
             <td  style="width:50px;">
                <input class="nui-datepicker" id="OendDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
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
    showSummaryRow="true"
    totalField="page.count" 
    sizeList=[50,100,500,1000] 
     onrowdblclick="" 
     allowCellWrap = true
    frozenStartColumn="0"
    frozenEndColumn="0">
    <div property="columns">
        <div type="indexcolumn">序号</div>
        <div header="工单信息" headerAlign="center">
            <div property="columns">
            	<div allowSort="true" field="serviceCode" width="100" headerAlign="center" header="业务单号"></div>
            	<div allowSort="true" field="carNo" width="100" headerAlign="center" header="车牌号"></div>
                <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                <div allowSort="true" field="partName" width="150" headerAlign="center" header="配件名称"></div>
                <div allowSort="true" field="oemCode" width="100" headerAlign="center" header="OEM码"></div>
   				<div allowSort="true" field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
   				<div allowSort="true" field="applyCarModel" width="200" headerAlign="center" header="车型"></div>
                <div allowSort="true" field="unit" width="100" headerAlign="center" header="单位"></div>
                <div allowSort="true" field="carTypeIdF" width="100" headerAlign="center" header="配件分类一级"></div>
                <div allowSort="true" field="carTypeIdS" width="100" headerAlign="center" header="配件分类二级"></div>
                <div allowSort="true" field="carTypeIdT" width="100" headerAlign="center" header="配件分类三级"></div>
                <div allowSort="true" field="spec" width="100" headerAlign="center" header="规格"></div>
            </div>
        </div>
        
<!--          <div header="领料信息" headerAlign="center"> -->
<!--             <div property="columns"> -->
<!--                 <div summaryType="sum" allowSort="true" datatype="float" field="qty" width="60" headerAlign="center" header="领料日期" dataType="float" align="right"></div> -->
<!--                 <div allowSort="true" datatype="float" field="price" width="60" headerAlign="center" header="领料人" dataType="float" align="right"></div> -->
<!--             </div> -->
<!--         </div> -->
   
        <div header="成本信息" headerAlign="center">
            <div property="columns">
                 <div field="trueUnitPrice" width="60" headerAlign="center" header="成本单价" dataType="float" align="right"></div>
                <div summaryType="sum" field="trueCost" headerAlign="center" header="成本金额" dataType="float" align="right"></div>
            </div>
        </div>
        
         <div header="销售信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true"  field="sellUnitPrice" width="60" headerAlign="center" header="销售单价" dataType="float" align="left"></div>
                <div allowSort="true"  field="sellAmt" headerAlign="center" header="销售金额" dataType="float" align="left"></div>
            </div>
        </div>
        <div header="盈利信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true"  field="gross" width="60" headerAlign="center" header="毛利" dataType="float" align="left"></div>
                <div allowSort="true"  field="grossRate" headerAlign="center" header="配件毛利率" dataType="float" align="left"></div>
                <div allowSort="true"  field="costRate" headerAlign="center" header="成本率" dataType="float" align="left"></div>
            </div>
        </div>
        <div header="退货信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true"  field=outReturnSign width="60" headerAlign="center" header="退货标志" dataType="float" align="left"></div>
                <div allowSort="true"  field="outDate" headerAlign="center" header="退货日期" dataType="float" align="left"></div>
            </div>
        </div>
    </div>
</div>
</div>


</html>
