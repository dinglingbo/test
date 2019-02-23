<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-12-11 20:01:24
  - Description:
-->

<head>
    <title>客户群发</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
      <%@include file="/common/commonRepair.jsp"%>
    <script type="text/javascript" src="https://unpkg.com/echarts@3.5.3/dist/echarts.js"></script>
    <script src="<%= request.getContextPath() %>/common/nui/macarons.js" type="text/javascript"></script>
    <style type="text/css">
        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .addyytime a.ztedit {
            height: 18px;
            display: inline-block;
            background: url(../images/sjde.png) 40px -1px no-repeat;
            padding-right: 22px;
            color: #888;
            text-decoration: none;
        }

        .addyytime a.hui {
            padding-left: 10px;
            padding-right: 10px;
            height: 36px;
            line-height: 36px;
            border: 1px #a6e0f5 solid;
            display: block;
            float: left;
            text-decoration: none;
            text-align: center;
            color: #00b4f6;
            border-radius: 4px;
            margin: 0 15px 15px 0;
        }

        .addyytime a.hui {
            border: 1px #e6e6e6 solid;
            color: #c8c8c8;
            background: #e6e6e6;
        }

        .addyytime a.xz {
            color: #fff !important;
            background: #5ab1ef;
        }

        .addyytime a:link,
        a:visited {
            font-family: 微软雅黑, Arial, Helvetica, sans-serif;
            font-size: 14px;
            color: #555555;
            text-decoration: none;
        }

        .addyytime a.hui:hover {
            font-family: 微软雅黑, Arial, Helvetica, sans-serif;
            font-size: 14px;
            background-color: #dc69aa;
            color: #FFF;
            text-decoration: none;
        }

        .addyytime a .hui {
            text-decoration: none;
            transition: all .4s ease;
        }

        #selectGuestType a {
            padding-left: 10px;
            padding-right: 10px;
            height: 36px;
            line-height: 36px;
            border: 1px #a6e0f5 solid;
            display: block;
            float: left;
            text-decoration: none;
            text-align: center;
            color: #00b4f6;
            border-radius: 4px;
            margin: 0 15px 15px 0;
            text-decoration: none;
            transition: all .4s ease;
        }

        .tabletitle {
            font-size: 18px;
        }

        .actionButton {
            padding-left: 10px;
            padding-right: 10px;
            height: 36px;
            line-height: 36px;
            display: inline-block;
            text-decoration: none;
            text-align: center;
            color: #FFF !important;
            background-color: #1ab394;
            border-radius: 4px;
            margin: 0 15px 15px 0;
        }

        .actionButton:hover {
            color: #ffb980 !important;
        }
    </style>
</head>

