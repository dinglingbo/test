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
<title>采购报表 </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/operatingStatement.js?v=1.0.0"></script>
      <link href="<%=request.getContextPath()%>/repair/js/report/storeReport/reportIndex.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div  id=""  > 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
				   <div class="menu_pannel menu_pannel_bg">
                        <a onclick="partBrandPchsForMonth()">
                            <i class="fa fa-area-chart fa-4x  fa-inverse"></i>
                            <p>品牌采购分析表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="supplierPchsForMonth()">
                            <i class="fa fa-area-chart fa-4x  fa-inverse"></i> 
                            <p>供应商采购分析表</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="partPchsForMonth()">
                            <i class="fa fa-area-chart fa-4x  fa-inverse"></i>
                            <p>配件采购分析表</p> 
                        </a> 

                    </div>
 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="purchaseOrderQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>采购订单明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="pchsOrderEnterQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>采购入库明细表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="purcharseRank()">
                            <i class="fa fa-area-chart fa-4x  fa-inverse"></i>
                            <p>采购排行分析表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="purchaseOrderRtnQuery()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>采购退货明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="partTypePchsForMonth()">
                            <i class="fa fa-area-chart fa-4x  fa-inverse"></i>
                            <p>配件类型采购分析表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="productUnsoldReport()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>滞销产品汇总表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="projectConstructionDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>项目施工明细表</p> 
                        </a>
                    </div>
                </div>
                
                 <div  id="menu3" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="projectConstructionTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>项目施工汇总表</p> 
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