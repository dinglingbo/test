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
<title>财务报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/financialReport.js?v=1.0.0"></script>
      <link href="<%=request.getContextPath()%>/repair/js/report/storeReport/reportIndex.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div  id=""  > 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
				   <div class="menu_pannel menu_pannel_bg">
                        <a onclick="cashBankReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>现金银行汇总表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailySettlementReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i> 
                            <p>日结算汇总表</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="accountBalance()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>账户余额汇总表</p> 
                        </a> 

                    </div>
 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="accountDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>账户明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="otherIncomeAndExpenditure()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>其他收支明细表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="accountPBillDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>供应商欠款明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="accountPDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>付款明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="accountRDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>收款明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="settlementStatement()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>经营收支统计汇总表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="summaryAccountBalances()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>结算账户余额汇总表</p> 
                        </a>
                    </div>
                </div>
                
                 <div  id="menu3" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="expenseSummary()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>费用汇总表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="otherGainPayReport()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>其它收支明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="painReport()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>应收明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="paymentReport()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>应付明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="profitTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>利润汇总表</p> 
                        </a>
                    </div>
                </div>
                
                 <div  id="menu4" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="twoCompSettleReport()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>跨店结算明细表</p> 
                        </a> 
                    </div>
                    <div >

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