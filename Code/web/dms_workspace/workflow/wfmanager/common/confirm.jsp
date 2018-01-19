<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<script>
	function init () {
		var msg =  window["dialogArguments"] ;	
		//FIXME:Firefox不支持InnerText需要用textContent代替		
		if(document.all){
			obj('message').innerText = msg;
		}else{
			obj('message').textContent = msg ;	
		}
	}
	
	function confirmForm(cf) {
		window.returnValue = cf;
		window.close();
	}
	
</script>

<html>
	<body onload="init()">
		 <table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center"> 
					 <div style="margin-top:10px;margin-left:5px;height:175px">
					 	<span id="message">
							 
						</span>
					 </div>
					 
					 <div style="margin-top:10px; margin-left:5px;">
					 	<button class="button" id="submit" onclick="confirmForm('true')"><b:message key="confirm_jsp.ok"/></button>&nbsp;&nbsp;<%-- 确定 --%>
						<button class="button" id="cancel" onclick="confirmForm('false')"><b:message key="confirm_jsp.cancel"/></button><%-- 取消 --%>
					 </div>
					</td>
				</tr>
		 </table>
	</body>
</html>