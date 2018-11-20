<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 11:31:52
  - Description:
-->
<head>
<title>车辆分析</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/echarts.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
    
</head>
<body>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>