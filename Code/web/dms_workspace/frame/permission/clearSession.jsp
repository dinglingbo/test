<%
session.invalidate();
response.sendRedirect(request.getContextPath()+"/frame/permission/login.jsp");
%>