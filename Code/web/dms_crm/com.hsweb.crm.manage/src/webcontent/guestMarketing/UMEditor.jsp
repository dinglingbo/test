<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<!-- 
  - Author(s): localhost
  - Date: 2018-08-01 10:10:32
  - Description:
-->
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
   <link href="http://ueditor.baidu.com/umeditor/themes/default/css/umeditor.min.css" rel="stylesheet" type="text/css" />    
         <script src="http://ueditor.baidu.com/umeditor/third-party/template.min.js" type="text/javascript"></script>
         <script src="http://ueditor.baidu.com/umeditor/umeditor.config.js" type="text/javascript"></script>
         <script src="http://ueditor.baidu.com/umeditor/umeditor.min.js" type="text/javascript"></script>
</head>
<body>
        <div style="padding:5px">文本编辑器：</div>
         <div type="text/plain" id="myEditor" style="height:300px" Readonly="true"></div>

	<script type="text/javascript">
    	nui.parse();
    	
    </script>
</body>
</html>