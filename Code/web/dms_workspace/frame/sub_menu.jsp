<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<body leftmargin="2" topmargin="2" rightmargin="2" bottommargin="2" marginwidth="0" marginheight="0">
<w:tabPanel id="sub_menu_pane" width="100%" height="100%">
	<l:iterate id="subMenu" property="subMenus">
		<b:set iterateId="subMenu" name="tempId" property="id"/>
		<b:set iterateId="subMenu" name="tempName" property="name"/>
		<b:set iterateId="subMenu" name="tempUrl" property="url"/>
		<%
			String id = String.valueOf(request.getAttribute("tempId"));
			String name = String.valueOf(request.getAttribute("tempName"));
			String url = String.valueOf(request.getAttribute("tempUrl"));
		%>
		<w:tabPage id="<%=id%>" title="<%=name%>" url="<%=url%>" tabType="iframe">
		</w:tabPage>
	</l:iterate>
</w:tabPanel>
</body>
