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
  <title>仓库报表</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
  <link href="<%=request.getContextPath()%>/cw/TextIndex.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
  <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <%@include file="/common/common.jsp"%>
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
                        <a onclick="churuku()">
                            <i class="fa fa-rocket fa-4x  fa-inverse"></i>
                            <p>材料出入库明细</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="churukuhuizong()">
                            <i class="fa fa-cart-plus fa-4x  fa-inverse"></i>
                            <p>材料出入库汇总</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="cailiaolishi()">
                            <i class="fa fa-calendar-plus-o fa-4x  fa-inverse"></i>
                            <p>材料历史库存汇总表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="cailiaozhouzhuan()">
                            <i class="fa fa-search-plus fa-4x  fa-inverse"></i>
                            <p>材料周转明细表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="kucunzhouzhuan()">
                            <i class="fa fa-search-plus fa-4x  fa-inverse"></i>
                            <p>材料库存周转汇总表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="kucunzhuangkuang()">
                            <i class="fa fa-truck fa-4x  fa-inverse"></i>
                            <p>材料库存状况明细表</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="tiaobomingxi()">
                            <i class="fa fa-copy fa-4x  fa-inverse"></i>
                            <p>材料调拨明细</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="savekucun()">
                            <i class="fa fa-calculator fa-4x  fa-inverse"></i>
                            <p>安全库存预警</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="daizhipin()">
                            <i class="fa fa-credit-card fa-4x  fa-inverse"></i>
                            <p>呆滞品统计分析</p> 
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

function churuku(){
	titb = "材料出入库明细";
    turlb = "report/ck/cailiaochurukumingxi.jsp";
    openPaper(titb, turlb);
}

function churukuhuizong(){
	titb = "材料出入库汇总表";
    turlb = "report/ck/cailiaochurukumingxi.jsp";
    openPaper(titb, turlb);
}

function cailiaolishi(){
	titb = "材料历史库存汇总表";
    turlb = "report/ck/cailiaolishikucun.jsp";
    openPaper(titb, turlb);
}

function cailiaozhouzhuan(){
	titb = "材料周转明细表";
    turlb = "report/ck/cailiaozhouzhuanmingxi.jsp";
    openPaper(titb, turlb);
}

function kucunzhouzhuan(){
	titb = "材料库存周转汇总表";
    turlb = "report/ck/cailiaokucunzhouzhuanhuizong.jsp";
    openPaper(titb, turlb);
}

function kucunzhuangkuang(){
	titb = "材料库存状况明细表";
    turlb = "report/ck/cailiaokucunzhuangkuang.jsp";
    openPaper(titb, turlb);
}

function tiaobomingxi(){
	titb = "材料调拨明细";
    turlb = "report/ck/cailiaotiaobomingxi.jsp";
    openPaper(titb, turlb);
}

function savekucun(){
	titb = "安全库存预警";
    turlb = "report/ck/savekucunyubao.jsp";
    openPaper(titb, turlb);
}

function daizhipin(){
	titb = "呆滞品统计分析";
    turlb = "report/ck/daizhipintongjifenxi.jsp";
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