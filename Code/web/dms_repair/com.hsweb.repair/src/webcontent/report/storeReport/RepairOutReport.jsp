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
    <title>维修出库明细</title>
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/repairOutReport.js?v=1.1.7"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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
 
 	<input class="nui-textbox" width="80px" id="partCode" name="partCode" selectOnFocus="true" enabled="true" emptyText="配件编码"/>
    <input class="nui-textbox" width="80px" id="partName" emptyText="配件名称"  selectOnFocus="true" name="partName"/>
   

     <input id="storeId"
        name="storeId"
        class="nui-combobox"
        width="80px"
        textField="name"
        valueField="id"
        valueFromSelect="true"
        emptyText="仓库"
        url=""
        dataField="storehouse"
        allowInput="false"
        showNullItem="false"
        nullItemText="仓库" onvaluechanged="onSearch"/>
    <input id="partBrandId"
        name="partBrandId"
        class="nui-combobox"
        width="80px"
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
      width="100px" onvaluechanged="onSearch">
      <input name="serviceTypeId"
       id="serviceTypeId"
       class="nui-combobox"
       textField="name"
       valueField="id"
       emptyText="业务类型"
       url=""
       allowInput="true"
       showNullItem="false"
       width="90px"
       valueFromSelect="true"
       nullItemText="请选择..."
       onvaluechanged="onSearch"
       />
<!--        0综合，1检查，2洗美，3销售，4理赔，5退货，6波箱 -->
       <input class="nui-combobox" 
          id="billTypeId" 
          name="billTypeId"
          textField="name"
          valueField="id"
          dataField="billTypeIdList"
          emptyText="工单类型"
          url=""
          allowInput="true"
          valueFromSelect="false"
          width="100px"
          onvaluechanged="onSearch"
          >
      <input class="nui-textbox" width="80px" id="carNo" name="carNo" selectOnFocus="true" enabled="true" emptyText="车牌号"/>
  出库日期 从:
     <input class="nui-datepicker"width="100px" id="sPickDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
 至:
    <input class="nui-datepicker" width="100px"id="ePickDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
 	</br>  
   结算日期 从:
     <input class="nui-datepicker"width="100px" id="sOutDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
 至:
    <input class="nui-datepicker" width="100px"id="eOutDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
     <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
    <input type="checkbox" id="ReturnSign" class="mini-checkbox"  onclick="changed()" >
	<span >是否显示归库</span>
</div>

<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="true"
    dataField="list"
    idField="partId"
    sortMode="client"
    pageSize="500"
    showSummaryRow="true"
    totalField="page.count" 
    sizeList=[500,1000,2000] 
     onrowdblclick="" 
     allowCellWrap = "false"
    frozenStartColumn="0"
    sortMode="client"
    frozenEndColumn="0">
    <div property="columns">
        <div type="indexcolumn">序号</div>
        <div header="工单信息" headerAlign="center">
            <div property="columns">
            	<div allowSort="true" field="serviceCode" name="serviceCode" width="180" headerAlign="center" header="业务单号" ></div>
            	<div allowSort="true" field="carNo" name="carNo" width="100" headerAlign="center" header="车牌号" ></div>
            	<div allowSort="true" field="serviceTypeId" name="serviceTypeId" width="100" headerAlign="center" header="业务类型" ></div>
            	<div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库" ></div>
                <div allowSort="true" field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码" ></div>
                <div allowSort="true" field="partName" name="partName" width="150" headerAlign="center" header="配件名称" ></div>
                <div allowSort="true" field="oemCode" width="100" headerAlign="center" header="OEM码" ></div>
                <div allowSort="true" field="outQty" summaryType="sum" name="outQty" width="100" headerAlign="center"  dataType="float" header="数量" ></div>
            </div>
        </div>
        
        <div header="成本信息" headerAlign="center">
            <div property="columns">
                 <div summaryType="sum" allowSort="true" field="trueUnitPrice" width="60" headerAlign="center" header="成本单价" datatype="float" align="left"></div>
                <div summaryType="sum" allowSort="true" field="trueCost" headerAlign="center" header="成本金额" dataType="float" align="left"></div>
            </div>
        </div>
        
         <div header="销售信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" summaryType="sum" allowSort="true" field="sellUnitPrice" width="60" headerAlign="center" header="销售单价" dataType="float" align="left"></div>
                <div allowSort="true" summaryType="sum" allowSort="true" field="sellAmt" headerAlign="center" header="销售金额" dataType="float" align="left"></div>
            </div>
        </div>
        <div header="盈利信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" summaryType="sum" allowSort="true" field="gross" width="80" headerAlign="center" header="毛利" dataType="float" align="left"></div>
                <div allowSort="true"  allowSort="true" field="grossRate" numberFormat="p" headerAlign="center" header="配件毛利率"  align="left"></div>
                <div allowSort="true"  allowSort="true" field="costRate" numberFormat="p" headerAlign="center" header="成本率"  align="left"></div>
            </div>
        </div>
        <div header="出库信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true"  field="pickMan" width="60" name="pickMan" headerAlign="center" header="出库人" dataType="float" align="left"></div>
                <div allowSort="true" width="130"  dateFormat="yyyy-MM-dd HH:mm" field="pickDate" headerAlign="center" header="出库日期" dataType="float" align="left"></div>
            </div>
        </div>
        <div header="其他" headerAlign="center">
            <div property="columns">
               <div allowSort="true" field="returnSign" width="80" headerAlign="center" header="是否归库" ></div>
               <div allowSort="true" field="returnDate" width="120" headerAlign="center" header="归库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                <div allowSort="true" field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
   				<div allowSort="true" field="applyCarModel" width="200" headerAlign="center" header="适用车型"></div>
                <div allowSort="true" field="unit" width="50" headerAlign="center" header="单位"></div>
                <div allowSort="true" field="carTypeIdF" width="100" headerAlign="center" header="配件分类一级"></div>
                <div allowSort="true" field="carTypeIdS" width="100" headerAlign="center" header="配件分类二级"></div>
                <div allowSort="true" field="carTypeIdT" width="100" headerAlign="center" header="配件分类三级"></div>
                <div allowSort="true" field="spec" width="100" headerAlign="center" header="规格"></div>
                <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
            </div>
        </div>
    </div>
</div>
</div>


</html>
