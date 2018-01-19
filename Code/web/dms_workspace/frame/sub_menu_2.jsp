<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<script type="text/javascript">
	var subMenuSize ='<b:write property="subMenuSize"/>';
	var defaultSubMenuOrder ='<b:write property="defaultSubMenu/displayOrder"/>';
	var defaultSubMenuUrl ='<b:write property="defaultSubMenu/url"/>';
	
	window.onload=function () {
		if (subMenuSize > 0) {
			$id("sub_menu_" + defaultSubMenuOrder).className="sub_menu_td_on_tab";
			firstMenuUrl = '<%=request.getContextPath()%>' + defaultSubMenuUrl;
			firstMenuUrl = firstMenuUrl.replace(new RegExp("&amp;","gm"), "&");
			window.document.getElementById("main").src = firstMenuUrl;
		}
	}
	
	function mouseOverMenu(index) {
		if ($id("sub_menu_" + index).className=="sub_menu_td") {
			$id("sub_menu_" + index).className="sub_menu_td_hover";
		}
	}
	
	function mouseOutMenu(index) {
		if ($id("sub_menu_" + index).className=="sub_menu_td_hover") {
			$id("sub_menu_" + index).className="sub_menu_td";
		}
	}
	
	function showSubMenu(index, id, url) {
		for (i=1; i <= subMenuSize; i++) {
			$id("sub_menu_" + i).className="sub_menu_td";
		}
		
		$id("sub_menu_" + index).className="sub_menu_td_on_tab";
		
		var currentMenuUrl = '<%=request.getContextPath()%>' + url;
		window.document.getElementById("main").src = currentMenuUrl;
	}
	
	function reSizeiFrame(iframe) {
		if (isFF) {
			//alert("isFF");
			//alert(iframe.height);
			iframe.height = iframe.offsetHeight - 200;
			//alert(iframe.offsetHeight);
		}
	}
</script>
<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<div class="sub_menu">
<table>
	<tr>
		<%int i=1;%>
		<l:iterate id="subMenu" property="subMenus">
			<td nowrap="nowrap" class="sub_menu_td" id="sub_menu_<%=i%>" valign="middle" onmouseout="mouseOutMenu('<l:indexId start="1"/>')" onmouseover="mouseOverMenu('<l:indexId start="1"/>')" onclick="showSubMenu('<l:indexId start="1"/>','<b:write iterateId="subMenu" property="id" />','<b:write iterateId="subMenu" property="url" />')"><b:write iterateId="subMenu" property="name" /></td>
			<%i++;%>
		</l:iterate>
	</tr>
</table>
</div>
<iframe name="mainframe" id="main" align="top" width="100%" height="100%" frameborder="0" style="margin-left: 5px; padding-bottom: 65px;" marginheight="0" marginwidth="0" scrolling="auto" src=""></iframe>
</body>
