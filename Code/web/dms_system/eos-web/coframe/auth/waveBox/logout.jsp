<%@page pageEncoding="UTF-8"%>
<%@page import="com.eos.system.utility.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.eos.data.datacontext.UserObject"%>
<html>
<!-- 
  - Author(s): shitf
  - Date: 2013-03-16 09:55:30
  - Description:
-->
<head>

<title>退出系统</title>
</head>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
%>
<body>
  <%
     session.invalidate();
     String _url=StringUtil.htmlFilter(request.getParameter("_url"));
     
     if(_url==null){
     	_url=request.getContextPath()+"/coframe/auth/waveBox/login.jsp";
     }
     response.sendRedirect(_url);
   %>
</body>
</html>