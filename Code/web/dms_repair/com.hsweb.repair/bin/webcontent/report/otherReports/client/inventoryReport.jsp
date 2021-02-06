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
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/inventoryReport.js?v=1.0.0"></script>
      <link href="<%=request.getContextPath()%>/repair/js/report/storeReport/reportIndex.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div  id=""  > 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
				   <div class="menu_pannel menu_pannel_bg">
                        <a onclick="businessOutputTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>业务产值汇总表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="businessTrend()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i> 
                            <p>营业趋势汇总表</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailySettlementDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>日结算明细表</p> 
                        </a> 

                    </div>
 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="stockCheckQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>盘点单明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="shopInvoingCount()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>进销存汇总表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="shopInvoingDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>进销存明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="storeInvoingDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>分仓进销存明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="storeInvongCount()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>分仓进销存汇总表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RepairOutReport()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>维修出库明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RepairReturnReport()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>维修归库明细表</p> 
                        </a>
                    </div>
                </div>
                
                 <div  id="menu3" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="sellOutQty()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>销售出库明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="returnOutQty()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>退货归库明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="shiftPositionOrderQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>移仓单明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="stockTurnOverCount()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>库存周转汇总表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="stockTurnOverDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>库存周转明细表</p> 
                        </a>
                    </div>
                </div>
                
                 <div  id="menu4" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="productUnsoldReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>滞销产品汇总表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="insuranceSaleDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>保险销售明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="itemSaleReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>套餐销售汇总表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="partRepairTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>配件维修汇总表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="partSaleReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>配件销售汇总表</p> 
                        </a>
                    </div>                                                        
                </div>
                 <div  id="menu5" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="projectSaleReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>项目销售汇总表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RepairNoSettle()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>未结算配件明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RepairOutQty()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>配件出库明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RepairReturnQty()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>配件归库明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="repairTotalReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>维修汇总表</p> 
                        </a>
                    </div>                                                        
                </div>
                <div  id="menu6" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="saleDetailTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>销售明细汇总表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="wholesaleReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>批发汇总表</p> 
                        </a>
                    </div>
                    <div >

                    </div>
                    <div >

                    </div>
                    <div >

                    </div>                   
                </div>
            </div> 
        </div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>