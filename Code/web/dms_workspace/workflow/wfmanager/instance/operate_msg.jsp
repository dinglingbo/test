<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/wfcomponent/web/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<%
	int operateType = request.getParameter("operateType") != null ? 
							Integer.valueOf(request.getParameter("operateType")) : -1;
	String promptMessageKey = "";
	String alertMessageKey_error = "";
	switch(operateType) {
	case 1:
		promptMessageKey = "operate_msp_jsp.input_press_message";
		alertMessageKey_error = "operate_msp_jsp.input_press_message_alert";
		break;
	case 2:
		promptMessageKey = "operate_msp_jsp.input_annotation_message";
		alertMessageKey_error = "operate_msp_jsp.input_annotation_message_alert";
		break;
	}
 %>
<script>
	function save(){
		var message = $id(pressMessage).value;
		if(trim(message) == ""){
			alert("<b:message key="<%=alertMessageKey_error %>"/>");//请输入  信息
			return;
		}
		returnValues.push(message);
		closeWindowAndReturnValue(1);
	}
	function cancel(){
		closeWindowOnly();
	}
	function trim(str){ //删除左右两端的空格
　　     	return str.replace(/(^\s*)|(\s*$)/g, "");
　　 	}
	function checkInputLength(){
	var message = $id(pressMessage).value;
	var length=getLength(message);
		if (length > 300){
       		$id(pressMessage).value = message.substring(0, 300);
		}
	}
	function getLength(name){
        	var len = 0; 
			name = name.split(""); 
			for (var i=0;i<name.length;i++) { 
				if (name[i].charCodeAt(0)<299) { 
					len++; 
				} else { 
					len+=2; 
				} 
			} 
			return len; 
        }
	
	
</script>
<body>
<div width="550" height="100%" >
	<table>
		<tr>
		    <th width="550" height="100%" style="text-align:left;"><b:message key="<%=promptMessageKey %>"/></th><%-- 请输入    信息 --%>
	  	</tr>
		<tr>
			<td width="550" height="100%" valign="middle"> 
		   		<h:textarea name="pressMessage" id="pressMessage" cols="65" rows="12" style="font-family:黑体;font-size:12pt;overflow:hidden;resize:none" onkeydown="checkInputLength()" onkeyup="checkInputLength()"/>
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
