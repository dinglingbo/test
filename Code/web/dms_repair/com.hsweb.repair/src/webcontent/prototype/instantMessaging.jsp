<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-06 15:15:08
  - Description:
-->
<head>
<title>即时消息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
   <style type="text/css">
   		body{
   			background-color: #CCC;
   		}
   		.guest{
					position: absolute;
					display: block;
					width: 20%;
					height: 100%;
					background-color: #FFF;
					top: 0px;
					left: 0px;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
   		}
   		   		.msg{
					position: absolute;
					display: block;
					width: 79%;
					height: 70%;
					background-color: #FFF;
					top: 0px;
					left: 20.5%;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
   		}
   		   		   .mymsg{
					position: absolute;
					display: block;
					width: 79%;
					height: 29%;
					background-color: #FFF;
					top: 70.5%;
					left: 20.5%;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
   		}
   </style>
</head>
<body>
	<div class="guest">
	
	</div>
	<div class="msg">
		
	</div>
	<div class="mymsg">
	
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>