<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/wfmanager/query/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("query_procInst_jsp.select");
String pleaseSelect = ResourcesMessageUtil.getI18nResourceMessage("query_procInst_jsp.please_select");
String length = ResourcesMessageUtil.getI18nResourceMessage("query_procInst_jsp.length_lessthan_nineteen");
 %>
<table height="100%" border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%">
		<h:form name="queryForm" action="com.primeton.workflow.manager.tranhistory.queryTranHistoryStatus.flow?_eosFlowAction=action0"
			method="post" target="transHistoryResult">
			<table class="workarea" width="100%">
				<tr>
					<td class="workarea_title"><b:message key="last_tran_info_jsp.select_server"/></td><%-- 查询条件 --%>
				</tr>
				<tr>
					<td>
					<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
						<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="form_table" width="100%">
							<tr>
								<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="login_jsp.server"/></td><%-- 流程实例ID: --%>
								<td nowrap="nowrap" style="padding-left:15px">
								<h:select id="clientID" property="clientID" style="width:170px" onchange="changeTip(this);">
									<option title="<b:message key="login_jsp.pleaseSelectDescription"/>" value=""><b:message key="login_jsp.pleaseSelect"/></option>
									<l:iterate id="ps" property="pss">
										<h:option labelField="name" iterateId="ps" valueField="id" />
									</l:iterate>
								</h:select>
								</td>
							</tr>
						</table>
					</td></tr></table>
					</td>
				</tr>			
			</table>
		</h:form>
		</td>
	</tr> 
	</table>
	</td>
	</tr>
	<tr height="800px">
		<td valign="top" align="center" style="padding-top:10px">
		<iframe width="100%" height="100%" marginHeight="0" frameBorder="0" marginWidth="0"	name="transHistoryResult" align="top"></iframe>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>
<script type="text/javascript">
	window.onload = function (){
		$name("queryForm").submit();
	}
	function changeTip(list){
		//list.title = list.options[list.selectedIndex].title;
		$name("queryForm").submit();
	}
</script>
<%@include file="/workflow/wfmanager/query/tail.jsp"%>
