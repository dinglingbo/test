<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-03 11:24:15
  - Description:
-->
<head>
<title>未修归档</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table>
		<tr style="display: block;margin:4px 0 0 5px;">
			<td style="width:85px">
				<label>未修原因类别：</label>
			</td>
			<td>
				<input class="nui-textbox" id="data"  width="280px" /> 
			</td>
		</tr>
		<tr style="display: block;margin:4px 0 0 5px;">
			<td style="width:85px">
				<label>未修原因说明：</label>
			</td>
			<td>
				<input class="nui-textArea" id="data"  width="280px" height="90px" /> 
			</td>
		</tr>
		<tr>
	    	<td>
	        	<div style="text-align:right;padding:2px 5px;">
		        	<a class="nui-button"  onclick="onSearch(3)" >保存(S)</a>
		            <a class="nui-button"  onclick="onSearch(4)" >关闭(C)</a>
	            </div> 	 	
	       	</td>
		</tr>
	</table>




	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>