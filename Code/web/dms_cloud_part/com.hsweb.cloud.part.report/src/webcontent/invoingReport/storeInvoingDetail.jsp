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
    <title>仓库进销存明细</title>
    <script src="<%=webPath + contextPath%>/report/js/invoing/storeInvoingDetail.js?v=1.0.5"></script>
    <link href="<%=webPath + contextPath%>/common/js/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/common/js/HeaderFilter.js" type="text/javascript"></script>
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
            <td style=" width:55%;">
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
               	仓库: <input  showNullItem="false" width="80" id="storehouse" name="storehouse" dataField="storehouse" allowInput="false" class="nui-combobox" valueField="id" textField="name" data="storehouse">
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
                  width="110px">
                
				操作日期 从:
                 <input class="nui-datepicker" id="OstartDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
 				至:
                <input class="nui-datepicker" id="OendDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                
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
        <div header="配件信息" headerAlign="center">
            <div property="columns">
<!--                 <div allowSort="true" field="partId" width="100" headerAlign="center" header="配件内码"></div> -->
                <div allowSort="false" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                <div allowSort="false" field="partName" name="partName" width="150" headerAlign="center" header="配件名称"></div>
   				<div allowSort="false" field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
   				<div allowSort="false" field="applyCarModel" name="applyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
   				<div allowSort="false" field="dc" width="100" headerAlign="center" header="方向"></div>
   				<div allowSort="false" field="operateDate" width="150" headerAlign="center" dateFormat ="yyyy-MM-dd HH:mm:ss" format="yyyy-MM-dd HH:mm:ss" header="操作日期"></div>
            </div>
        </div>
        
         <div header="本次操作信息" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" allowSort="true" datatype="float" field="qty" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                <div allowSort="true" datatype="float" field="costPrice" width="60" headerAlign="center" header="单价" dataType="float" align="right"></div>
                <div summaryType="sum" allowSort="true" datatype="float" field="costAmt" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
   
        <div header="结存" headerAlign="center">
            <div property="columns">
                <div summaryType="sum" field="balaQty" allowSort="true" width="60" headerAlign="center" header="数量" dataType="float" align="right"></div>
                 <div field="balaPrice" width="60" headerAlign="center" allowSort="true" header="单价" dataType="float" align="right"></div>
                <div summaryType="sum" field="balaAmt" allowSort="true" headerAlign="center" header="金额" dataType="float" align="right"></div>
            </div>
        </div>
        
         <div header="其他信息" headerAlign="center">
            <div property="columns">
            	<div allowSort="false"  field="serviceId" width="150" headerAlign="center" header="业务单号"  align="left"></div>
                <div allowSort="false"  field="billTypeId" name="billTypeId" width="90" headerAlign="center" header="操作类型"  align="left"></div>
                <div allowSort="false"  field="operator" name="operator" headerAlign="center" header="操作员" dataType="float" align="left"></div>
                <div allowSort="false"  field="guestName" width="250" headerAlign="center" header="客户/供应商"  align="left"></div>
                <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
            </div>
        </div>
        
    </div>
</div>
</div>

</div>

<div id="exportDiv" style="display:none"> 
</html>
