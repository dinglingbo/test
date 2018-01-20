<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/wfcomponent/web/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<%
	int operateType = request.getParameter("operateType") != null ? 
							Integer.valueOf(request.getParameter("operateType")) : -1;
	String promptMessageKey = "";
	switch(operateType) {
	case 1:
		promptMessageKey = "input_press_message";
		break;
	case 2:
		promptMessageKey = "input_annotation_message";
		break;
	}
 %>
<script>
	function save(){
		var message = $id(pressMessage).value;
		returnValues.push(message);
		closeWindowAndReturnValue(1);
	}
	function cancel(){
		closeWindowOnly();
	}
</script>
<body>
<div width="428" height="100%" >
	<table>
		<tr>
		    <th width="415" height="100%" style="text-align:left;"><b:message key="<%=promptMessageKey %>"/></th><%-- 请输入    信息 --%>
	  	</tr>
		<tr>
			<td width="415" height="100%" valign="middle"> 
		   		<h:textarea name="pressMessage" id="pressMessage" cols="67" rows="20" />
			</td>
		</tr>
		<tr>
		    <td align="center" colspan="4"  valign="baseline">
		    <input type="button" id="okBtn" class="button" name="close" value="<b:message key="input_message_jsp.save"/>" onClick="save()"><%-- 保存 --%>
					&nbsp;<input type="button" id="cancelBtn" class="button" name="close" value="<b:message key="input_message_jsp.cancel"/>" onClick="cancel()"><%-- 取消 --%>
			</td>
	  	</tr>
	</table>
</div>
</body>
