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
<title>工作报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/workReport.js?v=1.0.0"></script>
      <link href="<%=request.getContextPath()%>/repair/js/report/storeReport/reportIndex.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div  id=""  > 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
				   <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailyQualityDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>质检日明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailyQualityTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i> 
                            <p>质检日汇总表</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailyReceptionDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>接待日明细表</p> 
                        </a> 

                    </div>
 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailyReceptionTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>接待日汇总表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailyTechnicianDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>技师日明细表</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="dailyTechnicianTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>技师日汇总表</p> 
                        </a> 
                    </div>
                    <div class="">

                    </div>
                    <div class="">

                    </div>
                    <div class="">

                    </div>

                    <div class="">

                    </div>
                </div>
                
            </div> 
        </div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>