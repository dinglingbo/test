<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-01-14 15:51:36
  - Description:
-->
<head>
<title>客户退款管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <style type="text/css">
    	.tips {
    color: #8a6d3b;
    background-color: #fcf8e3;
    border-color: #faebcc;
}
    </style>
</head>
<body style="margin:0;width: 98%; height:100%;overflow-x:hidden">	

	<div id ="tabs" class="nui-tabs" width="100%" height="100%">
		<div title="储值卡退款" url="<%=request.getContextPath() %>/manage/settlement/statement/refundList.jsp">
		</div>
		<div title="计次卡退款" url="<%=request.getContextPath() %>/manage/settlement/statement/refundTimesCardList.jsp">
		</div>
		<div title="预收预付款列表" url="<%=request.getContextPath() %>/manage/settlement/statement/advanceList.jsp">
		</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>