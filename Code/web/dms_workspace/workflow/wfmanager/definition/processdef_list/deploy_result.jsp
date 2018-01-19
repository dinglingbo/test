<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
		function closeWin(){
			if(parent.G_NESTED) {
				parent.window.returnValue = '<%=request.getAttribute("result")%>' ;
				parent.window.close();
			} else {
				window.returnValue = '<%=request.getAttribute("result")%>' ;
				window.close() ;
			}
		}
	</script>
</head>
<body>
	<table border="1" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td><b:message key="deploy_result_jsp.results"/></td><!-- 结果 -->
			<td><b:message key="edit_process_info_jsp.processName"/></td><!-- 流程名称 -->
			<td><b:message key="deploy_result_jsp.resultInfoAndNote"/></td><!-- 结果信息与备注 -->
		</tr>
		<l:present property="deployResult">
				<tr>
				    <l:iterate id="result" property="deployResult">
						<td><b:write iterateId="result" property="/"/></td>
				    </l:iterate>
				</tr>
		</l:present>
		
		<tr>
			<td colspan="3" align="center">
				<input type="button" name="" value="<b:message key="edit_autoact_info_jsp.ok"/>" onclick="closeWin()"><!-- 确定 -->
			</td>
		</tr>
	</table>
</body>
</html>	