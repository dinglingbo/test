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
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
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

    <div id="form1" class="mini-toolbar" style="padding:10px;">
        结算日期:
        <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
        <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
        <a class="nui-button" iconcls=""  name="" onclick="load()">查询</a>
        <a class="nui-button" iconcls=""  name="" onclick="load(0)">按日期汇总</a>
        <a class="nui-button" iconcls=""  name="" onclick="load(1)">按业务类型汇总</a>
        <a class="nui-button" iconcls=""  name="" onclick="load(2)">按项目名称汇总</a>
        <a class="nui-button" iconcls=""  name="" onclick="">导出</a>
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
        pageSize="10000"
        sizeList="[1000,5000,10000]"
        showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="业务信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="groupName" name="groupName" width="60" headerAlign="center" header="业务类型"></div>
                    <div allowSort="true" field="tc" width="60" headerAlign="center" header="施工台次"></div>
                    <div allowSort="true" field="itemTime" width="60" headerAlign="center" header="工时时间"></div>
                    <div allowSort="true" field="subtotal" width="60" headerAlign="center" header="工时收入"></div>
                    <div allowSort="true" field="costAmt" width="60" headerAlign="center" header="工时成本"></div>
                    <div allowSort="true" field="retc" width="60" headerAlign="center" header="返工台次"></div>
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
    var cType = 2;
    var gridUrl = 'com.hsapi.repair.repairService.report.queryItemTotalReport.biz.ext';
    grid1.setUrl(gridUrl);
    var params ={
        groupByType:2 // 0按日期分组  1业务类型  2工时项目
    };

    load(cType);
    function load(e){
        cType = e;
        var form=new nui.Form("#form1");
        var data= form.getData();
        data.groupByType = cType;
        updateGridColoumn(cType);
        grid1.load({params:data});
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



</script>

</body>
</html>
