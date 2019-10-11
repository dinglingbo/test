<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
    <title>维修配件销售汇总表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
  <script src="<%=request.getContextPath()%>/repair/js/report/storeReport/partRepairQtySummary.js?v=1.0.1"></script>
    <style type="text/css">
    body { 
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
    .title {
       width: 90px;
       text-align: right;
   }

   .title.required {
       color: red;
   }

   .mini-panel-border {
       /*border-right: 0;*/

   }

   .mini-panel-body {
       padding: 0;
   }
</style>
</head>
<body>
    <input name="serviceTypeId"id="serviceTypeId"class="nui-combobox "textField="name"valueField="id" visible="false"/>
    <div id="form1" class="mini-toolbar" style="padding:10px;">
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
     结算日期:
     <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
     <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
<!--      <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> -->
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(0)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按日期汇总</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(1)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按业务类型汇总</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(2)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按配件编码汇总</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(3)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按服务顾问汇总</a>
 </div>
 <div class="nui-fit">
    <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;"
    dataField="data"
    idField="detailId" totalField='page.count'
    ondrawcell=""
    sortMode="client"
    url=""
    showSummaryRow="true">
            <div property="columns">          
        <div type="indexcolumn">序号</div>
                <div  field="groupName" name="groupName" width="60" headerAlign="center" header="业务类型"></div>
                <div  field="partName" name="partName" width="60" headerAlign="center" header="配件名称"></div> 
                <div  field="ct" width="60" headerAlign="center" summaryType="sum" header="单数"></div>
                <div  field="qty" width="60" headerAlign="center" summaryType="sum" header="配件数量"></div>
                <div  field="trueCost" width="60" headerAlign="center" summaryType="sum" header="成本"></div>
                <div  field="amt" width="60" headerAlign="center" summaryType="sum" header="销售金额 "></div>
                <div  field="discountAmt" width="60" headerAlign="center" summaryType="sum" header="优惠金额"></div>
                <div  field="subtotal" width="60" headerAlign="center" summaryType="sum" header="配件小计"></div>
<!--                  <div  field="costAmt" width="60" headerAlign="center" header="计次卡抵扣次数"></div>
                  <div  field="costAmt" width="60" headerAlign="center" header="计次卡抵扣金额"></div> -->
    </div>
</div>
</div>
<div id="exportDiv" style="display:none">  

</div> 

</body>
</html>
