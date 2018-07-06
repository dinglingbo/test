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
<title>经营收支统计报表</title>
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
<div style="height: 60px">
    <input class="nui-combobox" style="width:12%" data="data" value="1">&nbsp;
     日期
    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
</div>
    <div class="nui-fit">
            <div id="t2" style="float:left;width: 60%; height: 100%;">
                <div class="nui-fit">
                    <div style="height: 150px;width:450px;border: 1px solid red">
                    	<table>
                            <tr >
                                <td style="width: 200px">
                                    收入
                                    <span></span>
                                </td>
                                                                <td style="width: 200px">
                                                                    ￥
                                                                    <span></span>
                                                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    现金
                                    <span></span>
                                </td>
                                                    <td style="width: 200px">
                                                        ￥
                                                        <span></span>
                                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    银行卡
                                    <span></span>
                                </td>
                                                    <td style="width: 200px">
                                                        ￥
                                                        <span></span>
                                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    支付宝
                                    <span></span>
                                </td>
                                                    <td style="width: 200px">
                                                        ￥
                                                        <span></span>
                                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    微信
                                    <span></span>
                                </td>
                                                    <td style="width: 200px">
                                                        ￥
                                                        <span></span>
                                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    银行转账
                                    <span></span>
                                </td>
                                                    <td style="width: 200px">
                                                        ￥
                                                        <span></span>
                                                    </td>
                            </tr>
                    	</table>
                    </div>

                    <div style="height: 150px;width:450px;border: 1px solid rgb(98, 0, 255)">
                        <table>
                            <tr>
                                <td style="width: 200px">
                                    支出
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    现金
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    银行卡
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    支付宝
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    微信
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    银行转账
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div style="height: 150px;width:450px;border: 1px solid rgb(0, 255, 76)">
                        <table>
                            <tr>
                                <td style="width: 200px">
                                    合计
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    现金
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    银行卡
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    支付宝
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    微信
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    银行转账
                                    <span></span>
                                </td>
                                <td style="width: 200px">
                                    ￥
                                    <span></span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div id="t3" style="float:left;width: 40%; height: 100%;">
                <div class="nui-fit">
                    <div id="lindChatB" style="width:98%;height:80%;"></div>
                </div>
            </div>
            
            <div style="clear: both"></div>
        </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "今天" }, { id: "2", text: "本周" }, { id: "3", text: "本月" }, { id: "4", text: "本季度" }, { id: "5", text: "本年" }];
    	nui.parse();
		car();
        
		function car(){
			option = {
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        }
			    },
			    legend: {
			        data:['利润', '支出', '收入']
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    yAxis : [
			        {
			            type : 'category',
			            axisTick : {show: false},
			            data : ['周一','周二','周三','周四','周五','周六','周日']
			        }
			    ],
			    series : [
			        {
			            name:'利润',
			            type:'bar',
			            itemStyle : { normal: {label : {show: true, position: 'inside'}}},
			            data:[200, 170, 240, 244, 200, 220, 210]
			        },
			        {
			            name:'收入',
			            type:'bar',
			            stack: '总量',
			            barWidth : 5,
			            itemStyle: {normal: {
			                label : {show: true}
			            }},
			            data:[320, 302, 341, 374, 390, 450, 420]
			        },
			        {
			            name:'支出',
			            type:'bar',
			            stack: '总量',
			            itemStyle: {normal: {
			                label : {show: true, position: 'left'}
			            }},
			            data:[-120, -132, -101, -134, -190, -230, -210]
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