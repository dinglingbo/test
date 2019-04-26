<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
-->

<head>
    <title>播放语音文件</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "微软雅黑";
            background-color:cadetblue
        }
    </style>
</head>

<body >

<video controls="" autoplay="" name="media" style="width:400px;">
<source src="http://test.file.recency.cn/auto-record-20190313-3fd0f9af-5114-432d-8d61-ec74698e8db2.wav?sign=975fab600906e63d71ebfcdcf43c5757&amp;t=5cc04a50" type="audio/x-wav">
</video>
  
    <script type="text/javascript">
       

        function onCancel() {
            CloseWindow("cancel");
        }

        function CloseWindow(action) {
            if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                window.close();
        }
    </script>
</body>

</html>