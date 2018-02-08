<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 14:49:18
  - Description:
-->
<head>
<title>满意度调研</title>
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
		    			<div field="" width="70px" headerAlign="center" allowSort="true">车牌号</div>
		    			<div field="" width="50px" headerAlign="center" allowSort="true">联系人</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">调研方式</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">调研日期</div>
		    			<div field="" width="100px" headerAlign="center" allowSort="true">接车速度满意度</div>
		    			<div field="" width="100px" headerAlign="center" allowSort="true">提车速度满意度</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">环境满意度</div>
		    			<div field="" width="130px" headerAlign="center" allowSort="true">修后车辆状况满意度</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">质量满意度</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">服务满意度</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">时间满意度</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">价格满意度</div>
		    			<div field="" width="200px" headerAlign="center" allowSort="true">调研内容</div>
		    			<div field="" width="50px" headerAlign="center" allowSort="true">调研人</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">工单号</div>
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