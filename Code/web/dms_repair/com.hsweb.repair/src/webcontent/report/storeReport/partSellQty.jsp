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
    <title>配件销售明细表查询</title>
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/partSellQty.js?v=1.0.0"></script>
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
    <table style="width:100%;">
        <tr>
            <td style=" width:51%;">
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
                <input class="nui-textbox" width="100px" id="carNo" emptyText="车牌号"  selectOnFocus="true" name="carNo"/>
                <input class="nui-textbox" width="100px" id="serviceCode" emptyText="工单号"  selectOnFocus="true" name="serviceCode"/>
                
                
                
				<input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/> <br>
                        进厂日期 从:<input class="nui-datepicker" id="sEnterDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
				至:    <input class="nui-datepicker" id="eEnterDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
				 结算日期 从:<input class="nui-datepicker" id="sOutDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
				至:    <input class="nui-datepicker" id="eOutDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
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
        <div header="工单信息" headerAlign="center">
            <div property="columns">
            	<div allowSort=false field="serviceCode" width="160" headerAlign="center" header="业务单号"></div>
            	<div allowSort="false" field="carNo" width="100" headerAlign="center" header="车牌号"></div>
            	<div allowSort="false" field="guestName" width="80" headerAlign="center" header="客户名称"></div>  
            </div>
        </div>
        
        <div header="配件信息" headerAlign="center">
            <div property="columns">
                <div allowSort="false" field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
                <div allowSort="false" field="partName" name="partName" width="150" headerAlign="center" header="配件名称"></div>
                <div allowSort="false" field="unit" width="50" headerAlign="center" header="单位"></div>
            </div>
        </div>
         <div header="销售信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" summaryType="sum" allowSort="true" field="qty" width="60" headerAlign="center" header="销售数量" dataType="float" align="left"></div>
                <div allowSort="true" summaryType="sum" allowSort="true" field="unitPrice" width="60" headerAlign="center" header="销售单价" dataType="float" align="left"></div>
                <div allowSort="true" summaryType="sum" allowSort="true" field="amt"   width="60"headerAlign="center" header="销售金额" dataType="float" align="left"></div>
                <div allowSort="true"  allowSort="true" field="saleMan"  width="60"headerAlign="center" header="销售员" dataType="float" align="left"></div>
            </div>
        </div>

        <div header="其他" headerAlign="center">
            <div property="columns">
            	<div allowSort="true" summaryType="sum"  allowSort="true" field="pickQty"  width="60"headerAlign="center" header="领料数量" dataType="float" align="left"></div>
            	<div allowSort="true" width="130"  dateFormat="yyyy-MM-dd HH:mm" field="enterDate" headerAlign="center" header="进厂日期" align="left"></div>
            	<div allowSort="true" width="130"  dateFormat="yyyy-MM-dd HH:mm" field="outDate" headerAlign="center" header="结算日期" align="left"></div>
                <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
            </div>
        </div>
    </div>
</div>
</div>

<div id="exportDiv" style="display:none">  

</div> 
</html>
