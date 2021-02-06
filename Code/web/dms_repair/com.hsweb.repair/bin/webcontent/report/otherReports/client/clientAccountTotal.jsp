<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-24 11:02:48
  - Description:
-->

<head>
    <title>客户账户统计</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>

    <%@include file="/common/commonRepair.jsp"%>
    <style>

        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
        .iconStyle{
            font-size: 14px;
            margin-top: 2px;
            position: absolute;
            color:#f0ce25;
        }
        .tipStyle{
            position: absolute; 
            background-color: #595959; 
            color:#fff;
            border-radius: 4px;
            padding:5px 10px 5px 10px;
            opacity:0.9;
            font-size:14px;
            display: none;
            z-index:999;
        }

    </style>
</head>

<body>
        <div id="showDiv" class="tipStyle"></div>
    <div class="nui-fit">
        <div class="nui-tabs" style="width:100%;height: 100%;">
            <div title="客户记账汇总表">


                    
                    <div class="nui-toolbar" style="padding:2px;" id="">
                        <table style="width:100%;">
                            <tr>
                                <td>
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
                                    单据日期:
                                    <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                                    至
                                    <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                                    <input class="nui-textbox" style="widows: 100px;" emptyText="客户名称">
                                    <input class="nui-textbox" style="widows: 100px;" emptyText="服务顾问">
                                    <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                    <!-- <li class="separator"></li> -->
                                </td>
                            </tr>
                        </table>
                    </div>
                    
                    <div class="nui-fit">
                        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
                        totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                        onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
                        <div property="columns">
                            <div field="id" name="id" visible="false" width="100" >id</div>
                          <div type="indexcolumn" width="40" headerAlign="center" align="center">客户姓名</div>
                          <div field="" name="" width="100" headerAlign="center" align="center">期初</div>
                          <div field="" name="" width="100" headerAlign="center" align="center">记账</div>
                          <div field="" name="" width="100" headerAlign="center" align="center">收款</div>
                          <div field="" name="" width="100" headerAlign="center" align="center">结余</div>
                      </div>
                      </div>
                      </div>

            </div>
            <div title="客户记账明细表">

                    <div class="nui-toolbar" style="padding:2px;" id="">
                            <table style="width:100%;">
                                <tr>
                                    <td>
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
                                        单据日期:
                                        <input class="nui-datepicker" id="startDate2" name="startDate2" dateFormat="yyyy-MM-dd" style="width:100px" />
                                        至
                                        <input class="nui-datepicker" id="endDate2" name="endDate2" dateFormat="yyyy-MM-dd" style="width:100px" />
                                        <input class="nui-textbox" style="widows: 100px;" emptyText="客户">
                                        <input class="nui-textbox" style="widows: 100px;" emptyText="业务类型">
                                        <input class="nui-textbox" style="widows: 100px;" emptyText="服务顾问">
                                        <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                        <!-- <li class="separator"></li> -->
                                    </td>
                                </tr>
                            </table>
                        </div>
                        
                        <div class="nui-fit">
                            <div id="mainGrid2" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
                            totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                            onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
                            <div property="columns">
                                <div field="id" name="id" visible="false" width="100" >id</div>
                              <div type="indexcolumn" width="40" headerAlign="center" align="center">单据编号</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">客户</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">业务单号</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">业务类型</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">记账</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">收款</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">车牌号</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">单据日期</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">操作员</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">添加时间</div>
                              <div field="" name="" width="100" headerAlign="center" align="center">所属分店</div>
                          </div>
                          </div>
                          </div>


            </div>
        
    
        </div>
    </div>




    <script type="text/javascript">
        nui.parse();
        var con8='这是一个提示';
     
        var startDateEl = nui.get('startDate');
        var endDateEl = nui.get('endDate');
        var currType = 2;
        quickSearch(1);

        function quickSearch(type) {
            //var params = getSearchParams();
            var params = {};
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
            currType = type;
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            var menunamedate = nui.get("menunamedate");
            menunamedate.setText(queryname);
            //doSearch(params);
        }



        function overShow(e,con) {
            var showDiv = document.getElementById('showDiv');
            var pos = e.getBoundingClientRect();
            $("#showDiv").css("top", pos.bottom); //设置提示div的位置
            $("#showDiv").css("left", pos.right);
            showDiv.style.display = 'block';
            showDiv.innerHTML = con;
        }

        function outHide() {
            var showDiv = document.getElementById('showDiv');
            showDiv.style.display = 'none';
            showDiv.innerHTML = '';
        }


    </script>
</body>

</html>