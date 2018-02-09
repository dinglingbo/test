<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 15:09:41
  - Description:
-->
<head>
<title>流失回访</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0;padding: 0;height: 100%;width: 100%">
	<div class="nui-fit">
		<div  class="nui-datagrid" dataField="data" url="" style="height: 100%;width: 100%" showPager="false">
		    <div property="columns">
		    	<div type="indexcolumn" width="30px" headerAlign="center">序号</div>
		    	<div header="&nbsp" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="60px" headerAlign="center" allowSort="true">车牌号</div>
		    			<div field="" width="70px" headerAlign="center" allowSort="true">回访方式</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">回访日期</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">现在维修厂</div>
		    			<div field="" width="90px" headerAlign="center" allowSort="true">是否继续跟进</div>
		    			<div field="" width="90px" headerAlign="center" allowSort="true">下次跟进日期</div>
		    			<div field="" width="90px" headerAlign="center" allowSort="true">计划来厂日期</div>
		    			<div field="" width="90px" headerAlign="center" allowSort="true">不来厂主要原因</div>
		    			<div field="" width="90px" headerAlign="center" allowSort="true">不来厂次要原因</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">回访内容</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">回访人</div>
		    		</div>
		    	</div>
		   </div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>