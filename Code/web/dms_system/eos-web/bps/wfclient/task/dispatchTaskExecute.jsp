<%@page import="org.gocom.bps.wfclient.common.ServiceFactory"%>
<%@page import="org.gocom.bps.wfclient.common.IWFBizFormForwardDriver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%
	long workItemID = Long.parseLong(request.getParameter("workItemID"));
	if(workItemID <= 0){
		return;
	}
	IWFBizFormForwardDriver manager = ServiceFactory.getWFBizFormForwardDriver();	
	request.setAttribute("workItemID", workItemID);
	if(manager.isForwardBizFormClient(workItemID)){
		//跳转到表单框架
		request.getRequestDispatcher(manager.queryURL4BizFormClient()).forward(request, response);
	}else{
		//按照原来的方式跳转
		request.getRequestDispatcher("forwardByWorkItem.jsp").forward(request, response);
	}
	out.clear();
	out = pageContext.pushBody();
%>