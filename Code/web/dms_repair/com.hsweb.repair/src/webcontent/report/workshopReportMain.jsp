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
  <title>车间报表</title>
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
                        <a>
                            <i class="fa fa-rocket fa-4x  fa-inverse"></i>
                            <p>施工项目明细</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-cart-plus fa-4x  fa-inverse"></i>
                            <p>施工项目明细（实收）</p> 
                        </a> 

                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-calendar-plus-o fa-4x  fa-inverse"></i>
                            <p>施工项目汇总表</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-search-plus fa-4x  fa-inverse"></i>
                            <p>施工项目汇总表（实收）</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-search-plus fa-4x  fa-inverse"></i>
                            <p>施工项目状况表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a>
                            <i class="fa fa-calculator fa-4x  fa-inverse"></i>
                            <p>查车施工状况表</p> 
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

</script>
</body>
s</html>