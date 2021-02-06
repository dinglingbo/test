<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-03 18:34:32
  - Description:
-->
<head>
  <title>意向管理</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
   <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">   
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }    

</style>
</head>
<body>
  <div id="tabs1" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="true">
    <div title="意向管理" >
      <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
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
             建档日期:
             <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
             <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
             <label>卡券名称：</label>
             <input class="nui-textbox" name="" id="" enabled="true"/>
             <label>卡券码：</label>
             <input class="nui-textbox" name="" id="" enabled="true"/>
             <label>车牌号：</label>
             <input class="nui-textbox" name="" id="" enabled="true"/>
             <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
             <li class="separator"></li>
             <a class="nui-button" iconCls="" plain="true" onclick="newEvent()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
             <a class="nui-button" iconCls="" plain="true" onclick="newEvent()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
             <a class="nui-button" iconCls="" plain="true" onclick="program()" id="addBtn"><span class="fa fa-reorder fa-lg"></span>&nbsp;营销方案</a>
             <a class="nui-button" iconCls="" plain="true" onclick="mem()" id="addBtn"><span class="fa fa-group fa-lg"></span>&nbsp;分配销售顾问</a>
             <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-user-times fa-lg"></span>&nbsp;战败</a>
             <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-user fa-lg"></span>&nbsp;取消战败</a>
             <li class="separator"></li>
             <a class="nui-button" iconCls="" plain="true" onclick="visit()" id="addBtn"><span class="fa fa-volume-control-phone fa-lg"></span>&nbsp;跟踪</a>
             <a class="nui-button" iconCls="" plain="true" onclick="visitList()" id="addBtn"><span class="fa fa-list fa-lg"></span>&nbsp;跟踪记录</a>
           </td>
         </tr>
       </table>
     </div>

     <div class="nui-fit">
      <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
      pageSize="50"
      multiSelect="false"
      totalField="page.count"
      sizeList=[20,50,100,200]
      dataField="list"
      onrowdblclick=""
      allowCellSelect="true"
      allowCellWrap = true
      ondrawcell=""
      >
      <div property="columns">
        <div type="checkcolumn" ></div>    
        <div type="indexcolumn" headerAlign="center" header="序号"></div>
        <div field="" name="" width="80" headerAlign="center" header="门店"></div>
        <div field="" name="" width="80" headerAlign="center" header="品牌"></div>
        <div field="" name="" width="80" headerAlign="center" header="品牌车型"></div>
        <div field="" name="" width="80" headerAlign="center" header="客户名称"></div>
        <div field="" name="" width="80" headerAlign="center" header="联系人"></div>
        <div field="" name="" width="80" headerAlign="center" header="手机"></div>
        <div field="" name="" width="80" headerAlign="center" header="电话"></div>
        <div field="" name="" width="80" headerAlign="center" header="销售顾问"></div>
        <div field="" name="" width="80" headerAlign="center" header="金额"></div>
        <div field="" name="" width="80" headerAlign="center" header="计划跟踪时间" dateFormat="yyyy-MM-dd HH:mm"></div>
        <div field="" name="" width="80" headerAlign="center" header="计划跟踪内容"></div>
        <div field="" name="" width="80" headerAlign="center" header="来访日期" dateFormat="yyyy-MM-dd HH:mm"></div>
        <div field="" name="" width="80" headerAlign="center" header="跟踪次数"></div>
        <div field="" name="" width="80" headerAlign="center" header="意向类型"></div>
        <div field="" name="" width="80" headerAlign="center" header="描述"></div>
      </div>
    </div>


  </div>

