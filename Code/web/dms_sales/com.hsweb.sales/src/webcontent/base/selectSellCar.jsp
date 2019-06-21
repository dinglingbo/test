<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-26 15:41:25
  - Description:
-->

<head>
    <title>选择销售单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
</head>

<body>
    <div class="nui-toolbar" >
     
        <label style="font-family:Verdana;">快速查询：</label>
        <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本月</a>

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
        <!-- <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>
        <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
            <li iconCls="" onclick="quickSearch(12)" id="type">所有</li>
            <li iconCls="" onclick="quickSearch(13)" id="type12">草稿</li>
            <li iconCls="" onclick="quickSearch(14)" id="type12">待审</li>
            <li iconCls="" onclick="quickSearch(15)" id="type12">已审</li>
            <li iconCls="" onclick="quickSearch(16)" id="type12">作废</li>
        </ul> -->
        <input class="nui-combobox" id="searchType" width="100" textField="name" valueField="id" value="0"
            data="statusList" allowInput="false" />
        <input class="nui-textbox" id="textValue" emptyText="输入查询条件" width="120"
            onenter="onenterSearch(this.value)" />
        <!-- <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox" />

            <input id="" name="" width="80px" emptyText="车型名称" class="nui-textbox" /> -->

        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span
                class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <li class="separator"></li>
        <a class="nui-button" iconCls="" plain="true" onclick="selectCar()" id="selectBtn"><span
                class="fa fa-check fa-lg"></span>&nbsp;选车</a>
        <a class="nui-button" iconCls="" plain="true" onclick="close()" id="closeBtn"><span
                class="fa fa-close fa-lg"></span>&nbsp;取消</a>

    </div>
    <div class="nui-fit">
    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" showPager="true" dataField="data"
        sortMode="client" url="" totalField="page.count" pageSize="20" sizeList="[20,50,100]"
        selectOnLoad="false" allowCellWrap=true showSummaryRow="true" showModified="false" >
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="serviceCode" name="serviceCode" width="120px" headerAlign="center" header="工单号"></div>
            <div field="status" name="status" width="50px" headerAlign="center" header="状态"></div>
            <div field="guestFullName" name="guestFullName" width="100px" headerAlign="center" header="客户名称"></div>
            <div field="orderDate" name="orderDate" width="100px" headerAlign="center" header="订车日期"></div>
            <div field="carModelName" name="carModelName" width="100px" headerAlign="center" header="车型名称"></div>
            <div field="submitPlanDate" name="submiPlanDate" width="100px" headerAlign="center" header="预交车日期" dateFormat="yyyy-MM-dd"></div>
            <div field="saleAdvisor" name="saleAdvisor" width="100px" headerAlign="center" header="销售顾问"></div>
            <!-- <div field="saleAmt" name="saleAmt" width="100px" headerAlign="center" header="车辆销价"></div>
            <div field="advanceChargeAmt" name="advanceChargeAmt" width="100px" headerAlign="center" header="应收定金">
            </div>
            <div field="receivedDeposit" name="receivedDeposit" width="100px" headerAlign="center" header="已收定金"></div>
            <div field="calculateField" name="calculateField" width="100px" headerAlign="center" header="应收余款"></div> -->
        </div>
    </div>
