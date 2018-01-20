<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
	<% 
		String proId = request.getParameter("id") ;
		String proName = request.getParameter("name") ;
		String pkgId = request.getParameter("pkgId") ;
		String catalogUUID = request.getParameter("catalogUUID") ;
	%>
<head>
	<title></title>
	<script>
		function removeProcess () {
			var proId = '<%=proId%>' ;
			proId = proId.replace("\"",'');
			//FIXME: document.getElementById  --> $name
			$name('processDefId').value =proId ;
			submitForm('confirmForm'); // Chrome无法提交表单
			window.returnValue = "refresh";
			window.close();
		}
		function closeConfirmWindow(){
			returnValue = null ;
			window.close();
		}
		
		function closeWindowAndRefreshParent(){
			returnValue = "refresh" ;
			window.close();
		}
		function init() {
			hs = new HideSubmit ("com.primeton.workflow.manager.def.processdef.isHaveInstance.biz") ;
			var proId = '<%=proId%>' ;
			proId = proId.replace("\"",'');
			hs.addParam("processDefId",proId) ;
			hs.submit();
			var hasProcessInstance = hs.getValues("/root/data/isHaveProcessInstance") ;
			if(hasProcessInstance == "true") {
				showdiv(getdiv("wranning")) ;
			}
		}
	</script>
</head>
<body onload="init()">
	<form name="confirmForm" action="com.primeton.workflow.manager.def.removeProcessDef.flow" method="post" target="middle">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td align="center">
					<div id="wranning" style="padding-top:5px;text-align:center;visibility:hidden;">
						<label><b:message key="remove_pro_confirm_jsp.warn"/></label><%-- 警告:该流程定义包含流程实例,删除该流程会同时删除这些流程实例! --%>
					</div>
					
					<div style="padding-top:15px">
						<label><b:message key="remove_pro_confirm_jsp.confirm_del"/></label><%-- 确定要删除该流程吗？ --%>
					</div>
					<div style="padding-top:75px;">
						<input type="submit" name="submitit" value="<b:message key="remove_pro_confirm_jsp.ok"/>" class="button" 
							onclick="if(window.ActiveXObject){removeProcess();return false;}else{setTimeout(closeWindowAndRefreshParent,300)}"><%-- 确定 --%>
						&nbsp;<input type="button" name="cancel" value="<b:message key="remove_pro_confirm_jsp.cancel"/>" class="button"  onclick="closeConfirmWindow()"><%-- 取消 --%>
					</div>
				</td>
			</tr>
		</table>
		<input type="hidden" name="processDefId" value='<%=proId.replace("\"","") %>'>
		
		<h:hidden name="processDefName" property="name" />
		<h:hidden name="packageId" property="pkgId" />
		<h:hidden name="catalogUUID" property="catalogUUID" />
		
	</form>
</body>
</html>