<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String delegate = ResourcesMessageUtil.getI18nResourceMessage("delegate_workitem_jsp.delegate_");
String help = ResourcesMessageUtil.getI18nResourceMessage("delegate_workitem_jsp.help");
String select = ResourcesMessageUtil.getI18nResourceMessage("delegate_workitem_jsp.select");
 %>
<html>
<head>
<title><b:message key="delegate_set_list_jsp.delegate_task"/></title><%-- 代办任务 --%>
<script>
function init() {
	//FIXME: document.getElementById  --> $id
	var arg = window["dialogArguments"] ;
	$id('buttonOK').onclick = function () {
		 var temp = $id('reason').value;
		 if(trim(temp)=='')
		 	temp="<b:message key="delegate_workitem_jsp.none"/>";//无
		 	
		 if(trim($id("participant").value)==''){
		 	alert("<b:message key="delegate_workitem_jsp.select_delegate"/>");//请选择代办人
		 	return;
		 }	
		 returnValue = new Array();
		 returnValue[0] = $e('delegType').value ;
		 returnValue[1] = temp ;
		 returnValue[2] = getElementsByNameEx("wfps");
		 window.close() ;
	}
}
</script>
</head>
<body marginheight="0" marginwidth="0" leftmargin="0" rightmargin="0" onload="init()">
<form action="" name="frm">
<table width="497" border="0" cellspacing="0" cellpadding="0" class="EOS_panel_body" height="100%">
  <tr>
    <td class="EOS_panel_head" valign="middle" colspan="2"><b:message key="delegate_workitem_jsp.set_delegate_task"/></td><%-- 设置代办任务 --%>
  </tr>
  <tr>
    <td class="EOS_table_row" nowrap="nowrap" width="15%">&nbsp;&nbsp;<b:message key="delegate_workitem_jsp.delegate"/></td><%-- 代办人: --%>
    <td class="EOS_table_row">
		<input id="participant" name="participant" type="text" size="40" class="textbox" readonly="readonly">
		<wf:selectParticipant form="frm" styleClass="button" output="participant" root="" value="<%=select %>" hidden="wfps" hiddenType="PARTICIPANT"><%-- 选择... --%>
		</wf:selectParticipant><font style="color:red">*</font>
    </td>
   </tr>
   <tr>
    <td nowrap="nowrap" class="EOS_table_row" width="15%">&nbsp;&nbsp;<b:message key="delegate_workitem_jsp.delegate_style"/></td><%-- 代办方式: --%>
	<td nowrap="nowrap">
		<h:select property="delegType" id="delegType">
			<h:option label="<%=delegate %>" value="DELEG"></h:option><%-- 代办 --%>
			<h:option label="<%=help %>" value="HELP"></h:option><%-- 协办 --%>
		</h:select>
	</td>
   </tr>
   <tr>
    <td class="EOS_table_row" nowrap="nowrap" width="15%">&nbsp;&nbsp;<b:message key="delegate_workitem_jsp.delegate_reason"/></td><%-- 代办原因: --%>
    <td class="EOS_table_row">
		<textarea rows="10" cols="50" id="reason" class="textbox" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
    </td>
  </tr>
  <tr>
    <td class="EOS_table_row" align="center" colspan="2">
		<input type="button" id="buttonOK" value="<b:message key="delegate_workitem_jsp.ok"/>" class="button"> <input type="reset" id="resetBtn" value="<b:message key="delegate_workitem_jsp.reset"/>" class="button">	<input type="button" id="cancelBtn" value="<b:message key="delegate_workitem_jsp.cancel"/>" class="button" onclick="window.close();"><%-- 确定/重置/取消 --%>
    </td>
  </tr>
</table>
</form>
</body>
</html>