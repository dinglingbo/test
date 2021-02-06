<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 20:31:40
  - Description:
-->
<head>
<title>按车辆类型图表分析</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
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
<div class="nui-fit">
            <div id="t2" style="float:left;width: 60%; height: 100%;">
                <div class="nui-fit">
                    <div id="lindChatA" style="width:98%;height:80%;"></div>
                </div>
            </div>
            <div id="t3" style="float:left;width: 40%; height: 100%;">
                <div class="nui-fit">
                    <div id="lindChatB" style="width:98%;height:80%;"></div>
                </div>
            </div>
            
            <div style="clear: both"></div>
</div>
	<script type="text/javascript">
    	nui.parse();
		brand();
		car();
	function brand(){
		option = {
		    title : {
		        text: '客户来源',
		        subtext: '客户来源',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient : 'vertical',
		        x : 'left',
		        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {
		                show: true, 
		                type: ['pie', 'funnel'],
		                option: {
		                    funnel: {
		                        x: '25%',
		                        width: '50%',
		                        funnelAlign: 'left',
		                        max: 1548
		                    }
		                }
		            },
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    series : [
		        {
		            name:'访问来源',
		            type:'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:335, name:'直接访问'},
		                {value:310, name:'邮件营销'},
		                {value:234, name:'联盟广告'},
		                {value:135, name:'视频广告'},
		                {value:1548, name:'搜索引擎'}
		            ]
		        }
		    ]
		};
            var myChart = echarts.init(document.getElementById('lindChatA'));
            myChart.setOption(option,true);
		    window.onresize = function(){
		        myChart.resize(); 
		    };
	}
        
		function car(){
		option = {
                title: {
                    text: '新增客户',
                    subtext: '纯属虚构'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['新增客户数量']
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: { show: true },
                        dataView: { show: true, readOnly: false },
                        magicType: { show: true, type: ['line', 'bar'] },
                        restore: { show: true },
                        saveAsImage: { show: true }
                    }
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: ['1','2']
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '新增客户数量',
                        type: 'bar',
                        data: [666, 777],
                        markPoint: {
                            data: [
                                { type: 'max', name: '最大值' },
                                { type: 'min', name: '最小值' }
                            ]
                        },
                        markLine: {
                            data: [
                                { type: 'average', name: '平均值' }
                            ]
                        }
                    }
                ]
            };
            var myChart = echarts.init(document.getElementById('lindChatB'));
            myChart.setOption(option,true);
		    window.onresize = function(){
		        myChart.resize(); 
		    };
	}
    </script>
</body>
</html>