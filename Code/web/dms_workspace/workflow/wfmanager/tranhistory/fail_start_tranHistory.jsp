<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<HTML>
<HEAD>
<TITLE><b:message key="current_tran_info_jsp.his_tran_proc_info"/></TITLE>
<script language="javascript">
</script>
<body>

<form method="post" name="tranhistoryForm"   action="com.primeton.workflow.manager.tranhistory.startTranHistory.flow" ><input
	type="hidden" name="_eosFlowAction"> <input type="hidden"
	name="type">
<table border="0" cellpadding="0" cellspacing="0" class="workarea"
	width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="last_tran_info_jsp.his_data_tran"/></td>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
						<table width="100%" height="20%" border="0" cellpadding="0"
							cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="fail_start_tran_history_jsp.opt_result"/></td>
								<td height="26" nowrap="nowrap"><b:write property="result/message" /></td>
							</tr>
							<!--tr>
								<td colspan="2" class="form_bottom">
								<A href="javascript:history.go(-1);">返回</A>
								</td>
							</tr-->
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</HTML>