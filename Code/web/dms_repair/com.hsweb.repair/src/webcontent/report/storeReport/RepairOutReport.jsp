<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description: 
-->
<head>
    <title>维修出库报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
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


	<div class="nui-toolbar" id="toolbar1" style="padding:2px;border-bottom:0;" >
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
        <div id="ck1" name="" class="nui-checkbox" readOnly="false" text="显示归库" ></div>
        <div class="nui-radiobuttonlist"
        repeatItems="2"
        id="countWay"
        width=""
        style="display: inline-block;"
        textField="text" valueField="id" value="1" data="[{id:1,text:'领料日期'},{id:2,text:'出厂日期:'}]">
    </div>


    <!-- <label style="font-family:Verdana;">审核日期 从：</label> -->
    <input class="nui-datepicker" id="startDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
    <label style="font-family:Verdana;">至</label>
    <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

    <span class="separator"></span> 
    <input id="carNo"name="carNo" width="100px" emptyText="车牌号"  class="nui-textbox"/>
    <input id="partName"name="partName" width="100px" emptyText="配件名称"  class="nui-textbox"/>
    <input id="partCode" name="partCode" width="100px" emptyText="配件编码"  class="nui-textbox"/>
    <!-- <input id="" width="100px" emptyText="配件品质"  class="nui-combobox"/>
    <input id="" width="100px" emptyText="审核状态"  class="nui-combobox"/> -->

    <a class="nui-button" iconCls="" plain="true" onclick="Search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
    <span class="separator"></span>
    <a class="nui-button" plain="true" onclick=""><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>

</div>
<div class="nui-fit">
    <div id="grid" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="true"
    dataField="list"
    idField="detailId"
    ondrawcell=""
    sortMode="client"
    url=""
    totalField="page.count"
    pageSize="10000"
    sizeList="[100,500,1000]"
    showSummaryRow="true">
    <div property="columns">
        <div type="indexcolumn">序号</div>

        <div header="业务信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="partCode" width="120" headerAlign="center" header="配件编码"></div>
                <div allowSort="true" field="partName" headerAlign="center" header="配件名称"></div>
                <div allowSort="true" field="partFullName" headerAlign="center" header="OEM码"></div>
                <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌编码"></div>
                <div allowSort="true" field="carTypeIdF" width="60" headerAlign="center" header="车身系统分类一级"></div>
                <div allowSort="true" field="carTypeIdS" width="100" headerAlign="center" header="车身系统分类二级"></div>
                <div allowSort="true" field="carTypeIdFT" width="100" headerAlign="center" header="车身系统分类三级"></div>
                <div allowSort="true" field="spec" width="100" headerAlign="center" header="规格"></div>
                <div allowSort="true" field="direction" width="100" headerAlign="center" header="方向"></div>
                <div allowSort="true" field="" width="100" headerAlign="center" header="车辆厂牌"></div>
                <div allowSort="true" field="serviceCode" width="100" headerAlign="center" header="业务单号"></div>
                <div allowSort="true" field="serviceTypeId" width="100" headerAlign="center" header="业务类型"></div>
                <div allowSort="true" field="mtAdvisor" width="100" headerAlign="center" header="维修顾问"></div>
                <div allowSort="true" field="carNo" width="100" headerAlign="center" header="车牌号"></div>
                <div allowSort="true" field="unit" width="100" headerAlign="center" header="单位"></div>
                <div allowSort="true" field="outQty" width="100" headerAlign="center" header="数量"></div>
                <div allowSort="true" field="" width="100" headerAlign="center" header="厂牌"></div>
                <div allowSort="true" field="applyCarModel" width="100" headerAlign="center" header="车型"></div>
            </div>
        </div>

        <div header="领料信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="pickDate" width="100" headerAlign="center" header="领料日期" dateFormat="yyyy-MM-dd"></div>
                <div allowSort="true" field="pickMan" width="100" headerAlign="center" header="领料人"></div>
                <div allowSort="true" field="recorder" width="100" headerAlign="center" header="操作人"></div>
            </div>
        </div>
        <div header="成本信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="trueUnitPrice" width="100" headerAlign="center" header="成本单价"></div>
                <div allowSort="true" field="trueCost" width="100" headerAlign="center" header="成本金额"></div>
            </div>
        </div>

        <div header="销售信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="" width="100" headerAlign="center" header="销售单价"></div>
                <div allowSort="true" field="" width="100" headerAlign="center" header="销售金额"></div>
            </div>
        </div>

        <div header="盈利信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="" width="100" headerAlign="center" header="毛利"></div>
                <div allowSort="true" field="" width="100" headerAlign="center" header="配件毛利率"></div>
                <div allowSort="true" field="" width="100" headerAlign="center" header="成本率"></div>
            </div>
        </div>

        <div header="归库信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="returnSign" width="100" headerAlign="center" header="归库标志"></div>
                <div allowSort="true" field="returnDate" width="100" headerAlign="center" header="归库日期" dateFormat="yyyy-MM-dd"></div>
                <div allowSort="true" field="returnMan" width="100" headerAlign="center" header="归库人"></div>
            </div>
        </div>

        <div header="其他信息" headerAlign="center">
            <div property="columns">
              <div allowSort="true" field="status" width="100" headerAlign="center" header="结算状态"></div>
              <div allowSort="true" field="guestName" width="100" headerAlign="center" header="供应商" ></div>
              <div allowSort="true" field="enterDate" width="100" headerAlign="center" header="采购日期"dateFormat="yyyy-MM-dd"></div>
              <div allowSort="true" field="" width="100" headerAlign="center" header="维修日期"dateFormat="yyyy-MM-dd"></div>
          </div>
      </div>
  </div>
</div>
</div>

<div id="advancedSearchWin" class="nui-window"
title="高级查询" style="width:416px;height:360px;"
showModal="true"
allowResize="false"
allowDrag="false">
<div id="advancedSearchForm" class="form">
    <table style="width:100%;">
     <tr>

     </tr>
 </table>
 <div style="text-align:center;padding:10px;">
    <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
</div>
</div>
</div>

<script type="text/javascript">
    nui.parse();
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
    var grid = nui.get("grid");
    var gridUrl = baseUrl+'com.hsapi.repair.repairService.report.queryRepairOutReport.biz.ext';
    var form=new nui.Form("#toolbar1");
    grid.setUrl(gridUrl);
    grid.load();

    function Search() {
        var data= form.getData();


        grid.load({params:data});
    }

</script>

</body>
</html>
