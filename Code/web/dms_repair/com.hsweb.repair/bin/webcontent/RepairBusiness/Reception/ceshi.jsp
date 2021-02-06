<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-20 10:01:58
  - Description:
-->
<head>
<title>ceshi</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
<a class="nui-button" onclick="open()">dakai</a>



	<script type="text/javascript">
    	nui.parse();
    	function open(){
    	
    	nui.open({
		url :  webPath + contextPath + "/repair/RepairBusiness/Reception/Salesperson.jsp",
		title : "销售员选择",
		width : 600,
		height : 400,
		onload : function() {
				
		},
		ondestroy : function(action) {// 弹出页面关闭前
			if (action == "saveSuccess") {
				
			}
		}
	});
    	}
    </script>
</body>
</html>