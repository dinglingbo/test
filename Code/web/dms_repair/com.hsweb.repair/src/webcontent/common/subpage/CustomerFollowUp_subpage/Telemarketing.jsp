<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 14:21:04
  - Description:
-->
<head>
<title>电话销售</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0;padding: 0;height: 100%;width: 100%">
	<div  class="nui-datagrid" dataField="data" url="" style="height: 100%;width: 100%" showPager="false">
	    <div property="columns">
	    	<div type="indexcolumn" width="30px" headerAlign="center">序号</div>
	    	<div header="&nbsp" headerAlign="center">
	    		<div property="columns">
	    			<div field="" width="50px" headerAlign="center" allowSort="true">车牌号</div>
	    			<div field="" width="60px" headerAlign="center" allowSort="true">客户名称</div>
	    			<div field="" width="50px" headerAlign="center" allowSort="true">联系人</div>
	    			<div field="" width="80px" headerAlign="center" allowSort="true">联系日期</div>
	    			<div field="" width="60px" headerAlign="center" allowSort="true">联系结果</div>
	    			<div field="" width="60px" headerAlign="center" allowSort="true">联系方式</div>
	    			<div field="" width="350px" headerAlign="center" allowSort="true">联系内容</div>
	    		</div>
	    	</div>
	   </div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>