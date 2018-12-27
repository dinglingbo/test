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
    <title>业务产值占比</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://unpkg.com/echarts@3.5.3/dist/echarts.js"></script>

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
    </style>
</head>

<body>
    <div class="nui-fit">
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

        <div style="border-bottom:1px solid #ccc;margin-top: 20px;">
            <span class="titleText"> 现金收入统计图</span>
        </div>

        <div id="t2" style="float:left;width: 100%; height: 450px;">

            <div class="nui-fit">
                <div id="lindChatA" style="width:1000px;height:400px;"></div>
            </div>
        </div>

        <div style="border-bottom:1px solid #ccc;margin-top: 20px;">
            <span class="titleText"> 业务产值趋势图</span>
        </div>

        <div id="t3" style="float:left;width: 100%; height: 450px;">

            <div class="nui-fit">
                <div id="lindChatB" style="width:1000px;height:400px;"></div>
            </div>
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
            var dataAxis = ['点', '击', '柱', '子', '或', '者', '两', '指', '在', '触', '屏', '上', '滑', '动', '能', '够', '自', '动',
                '缩', '放'
            ];
            var data = [220, 182, 191, 234, 290, 330, 310, 123, 442, 321, 90, 149, 210, 122, 133, 334, 198, 123, 125,
                220
            ];

            var option = {
                title: {
                    text: '现金收入统计',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                xAxis: {
                    data: dataAxis,

                    axisLabel: {
                        //inside: true,

                    },

                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        show: false
                    },
                    z: 10
                },
                yAxis: {
                    name: "金额（元）",
                    axisLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    splitLine: {
                        show: true,
                        lineStyle: {
                            color: '#CCC',
                            width: 1
                        }
                    },
                    axisLabel: {
                        textStyle: {
                            color: '#999'
                        }
                    }
                },
                dataZoom: [{
                    type: 'inside'
                }],
                series: [{ // For shadow
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: 'rgba(0,0,0,0.05)'
                            }
                        },
                        barGap: '-100%',
                        barCategoryGap: '40%',
                        //data: dataShadow,
                        animation: false
                    },
                    {
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1,
                                    [{
                                            offset: 0,
                                            color: '#83bff6'
                                        },
                                        {
                                            offset: 0.5,
                                            color: '#188df0'
                                        },
                                        {
                                            offset: 1,
                                            color: '#188df0'
                                        }
                                    ]
                                )
                            },
                            emphasis: {
                                color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1,
                                    [{
                                            offset: 0,
                                            color: '#2378f7'
                                        },
                                        {
                                            offset: 0.7,
                                            color: '#2378f7'
                                        },
                                        {
                                            offset: 1,
                                            color: '#83bff6'
                                        }
                                    ]
                                )
                            }
                        },
                        data: data
                    }
                ]
            };


            var myChart = echarts.init(document.getElementById('lindChatA'), 'macarons');

            //使用刚指定的配置项和数据显示图表。
            myChart.setOption(option, true);
            window.onresize = function () {
                myChart.resize();
            };
        }

        function showMainB() {

            var option = {
                title: {
                    text: '业务产值趋势',
                    x:"center"

                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    orient: 'vertical',
                    data: ['洗车','保养','机电','其它','未知','美容','轮胎','改装','喷漆','钣金','代办','用品'],
                    x:"right",
                    y:"center"
                },
                toolbox: {
                    show: true,
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        dataView: {
                            readOnly: false
                        },
                        magicType: {
                            type: ['line', 'bar']
                        },
                        restore: {},
                        saveAsImage: {}
                    }
                },
                dataZoom: [{
            startValue: '2014-06-01'
        }, {
            type: 'inside'
        }],
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: ['2018-10-1', '2018-10-2', '2018-10-3', '2018-10-4', '2018-10-5', '2018-10-6', '2018-10-7']
                },
                yAxis: {
                    type: 'value',
                    name: "金额（元）",
                    splitLine: {
                        show: true,
                        lineStyle: {
                            color: '#CCC',
                            width: 1
                        }
                    },
                    axisLabel: {
                        formatter: function (value) {
                            return parseInt(value)+'K';
                        }
                    },
                    axisLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                },
                series: [

                    {
                        name: '洗车',
                        type: 'line',
                        data: [1, -2, 2, 5, 3, 2, 0],
                        smooth: false
                    },
                    {
                        name: '保养',
                        type: 'line',
                        data: [3, -3, 1, 3, -2, 3, 1],
                        smooth: false
                    },
                    {
                        name: '其它',
                        type: 'line',
                        data: [2, 4, 6, 4, 2, -1, 3],
                        smooth: false
                    },
                ]
            };


            var myChartB = echarts.init(document.getElementById('lindChatB'), 'macarons');
            //使用刚指定的配置项和数据显示图表。
            myChartB.setOption(option, true);
            window.onresize = function () {
                myChartB.resize();
            };
        }
    </script>
</body>

</html>