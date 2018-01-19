<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%
String contextPath = request.getContextPath();
%>
<script type="text/javascript">
	var rootMenuSize ='<b:write property="rootMenuSize"/>';
	var firstMenuId = "";
	
	window.onload=function () {
		if (rootMenuSize > 0) {
			
			$id("menu").className="menu"+ rootMenuSize +"_1";
			$id("root_menu_1").className="root_menu_on_tab";
			
			if (rootMenuSize == 1)
				$id("menu_table").width=133;
			
			if (rootMenuSize == 2)
				$id("menu_table").width=258;
			
			if (rootMenuSize == 3)
				$id("menu_table").width=384;
			
			if (rootMenuSize == 4)
				$id("menu_table").width=509;
			
				
			firstMenuId = '<b:write property="rootMenus[1]/id"/>';
			defaultSubMenuId  = '<b:write property="rootMenus[1]/defaultSubMenuId"/>';
			url = "com.primeton.bps.workspace.frame.permission.TopSubMenu.flow?parentMenuId=" + firstMenuId + "&defaultSubMenuId=" + defaultSubMenuId;
			window.document.getElementById("sub").src = url;
		}
		else {
			$id("menu").className="menu0";
		}
	}
	
	function mouseOverMenu(index) {
		if ($id("root_menu_" + index).className=="root_menu") {
			$id("root_menu_" + index).className="root_menu_hover";
		}
	}
	
	function mouseOutMenu(index) {
		if ($id("root_menu_" + index).className=="root_menu_hover") {
			$id("root_menu_" + index).className="root_menu";
		}
	}
	
	function changeSubMenu(index, id, defaultSubMenuId) {
		$id("menu").className="menu"+ rootMenuSize + "_" + index;
		
		for (i=1; i <= rootMenuSize; i++) {
			$id("root_menu_" + i).className="root_menu";
		}
		
		$id("root_menu_" + index).className="root_menu_on_tab";
		
		url = "com.primeton.bps.workspace.frame.permission.TopSubMenu.flow?parentMenuId=" + id + "&defaultSubMenuId=" + defaultSubMenuId;;
		window.document.getElementById("sub").src = url;
	}
</script>
	<body class="frame_top_body" >
		<table cellpadding="0" cellspacing="0" style="background:url('<%=contextPath%>/images/Bar_bg.jpg');width:100%">
		  <tr> 
		    <td width="968" height="51" style="background:url('<%=contextPath%>/images/Bar.jpg') no-repeat;"></td>
		  </tr>
		</table>
		
    	<div id="greeting" class="greeting">
			<l:present property="ProcessSeverName" scope="session" >
				<b:message key="top_jsp.server"/><b:message key="wsp_punctuation.colon"/><b:write scope="session" property="ProcessSeverName" />&nbsp;,&nbsp;
			</l:present>
			<b:message key="top_jsp.welcome"/><b:message key="wsp_punctuation.colon"/><b:write scope="session" property="userObject/userName" />&nbsp;
			<%
				Object u=((UserObject)(session.getAttribute("userObject"))).get("TENANT_ID");
				if(u!=null){
					out.print("("+String.valueOf(u)+")");
				}
			%>
		
			&nbsp;|&nbsp;
			<a href="<%=request.getContextPath()%>/frame/permission/clearSession.jsp" class="greeting_link" target="_top"><b:message key="top_jsp.logout"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<div id="menu" class="menu0">
			<table id="menu_table">
				<tr height="25" align="center">
				<%int i=1;%>
				<l:iterate id="rootMenu" property="rootMenus">
					<td nowrap="nowrap" onmouseout="mouseOutMenu('<l:indexId start="1"/>')" onmouseover="mouseOverMenu('<l:indexId start="1"/>')" id="root_menu_<%=i%>" class="root_menu" valign="bottom" onclick="changeSubMenu('<l:indexId start="1"/>','<b:write iterateId="rootMenu" property="id" />','<b:write iterateId="rootMenu" property="defaultSubMenuId" />')"><b:write iterateId="rootMenu" property="name" /></td>
					<%i++;%>
				</l:iterate>
				</tr>
			</table>
		</div>
		<iframe align="top" id="sub" width="100%" height="95%" frameborder="0" scrolling="no" src=""></iframe>
	</body>
