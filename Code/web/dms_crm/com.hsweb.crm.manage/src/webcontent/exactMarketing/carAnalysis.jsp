<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 11:31:52
  - Description:
-->
<head>
<title>车辆分析</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/echarts.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
    
</head>
<body>


<div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
	<!-- 上 -->
	<div size="50%" showCollapseButton="false">
		<div  class="nui-toolbar" style="padding:2px;border-bottom:1;">
	        <table id="top"style="width:100%;">
	            <tr>
	                <td>车辆品牌统计</td>
	            </tr>
	        </table>
	    </div>  
		<div  class="nui-splitter"  vertical="false" style="width:100%;height:100%;" allowResize="true">
			<!-- 左 -->
			<div size="50%" showCollapseButton="false">
				<div id="brand" style="background-color:#FFFFFF;height:100%;width: 100%"></div>
			</div>
			<!-- 右 -->
			<div size="50%" showCollapseButton="false">
				<div class="nui-fit"> 	
					<div id="brandGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
		            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
		            <div property="columns">
		            		<div type="indexcolumn" width="15">序号</div>
		                	<div field="" name="" width="80" headerAlign="center" header="车辆品牌"></div>
			                <div field="" name="" width="55" headerAlign="center" header="数量合计"></div>
			                <div field="" name="" width="100" headerAlign="center" header="占比"></div>
		            </div>
		        	</div>
				</div> 
			</div>
		</div>
		
		
	</div>
	<!-- 下 -->
	<div showCollapseButton="false">
		<div  class="nui-toolbar" style="padding:2px;border-bottom:1;">
	        <table id="top"style="width:100%;">
	            <tr>
	                <td>车辆价格统计</td>
	            </tr>
	        </table>
	    </div>  
		<div  class="nui-splitter"  vertical="false" style="width:100%;height:100%;" allowResize="true">
			<!-- 左 -->
			<div size="50%" showCollapseButton="false">
				<div id="price" style="background-color:#FFFFFF;height:100%;width: 100%"></div>
			</div>
			<!-- 右 -->
			<div size="50%" showCollapseButton="false">
				<div class="nui-fit"> 	
					<div id="priceGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
		            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
		            <div property="columns">
		            		<div type="indexcolumn" width="15">序号</div>
		                	<div field="" name="" width="80" headerAlign="center" header="车辆价格"></div>
			                <div field="" name="" width="55" headerAlign="center" header="数量合计"></div>
			                <div field="" name="" width="100" headerAlign="center" header="占比"></div>
		            </div>
		        	</div>
				</div> 
			</div>
		</div>
	
</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	$(document).ready(function(){
    		openMyChart();
    		openMyChart2();
    	});
    	
 function openMyChart(){
    	option = {
        tooltip : {

        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
   
 	title:[{
 		x: "235",
        y:"190",
        text: '',
          textStyle: {
            fontWeight: 'normal',
       
            color: "#909090"
        }   
 	}],
 	
    series : [
        {
            name:'',
            type:'pie',
            radius : ['40%', '60%'],
            center : ['50%', 200],

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
                {value:200, name:'未设置'},
                {value:150, name:'奥迪'},
                {value:100, name:'宝马'}
                
            ],
              roseType: 'radius',
          
        }
    ]
};                    

        var myChart = echarts.init(document.getElementById('brand')); 
        myChart.setOption(option);
}        

 function openMyChart2(){
    	option = {
        tooltip : {

        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
   
 	title:[{
 		x: "235",
        y:"190",
        text: '',
          textStyle: {
            fontWeight: 'normal',
       
            color: "#909090"
        }   
 	}],
 	
    series : [
        {
            name:'',
            type:'pie',
            radius : ['40%', '60%'],
            center : ['50%', 200],

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
                {value:200, name:'未设置'},
                {value:150, name:'八万以下'},
                {value:100, name:'八万至十五万'}
                
            ],
              roseType: 'radius',
          
        }
    ]
};                    

        var myChart2 = echarts.init(document.getElementById('price')); 
        myChart2.setOption(option);
}      
        
    </script>
</body>
</html>