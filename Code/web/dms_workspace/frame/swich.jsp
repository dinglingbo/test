<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/frame/common/common.jsp"%>
<%
String contextPath = request.getContextPath();
%>
<BODY onclick="shift_status()" leftmargin=0 topmargin=0 style="cursor:hand;background:url(<%=contextPath%>/images/leftBar/MainFrameBg.gif) repeat-x;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="middle">
    <img src="<%=contextPath%>/images/leftBar/arrow_left.gif" id="menuSwitch1">
    </td>
  </tr>
</table>
<script language="JavaScript">
var flag = false;
function shift_status()
{
	if(flag)
	{
		parent.document.getElementById("fst").cols = "180,8,*";
		document.getElementById("menuSwitch1").src='<%=contextPath%>/images/leftBar/arrow_left.gif';
		document.getElementById("menuSwitch1").title='隐藏';
	}
	else
	{
		parent.document.getElementById("fst").cols = "0,8,*";
		document.getElementById("menuSwitch1").src='../images/leftBar/arrow_right.gif';
		document.getElementById("menuSwitch1").title='显示';
	}
	flag = !flag;
}
</script>
</body>
