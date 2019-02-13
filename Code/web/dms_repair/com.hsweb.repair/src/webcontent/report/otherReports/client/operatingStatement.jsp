<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
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
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
      <link href="<%=request.getContextPath()%>/common/Index/TextIndex.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div  id=""  class="main_child_left"> 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toRepairBill()">
                            <i class="fa fa-wrench fa-4x  fa-inverse"></i>
                            <p>综合开单</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toCarWashBill()">
                            <i class="fa fa-shower fa-4x  fa-inverse"></i> 
                            <p>洗美开单</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toSellBill()">
                            <i class="fa fa-cart-plus fa-4x  fa-inverse"></i>
                            <p>销售开单</p> 
                        </a> 

                    </div>
 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toCarInsuranceDetail()">
                            <i class="fa fa-unlock-alt fa-4x  fa-inverse"></i>
                            <p>保险开单</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toRepairBillTable()">
                            <i class="fa fa-car fa-4x  fa-inverse"></i>
                            <p>维修档案</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toTimesCardList()">
                            <i class="fa fa-gift fa-4x  fa-inverse"></i>
                            <p>计次卡销售</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toCardList()">
                            <i class="fa fa-credit-card-alt fa-4x  fa-inverse"></i>
                            <p>储值卡充值</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toVisitMain()">
                            <i class="fa fa-phone fa-4x  fa-inverse"></i>
                            <p>客户回访</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toPurchaseOrderMain()">
                            <i class="fa fa-copy fa-4x  fa-inverse"></i>
                            <p>采购订单</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toRepairOut()">
                            <i class="fa fa-imdb fa-4x  fa-inverse"></i>
                            <p>配件出库</p> 
                        </a>
                    </div>
                </div>
            </div> 
        </div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>