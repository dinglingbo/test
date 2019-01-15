<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-01-14 16:51:17
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/common/js/qrcode.js" type="text/javascript"></script>
    
</head>
<body>

	<div id="qrcode"></div>

	<script type="text/javascript">
    	nui.parse();
    	
    	function guid() {
		    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
		        return v.toString(16);
		    });
		}
		
		var code = guid();
		
		// 设置参数方式 
		var qrcode = new QRCode('qrcode', { 
		  text: code, 
		  width: 256, 
		  height: 256, 
		  colorDark : '#000000', 
		  colorLight : '#ffffff', 
		  correctLevel : QRCode.CorrectLevel.H 
		});
		
		function testOne() {
			// 简单方式 
			new QRCode(document.getElementById('qrcode'), 'your content');
		}
    	
    	function testTwo() {
	    	 
    	}
    	
    	function testThree() {
    		qrcode.makeCode(code); 
    	}
    	
    	function clear() {
    		// 使用 API 
			qrcode.clear(); 
    	}
    	
		 
		 
		
		 
		
		
    </script>
</body>
</html>