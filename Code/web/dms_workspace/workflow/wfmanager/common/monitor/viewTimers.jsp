
<%@page import = "com.primeton.workflow.api.*,com.primeton.workflow.api.engine.*,com.primeton.workflow.model.rt.das.*"%>
<%
	out.println("<pre>");
		out.println(ServiceFactory.getTimerService().getTimerString());
		out.println("</pre>");

%>
