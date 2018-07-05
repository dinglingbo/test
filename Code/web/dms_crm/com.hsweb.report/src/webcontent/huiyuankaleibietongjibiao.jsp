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
<title>会员卡类别统计表</title>
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
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient : 'vertical',
        x : 'left',
        data:['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他']
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {
                show: true, 
                type: ['pie', 'funnel']
            },
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : false,
    series : [
        {
            name:'访问来源',
            type:'pie',
            selectedMode: 'single',
            radius : [0, 70],
            
            // for funnel
            x: '20%',
            width: '40%',
            funnelAlign: 'right',
            max: 1548,
            
            itemStyle : {
                normal : {
                    label : {
                        position : 'inner'
                    },
                    labelLine : {
                        show : false
                    }
                }
            },
            data:[
                {value:335, name:'直达'},
                {value:679, name:'营销广告'},
                {value:1548, name:'搜索引擎', selected:true}
            ]
        },
        {
            name:'访问来源',
            type:'pie',
            radius : [100, 140],
            
            // for funnel
            x: '60%',
            width: '35%',
            funnelAlign: 'left',
            max: 1048,
            
            data:[
                {value:335, name:'直达'},
                {value:310, name:'邮件营销'},
                {value:234, name:'联盟广告'},
                {value:135, name:'视频广告'},
                {value:1048, name:'百度'},
                {value:251, name:'谷歌'},
                {value:147, name:'必应'},
                {value:102, name:'其他'}
            ]
        }
    ]
};
/* var ecConfig = require('echarts/config');
myChart.on(ecConfig.EVENT.PIE_SELECTED, function (param){
    var selected = param.selected;
    var serie;
    var str = '当前选择： ';
    for (var idx in selected) {
        serie = option.series[idx];
        for (var i = 0, l = serie.data.length; i < l; i++) {
            if (selected[idx][i]) {
                str += '【系列' + idx + '】' + serie.name + ' : ' + 
                       '【数据' + i + '】' + serie.data[i].name + ' ';
            }
        }
    }
     document.getElementById('lindChatB').innerHTML = str;  
})*/
             
           var myChart = echarts.init(document.getElementById('lindChatB'));
            myChart.setOption(option,true);
		   /* window.onresize = function(){
		        myChart.resize(); 
		    }; */
	}
    </script>
</body>
</html>