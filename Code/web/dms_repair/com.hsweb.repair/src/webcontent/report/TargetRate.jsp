<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2018-07-30 14:22:15
  - Description:
-->
<head>
<title>运营报表-目标达成率</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>
	<script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
</head>
<body>
<style>
	#main{
	background-color:#FFFFFF!important;
	}
</style>
<div style="background-color:#F0F4F7;">
<br>
	<td>
    <select id="deptCombo" class="nui-combobox" style="width:200px; "  text="请选择大区"
        onvaluechanged="onDeptChanged" showNullItem="true"></select>
     </td>  &nbsp;&nbsp;       
    <td>
    <select id="positionCombo" class="nui-combobox" style="width:200px;" text="请选择门店" ></select>
    </td>&nbsp;&nbsp;
    <td>
    <select id="positionCombo" class="nui-combobox" style="width:200px;" text="请选择员工" ></select>
    </td>&nbsp;&nbsp;
    <input id="date1" class="mini-datepicker" value="" text="请选择日期" style="width:225px"/> &nbsp;&nbsp; 
    <button style="background-color:#4F5F6F; color:white;width:80px;border:none">查询</button>
    <br>


    <br>
    <div id="main" style="height:450px;width: 100%;"></div>
    <br>
    <div class="" >
<!--     <div class="nui-panel"   showToolbar="false" showFooter="false"  style="width:100%;height:100%;" > -->
    	<div class="">
        <div id="datagrid1" dataField="ooperators" class="nui-datagrid" style="height:250px;" url="" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
          <div property="columns">
           <div field="" headerAlign="center" allowSort="true" >
            目标类型
            </div>
            <div field="" headerAlign="center" allowSort="true" >
              目标值
            </div>
            <div field="" headerAlign="center" allowSort="true" >
            实际值
            </div>
           <div field="" headerAlign="center" allowSort="true" >
         达成率
            </div>
       
          </div>
        </div>
<!--        </div> -->
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

 	var myChart = echarts.init(document.getElementById('main')); 
        
        var option = {

            title:{
                text:'目标达成率',
                
                
            },

            tooltip: {
                show: true
            },
            legend: {
                x:'left',
                data:['','实际量','目标值']
              
            },

            xAxis : [
                {
                    type : 'category',
                    data : ["营收","结算车次","运营毛利","洗美首修车次","预存储值"]
                   
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    "name":"实际值",
                    "type":"bar",
					barCategoryGap:'75%',
                    "data":[50, 45, 62,22, 55],
                    itemStyle:{  normal:{color:'#8E6CCA'}   }  
                },
                {
                    "name":"目标值",
                    "type":"bar",barCateGoryGap:20,
 
                    "data":[60, 58, 65,33,66],
                     itemStyle:{  normal:{color:'#FEC045'}}  
                }
                 
            ]
        };

        // 为echarts对象加载数据 
        myChart.setOption(option); 
 
  </script>
  </body>
</html>