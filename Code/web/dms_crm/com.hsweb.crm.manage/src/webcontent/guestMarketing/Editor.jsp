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
    <script src="http://kindeditor.net/ke4/kindeditor-all-min.js?t=20160331.js" type="text/javascript"></script>

    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }

</style>
</head>
<body>
                    
         <div name="editor" id="editor" rows="1000" cols="80" style="width:100%;height:100%"></div>
                    


	<script type="text/javascript">
    	nui.parse();
    	var editor = KindEditor.create('#editor');
    	
    </script>
</body>
</html>