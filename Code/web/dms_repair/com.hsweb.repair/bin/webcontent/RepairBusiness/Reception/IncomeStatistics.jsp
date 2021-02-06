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
    <title>收入统计</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://unpkg.com/echarts@3.5.3/dist/echarts.js"></script>
    <script src="<%= request.getContextPath() %>/common/nui/macarons.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style>

        .parent{display:flex;}
        .column{flex:1;border-radius:10px;background-color:#95d9f966;margin-top:20px;padding:10px;}
        .column+.column{margin-left:20px;} 
        .incomeTitle{
            margin: 10px 0px 0px 5px;
            color: #23c0fa;
            font-size:18px;
            font-weight: normal;
        }
        .incomeStyle{
            margin: 10px 0px 0px 0px;
            text-align: center;
            color: #f9a52e ;
            font-size:28px;
        }
        .incomeStyle2{
            margin: 10px 0px 0px 0px;
            text-align: center;
            color: #f9a52e ;
            font-size:18px;
        }
         .parent div:hover{
            background-color:#B0D6F9;
            
            cursor: pointer;
        }
        .parent div:hover p{
            color:#fff ;
        }
        .parent div:hover h3{
            color:#fff ;
        }
        .parent div:hover p>span{
            color:#fff ;
        }
        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
    </style>
</head>

<body>
    <div class="nui-toolbar" style="padding:2px;" id="queryForm">
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
                    结算日期:
                    <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    至
                    <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    <a class="nui-button" plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <!-- <li class="separator"></li> -->
                </td>
            </tr>
        </table>
    </div>
    <div style="height: 150px;" class="parent">

        <div class="column">
            <h3 class="incomeTitle">总收入</h3>
            <p class="incomeStyle" style="margin-top: 20px;">345342.00</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">总利润</h3>
            <p class="incomeStyle"  style="margin-top: 20px;">345342.00</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">预收</h3>
            <p class="incomeStyle2">充值：<span>34235.00</span></p>
            <p class="incomeStyle2">套餐：<span>34235.00</span></p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">客户记账</h3>
            <p class="incomeStyle2">记账：<span>34235.00</span></p>
            <p class="incomeStyle2">收款：<span>37635.00</span></p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">现金银行</h3>
            <p class="incomeStyle2">收款：<span>37635.00</span></p>
            <p style="text-align: center;margin: 0px;color:#999999">(含保险收入：<span style="color:#999999">37635.00</span>元)</p>
            <p class="incomeStyle2" style="margin-top: 0;">收款：<span>37635.00</span></p>
        </div>

    </div>
    <div style="border-bottom:1px solid #ccc;margin-top: 20px;">
        <span class="titleText"> 总收入</span>
    </div>
    <div class="nui-fit">
        <div id="t1" style="width: 100%; height: 100%;padding:20px 0px 0px 0px;">

            <div id="t2" style="float:left;width: 49.5%; height: 100%;">

                <div class="nui-fit">
                    <div id="lindChatA" style="width:580px;height:230px;"></div>
                </div>
            </div>
            <div id="t4" style="float:left;width: 1%; height: 100%;"></div>
            <div id="t3" style="float:left;width: 49%; height: 100%;">

                <div class="nui-fit">
                    <div id="lindChatB" style="width:580px;height:230px;"></div>
                </div>
            </div>

            <div style="clear: both"></div>
            <!-- 注释：清除float产生浮动 -->
        </div>
    </div>


    <script type="text/javascript">
        nui.parse();


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



        showMainA();
        showMainB();

        function showMainA() {

            var option = {
                title: {
                    text: '收入统计',
                    // subtext: '纯属虚构',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: ['工单销售', '其他费用收入']
                },
                series: [{
                    name: '收入类型',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [{
                            value: 335,
                            name: '工单销售'
                        },
                        {
                            value: 310,
                            name: '其它费用收入'
                        }
                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            };


            var myChart = echarts.init(document.getElementById('lindChatA'),'macarons');

            //使用刚指定的配置项和数据显示图表。
            myChart.setOption(option, true);
            window.onresize = function () {
                myChart.resize();
            };
        }

        function showMainB() {

            var option = {
                title: {
                    text: '业务产值占比图',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: ['洗车', '美容', '保养', '机电', '轮胎', '其他']
                },
                series: [{
                    name: '业务类型',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [{
                            value: 335,
                            name: '洗车'
                        },
                        {
                            value: 310,
                            name: '美容'
                        },
                        {
                            value: 234,
                            name: '保养'
                        },
                        {
                            value: 135,
                            name: '机电'
                        },
                        {
                            value: 218,
                            name: '轮胎'
                        },
                        {
                            value: 1548,
                            name: '其他'
                        }
                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            };


            var myChartB = echarts.init(document.getElementById('lindChatB'),'macarons');
            //使用刚指定的配置项和数据显示图表。
            myChartB.setOption(option, true);
            window.onresize = function () {
                myChartB.resize();
            };
        }
    </script>
</body>

</html>