<%@page pageEncoding="UTF-8"%>
<%@page import="com.primeton.workflow.commons.sql.monitor.DBMonoitorManager"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
	String sqlmonitor=ResourcesMessageUtil.getI18nResourceMessage("sql_jsp.sqlMonitor");
	String sqlmonitoroff=ResourcesMessageUtil.getI18nResourceMessage("sql_jsp.sqlMonitorOff");
	String parameters=ResourcesMessageUtil.getI18nResourceMessage("sql_jsp.parameters");
 %>
<html>
<head>
<title>sqlMonitor</title>
</head>
<%
String sOpen = request.getParameter("open"); 
boolean open = false;
if(sOpen!=null)		open = "true".equals(sOpen.toLowerCase() );
%>
<body>
<%
	if (open){
		DBMonoitorManager.setMonitor(true);
		out.println(sqlmonitor);//sql监控已开启！
	}
	else{
		DBMonoitorManager.setMonitor(false);
		out.println(sqlmonitoroff);//sql监控已关闭！
		out.println(parameters);//需要参数:open=true
	}			
 %>
</body>
</html>