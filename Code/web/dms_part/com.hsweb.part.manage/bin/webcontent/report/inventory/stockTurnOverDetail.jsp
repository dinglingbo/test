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
    <title>库存周转明细查询</title>
    <script src="<%=webPath + contextPath%>/manage/js/report/stockTurnOverDeatail.js?v=1.0.0"></script>
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
            <td style=" width:36%;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">最近7天</a>
                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                   <li iconCls="" onclick="quickSearch(0)" id="type0">最近7天</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">最近30天</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(2)" id="type2">最近90天</li>
                   <li iconCls="" onclick="quickSearch(3)" id="type3">最近180天</li>
               </ul>
               <span class="separator"></span>
             	<input class="nui-textbox" width="100px" id="partCodeOrName" name="partCodeOrNmae" selectOnFocus="true" enabled="true" emptyText="配件编码/名称"/>
<!--                 <input class="nui-textbox" width="100px" id="morePartId" emptyText="内码"  selectOnFocus="true" name="morePartID"/> -->
<!--                 <input class="nui-textbox" width="100px" id="guestName" emptyText="客户/供应商"  selectOnFocus="true" name="guestName"/> -->
                
         
                <input id="partBrandId"
	                name="partBrandId"
	                class="nui-combobox"
	                width="120px"
	                textField="name"
	                valueField="id"
	                dataField="brandList"
	                valueFromSelect="true"
	                emptyText="品牌"
	                url=""
	                allowInput="true"
	                showNullItem="false"
	                nullItemText="品牌"/>
                
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
                  width="120px">
     		日期 从
                 <input class="nui-datepicker" id="startDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
  			至:
                <input class="nui-datepicker" id="endDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                 <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 
            
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
                <div allowSort="true" field="partCode" width="130" headerAlign="center" header="配件编码"></div>
                <div allowSort="true" field="partName" width="150" headerAlign="center" header="配件名称"></div>
                <div allowSort="true" field="oemCode" width="150" headerAlign="center" header="OEM码"></div>
   				<div allowSort="true" field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
   				<div allowSort="true" field="applyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
                <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                <div allowSort="true" field="carTypeIdF" width="100" headerAlign="center" header="配件分类一级"></div>
                <div allowSort="true" field="carTypeIdS" width="100" headerAlign="center" header="配件分类二级"></div>
                <div allowSort="true" field="carTypeIdT" width="100" headerAlign="center" header="配件分类三级"></div>
                <div allowSort="true" field="spec" width="100" headerAlign="center" header="规格"></div>
   				<div allowSort="true" field="qcQty" width="100" headerAlign="center" header="期初库存数量"  dataType="float" allowSort="true"></div>
   				<div allowSort="true" field="qcAmt" width="100" headerAlign="center" header="期初库存成本"  dataType="float" allowSort="true"></div>
   				<div allowSort="true" field="balaQty" width="100" headerAlign="center" header="期末库存数量"  dataType="float" allowSort="true"></div>
   				<div allowSort="true" field="balaAmt" width="100" headerAlign="center" header="期末库存成本"  dataType="float" allowSort="true"></div>
   				<div allowSort="true" field="sellQty" width="100" headerAlign="center" header="销售数量"  dataType="float" allowSort="true"></div>
   				<div allowSort="true" field="sellAmt" width="100" headerAlign="center" header="销售总成本"  dataType="float" allowSort="true"></div>
   				<div allowSort="true" field="turnOverDay" numberFormat="0.00" width="100" headerAlign="center" header="库存周转天数"  dataType="float" allowSort="true"></div>
   				<div allowSort="true" field="turnOverRate" numberFormat="0.00" width="100" headerAlign="center" header="库存周转率"  dataType="float" allowSort="true"></div>
   				<div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
            </div>
        </div>
        
        
    </div>
</div>


<div id="exportDiv" style="display:none">  

</div> 
</html>
