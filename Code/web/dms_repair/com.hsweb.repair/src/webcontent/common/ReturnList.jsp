<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-07 10:23:36
  - Description:
-->
<head>
<title>返单页面</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#cs{
    		width:410px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table style="width:100%;">
		<tr style=" display:block;margin:25px 5px 0 5px">
			<td>
				<label>当前进程：</label>
			</td>
			<td>
				<input id="cs" class="nui-combobox" textField="" url="" valueField=""/>
			</td>
		</tr>
		<tr style=" display:block;margin:20px 5px 0 5px">
			<td>
				<label style="color: #AA0000">返入进程：</label>
			</td>
			<td>
				<input id="cs" class="nui-combobox" textField="" url="" valueField=""/>
			</td>
		</tr>
		<tr >
			<td style="text-align: right;">
				<a class="nui-button" onclick="onOk" style="margin-right:10px; margin-top: 15px ;width:60px">确定(Y)</a> 
				<a class="nui-button" onclick="onOk" style="margin-right:10px; margin-top: 15px ;width:60px">关闭(C)</a>     
			</td>
		</tr>
	</table>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>