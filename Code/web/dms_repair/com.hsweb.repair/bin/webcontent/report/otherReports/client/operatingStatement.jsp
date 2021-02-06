<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-13 16:56:09
  - Description:
-->
<head>
<title>营业报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/operatingStatement.js?v=1.0.3"></script>
      <link href="<%=request.getContextPath()%>/repair/js/report/storeReport/reportIndex.css" rel="stylesheet" type="text/css" />
</head>
<body>


                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
				   <div class="menu_pannel menu_pannel_bg">
                        <a onclick="IncomeStatistics()">
                            <i class="fa fa-pie-chart fa-4x  fa-inverse"></i>
                            <p>仪表盘</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RetailStatistics()">
                            <i class="fa fa-area-chart fa-4x  fa-inverse"></i> 
                            <p>零售业务统计分析表</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RepairConsultantPerformanceMain()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>服务顾问业绩汇总表</p> 
                        </a> 

                    </div>
 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="businessDaily()">
                            <i class="fa fa-area-chart fa-4x  fa-inverse"></i>
                            <p>营业日分析表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="carTypeCount()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>充值办卡汇总表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="selectCompensation()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>理赔开单明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="checkMainDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>查车单明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="CarInsuranceQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>车险开单明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="selectComprehensive()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>已结算工单明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="inFactoryVehicle()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>未结算工单明细表</p> 
                        </a>
                    </div>
                </div>
                
                 <div  id="menu3" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="businessOutputTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>已结算工单汇总表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="returnQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>退货开单明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="sellQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>销售开单明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="sellectWash()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>洗美开单明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="BookingManagementSummary()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>预约汇总表</p> 
                        </a>
                    </div>
                </div>
                
                 <div  id="menu4" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="notSettledPartDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>未结算配件明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="rpsCardTimeList()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>计次卡消费明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="cardRunningWaterSummary()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>储值卡流水汇总表</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="cardTimesRunningWaterSummary()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>计次卡流水汇总表</p> 
                        </a> 

                    </div>
                    <div >

                    </div>                   
                </div>
            </div> 
      

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>