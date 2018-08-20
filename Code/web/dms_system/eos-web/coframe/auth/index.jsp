<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="org.gocom.components.coframe.tools.IConstants" %>
<%@page pageEncoding="UTF-8"%>
<%@include file="/common/sysCommon.jsp" %>

<%
	String skin = "outlookmenu";/* default */
	Object userObj = session.getAttribute("userObject");
	if(userObj != null){
		UserObject userObject = (UserObject)userObj;
		if(userObject.getAttributes().get(IConstants.MENU_TYPE) != null){
			skin = (String)userObject.getAttributes().get(IConstants.MENU_TYPE);
		}
	}
	
	response.sendRedirect(sysDomain + "/skins/"+skin+"/index.jsp");
 %>