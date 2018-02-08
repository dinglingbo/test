<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 15:38:44
  - Description:
-->
<head>
<title>销售3DC回访</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0;padding: 0;height: 100%;width: 100%">
	<div class="nui-fit">
		<div  class="nui-datagrid" dataField="data" url="" style="height: 100%;width: 100%" showPager="false">
		    <div property="columns">
		    	<div header="客户信息" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="60px" headerAlign="center" allowSort="true">客户名称</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">离店日期</div>
		    		</div>
		    	</div>
		    	<div header="客户信息" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="70px" headerAlign="center" allowSort="true">品牌</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">车型</div>
		    			<div field="" width="50px" headerAlign="center" allowSort="true">规格</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">外观颜色</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">内饰颜色</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">期望价格</div>
		    			<div field="" width="150px" headerAlign="center" allowSort="true">配置</div>
		    		</div>
		    	</div>
		    	<div header="" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="60px" headerAlign="center" allowSort="true">跟进人</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">跟进日期</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">跟踪方式</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">跟踪状态</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">跟踪结果</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">关系阶段</div>
		    			<div field="" width="150px" headerAlign="center" allowSort="true">需求内容</div>
		    			<div field="" width="150px" headerAlign="center" allowSort="true">行动内容</div>
		    			<div field="" width="130px" headerAlign="center" allowSort="true">后续措施</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">战败原因</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">下次预约时间</div>
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