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
    <style type="text/css">
    	.tips {
    color: #8a6d3b;
    background-color: #fcf8e3;
    border-color: #faebcc;
}
    </style>
</head>
<body style="margin:0;width: 98%; height:100%;overflow-x:hidden">	
	<div class="tips">
		<span class="fa fa-exclamation-triangle fa-lg"></span>数据导入功能通常只在系统初次使用时使用，导入完成后数据无法撤回，请检查数据正确性，谨慎操作！<br>
		<span class="fa fa-exclamation-triangle fa-lg"></span>数据导入前请下载我们的导入模板整理文件,选中文件时会加载几秒，导入需要大概一分钟，请耐心等待！<br>
		<span class="fa fa-exclamation-triangle fa-lg"></span>每次导入最多4000条数据， 如果数量超过4000，请分批导入，规定 导入时间为19:00:00-07:00:00<br>
		<span class="fa fa-exclamation-triangle fa-lg"></span>表头标*为必填项，请按正常数据格式整理文件（如：数量请用数字，勿用中文.日期格式：2018-10-24）。<br>
	</div>
	<div id ="tabs" class="nui-tabs" width="100%" height="100%">
		<div title="客户导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importGuest.jsp">
		</div>
		<div title="电销客户导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importTelTrackGuest.jsp">
		</div>
<%-- 		<div title="按电话号码导入储值卡" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importCardByMobile.jsp">
		</div> --%>
		<div title="按车牌号导入储值卡" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importCardByCarNo.jsp">
		</div>
		<div title="计次卡导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importTimesCard.jsp">
		</div>
		<div title="配件导入" url="<%=request.getContextPath() %>/baseDataPart/importPartCommon.jsp">
		</div>
		<div title="供应商导入" url="<%=request.getContextPath() %>/baseDataPart/importSupplier_view0.jsp">
		
		</div>
		<div title="工单导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/oldMaintain.jsp">
		</div>
		<div title="工单项目导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/oldItem.jsp">
		</div>
		<div title="工单配件导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/oldPart.jsp">
		</div>
		<div title="员工导入" url="<%=request.getContextPath() %>/common/importEmployee_view0.jsp">
		</div>
<%-- 		<div title="预收预付导入" url="<%=request.getContextPath() %>/repair/RepairBusiness/CustomerProfile/importAdvance.jsp">
		</div>	 --%>	
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>