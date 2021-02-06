<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-14 15:46:04
  - Description:
-->
<head>
<title>myMessage</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/query/stat/js/myMessage.js?v=1.0.0"></script>
    
</head>
<body>
         <div id ="tabs" class="nui-tabs" width="100%" height="100%">
					<div title="我的消息提醒" >
						<div id="workOrder"  dataField="data" class="nui-datagrid" style="width: 100%; height: 100%;" 
						showPager="true" pageSize="20" 
						sizeList=[20,50,100,200]
						 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" 
						 allowSortColumn="false"
						 totalField="page.count"
						 >
							<div property="columns">
								<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
								<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
								<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
								<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
								<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
								<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
								<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
									发生日期</div>
							</div>
						</div>
				</div>
				<div title="我的反馈记录" url="<%=request.getContextPath() %>/com.hs.common.userFeedbackList.flow">
		        </div>
		        <div title="系统更新日志" url="<%=request.getContextPath() %>/common/updateLogList.jsp">
		        </div>
       </div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>