<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/frame/common/common.jsp"%>
<%
	String fileName = (String)request.getAttribute("fileName");
 %>
<%@page import="com.primeton.bps.workspace.frame.multitenancy.DownloadHelper"%>
<script>
	function downloadToken(action){
		if(!_validate()){
			return false;
		}
		$id("_eosFlowAction").value=action;
		$id("form1").submit();
	}
	
	function _validate(){
		return checkInput($id("adminPWD"));
	}
	
	function back(){
		$id("_eosFlowAction").value='download2cancel';
		$id("form1").submit();
	}
	
</script>
<form id="form1" method="post" action="com.primeton.bps.workspace.frame.multitenancy.MultiTenancyManager.flow">

	<h:hidden  property="tenantID" />
	<h:hidden id="_eosFlowDataContext" property="_eosFlowDataContext" />
	<h:hidden id="_eosFlowAction" property="_eosFlowAction" />
	
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="list_process_server_jsp.downloadToken"/></h3></td>
  </tr>
  <tr> 
    <td width="100%" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	<tr>
		<td class="form_label" width="10%">
		<b:message key="update_process_server_jsp.tenantPassword"/>
		</td>
		<td>
		<h:password id="adminPWD" property="adminPWD" validateAttr="allowNull=false;maxLength=20;minLength=6" onblur="checkInput(this)" filter="true" />
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<input id="btnOK" name="btnOK" type="button" value="<b:message key="change_password_jsp.btnOK"/>" class="button" onclick="downloadToken('download')"/>
		<input id="btnCancel" name="btnCancel" class="button" type="button" value="<b:message key='add_process_server_jsp.btnCancel'/>" onclick="back()">
		</td>
	</tr>
	</table>
	</td>
   </tr>
   <%
		if(null != fileName && fileName.endsWith("token")){
		%>
		 <tr> 
		    <td class="workarea_title" valign="middle"><h3><b:message key="update_process_server_jsp.download_tenant_file"/></h3></td>
		 </tr>
		<tr>
		 <td width="100%" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
		<tr>
			<td colspan="2">
				<a href="<%=request.getContextPath() %>/multitenancy/downloadFile.jsp?dirName=<%=DownloadHelper.TEMP_TOKEN %>&fileName=<%=fileName %>">primeton_tenant.token</a>
			</td>
		</tr>
		</table>
		</td>
		</tr>
		<%
		}
	 %>
</table>
</form>
<script>
	<%
		if("2".equals(fileName)){
			%>
				(function(){
					f_alert($id("adminPWD"),"<b:message key="update_process_server_jsp.adminPWD_error"/>");
				})();
			<%
		}
	 %>
</script>

