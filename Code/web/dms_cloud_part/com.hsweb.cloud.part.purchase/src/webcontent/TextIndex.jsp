<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-03-21 09:13:58
  - Description:
-->
<head>
  <title>首页</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
  <link href="<%=request.getContextPath()%>/eos/TextIndex.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
  <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <%@include file="/common/common.jsp"%>
  <style type="text/css">          

</style>
</head>
<body> 
    <div class="nui-fit">

        <div  id="" class="main" style="margin-top: 15px;height:250px !important;">

            <div  id=""  class="main_child"> 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-rocket fa-4x  fa-inverse"></i>
                            <p>快速报价</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-cart-plus fa-4x  fa-inverse"></i>
                            <p>新建采购订单</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-calendar-plus-o fa-4x  fa-inverse"></i>
                            <p>新建销售订单</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-search-plus fa-4x  fa-inverse"></i>
                            <p>EPC查询</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-truck fa-4x  fa-inverse"></i>
                            <p>打包发货</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-copy fa-4x  fa-inverse"></i>
                            <p>月结对账</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-calculator fa-4x  fa-inverse"></i>
                            <p>应收应付结算</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-credit-card fa-4x  fa-inverse"></i>
                            <p>其它费用支出</p> 
                        </a>
                    </div>
                </div>
            </div> 
        </div>

        <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" ><i class="fa fa-eye fa-lg-custom fa-fw"></i><span>今日工作看板</span></div>
                <div class="nui-fit">
                    <div class="nui-fit"> 
                        <div id="grid1" class="nui-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;" showColumns="false" showpager="false" > 
                            <div property="columns">
                                <div field="id" name="id" visible="false" ></div>
                                <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
                                <div field="business" name="business" width="80px" headeralign="center" ><strong>订单</strong></div>
                                <div field="custom" name="custom" width="80px" headeralign="center" ><strong>客户</strong></div>
                                <div field="address" name="address" width="80px" headeralign="center" ><strong>地点</strong></div>
                                <div field="date" name="date" width="80px" headeralign="center" ><strong>时间</strong></div>
                                <div field="status" name="status" width="80px" headeralign="center" ><strong>状态</strong></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div style="clear: both"></div>
        <!-- 注释：清除float产生浮动 -->
    </div>

    <div  id="" class="main" style="margin-top: 15px;height: 205px;">

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" ><i class="fa fa-th-list fa-lg-custom fa-fw"></i> <span >待办事项版块</span></div>
                <div class="nui-fit">
                    <div class="nui-fit">

                        <div id="grid2" class="nui-datagrid" style="width: 100%; height: 100%;font-weight: 600;" borderstyle="border:0;" showColumns="false" showpager="false" > 
                            <div property="columns">
                                <div field="id" name="id" visible="false" ></div>
                                <div field="business" name="business" width="80px" headeralign="center" ><strong>订单</strong></div>
                                <div field="num" name="num" width="80px" headeralign="center" ><strong>数量</strong></div>
                                <div field="cost" name="cost" width="80px" headeralign="center" numberFormat="￥#,0"><strong>金额</strong></div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>

        <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" ><i class="fa fa-bars fa-lg-custom fa-fw"></i><span>今日数据</span></div>
                <div class="nui-fit">
                    <div class="nui-fit" > 
                        <div style="padding:10px 10px 10px 10px;">
                            <table id="table1" style="margin-left:20px;">
                                <tr>  
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>今日收入：</td>
                                    <td class="tablenum"><span>3,453,232</span></td>
                                    <td style="width:0.05%;"></td>
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>今日支出：</td>
                                    <td class="tablenum"><span>1,753,542</span></td>
                                </tr>

                                <tr>
                                 <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>库存总成本：</td>
                                 <td class="tablenum"><span>5,523,254</span></td>
                                 <td ></td>
                                 <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>库存SKU种类：</td>
                                 <td class="tablenum"><span>9,443</span></td>
                             </tr>


                             <tr>
                              <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>客户欠款：</td>
                              <td class="tablenum"><span>0</span></td>
                              <td ></td>
                              <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>供应商欠款：</td>
                              <td class="tablenum"><span>0</span></td>
                          </tr>

                      </table>
                  </div>
              </div>
          </div>
      </div>
  </div>

  <div style="clear: both"></div>
  <!-- 注释：清除float产生浮动 -->
