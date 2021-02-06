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
<title>车间报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/workshopReport.js?v=1.0.0"></script>
      <link href="<%=request.getContextPath()%>/repair/js/report/storeReport/reportIndex.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div  id=""  > 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
				   <div class="menu_pannel menu_pannel_bg">
                        <a onclick="RepairCommissionDetailsMain()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i>
                            <p>员工提成明细表</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="projectConstructionDetail()">
                            <i class="fa fa-calendar fa-4x  fa-inverse"></i> 
                            <p>施工项目明细表</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="projectConstructionTotal()">
                            <i class="fa fa-bar-chart fa-4x  fa-inverse"></i>
                            <p>施工项目汇总表</p> 
                        </a> 

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