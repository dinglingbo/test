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
    <title>库存周转汇总</title>
    <script src="<%=webPath + contextPath%>/manage/js/report/stockTurnOverCount.js?v=1.0.1"></script>
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
            <td style=" width:19%;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">最近7天</a>
                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                   <li iconCls="" onclick="quickSearch(0)" id="type0">最近7天</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">最近30天</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(2)" id="type2">最近90天</li>
                   <li iconCls="" onclick="quickSearch(3)" id="type3">最近180天</li>
<!--                    <li class="separator"></li> -->
<!--                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li> -->
<!--                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li> -->
<!--                    <li class="separator"></li> -->
<!--                    <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li> -->
<!--                    <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li> -->
               </ul>
               <span class="separator"></span>
	         	<div class="nui-radiobuttonlist"
                     repeatItems="2"
                     id="countWay"
                     width="180"
                     style="position: absolute;top: 4px;display: inline-table;"
                     textField="text" valueField="id" value="1" data="[{id:1,text:'汇总'},{id:2,text:'分仓'}]">
                </div>
                
               <td class="form_label" style="width:6%; text-align:center;">日期 从:</td>
               <td style="width:4%;">
                 <input class="nui-datepicker" id="startDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
             </td>
             <td class="" style="width:1%;">至:</td>
             <td  style="width:50px;">
                <input class="nui-datepicker" id="endDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 
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
    pageSize="10"
    showSummaryRow="true"
    totalField="page.count" 
    sizeList=[10,15,20] 
     onrowdblclick="" 
     allowCellWrap = true
    frozenStartColumn="0"
    frozenEndColumn="0">
            <div property="columns">
        		<div type="indexcolumn">序号</div>
                <div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库"></div>
   				<div allowSort="true" field="qcQty" width="100" headerAlign="center" header="期初库存数量" allowSort="true" dataType="float"></div>
   				<div allowSort="true" field="qcAmt" numberFormat="0.00" width="100" headerAlign="center" header="期初库存成本" allowSort="true"  dataType="float"></div>
   				<div allowSort="true" field="balaQty" width="100" headerAlign="center" header="期末库存数量" allowSort="true"  dataType="float"></div>
   				<div allowSort="true" field="balaAmt" numberFormat="0.00" width="100" headerAlign="center" header="期末库存成本" allowSort="true"  dataType="float"></div>
   				<div allowSort="true" field="sellQty" width="100" headerAlign="center" header="销售数量" allowSort="true"  dataType="float"></div>
   				<div allowSort="true" field="sellAmt" numberFormat="0.00" width="100" headerAlign="center" header="销售总成本" allowSort="true"  dataType="float"></div>
   				<div allowSort="true" field="turnOverDay" numberFormat="0.00" width="100" headerAlign="center" header="库存周转天数" allowSort="true"  dataType="float"></div>
   				<div allowSort="true" field="turnOverRate" numberFormat="0.00" width="100" headerAlign="center" header="库存周转率" allowSort="true"  dataType="float"></div>

            </div>
        </div>
        
        
    </div>
</div>

</div>


<div id="exportDiv" style="display:none">  

</html>
