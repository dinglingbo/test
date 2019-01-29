<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
 
<head>
    <title>储值卡汇总报表</title>
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
        <div id="tabs" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false">
                <div title="储值卡汇总表" >

 
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
        <input class="nui-textbox" id="cardName" name="cardName" emptyText="输入计次卡名称" width="120"  onenter="onenterSearch(this.value)"/>
        <input name="saleManId" id="saleManId" class="nui-combobox " textField="empName" valueField="empId" visible="false"
        emptyText="销售员" url=""  allowInput="true" showNullItem="true"  nullItemText="请选择..." width="100" valueFromSelect="true"/>
        <a class="nui-button" iconcls="" name="" plain="true" onclick="load()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <span class="separator"></span> 
        <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(0)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按计次卡汇总</a>
        <a class="nui-button" iconcls=""  name="" plain="true" onclick="load(1)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按销售员汇总</a>

    </div> 
    <div class="nui-fit">
        <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;" showPager="true" dataField="list" idField="detailId"
            ondrawcell="" sortMode="client" url="" totalField="page.count" pageSize="20" sizeList="[10,20,50,100]"
            showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn" headerAlign="center">序号</div>
                <div allowSort="true" field="cardId" name="cardId" width="60" headerAlign="center" visible="false" header="计次卡ID"></div>
                <div allowSort="true" field="groupName" name="groupName" width="60" headerAlign="center" header="计次卡名称"></div>
                <div allowSort="true" field="num" width="60" headerAlign="center" summaryType="sum" dataType="int" header="数量"></div>
                <div allowSort="true" field="rechargeAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="充值金额"></div>
                <div allowSort="true" field="giveAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="赠送金额"></div>
                <div allowSort="true" field="totalAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="总金额"></div>
                <div allowSort="true" field="balaAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="已消费金额"></div>
                <div allowSort="true" field="useAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="剩余金额"></div>
                <div field="action" width="60" headerAlign="center" header="操作"></div>
            </div>
        </div>
    </div>

</div>
<div title="储值卡明细表" >
    
        <div id="form2" class="nui-toolbar" style="padding:10px;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-menubutton " menu="#popupMenuDate2" id="menunamedate2">本日</a>
                <ul id="popupMenuDate2" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearchB(0)" id="">本日</li>
                    <li iconCls="" onclick="quickSearchB(1)" id="">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearchB(2)" id="">本周</li>
                    <li iconCls="" onclick="quickSearchB(3)" id="">上周</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearchB(4)" id="">本月</li>
                    <li iconCls="" onclick="quickSearchB(5)" id="">上月</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearchB(10)" id="">本年</li>
                    <li iconCls="" onclick="quickSearchB(11)" id="">上年</li>
                </ul>
                结算日期:
                <input class="nui-datepicker" id="startDate2" name="startDate2" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
                <input class="nui-datepicker" id="endDate2" name="endDate2" dateFormat="yyyy-MM-dd" style="width:100px" />
                <input class="nui-combobox" id="searchType" name="searchType" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                <input class="nui-textbox" id="searchText" name="searchText" emptyText="输入查询条件" width="120" onenter=""/>
                <input name="saleManIdDet" id="saleManIdDet" class="nui-combobox " textField="empName" valueField="empId" 
                emptyText="销售员" showNullItem="true"  nullItemText="请选择..." width="100"/>
                <input class="nui-textbox" id="cardNameDet"  name="cardNameDet" emptyText="储值卡名称" width="120" />
                <a class="nui-button" iconcls="" name="" plain="true" onclick="loadB()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        
            </div>
            <div class="nui-fit">
                <div id="grid2" class="nui-datagrid" style="width:100%;height:100%;" showPager="true" dataField="list" idField="detailId"
                    ondrawcell="" sortMode="client" url="" totalField="page.count" pageSize="20" sizeList="[10,20,50,100]"
                    showSummaryRow="true">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center">序号</div>
                        <div allowSort="true" field="cardName" name="cardName" width="60" headerAlign="center" header="计次卡名称"></div>
                        <div allowSort="true" field="guestName" width="60" headerAlign="center"  header="客户名称"></div>
                        <div allowSort="true" field="mobile" width="60" headerAlign="center" header="手机号"></div>
                        <div allowSort="true" field="carNo" width="60" headerAlign="center"  header="车牌号"></div>
                        <div allowSort="true" field="rechargeAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="充值金额"></div>
                        <div allowSort="true" field="giveAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="赠送金额"></div>
                        <div allowSort="true" field="totalAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="总金额"></div>
                        <div allowSort="true" field="balaAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="已消费金额"></div>
                        <div allowSort="true" field="useAmt" width="60" headerAlign="center" summaryType="sum" dataType="int" header="剩余金额"></div>
                        <div allowSort="true" field="saleMan" width="60" headerAlign="center"  header="销售员"></div>
                        <div allowSort="true" field="settleDate" width="60" headerAlign="center"  header="结算日期"dateFormat="yyyy-MM-dd HH:mm"></div>
                    </div>
                </div>
            </div>
