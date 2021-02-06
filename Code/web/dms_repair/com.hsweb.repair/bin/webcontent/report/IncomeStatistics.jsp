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
            text-align: left;
    		margin-left: 50px;
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
                    <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                    <a class="nui-button" plain="true" onclick="onSearch" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <!-- <li class="separator"></li> -->
                </td>
            </tr>
        </table>
    </div>
    <div style="height: 150px;" class="parent">

        <div class="column">
            <h3 class="incomeTitle">总收入</h3>
            <p id="pdata1" class="incomeStyle" style="margin-top: 20px;">0.00</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">总毛利</h3>
            <p id="pdata2" class="incomeStyle"  style="margin-top: 20px;">0.00</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">预收</h3>
            <p class="incomeStyle2">充值：<span id="pdata3">0.00</span></p>
            <p class="incomeStyle2">套餐：<span id="pdata4">0.00</span></p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">客户记账</h3>
            <p class="incomeStyle2">记账：<span id="pdata5">0.00</span></p>
            <p class="incomeStyle2">收款：<span id="pdata6">0.00</span></p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">现金银行</h3>
            <p class="incomeStyle2">收款：<span id="pdata7">0.00</span></p>
            <!-- <p style="text-align: center;margin: 0px;color:#999999">(含保险收入：<span id="pdata8" style="color:#999999">37635.00</span>元)</p> -->
            <p class="incomeStyle2">付款：<span id="pdata9">0.00</span></p>
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
        var webBaseUrl = webPath + contextPath + "/";
        var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
        var tUrl = apiPath + repairApi + '/com.hsapi.repair.report.dataStatistics.queryReceive.biz.ext';
        var incomeUrl = apiPath + repairApi + '/com.hsapi.repair.report.dataStatistics.queryIncomePiechart.biz.ext';
        var businessUrl = apiPath + repairApi + '/com.hsapi.repair.report.dataStatistics.queryOutputValue.biz.ext';
        var startDateEl = nui.get('startDate');
        var endDateEl = nui.get('endDate');
        var currType = 2;
        var orgidsEl = null;
        //判断是否有兼职门店,是否显示门店选择框
	    orgidsEl = nui.get("orgids");
	    orgidsEl.setData(currOrgList);
	    if(currOrgList.length==1){
	    	orgidsEl.hide();
	    }else{
	    	orgidsEl.setValue(currOrgid);
	    }
        quickSearch(4);

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
            loadData(params);
        }
        
		function onSearch()
		{
		    var params = getSearchParam();
		    loadData(params);
		}

		function getSearchParam() {
		    var params = {};
 			params.startDate = startDateEl.getValue();
        	params.endDate = addDate(endDateEl.getValue(),1);
		    var orgidsElValue = orgidsEl.getValue();
		    if(orgidsElValue==null||orgidsElValue==""){
		    	 params.orgids =  currOrgs;
		    }else{
		    	params.orgid=orgidsElValue;
		    }

		    
		    return params;
		}

        function loadData(params) {
            nui.ajax({//加载顶部数据
                url:tUrl,
                type:'post',
                data:params,
                success:function(res){
                    if(res.errCode == "S"){
                        var data = res.data;
                        document.getElementById("pdata1").innerHTML = (data.netinAmt||0).toFixed(2);
                        document.getElementById("pdata2").innerHTML = (data.grossProfit||0).toFixed(2);
                        document.getElementById("pdata3").innerHTML = (data.storedAmt||0).toFixed(2);
                        document.getElementById("pdata4").innerHTML = (data.cardTimesAmt||0).toFixed(2);
                        document.getElementById("pdata5").innerHTML = (data.unSettleAmt||0).toFixed(2);
                        document.getElementById("pdata6").innerHTML = (data.settleAmt||0).toFixed(2);
                        document.getElementById("pdata7").innerHTML = (data.rAmt||0).toFixed(2);
                        // document.getElementById("pdata8").innerHTML = 0;
                        document.getElementById("pdata9").innerHTML = (data.pAmt||0).toFixed(2);
                    }
                }
            });
            nui.ajax({//加载左边Echat数据  收入统计
                url:incomeUrl,
                type:'post',
                data:params,
                success:function(res){
                    if(res.errCode == "S"){
                        showMainA(res.rs.dim,res.rs.data);
                    }
                }
            });
            nui.ajax({//加载右边Echat数据  业务产值占比
                url:businessUrl,
                type:'post',
                data:params,
                success:function(res){
                    if(res.errCode == "S"){
                        showMainB(res.rs.dim,res.rs.data);
                    }
                }
            });
        }

        function showMainA(dim,tdata) {

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
                    data: dim
                },
                series: [{
                    name: '收入类型',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: tdata,
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
		function setInitData(params) {
		    if (params.id == 'receiveAmt') {
		    	quickSearch(0);
		    	
		    }
		}
        function showMainB(dim,tdata) {


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
                    data: dim
                },
                series: [{
                    name: '业务类型',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: tdata,
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