<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-05 15:21:02
  - Description:
-->
<head>
<title>发送短信</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
 a:link {
	width: 300px;
	height: 50px;
	font-size: 20px;
	background: #8EE5EE;
	color: #fff;
	text-align: center;
	border-radius: 5px;
	display: block;
	line-height: 2;
	text-decoration: none;
	 margin:0 5px;
} 

a:active,a:hover{
	width: 300px;
	height: 50px;
	font-size: 20px;
	background: #836FFF;
	color: #fff;
	text-align: center;
	display: block;
	border-radius: 5px;
	text-decoration: none;
	line-height: 2;

} 

			span.xiao{
				margin-top: 80px;
				font-size: 15px;
				font-weight:bold;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.da{
				white-space: nowrap;
				display: inline-block;
				line-height: 0.9; 
				margin-top: 40px;
				font-size: 30px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}
			#btn {
					margin-top: 20px;
					position: absolute;
					display: block;
					width: 330px;
					height: 600px;
					background-color: #FFF;
					down:50px;
					padding-bottom: 20px;	
            		border-radius: 25px;
				}
    </style>
</head>
<body>
	<div align="center" style="width: 100%;height: 70%">
		<span class="xiao">官方活动短信推送</span><br>
		<img src="images/10.jpg" width="120px" height="80px" text-align="center"/><br>
		<span class="da">本次短信发送费用折后 RMB 146.35</span><br>
		<span class="xiao">本次推送人数998人</span><br>
		
	</div>
			<div id="btn" align="center" style="width:100%">
				<table>
					<tr>
						<td>
							<a href="" onclick="return false;"  >暂不发送</a>
						</td>
						<td>
							<a href="" onclick="return false;"  >立即发送</a>
						</td>
					</tr>
				</table>  
			</div>
				

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>