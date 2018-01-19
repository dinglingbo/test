<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><b:message key="index_jsp.process_inst_manage"/></title><%-- 流程实例管理 --%>
</head>
<frameset cols="200,*" border="1" name="middleMain" id="middleMain">
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/instance/left.jsp" name="left" id="left"  frameborder="0" scrolling="no" marginheight="0" marginwidth="0"> 
  <frame src="<%=request.getContextPath()%>/workflow/wfmanager/instance/processinst_frame.jsp" name="middle" id="middle" scrolling="no"></frameset>
<noframes><body>
</body>
</noframes></html>
 			
