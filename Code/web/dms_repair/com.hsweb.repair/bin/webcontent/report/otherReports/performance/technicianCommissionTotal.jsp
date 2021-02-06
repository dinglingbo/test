<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
    <title>技师提成汇总表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
  <script src="<%=request.getContextPath()%>/repair/js/report/storeReport/technicianCommissionTotal.js?v=1.0.1"></script>
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
      <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
             emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(0)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按日期汇总</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(1)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按业务类型汇总</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(2)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按提成人汇总</a>
	 <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
 </div>
 <div class="nui-fit">
    <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;"
    dataField="data"
    idField="detailId"
    ondrawcell=""
    sortMode="client"
    showPager="false"
    url=""
    showSummaryRow="true">
            <div property="columns">          
        <div type="indexcolumn">序号</div>
              <div  field="groupName" name="groupName" width="60" headerAlign="center" header="业务类型" allowsort="true" ></div>
<!--               <div field="salesDeductValue" name="salesDeductValue" width="60" headerAlign="center" header="销售提成" summaryType="sum" allowsort="true" ></div> -->
              <div field="deductWorkerValue" name="deductWorkerValue" width="60" headerAlign="center" header="施工提成" summaryType="sum" dataType="float" allowsort="true" ></div>
<!--               <div field="advisorDeductValue" name="advisorDeductValue" width="60" headerAlign="center" header="服务提成" summaryType="sum" allowsort="true" ></div>
              <div field="annualInspectionDeductValue" name="annualInspectionDeductValue" width="60" headerAlign="center" header="商业险提成" summaryType="sum" allowsort="true" ></div>
              <div field="insureDueDeductValue" name="insureDueDeductValue" width="60" headerAlign="center" header="交强险提成" summaryType="sum" allowsort="true" ></div>
              <div field="vesselTaxDeductValue" name="vesselTaxDeductValue" width="60" headerAlign="center" header="车船税提成" summaryType="sum" allowsort="true" ></div>
              <div field="totalDeductAmt" name="totalDeductAmt" width="60" headerAlign="center" header="总提成" summaryType="sum" allowsort="true" ></div> -->
    </div>
</div>
</div>
<div id="exportDiv" style="display:none"> 
</div>
</body>
</html>
