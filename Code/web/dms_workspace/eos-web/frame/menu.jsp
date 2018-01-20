<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<body leftmargin="2" topmargin="2" rightmargin="2" bottommargin="2" marginwidth="0" marginheight="0">
<w:tabPanel id="root_menu_pane" width="100%" height="100%">
	<l:iterate id="rootMenu" property="rootMenus">
		<b:set iterateId="rootMenu" name="tempId" property="id"/>
		<b:set iterateId="rootMenu" name="tempName" property="name"/>
		<b:set iterateId="rootMenu" name="tempUrl" property="url"/>
		<%
			String id = String.valueOf(request.getAttribute("tempId"));
			String name = String.valueOf(request.getAttribute("tempName"));
			String url = String.valueOf(request.getAttribute("tempUrl"));
			if (url == null || "null".equalsIgnoreCase(url.trim()) || url.trim().length() == 0) {
				url = "com.primeton.bps.workspace.frame.permission.SubMenu.flow";
			}
		%>
		<w:tabPage id="<%=id%>" title="<%=name%>" url="<%=url%>" tabType="iframe" >
			<h:param name="parentMenuId" value="<%=id%>"></h:param>
		</w:tabPage>
	</l:iterate>
</w:tabPanel>
</body>
