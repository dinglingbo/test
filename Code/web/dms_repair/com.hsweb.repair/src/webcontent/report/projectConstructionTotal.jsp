<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
    <title>项目施工汇总报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
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
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(0)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按日期汇总</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(1)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按业务类型汇总</a>
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(2)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按项目名称汇总</a>
<!--      <a class="nui-button" iconcls=""  name="" plain="true" onclick=""><span class="fa fa-mail-forward fa-lg"></span>&nbsp;导出</a> -->
 </div>
 <div class="nui-fit">
    <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="true"
    dataField="list1"
    idField="detailId"
    ondrawcell=""
    sortMode="client"
    url=""
    totalField="page.count"
    pageSize="500"
    sizeList="[500,1000,2000]" showSummaryRow = "true"
    showSummaryRow="true">
    <div property="columns">
        <div type="indexcolumn">序号</div>
        <div header="业务信息" headerAlign="center">
            <div property="columns">
                <div allowSort="true" field="groupName" name="groupName" width="60" headerAlign="center" header="业务类型"></div>
                <div allowSort="true" field="tc" width="60" headerAlign="center" summaryType="sum" header="施工台次"></div>
                <div allowSort="true" field="itemTime" width="60" headerAlign="center" summaryType="sum" header="工时时间"></div>
                <div allowSort="true" field="subtotal" width="60" headerAlign="center" summaryType="sum" header="工时收入"></div>
                <div allowSort="true" field="costAmt" width="60" headerAlign="center" summaryType="sum" header="工时成本"></div>
                <div allowSort="true" field="retc" width="60" headerAlign="center" summaryType="sum" header="返工台次"></div>
                <div allowSort="true" field="retcRate" width="60" headerAlign="center" header="返工占比"></div>
            </div>
        </div>
    </div>
</div>
</div>
<script type="text/javascript">
    nui.parse();
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
    var grid1 = nui.get("grid1");
    var form=new nui.Form("#form1");
    var cType = 2;
    var startDateEl = nui.get("startDate");
    var endDateEl = nui.get("endDate");
        var serviceTypeIdEl = nui.get("serviceTypeId");
    var servieTypeList = [];
    var servieTypeHash = {};
    var gridUrl = apiPath + repairApi+'/com.hsapi.repair.repairService.report.queryItemTotalReport.biz.ext';
    grid1.setUrl(gridUrl);
    var params ={
        groupByType:2 // 0按日期分组  1业务类型  2工时项目
    };

quickSearch(4);


    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });


    grid1.on("drawcell", function (e) {
        if(e.field =="groupName" && cType == 1){
            e.cellHtml = servieTypeHash[e.value].name;
        }

    });

    //load(cType);
    function load(e){
        if(e != undefined){
            cType = e;
        }
        
        var data= form.getData();
    	data.endDate = formatDate(data.endDate) +" 23:59:59";
        data.groupByType = cType;
        updateGridColoumn(cType);
        grid1.load({params:data,token :token});
    }


    function updateGridColoumn(e){
        var column = grid1.getColumn("groupName");
        if(e == 0){
            grid1.updateColumn(column,{header:"日期"});
        }
        if(e == 1){
            grid1.updateColumn(column,{header:"业务类型"});
        }
        if(e == 2){
            grid1.updateColumn(column,{header:"工时项目"});
        }

    }

    var currType = 2;
    function quickSearch(type){
       var params = form.getData();
       var queryname = "本日";
       switch (type)
       {
        case 0:
        params.today = 1;
        params.startDate = getNowStartDate();
        params.endDate = addDate(getNowEndDate(), 1);
        queryname = "本日";
        break;
        case 1:
        params.yesterday = 1;
        params.startDate = getPrevStartDate();
        params.endDate = addDate(getPrevEndDate(), 1);
        queryname = "昨日"; 
        break;
        case 2:
        params.thisWeek = 1;
        params.startDate = getWeekStartDate();
        params.endDate = addDate(getWeekEndDate(), 1);
        queryname = "本周";
        break;
        case 3: 
        params.lastWeek = 1;
        params.startDate = getLastWeekStartDate();
        params.endDate = addDate(getLastWeekEndDate(), 1);
        queryname = "上周";
        break;
        case 4:
        params.thisMonth = 1;
        params.startDate = getMonthStartDate();
        params.endDate = addDate(getMonthEndDate(), 1);
        queryname = "本月";
        break;
        case 5:
        params.lastMonth = 1;
        params.startDate = getLastMonthStartDate();
        params.endDate = addDate(getLastMonthEndDate(), 1);
        queryname = "上月";
        break;

        case 10:
        params.thisYear = 1;
        params.startDate = getYearStartDate();
        params.endDate = getYearEndDate();
        queryname="本年";
        break;
        case 11:
        params.lastYear = 1;
        params.startDate = getPrevYearStartDate();
        params.endDate = getPrevYearEndDate();
        queryname="上年";
        break;
        default:
        break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    params.groupByType = cType;
    // doSearch(params);

//     if(params.endDate){
//     params.endDate = params.endDate +" 23:59:59";
// }
grid1.load({params:params});
updateGridColoumn(cType);
}


</script>

</body>
</html>
