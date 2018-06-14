<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>参数设置</title>
    

</head>
<body>

<div id="tabs1" class="nui-tabs" activeIndex="0" style="width:95%;height:100%; margin-left: 3%;  " plain="false">
    <div title="免责条款" >
  <%@ include file="/config/relief.jsp"%>
	</div>
    <div title="客户级别设置" >
    <%@ include file="/config/userLevelSet.jsp"%>
	 </div>
     <div title="回返设置" >
     	<%@ include file="/config/visitSet.jsp"%>
     </div>
     <div title="汽车电子健康档案上传设置" >	
     <%@ include file="/config/carSet.jsp"%>

     </div>
     <div title="查车模板设置" >
       <%@ include file="/config/searchCarSet.jsp"%>
   
     </div>
     <div title="显示设置" >
       <%@ include file="/config/showSet.jsp"%>
	
     </div>

</div>
	
</body>
 <script type="text/javascript">
      
		nui.parse();

      
       
  </script>
</html>