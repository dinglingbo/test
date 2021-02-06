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
  <title>采购报表</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
  <link href="<%=request.getContextPath()%>/cw/TextIndex.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
  <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <%@include file="/common/commonPart.jsp"%>
  <style type="text/css">          

</style>
</head>
<body> 
    <div class="nui-fit">

        <div  id="" class="main" style="margin-top: 15px;height:400px !important;width:80%">

            <div  id=""  class="main_child"> 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
                    <div class="menu_pannel menu_pannel_bg">
                        <a >
                            <i class="fa fa-rocket fa-4x  fa-inverse"></i>
                            <p>材料采购统计排名</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="gongyingshangrank()">
                            <i class="fa fa-cart-plus fa-4x  fa-inverse"></i>
                            <p>采购排行榜</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="cailiaocaigou()">
                            <i class="fa fa-calendar-plus-o fa-4x  fa-inverse"></i>
                            <p>材料采购统计表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="gongyingshangsum()">
                            <i class="fa fa-search-plus fa-4x  fa-inverse"></i>
                            <p>供应商材料采购统计表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="caigousum()">
                            <i class="fa fa-search-plus fa-4x  fa-inverse"></i>
                            <p>采购统计表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick = "mingxisum()">
                            <i class="fa fa-truck fa-4x  fa-inverse"></i>
                            <p>采购明细统计表</p> 
                        </a> 
                    </div>
                </div>
            </div> 
        </div>


        

        <div style="clear: both"></div>
        <!-- 注释：清除float产生浮动 -->
    </div>

    




</div>
<script type="text/javascript">
    nui.parse();
	var titb = null;
    var turlb = null;

function cailiaocaigou(){
	titb = "材料采购统计表";
    turlb = webPath+contextPath+"/report/partPurchaseSummary.jsp";
    openPaper(titb, turlb);
}

function gongyingshangrank(){
	titb = "采购排行榜";
    //turlb = webPath+contextPath+"/report/supplierPurcheseRanking.jsp";
    turlb = webPath+contextPath+"/com.hsweb.part.manage.purcharseRank.flow";
    openPaper(titb, turlb);
}

function caigousum(){
	titb = "采购统计表";
    turlb = webPath+contextPath+"/report/partSum.jsp";
    openPaper(titb, turlb);
}

function gongyingshangsum(){
	titb = "供应商材料采购统计表";
    turlb = webPath+contextPath+"/report/gongyingshangcailiaocaigousun.jsp";
    openPaper(titb, turlb);
}

function mingxisum(){
	titb = "采购明细统计表";
    turlb = webPath+contextPath+"/report/partmingxitongji.jsp";
    openPaper(titb, turlb);
}
function openPaper(tit, url) {
	var item={};
	item.id = tit;
	item.text = tit;
	item.url = url;
	window.parent.activeTab(item);
}   
</script>
</body>
s</html>