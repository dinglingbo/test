<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonRepair.jsp"%>
<%@include file="/common/common.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 16:51:28
  - Description:
-->
<head>
    <title>未结算配件查询</title>
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/repairNoSettle.js?v=1.0.2"></script>
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
 	<input class="nui-textbox" width="100px" id="partCode" name="partCode" selectOnFocus="true" enabled="true" emptyText="配件编码"/>
    <input class="nui-textbox" width="100px" id="partName" emptyText="配件名称"  selectOnFocus="true" name="partName"/>
   
     <input id="storeId"
        name="storeId"
        class="nui-combobox"
        width="100px"
        textField="name"
        valueField="id"
        valueFromSelect="true"
        emptyText="仓库"
        url=""
        dataField="storehouse"
        allowInput="true"
        showNullItem="false"
        nullItemText="仓库" onvaluechanged="onSearch"/>
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
        nullItemText="品牌"
        onvaluechanged="onSearch"/>
    
    <input class="nui-combobox" 
      id="partTypeId" 
      name="partTypeId"
      textField="name"
      valueField="id"
      dataField="partTypes"
      emptyText="配件分类"
      url=""
      allowInput="true"
      valueFromSelect="false"
      width="120px" onvaluechanged="onSearch">
   开单日期 从:
     <input class="nui-datepicker" id="sRecordDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
 至:
    <input class="nui-datepicker" id="eRecordDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
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
            	<div allowSort="true" field="serviceCode" width="170" headerAlign="center" header="业务单号"></div>
            	<div allowSort="true" field="carNo" width="100" headerAlign="center" header="车牌号"></div>
            	<div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库"></div>
                <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                <div allowSort="true" field="partName" width="150" headerAlign="center" header="配件名称"></div>
                <div allowSort="true" field="oemCode" width="100" headerAlign="center" header="OEM码"></div>
   				<div allowSort="true" field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
   				<div allowSort="true" field="applyCarModel" width="200" headerAlign="center" header="适用车型"></div>
                <div allowSort="true" field="unit" width="50" headerAlign="center" header="单位"></div>
                <div allowSort="true" field="carTypeIdF" width="100" headerAlign="center" header="配件分类一级"></div>
                <div allowSort="true" field="carTypeIdS" width="100" headerAlign="center" header="配件分类二级"></div>
                <div allowSort="true" field="carTypeIdT" width="100" headerAlign="center" header="配件分类三级"></div>
                <div allowSort="true" field="spec" width="100" headerAlign="center" header="规格"></div>
            </div>
        </div>
        
        <div header="成本信息" headerAlign="center">
            <div property="columns">
                 <div summaryType="sum" field="trueUnitPrice" width="60" headerAlign="center" header="成本单价" dataType="float" align="left"></div>
                <div summaryType="sum" field="trueCost" headerAlign="center" header="成本金额" dataType="float" align="left"></div>
            </div>
        </div>
        
         <div header="销售信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" summaryType="sum"  field="sellUnitPrice" width="60" headerAlign="center" header="销售单价" dataType="float" align="left"></div>
                <div allowSort="true" summaryType="sum" field="sellAmt" headerAlign="center" header="销售金额" dataType="float" align="left"></div>
            </div>
        </div>
        <div header="盈利信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" summaryType="sum" field="gross" width="80" headerAlign="center" header="毛利" dataType="float" align="left"></div>
                <div allowSort="true" summaryType="sum" field="grossRate" headerAlign="center" header="配件毛利率" dataType="float" align="left"></div>
                <div allowSort="true" summaryType="sum" field="costRate" headerAlign="center" header="成本率" dataType="float" align="left"></div>
            </div>
        </div>
        <div header="开单信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true"  field=pickMan width="60" headerAlign="center" header="开单人" dataType="float" align="left"></div>
                <div allowSort="true" width="130"  dateFormat="yyyy-MM-dd HH:mm" field="recordDate" headerAlign="center" header="开单日期" dataType="float" align="left"></div>
            </div>
        </div>
    </div>
</div>
</div>


</html>
