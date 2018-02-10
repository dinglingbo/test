<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 11:59:13
  - Description:
-->
<head>
<title>选择样式（维修营业分析）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; ">
	<div  class="nui-tabs" style="width:100%;height:100%;" activeIndex="0">
	    <div title="系数">
	         <ul  class="nui-tree" resultAsTree="false" style="width:100%;height:100%;" idField="id" parentField="pid" textField="text" url="">
			</ul>
	    </div>
	   	<div title="选项">
	        <ul  class="nui-tree" resultAsTree="false" style="width:100%;height:100%;" idField="id" parentField="pid" textField="text" url="">
			</ul>
	    </div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>