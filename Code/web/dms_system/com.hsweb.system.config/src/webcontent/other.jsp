<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-01-15 14:06:57
  - Description:
-->
<head>
<title>其他</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div style="width: 80%; height: 10%; margin-left: 10%; margin-top: 1%;">
		<input  class="nui-button" onclick="platformSignIn" text="配件采购平台注册"  style="float:right; margin-top: 10px;"></input>		
	</div>


	<script type="text/javascript">
    	nui.parse();
    	function platformSignIn(){
    		window.open("http://192.168.111.58:8080/srm/supplier/cusRegister.html?id="+currOrgId);    
    	}
    </script>
</body>
</html>