</div>
</div>


    <script type="text/javascript">
        var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"},{id:"2",name:"手机号"}];
        nui.parse();
        var webBaseUrl = webPath + contextPath + "/";
        var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
        var grid1 = nui.get("grid1");
        var grid2 = nui.get("grid2");
        var form = new nui.Form("#form1");
        var form2 = new nui.Form("#form2");
        var startDateEl = nui.get("startDate");
        var endDateEl = nui.get("endDate");
        var startDateEl2 = nui.get("startDate2");
        var endDateEl2 = nui.get("endDate2");
        var saleManIdEl = nui.get("saleManId");
        var saleManIdDetEl = nui.get("saleManIdDet");
        var gridUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.report.queryStoredCard.biz.ext';
        var gridUrl2 = apiPath + repairApi + '/com.hsapi.repair.repairService.report.queryStoredCardDetail.biz.ext';
        var su = '<a  href="javascript:viewDet()"style="color:blue;text-decoration:underline">查看明细</a>';
        var cType = 0;//分组类型
        var params = {
            groupByType: cType // 0按卡名分组  1销售员 
        };

        initMember("saleManId",function(){
            var list = saleManIdEl.getData();
            saleManIdDetEl.setData(list);
           // mtAdvisorIdEl.setValue(currEmpId);
           // mtAdvisorIdEl.setText(currUserName);
        });

        quickSearch(4);
        quickSearchB(4);
        grid1.setUrl(gridUrl);
        grid2.setUrl(gridUrl2);
        grid1.on("drawcell", function (e) {
            if(e.field =="action" ){
                e.cellHtml = su;
            }
        }); 
        grid2.on("drawcell", function (e) {
            if(e.field == "mobile"){
                var value = e.value;
                value = "" + value;
                var reg=/(\d{3})\d{4}(\d{4})/;
                var value = value.replace(reg, "$1****$2");
                //e.cellHtml = value;
                if(e.value){
                    e.cellHtml = value;
                }else{
                    e.cellHtml="";
                }
            }
        }); 
        //load(cType);
        function load(e) {
            if (e != undefined) {
                cType = e;
            }

            var data = form.getData();
            data.endDate = formatDate(data.endDate) + " 23:59:59";
            data.groupByType = cType;
            updateGridColoumn(cType);
            grid1.load({
                params: data,
                token: token
            });
        }

        function loadB() {
            var data = form2.getData();
            data.endDate2 = formatDate(data.endDate2) + " 23:59:59";
            data.startDate2 = formatDate(data.startDate2);
            if(data.finish == "0"){
                data.isFinish = 0;
            }
            if(data.searchType == "0" && data.searchText){
                data.carNo = data.searchText;
            }else if(data.searchType == "1" && data.searchText){
                data.guestName = data.searchText;
            }else if(data.searchText) {
                data.mobile = data.searchText;
            }else{}
            grid2.load({
                params: data,
                token: token
            });
        }

        function updateGridColoumn(e) {
            var column = grid1.getColumn("groupName");
            if (e == 0) {
                grid1.updateColumn(column, {
                    header: "计次卡名称"
                });
                nui.get("cardName").show();
                nui.get("saleManId").hide();
                nui.get("saleManId").setValue();
            }
            if (e == 1) {
                grid1.updateColumn(column, {
                    header: "销售员"
                });
                nui.get("cardName").hide();
                nui.get("cardName").setValue();
                nui.get("saleManId").show();
            }
        }

function viewDet() {
    var row = grid1.getSelected();
    var tab = nui.get("tabs").getTab(1);
    if(row){
        form2.clear();
        if(cType == 0){
            startDateEl2.setValue(startDateEl.value);
            endDateEl2.setValue(endDateEl.value);
            nui.get("cardNameDet").setValue(row.groupName);
            nui.get("tabs").activeTab(tab);
            loadB();
        }
        if(cType == 1){
            startDateEl2.setValue(startDateEl.value);
            endDateEl2.setValue(endDateEl.value);
            saleManIdDetEl.setValue(row.saleManId);
            nui.get("tabs").activeTab(tab);
            loadB();
        }
    }
}


        function quickSearch(type){
            var params = form.getData();
            var queryname = "本日";
            switch (type) {
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
                    queryname = "本年";
                    break;
                case 11:
                    params.lastYear = 1;
                    params.startDate = getPrevYearStartDate();
                    params.endDate = getPrevYearEndDate();
                    queryname = "上年";
                    break;
                default:
                    break;
            }
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            var menunamedate = nui.get("menunamedate");
            menunamedate.setText(queryname);
            params.groupByType = cType;
            // doSearch(params);
            //     if(params.endDate){
            //     params.endDate = params.endDate +" 23:59:59";
            // }
            grid1.load({
                params: params
            });
             updateGridColoumn(cType);
        }



        function quickSearchB(type){
            var params = form2.getData();
            var queryname = "本日";
            switch (type) {
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
                    queryname = "本年";
                    break;
                case 11:
                    params.lastYear = 1;
                    params.startDate = getPrevYearStartDate();
                    params.endDate = getPrevYearEndDate();
                    queryname = "上年";
                    break;
                default:
                    break;
            }
            startDateEl2.setValue(params.startDate);
            endDateEl2.setValue(addDate(params.endDate, -1));
            var menunamedate2 = nui.get("menunamedate2");
            menunamedate2.setText(queryname); 
            params.endDate2 = addDate(params.endDate, -1);
            params.startDate2 = params.startDate;
            if(params.finish == "0"){
                params.isFinish = 0;
            }
            if(params.searchType =="0" && params.searchText){
                params.carNo = params.searchText;
            }else if(params.searchType == "1" && params.searchText){
                params.guestName = params.searchText;
            }else if(params.searchText){
                params.mobile = params.searchText;
            }else{}
            grid2.load({
                params: params,
                token:token
            });
        }
    </script>

</body>

</html>