<body>

    <div class="nui-fit">
        <div id="t1" style="width: 100%; height: 100%;">
            <div id="t2" style="float:left;width: 40%; height: 100%;">
                <div class="nui-fit">
                    <div id="lindChatA" style="width:490px;height:530px;"></div>
                </div>
            </div>

            <div id="t3" style="float:left;width: 60%; height: 100%;">
                <div class="addyytime" style="margin-top:26px;">
                    <table style="width:100%;height:100%;line-height: 30px;">
                        <tr>
                            <td><span class="tabletitle">已选客户类型：</span></td>
                        </tr>
                        <tr style="height:38px;">
                            <td id="selectGuestType">
                                <!-- <a href='javascript:;' typeId='0' style='border:0px;;color:#fff;margin-bottom:0px;background-color:#2ec7c9'>全
                                    部</a> -->
                            </td>
                        </tr>
                        <tr>
                            <td><span class="tabletitle">筛选客户标签：</span></td>
                        </tr>
                        <tr>
                            <td>
                                <!-- <a href='javascript:;' itemid='"+timeStr+"' class='hui'>"+timeStr+"</a> -->
                                <a href='javascript:;' itemid='1' name='type' class='hui'>商业险到期客户</a>
                                <a href='javascript:;' itemid='1' name='type' class='hui'>交强险到期客户</a>
                                <a href='javascript:;' itemid='2' name='type' class='hui'>保养到期客户</a>
                                <a href='javascript:;' itemid='3' name='type' class='hui'>年检到期客户</a>
                                <a href='javascript:;' itemid='3' name='type' class='hui'>驾照年审到期客户</a>
                                <a href='javascript:;' itemid='3' name='type' class='hui'>客户生日</a>
                                <a href='javascript:;' itemid='3' name='type' class='hui'>员工生日</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="tabletitle">统计：</span>
                            </td>
                        </tr>
                        <tr style="height:44px;">
                            <td style="border-bottom:2px solid #CCC;position: relative;">

                                <a href='javascript:;' itemid='1' name='act' class='actionButton' style="margin: 0;"><span
                                        class="fa fa-circle-o-notch fa-lg"></span>&nbsp;统计</a>
                                <span style="position: relative;bottom: -12px;margin-left:50px;">
                                    <span>共选中客户:</span><span style="color:#1890ff;font-size:30px;">349</span>
                                    <span>位</span>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td><span class="tabletitle">操作：</span></td>
                        </tr>
                        <tr>
                            <td>
                                <!-- <a href='javascript:;' itemid='"+timeStr+"' class='hui'>"+timeStr+"</a> -->
                                <a href='javascript:;' itemid='1' name='act' class='actionButton'><span class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                <a href='javascript:;' itemid='1' name='act' class='actionButton'><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                <a href='javascript:;' itemid='2' name='act' class='actionButton'><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                <a href='javascript:;' itemid='3' name='act' class='actionButton'><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div style="clear: both"></div>
            <!-- 注释：清除float产生浮动 -->
        </div>
    </div>

    <script type="text/javascript">
        nui.parse();
        var webBaseUrl = webPath + contextPath + "/";
		var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
        var turl =  baseUrl+"com.hsapi.crm.svr.guest.getGuestTypeNum.biz.ext";
        var echartData = {};

        $("a[name=type]").click(function () {
            if (!$(this).hasClass("xz")) {
                $(this).addClass("xz");
            } else {
                $(this).removeClass("xz");
            }
        });
        getEchartDate();

        function getEchartDate() {
            nui.ajax({
                url: turl,
                type: "post",
                data: {},
                success: function (res) {
                    if (res.errCode == 'S') {
                        if (res.carNum != []) {
                            echartData = res.carNum[0];
                            showMainA();
                            var p = {
                                name: '全 部', //初始化
                                color:'#2ec7c9'
                        }
                        setGuestType(p);
                        }
                    } else {
                        showMsg('接口执行错误！', 'E');
                    }
                }
            })

        }

        function showMainA() {

            var option = {
                title: {
                    text: '客户分类',
                    //subtext: ''
                    x: 'center',
                    y: 'bottom',
                    textStyle: {
                        color: '#000',
                        fontStyle: 'bold'
                    }
                },
                tooltip: {
                    trigger: 'item',
                    //formatter: "{a} <br/>{b} : {c}%"
                    formatter: showTooltip
                },
                //toolbox: {
                //    feature: {
                //        dataView: {readOnly: false},
                //        restore: {},
                //        saveAsImage: {}
                //    }
                //},
                legend: {
                    data: ['全 部', '未分类', '流失期', '睡眠期', '稳定期', '活跃期'],
                    x: 'center',
                    y: 20,
                },
                calculable: true,
                series: [{
                    name: '客户类型',
                    type: 'funnel',
                    left: '10%',
                    top: 60,
                    //x2: 80,
                    bottom: 60,
                    width: '80%',
                    // height: {totalHeight} - y - y2,
                    min: 0,
                    max: 100,
                    minSize: '0%',
                    maxSize: '100%',
                    sort: 'descending',
                    gap: 2,
                    label: {
                        normal: {
                            show: true,
                            position: 'inside'
                        },
                        emphasis: {
                            textStyle: {
                                fontSize: 20
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            length: 10,
                            lineStyle: {
                                width: 1,
                                type: 'solid'
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            borderColor: '#CCC',
                            borderWidth: 1
                        }
                    },
                    data: [{
                            //value: echartData.allCarNum || 0,
                            value: 100,
                            name: '全 部'
                        },
                        {
                            // value: echartData.notypeCarNum|| 0,
                            value: 80,
                            name: '未分类'
                        },
                        {
                            // value: echartData.loseCarNum|| 0,
                            value: 60,
                            name: '流失期'
                        },
                        {
                            //value: echartData.sleepCarNum|| 0,
                            value: 40,
                            name: '睡眠期'
                        },
                        {
                            //value: echartData.stableCarNum|| 0,
                            value: 20,
                            name: '稳定期'
                        },
                        {
                            // value: echartData.activeCarNum|| 0,
                            value: 10,
                            name: '活跃期'
                        }
                    ],
                    // color: ['rgb(239,219,200)','rgb(137,246,100)','rgb(155,314,203)','rgb(155,155,146)','rgb(111,222,100)']
                }]
            };

            var myChart = echarts.init(document.getElementById('lindChatA'), 'macarons');

            //使用刚指定的配置项和数据显示图表。
            myChart.setOption(option, true);
            window.onresize = function () {
                myChart.resize();
            };

            myChart.on('click', function (param) {
                console.log(param); //重要的参数都在这里！
                setGuestType(param);
            });
 
            var app = {};
            app.currentIndex = -1;

            setInterval(function () {
                var dataLen = option.series[0].data.length;
                // 取消之前高亮的图形
                myChart.dispatchAction({
                    type: 'downplay',
                    seriesIndex: 0,
                    dataIndex: app.currentIndex
                });
                app.currentIndex = (app.currentIndex + 1) % dataLen;
                // 高亮当前图形
                myChart.dispatchAction({
                    type: 'highlight',
                    seriesIndex: 0,
                    dataIndex: app.currentIndex
                });
                // 显示 tooltip
                myChart.dispatchAction({
                    type: 'showTip',
                    seriesIndex: 0,
                    dataIndex: app.currentIndex
                });
            }, 2000);
        }

        function setGuestType(params) {
            var typeId = null;
            var value = 0;
            switch (params.name) {
                case '全 部':
                    typeId = 0;
                    value = echartData.allCarNum;
                    break;
                case '未分类':
                    typeId = 1;
                    value = echartData.notypeCarNum;
                    break;
                case '流失期':
                    typeId = 2;
                    value = echartData.loseCarNum;
                    break;
                case '睡眠期':
                    typeId = 3;
                    value = echartData.sleepCarNum;
                    break;
                case '稳定期':
                    typeId = 4;
                    value = echartData.stableCarNum;
                    break;
                case '活跃期':
                    typeId = 5;
                    value = echartData.activeCarNum;
                    break;
                default:
                    typeId = 0;
                    value = 0;
                    break;
            }
            value = value || 0;
            var html = "<a href='javascript:;' typeId='" + typeId +
                "'style='border:0px;cursor:default;color:#fff;margin-bottom:0px;background-color:" + params.color +
                "'class='guestTypeCla'>" + params.name + '(' + value + ')' + "</a>";
            console.log(html);
            $('#selectGuestType').html(html);
        }


        var showTooltip = function showEchartTooltip(vla) {
            var value = 0;
            switch (vla.name) {
                case '全 部':
                    value = echartData.allCarNum;
                    break;
                case '未分类':
                    value = echartData.notypeCarNum;
                    break;
                case '流失期':
                    value = echartData.loseCarNum;
                    break;
                case '睡眠期':
                    value = echartData.sleepCarNum;
                    break;
                case '稳定期':
                    value = echartData.stableCarNum;
                    break;
                case '活跃期':
                    value = echartData.activeCarNum;
                    break;
                default:
                    value = 0
                    break;
            }
            value = value || 0;
            return vla.seriesName + '<br>' + vla.name + ':' + value;
        }
    </script>
</body>

</html>