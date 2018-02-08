<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-05 12:01:56
  - Description:
-->
<head>
<title>材料优惠信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="height:100%;widht:100%;margin: 0;padding: 0">
	<div class="nui-fit">
		<div  class="nui-datagrid" dataField="data" url="" style="height: 100%;width: 100%">
		    <div property="columns">
		    	<div width="30px" headerAlign="center" allowSort="true" type="indexcolumn">
		    		序号
		    	</div>
		        <div field="" width="110px" headerAlign="center" allowSort="true">
		        	材料名称
		        </div>
		        <div field="" width="90px" headerAlign="center" allowSort="true" >
		        	收费类型
		        </div>
		        <div field="" width="90px" headerAlign="center" allowSort="true">
		        	数量
		        </div>
		        <div field="" width="80px" headerAlign="center" allowSort="true">
		        	单价
		        </div>
		        <div field="" width="80px" headerAlign="center" allowSort="true">
		        	金额
		        </div>
		        <div field="" width="90px" headerAlign="center" allowSort="true">
		        	优惠率
		        </div>
		        <div field="" width="90px" headerAlign="center" allowSort="true">
		        	优惠金额
		        </div>
		        <div field="" width="80px" headerAlign="center" allowSort="true">
		        	小计
		        </div>
		        <div field="" width="100px" headerAlign="center" allowSort="true">
		        	材料编码
		        </div>
		    </div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>