<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2018-07-30 14:22:15
  - Description:
-->
<head>
<title>运营报表客户结构分析</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>
	<script src="https://cdn.bootcss.com/echarts/4.1.0.rc2/echarts-en.common.js"></script>
</head>
<body>
<style>

</style>
<span></span>

<div style="background-color:#F0F4F7">
<br>
   <td >
    <select class="nui-combobox" style="width:200px;"  text="请选择大区"
        onvaluechanged="onDeptChanged" showNullItem="true" style="color:#C4C4C4" ></select>
     </td>  &nbsp;&nbsp;       
    <td>
    <select class="nui-combobox" style="width:200px;" text="请选择门店" ></select>
    </td>&nbsp;&nbsp;
    <input id="date1" class="mini-datepicker" value="" text="请选择日期" style="width:225px" /> &nbsp;&nbsp; 
    <button style="background-color:#4F5F6F; color:white ;width:80px;border:none">查询</button>
    <br>
    <br>
    <div id="main" style="background-color:#FFFFFF;height:400px;width: 100%"></div>
    <br>
    <div class="">
    	<div class="">
        <div id="datagrid1" dataField="ooperators" class="nui-datagrid" style="height:250px;" url="" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
          <div property="columns">
           <div field="" headerAlign="center" allowSort="true" >
            区域
            </div>
            <div field="" headerAlign="center" allowSort="true" >
              门店
            </div>
            <div field="" headerAlign="center" allowSort="true" >
            基盘客户数
            </div>
           <div field="" headerAlign="center" allowSort="true" >
         流失客户数
            </div>
            <div field="" headerAlign="center" allowSort="true" >
         新增客户数
            </div>
            <div field="" headerAlign="center" allowSort="true" >
         新增预存客户数
            </div>
            <div field="" headerAlign="center" allowSort="true" >
        客户来源
            </div>
            <div field="" headerAlign="center" allowSort="true" >
 	来源渠道客户数
            </div>
            
          </div>
        </div>
    </div>
  </div>  
  <script type="text/javascript">
      nui.parse();

      var deptCombo = nui.get("deptCombo");
      var positionCombo = nui.get("positionCombo");

//二级联动
    function onDeptChanged(e) {
      var id = deptCombo.getValue();

      positionCombo.setValue("");
        
      var url = "" + id
      positionCombo.setUrl(url);
        
      positionCombo.select(0);
}

 	// 基于准备好的dom，初始化echarts图表
        var myChart = echarts.init(document.getElementById('main')); 

     option = {
        tooltip : {

        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
   
 	title:[{
 		x: "235",
        y:"190",
        text: '客户结构',
          textStyle: {
            fontWeight: 'normal',
       
            color: "#909090"
        }   
 	},
 	{
 		x:"684",
 		y:"190",
 		text:"预存客户",
 		textStyle: {
            fontWeight: 'normal',

            color: "#909090"
        }
 	},
 	{
 		x:"1140",
 		y:"190",
 		text:"客户来源",
 		textStyle: {
            fontWeight: 'normal',
//             fontSize: 30,
            color: "#909090"
        }
 	}
 	
 	],
 	
    series : [
        {
            name:'客户结构',
            type:'pie',
            radius : ['40%', '60%'],
            center : ['18%', 200],

            itemStyle : {
                normal : {
                    label : {
                        show : true,
                        formatter: '{b} : {c} ({d}%)' 
                    },
                    labelLine : {
                        show : true

                    },
                    borderWidth:4,
                    borderColor:'#ffffff'
                },
                emphasis : {
                    label : {

                        show : true,
                 position:"center",
                        textStyle : {
                            fontSize : '25',
                            fontWeight : 'bold'
                        }
                    }
                }
            },
            data:[
                {value:200, name:'基盘客户'},
                {value:150, name:'流失客户'},
                {value:100, name:'新客户'}
                
            ],
              roseType: 'radius',
          
        },
      {
            name:'预存客户',
            type:'pie',
            radius : ['40%', '60%'],
        center : ['48%', 200],
            itemStyle : {
                normal : {
                    label : {
                        show : true,
                        formatter: '{b} : {c} ({d}%)' 
                    },
                    labelLine : {
                        show : true
                    },
                    borderWidth:4,
                    borderColor:'#ffffff'
                },
                emphasis : {
                    label : {
                        show : true,
                 position:"center",
                        textStyle : {
                            fontSize : '25',
                            fontWeight : 'bold'
                        }
                    }
                }
            },
            data:[
                {value:200, name:'流失预存客户'},
                {value:100, name:'新增预存客户'}
                
            ],
             roseType: 'radius',
        },
         {
            name:'客户来源',
            type:'pie',
            radius : ['40%', '60%'],
          center : ['78%', 200],
            itemStyle : {
                normal : {
                    label : {
                        show : true,
                        formatter: '{b} : {c} ({d}%)' 
                    },
                    labelLine : {
                        show : true
                    },
                    borderWidth:4,
                    borderColor:'#ffffff'
                },
                emphasis : {
                    label : {
                        show : true,
                 position:"center",
                        textStyle : {
                            fontSize : '25',
                            fontWeight : 'bold'
                        }
                    }
                }
            },
            data:[
                {value:200, name:'营销预约客户'},
                {value:150, name:'其他'},
                {value:100, name:'转介绍客户'}
                
            ],
             roseType: 'radius',
        }
    ]
};
                    
                    

        // 为echarts对象加载数据 
        myChart.setOption(option); 
  </script>
  </body>
