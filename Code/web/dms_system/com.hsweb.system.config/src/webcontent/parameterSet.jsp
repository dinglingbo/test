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
      <div title="免责条款" name="reliefSet">
        <iframe src="reliefSet.jsp" width="100%" height="100%"></iframe>
      </div>

      <div title="业务分类" name="businessSort">
          <iframe src="businessSort.jsp" width="100%" height="100%"></iframe>
      </div>

      <div title="客户级别设置" name="userLevelSet">
        <iframe src="userLevelSet.jsp" width="100%" height="100%"></iframe>
      </div>

      <div title="客户级来源" name="userFrom">
        <iframe src="userFrom.jsp" width="100%" height="100%"></iframe>
      </div>      

      <div title="回访设置" name="visitSet">
        <iframe src="visitSet.jsp" width="100%" height="100%"></iframe>
      </div>

      <div title="汽车电子健康档案上传设置" name="carSet">
        <iframe src="carSet.jsp" width="100%" height="100%"></iframe>
      </div>

      <div title="检测模板设置" name="searchCarSet">
        <iframe src="searchCarSet.jsp" width="100%" height="100%"></iframe>
      </div>

      <div title="显示设置" name="showSet">
        <iframe src="showSet.jsp" width="100%" height="100%"></iframe>
      </div>

      <div title="提醒设置" name="alarmSet">
        <iframe src="alarmSet.jsp" width="100%" height="100%"></iframe>
      </div>
    </div>
  </body>
</html>