</div>
<div title="统计分析"  >


  <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
      <tr>
        <td>
          <!-- <label style="font-family:Verdana;">快速查询：</label>
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
                   建档日期:
                   <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
                   <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
           -->
         <label>销售顾问：</label>
         <input class="nui-textbox" name="" id="" enabled="true"/>
         <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

       </td>
     </tr>
   </table>
 </div>

 <div class="nui-fit">


  <div style="height:50%;width: 50%;">
    <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
    pageSize="50"
    multiSelect="false"
    totalField="page.count"
    sizeList=[20,50,100,200]
    dataField="list"
    onrowdblclick=""
    allowCellSelect="true"
    allowCellWrap = true
    ondrawcell=""
    >
    <div property="columns">
      <div field="" name="" width="80" headerAlign="center" header="销售员"></div>
      <div field="" name="" width="80" headerAlign="center" header="单数"></div>
      <div field="" name="" width="80" headerAlign="center" header="金额"></div>
      <div field="" name="" width="80" headerAlign="center" header="已跟踪"></div>
    </div>
  </div>
</div>
<div style="height:50%">

  <div class="nui-fit">
        <div  id="t1" style="width: 100%; height: 100%;">  

            <div  id="t2"  style="float:left;width: 49.5%; height: 100%;"> 
   
                <div class="nui-fit">
                    <div id="lindChatA" style="width:580px;height:230px;"></div>
                </div>
            </div>
            <div  id="t4"  style="float:left;width: 1%; height: 100%;"></div>
            <div  id="t3"  style="float:left;width: 49%; height: 100%;">       
  
                <div class="nui-fit">
                    <div id="lindChatB" style="width:580px;height:230px;"></div>
                </div>
            </div>

            <div style="clear: both"></div>
            <!-- 注释：清除float产生浮动 -->
        </div>
 </div>
</div>

</div>

</div>

</div>
<script type="text/javascript">
 nui.parse();


 var startDateEl =nui.get('startDate');
 var endDateEl = nui.get('endDate');
 var currType = 2;
 quickSearch(1);
 function quickSearch(type){
    //var params = getSearchParams();
    var params = {};
    var queryname = "本日";
    switch (type)
    {
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
      queryname="本年";
      break;
      case 11:
      params.lastYear = 1;
      params.startDate = getPrevYearStartDate();
      params.endDate = getPrevYearEndDate();
      queryname="上年";
      break;
      default:
      break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    //doSearch(params);
  }

  showMainA();
  showMainB();
  function showMainA() {

    var option = {
      color: ['#3398DB'],
      tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis : [
        {
          type : 'category',
          data : ['昂科威', '新昂科威18T', '商务车', '更多', '', '', ''],
          axisTick: {
            alignWithLabel: true
          }
        }
        ],
        yAxis : [
        {
          type : 'value'
        }
        ],
        series : [
        {
          name:'车型数量',
          type:'bar',
          barWidth: '60%',
          data:[10, 52, 200, 334, 390, 330, 220]
        }
        ]
      };

      var myChart = echarts.init(document.getElementById('lindChatA'));

    //使用刚指定的配置项和数据显示图表。
    myChart.setOption(option,true);
    window.onresize = function(){
      myChart.resize(); 
    };
  }

  function showMainB() {

    var option = {
      color: ['#3398DB'],
      tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis : [
        {
          type : 'category',
          data : ['即将', '意向', '成交', '有兴趣'],
          axisTick: {
            alignWithLabel: true
          }
        }
        ],
        yAxis : [
        {
          type : 'value'
        }
        ],
        series : [
        {
          name:'意向统计',
          type:'bar',
          barWidth: '60%',
          data:[10, 52, 100, 134]
        }
        ]
      };

      var myChartB = echarts.init(document.getElementById('lindChatB'));

    //使用刚指定的配置项和数据显示图表。
    myChartB.setOption(option,true);
    window.onresize = function(){
      myChartB.resize(); 
    };
  }


            function newEvent(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/intentionMgr_edit.jsp",
             title: "添加评论",
             width: 700, 
             height: 350,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }

            function program(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/marketingProgram.jsp",
             title: "营销方案",
             width: 900, 
             height: 500,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }


            function mem(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/selectMember.jsp",
             title: "分配销售顾问",
             width: 620, 
             height: 250,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }

               function visit(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/intention_visit.jsp",
             title: "跟踪回访",
             width: 650, 
             height: 370,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }

                  function visitList(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/intention_visitRecord.jsp",
             title: "跟踪记录",
             width: 720, 
             height: 300,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }


</script>
</body>
</html>