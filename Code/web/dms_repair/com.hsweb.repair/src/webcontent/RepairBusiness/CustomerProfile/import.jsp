<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-12 16:25:08
  - Description:
-->
<head>
<title>导入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin:0;width: 98%; height:100%;overflow-x:hidden">	
	<div id ="tabs" class="nui-tabs" width="100%" height="100%">
		<div title="客户导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importGuest.jsp">
		</div>
		<div title="电销客户导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importTelTrackGuest.jsp">
		</div>
		<div title="按电话号码导入储值卡" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importCardByMobile.jsp">
		</div>
		<div title="按车牌号导入储值卡" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importCardByCarNo.jsp">
		</div>
		<div title="计次卡导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importTimesCard.jsp">
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>