</div>

<div  id="" class="main" style="margin-top: 15px;">

    <div  id=""  class="main_child">
        <div class="vpanel" >
            <div class="vpanel_heading" > <i class="fa fa-bar-chart fa-lg-custom fa-fw"></i><span >本季度业务员销售排名</span></div>
            <div class="nui-fit">
                <div id="Ranking" style="height:95%;width:95%;" title="图"> </div>
            </div>
        </div> 
    </div>  

    <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

    <div  id=""  class="main_child">
        <div class="vpanel" >
            <div class="vpanel_heading" ><i class="fa fa-lightbulb-o fa-lg-custom fa-fw"></i><span>新闻公告</span></div>
            <div class="nui-fit">
                <div class="nui-fit">
                    <div  style="padding:10px 10px 10px 10px;">
                       <ul id="newul" > 

                        <li><a href="http://www.baidu.com">华胜企业体系</a></li>
                        <li><a href="http://www.baidu.com">关于华胜526</a></li>
                        <li><a href="http://www.baidu.com">你所不知道的华胜</a></li>
                    </ul>

                </div>
            </div>
        </div>
    </div>
</div>

<div style="clear: both"></div>
<!-- 注释：清除float产生浮动 -->
</div>


</div>
<script type="text/javascript">
    var grid1_data =[{business:"采购订单",custom:"长荣行",address:"上海浦东",date:"8:40",status:"已受理"},
    {business:"采购订单2",custom:"长荣行2",address:"上海浦东2",date:"8:50",status:"已受理2"}];

    var grid2_data =[{business:"未入库采购订单",num:"2",cost:"5454342"},
    {business:"未出库销售订单",num:"0",cost:"0"},
    {business:"未付款对账单",num:"1",cost:"72145"},
    {business:"未收款对账单",num:"2",cost:"931455"},
    {business:"本月月结未对账",num:"2",cost:"42467"},];
    nui.parse();


    var grid1 = nui.get("grid1");
    var grid2 = nui.get("grid2");
    grid1.setData(grid1_data);
    grid1.setShowVGridLines(false);
    grid1.setShowHGridLines(false);

    grid2.setData(grid2_data);
    grid2.setShowVGridLines(false);
    grid2.setShowHGridLines(false);


    grid2.on("drawcell",function(e){
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var value = e.value;
        var row = e.row;
        if(column.field == "num"||column.field == "business"){
            if(value){
                e.cellStyle = "color:#4d7496";
            }
        }


    });


    var  echartNum = [373423,345343,322796,306731,296842,285433,250000,230000,213434,203434,183434,163434];
    var xdata = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"];
    showMain();
    function showMain(tdata) {
        var dataurl = null;
        var rot = 0;

        var itemStyle = {
            normal: {
                color: [
                '#ff7f50','#87cefa','#da70d6','#32cd32'
                ]
            }
        };

        var soption = {
            title: {
                text: '',
                subtext: '',
                x: 'center'
            },
            color: ['#3398DB', '#ff7f50','#da70d6','#32cd32'],
            tooltip: {
                trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    }, 
                    
                 /*   legend: {
                        data: ['数量']
                    },*/
                    
                    grid: {
                        left: '10%', 
                        right: '5%',
                    /*      bottom: '3%',
                    containLabel: true,*/
                    x:35,
                    y:20,
                    x2:20,
                    y2:30
                },
                xAxis: [
                {
                    type: 'category',
                    axisLabel:{
                            interval:0,//横轴信息全部显示
                            rotate:rot,//-30度角倾斜显示 (省份)
                        },
                        data: xdata,
                        axisTick: {
                            alignWithLabel: true
                        }
                    }
                    ],
                    yAxis: [
                    {
                        type: 'value',
                        scale: 'true',
                        splitLine: {
                            show: false
                        },
                    }
                    ],
                    series: 
                    {
                        name: '数量',
                        type: 'bar',
                        data: echartNum
                    },
                    
                };

                var myChart = echarts.init(document.getElementById('Ranking'));

                    //使用刚指定的配置项和数据显示图表。
                    myChart.setOption(soption,true);
                    window.onresize = function(){
                        myChart.resize(); 
                    };
                } 

            </script>
        </body>
        </html>