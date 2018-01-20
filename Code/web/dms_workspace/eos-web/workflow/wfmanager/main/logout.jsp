<%
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/workflow/index.jsp");
 %>