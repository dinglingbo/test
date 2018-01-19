<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/wfmanager/common/common.jsp"%>
<script>
	function init () {
		var msg =  window["dialogArguments"] ;
		obj('message').innerText = msg ;		
	}
	
	function closeWind() {
		window.returnValue = true;
		window.close();
	}
	
</script>

<html>
	<body onload="init()">
		<div style="margin-top:10px;">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center"><span id="message"></span></td>
				</tr>
			</table>
		</div>
		<div style="margin-top:10px; margin-left:5px; position:absolute; top: 175px;">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center">
						<button class="button" id="submit" onclick="closeWind()"><b:message key="notification_jsp.ok"/></button>&nbsp;&nbsp;<!-- 确定 -->
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>