</div>
    <script type="text/javascript">
        var statusList = [{ id: "0", name: "订单单号" }, { id: "1", name: "客户名称" }];
        nui.parse();
        var mainGridUrl = apiPath + saleApi + "/sales.search.searchSalesMainSelect.biz.ext";
        var param = {};
        var mainGrid = nui.get("mainGrid");
        mainGrid.setUrl(mainGridUrl);
        onSearch();
        mainGrid.on("load", function (e) {
            var data = e.text.data;
            if (data.length > 0) {
                for (var i = 0, l = data.length; i < l; i++) {
                    var row = mainGrid.getRow(i);
                    var buyBudgetTotal = data[i].buyBudgetTotal;
                    var receivedDeposit = data[i].receivedDeposit;
                    var receivedBala = data[i].receivedBala;
                    var calculateField = buyBudgetTotal - (receivedDeposit + receivedBala);
                    var newRow = {
                        calculateField: calculateField
                    };
                    mainGrid.updateRow(row, newRow);
                }
            }
        });

        mainGrid.on('rowdblclick', function (e) {
            CloseWindow("ok");
        });

        mainGrid.on("drawcell", function (e) {
            var field = e.field,
                value = e.value;
            if (field == "submiPlanDate" || field == "orderDate") {
                if (value) {
                    e.cellHtml = format(value, 'yyyy-MM-dd');
                }
            }
            // if (field == "status") {
            //     var value1 = value == 0 ? "草稿" : (value == 1 ? "待审" : (value == 2 ? "已审" : (value == 3 ? "作废" :
            //         "")));
            //     e.cellHtml = value1;
            // }
        });

        function getRow() {
            return mainGrid.getSelected();
        }

        function selectCar() {
            var row = mainGrid.getSelected();
            if(!row){
                showMsg('请先选择一条数据','W');
                return;
            }
            CloseWindow('ok');
        }

        function quickSearch(e) {
            var queryname = null;
            var menubillstatus = null;
            switch (e) {
                case 0:
                    param.recordStartDate = getNowStartDate();
                    param.recordEndDate = addDate(getNowEndDate(), 1);
                    queryname = "本日";
                    break;
                case 1:
                    param.recordStartDate = getPrevStartDate();
                    param.recordEndDate = addDate(getPrevEndDate(), 1);
                    queryname = "昨日";
                    break;
                case 2:
                    param.recordStartDate = getWeekStartDate();
                    param.recordEndDate = addDate(getWeekEndDate(), 1);
                    queryname = "本周";
                    break;
                case 3:
                    param.recordStartDate = getLastWeekStartDate();
                    param.recordEndDate = addDate(getLastWeekEndDate(), 1);
                    queryname = "上周";
                    break;
                case 4:
                    param.recordStartDate = getMonthStartDate();
                    param.recordEndDate = addDate(getMonthEndDate(), 1);
                    queryname = "本月";
                    break;
                case 5:
                    param.recordStartDate = getLastMonthStartDate();
                    param.recordEndDate = addDate(getLastMonthEndDate(), 1);
                    queryname = "上月";
                    break;
                case 10:
                    param.recordStartDate = getYearStartDate();
                    param.recordEndDate = getYearEndDate();
                    queryname = "本年";
                    break;
                case 11:
                    param.recordStartDate = getPrevYearStartDate();
                    param.recordEndDate = getPrevYearEndDate();
                    queryname = "上年";
                    break;
                    // case 12:
                    //     param.status = null;
                    //     menubillstatus = "所有";
                    //     break;
                    // case 13:
                    //     param.status = 0;
                    //     menubillstatus = "草稿";
                    //     break;
                    // case 14:
                    //     param.status = 1;
                    //     menubillstatus = "待审";
                    //     break;
                    // case 15:
                    //     param.status = 2;
                    //     menubillstatus = "已审";
                    //     break;
                    // case 16:
                    //     param.status = 3;
                    //     menubillstatus = "作废";
                    //     break;
                default:
                    break;
            }
            if (queryname) {
                var menunamedate = nui.get("menunamedate");
                menunamedate.setText(queryname);
            }
            // if (menubillstatus) {
            //     var menubillstatusData = nui.get("menubillstatus");
            //     menubillstatusData.setText(menubillstatus);
            // }
            onSearch();
        }



        function onSearch() {
            param.serviceCode = null;
            param.guestName = null;
            //param.enterId = 
            param.hasEnterId = 1;//已选车
            param.status = 2;
            param.isSubmitCar = 0;
            var searchType = nui.get("searchType").value;
            searchType = parseInt(searchType);
            switch (searchType) {
                case 0:
                    param.serviceCode = nui.get("textValue").value;
                    break;
                case 1:
                    param.guestName = nui.get("textValue").value;
                    break;
                default:
                    break;
            }
            mainGrid.load({
                params: param
            });
        }


        function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
    else 
        window.close();
}
    </script>
</body>

</html>