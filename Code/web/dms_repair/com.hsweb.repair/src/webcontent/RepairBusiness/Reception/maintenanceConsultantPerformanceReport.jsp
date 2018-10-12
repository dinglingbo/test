<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-28 10:39:20
  - Description:
-->
<head>
<title>维修顾问业绩报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/echarts.js" type="text/javascript" ></script>
</head>
<style type="text/css">

</style>
<body>
<div id="toolbar1" class="nui-toolbar" style="padding:2px;">
    <table style="width:80%;">
        <tr>
        <td style="width:80%;">
        	快速统计：
            <a class="nui-button" plain="true"><font color="blue"><u>本周</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>上周</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>本月</u></font></a>
            <a class="nui-button" plain="true"><font color="blue"><u>上月</u></font></a>
            <span class="separator"></span>
                      结算日期  从：
          	<input class="nui-datepicker"/>&nbsp;至：<input class="nui-datepicker"/>
          	<span class="separator"></span>
          	<a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        </td>
        </tr>
    </table>
</div>
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:70%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="80"
               totalField="page.count"
               sizeList=[20,80,80,200]
               dataField="list"
               onrowdblclick=""
               showModified="false"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url=""
               frozenStartColumn="0" frozenEndColumn="3"
               >
              <div property="columns">
              	<div type="indexcolumn" headerAlign="center" align="center">序号</div>
                  <div header="基本信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="维修顾问"></div>
                		<div field="" width="100" headerAlign="center" align="center" header="首次到店车辆数"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="结算车次"></div>
                	</div>
        		  </div>
        		  <div header="维修金额信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="项目金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="配件金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="配件管理费"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="维修金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="应收金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="预提费"></div>
                	</div>
        		  </div>
        		  <div header="营业信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="折让金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="业务费"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="维修毛收入"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="实营金额"></div>
                	</div>
        		  </div>
        		  <div header="配件成本信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="销售金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="配件成本"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="配件销售加点"></div>
                	</div>
        		  </div>
        		  <div header="毛利信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="毛利"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="毛利率"></div>
                	</div>
        		  </div>
        		  <div header="运营毛利信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="运营毛利"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="运营毛利率"></div>
                	</div>
        		  </div>
        		  <div header="其他信息" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="整单优惠率"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="单车产值"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="活动冲减金额"></div>
                	</div>
        		  </div>
              </div>
          </div>
         <div class="nui-fit">
          <div id="zzjg" style="width:99%;height:99%;left:0;right:0;margin:0 auto;"></div>
         </div>
	<script type="text/javascript">
    	nui.parse();
    	var orgChart = echarts.init(document.getElementById('zzjg'));
    	var option = {
		    title : {
		        text: '某地区蒸发量和降水量',
		        subtext: '纯属虚构'
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['蒸发量','降水量']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            
		           
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'蒸发量',
		            type:'bar',
		            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3],
		            markPoint : {
		                data : [
		                    {type : 'max', name: '最大值'},
		                    {type : 'min', name: '最小值'}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name: '平均值'}
		                ]
		            }
		        },
		        {
		            name:'降水量',
		            type:'bar',
		            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3],
		            markPoint : {
		                data : [
		                    {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183, symbolSize:18},
		                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name : '平均值'}
		                ]
		            }
		        }
		    ]
		};
		orgChart.setOption(option);
    </script>
</body>
</html>