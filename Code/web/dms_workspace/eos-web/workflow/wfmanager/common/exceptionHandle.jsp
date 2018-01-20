<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%
	Object obj = DataContextManager.current().getDefaultContext().get("exception");
	if ( obj != null)
 		out.println(obj);
%>