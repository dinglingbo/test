<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2017-11-10 23:20:02
  - Description:
-->
<head>
        <meta charset="UTF-8">
        <title>ECharts练习</title>
        <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
    	<link href="<%=request.getContextPath()%>/common/nui/themes/res/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    	<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
	    <script src="<%=request.getContextPath()%>/common/nui/themes/scripts/boot.js" type="text/javascript"></script>
	    <link href="<%=request.getContextPath()%>/common/nui/themes/res/third-party/scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
	    <script src="<%=request.getContextPath()%>/common/nui/themes/res/third-party/scrollbar/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
	   
	    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/menu/menu.css" rel="stylesheet" type="text/css" />
	    <script src="<%=request.getContextPath()%>/common/nui/themes/frame1/res/menu/menu.js" type="text/javascript"></script>
	    <script src="<%=request.getContextPath()%>/common/nui/themes/frame1/res/menutip.js" type="text/javascript"></script>
	    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/tabs.css" rel="stylesheet" type="text/css" />
	    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/frame.css" rel="stylesheet" type="text/css" />
	    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/index.css" rel="stylesheet" type="text/css" />
	    <style type="text/css">
	    	.hightBtn
			{
				border:2px solid #a1a1a1;
				padding:10px 40px; 
				background:#dddddd;
				width:300px;
				border-radius:25px;
			}
			
			#linknav{height:140px;width:100%;}
			#linknav ul{text-align:center;list-style-type:none;}
			#linknav ul li{display:inline;list-style-type:none;}
	    </style>
</head>

    <body>
        <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
        <div id="main" style="width: 100%;height:400px;"></div>
        <!-- <div id="linknav">
		    <ul class="">
		        <li ><a href="#"><i class="fa fa-hand-pointer-o"></i><span >系统演示</span></a></li>
		        <li ><a href="#"><i class="fa fa-puzzle-piece"></i><span >开发文档</span></a></li>
		        <li ><a href="#"><i class="fa fa-sort-amount-asc"></i><span >人力资源</span></a></li>
		        <li class="icontop"><a href="#"><i class="fa  fa-cog"></i><span >系统设置</span></a></li>
		    </ul>
		</div> -->
        <script type="text/javascript">
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'));
            

            var labelTop = {
			    normal : {
			    	color: '#40E0D0',
			        label : {
			            show : true,
			            position : 'center',
			            formatter : '{b}',
			            textStyle: {
			                baseline : 'bottom'
			            }
			        },
			        labelLine : {
			            show : false
			        }
			    }
			};
			var labelFromatter = {
			    normal : {
			        label : {
			            formatter : function (params){
			                return 100 - params.value + '%'
			            },
			            textStyle: {
			                baseline : 'top'
			            }
			        }
			    },
			}
			var labelBottom = {
			    normal : {
			        color: '#C9C9C9',
			        label : {
			            show : true,
			            position : 'center'
			        },
			        labelLine : {
			            show : false
			        }
			    },
			    emphasis: {
			        color: 'rgba(0,0,0,0)'
			    }
			};
			
			var radius = [40, 55];
			option = {
			    legend: {
			        x : 'center',
			        y : 'center',
			        data:[
			            'GoogleMaps','Facebook','Youtube','Google+','Weixin',
			            'Twitter', 'Skype', 'Messenger', 'Whatsapp', 'Instagram'
			        ]
			    },
			    title : {
			        //text: 'The App World',
			        //subtext: 'from global web index',
			        //x: 'center'
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            dataView : {show: true, readOnly: false},
			            magicType : {
			                show: true, 
			                type: ['pie', 'funnel'],
			                option: {
			                    funnel: {
			                        width: '20%',
			                        height: '30%',
			                        itemStyle : {
			                            normal : {
			                                label : {
			                                    formatter : function (params){
			                                        return 'other\n' + params.value + '%\n'
			                                    },
			                                    textStyle: {
			                                        baseline : 'middle'
			                                    }
			                                }
			                            },
			                        } 
			                    }
			                }
			            },
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    series : [
			        {
			            type : 'pie',
			            center : ['10%', '30%'],
			            radius : radius,
			            x: '0%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:46, itemStyle : labelBottom},
			                {name:'GoogleMaps', value:54,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['30%', '30%'],
			            radius : radius,
			            x:'20%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:56, itemStyle : labelBottom},
			                {name:'Facebook', value:44,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['50%', '30%'],
			            radius : radius,
			            x:'40%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:65, itemStyle : labelBottom},
			                {name:'Youtube', value:35,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['70%', '30%'],
			            radius : radius,
			            x:'60%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:70, itemStyle : labelBottom},
			                {name:'Google+', value:30,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['90%', '30%'],
			            radius : radius,
			            x:'80%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:73, itemStyle : labelBottom},
			                {name:'Weixin', value:27,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['10%', '70%'],
			            radius : radius,
			            y: '55%',   // for funnel
			            x: '0%',    // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:78, itemStyle : labelBottom},
			                {name:'Twitter', value:22,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['30%', '70%'],
			            radius : radius,
			            y: '55%',   // for funnel
			            x:'20%',    // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:78, itemStyle : labelBottom},
			                {name:'Skype', value:22,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['50%', '70%'],
			            radius : radius,
			            y: '55%',   // for funnel
			            x:'40%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:78, itemStyle : labelBottom},
			                {name:'Messenger', value:22,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['70%', '70%'],
			            radius : radius,
			            y: '55%',   // for funnel
			            x:'60%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:83, itemStyle : labelBottom},
			                {name:'Whatsapp', value:17,itemStyle : labelTop}
			            ]
			        },
			        {
			            type : 'pie',
			            center : ['90%', '70%'],
			            radius : radius,
			            y: '55%',   // for funnel
			            x:'80%', // for funnel
			            itemStyle : labelFromatter,
			            data : [
			                {name:'other', value:89, itemStyle : labelBottom},
			                {name:'Instagram', value:11,itemStyle : labelTop}
			            ]
			        }
			    ]
			};
			                    
            // 使用刚指定的配置项和数据显示图表。
           myChart.setOption(option);
            window.addEventListener('resize', function () {
				myChart.resize();
			});
			
        </script>
    </body>

</html>