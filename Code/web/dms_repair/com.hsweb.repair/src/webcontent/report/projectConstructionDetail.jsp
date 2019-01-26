<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 17:02:13
  - Description:
-->

<head>
    <title>施工项目明细（应收）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
         <%@include file="/common/commonRepair.jsp"%>
 <%--    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" /> --%>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>

<body>
    <input name="serviceTypeId" id="serviceTypeId" class="nui-combobox " textField="name" valueField="id" visible="false" />
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
        <input class="nui-textbox" id="serviceCode" name="serviceCode" emptytext="工单号">
        <input class="nui-textbox" id="itemName" name="itemName" emptytext="项目名称">
        <input class="nui-textbox" id="carNo" name="carNo" emptytext="车牌号" style="width: 90px;">
        <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
            emptyText="服务顾问" url="" allowInput="true" showNullItem="false" style="width:90px;" valueFromSelect="true"
            nullItemText="服务顾问" />
        <!-- <input class="nui-textbox" id=""name=""emptytext="配件分类"> -->

        <a class="nui-button" iconcls="" plain="true" name="" onclick="Search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <!--      <a class="nui-button" iconcls="" plain="true" name="" onclick=""><span class="fa fa-mail-forward fa-lg"></span>&nbsp;导出</a> -->
    </div>

    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="list" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;"
            totalField="page.count"> 
            <div property="columns">
                <div field="serviceCode" name="serviceCode" headeralign="center" width="170" align="center">工单号</div>
                <div field="serviceTypeId" name="serviceTypeId" headeralign="center" width="80" align="center">业务类型</div>
                <div field="itemName" name="itemName" headeralign="center" width="100" align="center">项目名称</div>
                <div field="carNo" name="carNo" headeralign="center" width="80" align="center">车牌号</div>
                <div field="carModel" name="carModel" headeralign="center" width="200" align="center" width="160">品牌车型</div>
                <div field="guestName" name="guestName" headeralign="center" width="100" align="center">客户名称</div>
                <div field="carVin" name="carVin" headeralign="center" width="150" align="center">车架号(VIN)</div>
                <div field="itemTime" name="itemTime" headeralign="center" width="80" align="center">工时</div>
                <div field="unitPrice" name="unitPrice" headeralign="center" width="80" align="center">单价</div>
                <div field="amt" name="amt" headeralign="center" width="80" align="center">金额</div>
                <div field="rate" name="rate" headeralign="center" width="80" align="center">优惠率</div>
                <div field="subtotal" name="subtotal" headeralign="center" width="80" align="center">小计</div>
                <!-- <div field="" name="" headeralign="center" width="100" align="center">来店途径</div> -->
                <div field="workers" name="workers" headeralign="center" width="100" align="center">施工员</div>
                <div field="status" name="status" renderer="onStatusRenderer" headeralign="center" width="80" align="center">状态</div>
                <div field="isBack" name="isBack" renderer="onIsBackRenderer" headeralign="center" width="80" align="center">是否返工</div>
                <div field="mtAdvisor" name="mtAdvisor" headeralign="center" width="100" align="center">服务顾问</div>
                <div field="finishDate" name="finishDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd">完工日期</div>
                <div field="outDate" name="outDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd">结算日期</div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        nui.parse();
        var statusList = [{
            id: 0,
            text: '草稿'
        }, {
            id: 1,
            text: '已完工'
        }];
        var isBackList = [{
            id: 0,
            text: '未返工'
        }, {
            id: 1,
            text: '已返工'
        }];
        var mtAdvisorIdEl = nui.get("mtAdvisorId");
        var webBaseUrl = webPath + contextPath + "/";
        var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
        var grid = nui.get("grid");
        var gridUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.report.queryItemTotalDetailReport.biz.ext';
        var form = new nui.Form("#form1");
        var startDateEl = nui.get("startDate");
        var endDateEl = nui.get("endDate");
        var serviceTypeIdEl = nui.get("serviceTypeId");
        var servieTypeList = [];
        var servieTypeHash = {};
        grid.setUrl(gridUrl);
        quickSearch(3);
        initMember("mtAdvisorId", function () {
            //memList = mtAdvisorIdEl.getData();
            //nui.get("checkManId").setData(memList);
        });

        initServiceType("serviceTypeId", function (data) {
            servieTypeList = nui.get("serviceTypeId").getData();
            servieTypeList.forEach(function (v) {
                servieTypeHash[v.id] = v;
            });
        });

        function onStatusRenderer(e) {
            for (var i = 0, l = statusList.length; i < l; i++) {
                var g = statusList[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }

        function onIsBackRenderer(e) {
            for (var i = 0, l = isBackList.length; i < l; i++) {
                var g = isBackList[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }


        grid.on("drawcell", function (e) {
            if (e.field == "serviceTypeId") {
                e.cellHtml = servieTypeHash[e.value].name;
            }

            document.onkeyup = function (event) {
                var e = event || window.event;
                var keyCode = e.keyCode || e.which; // 38向上 40向下


                if ((keyCode == 13)) { // F9
                    Search();
                }
            }
        });    

	  var filter = new HeaderFilter(grid, {
	        columns: [
	            { name: 'itemName' },
	            { name: 'carModel' },
		            { name: 'workers' },
	            { name: 'mtAdvisor' },
	            { name: 'guestName' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
        function Search() {
            var data = form.getData();
            var eDate = nui.get("endDate").getFormValue();
            if (eDate) {
                data.endDate = eDate + " 23:59:59";
            }
            grid.load({
                params: data
            });
        }



        var currType = 2;

        function quickSearch(type) {
            var params = form.getData();
            var queryname = "本日";
            switch (type) {
                case 0:
                    params.today = 1;
                    params.startDate = getNowStartDate();
                    params.endDate = addDate(getNowEndDate(), 0);
                    queryname = "本日";
                    break;
                case 1:
                    params.yesterday = 1;
                    params.startDate = getPrevStartDate();
                    params.endDate = addDate(getPrevEndDate(), 0);
                    queryname = "昨日";
                    break;
                case 2:
                    params.thisWeek = 1;
                    params.startDate = getWeekStartDate();
                    params.endDate = addDate(getWeekEndDate(), 0);
                    queryname = "本周";
                    break;
                case 3:
                    params.lastWeek = 1;
                    params.startDate = getLastWeekStartDate();
                    params.endDate = addDate(getLastWeekEndDate(), 0);
                    queryname = "上周";
                    break;
                case 4:
                    params.thisMonth = 1;
                    params.startDate = getMonthStartDate();
                    params.endDate = addDate(getMonthEndDate(), 0);
                    queryname = "本月";
                    break;
                case 5:
                    params.lastMonth = 1;
                    params.startDate = getLastMonthStartDate();
                    params.endDate = addDate(getLastMonthEndDate(), 0);
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
            currType = type;
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            var menunamedate = nui.get("menunamedate");
            menunamedate.setText(queryname);
            // doSearch(params);

            //     if(params.endDate){
            //         params.endDate = params.endDate +" 23:59:59";
            //     }
            grid.load({
                params: params
            });
        }
    </script>
</body>

</html>