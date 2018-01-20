<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<HTML>
<HEAD>
<TITLE></TITLE>
<script>
function promtForm(){
		document.tranhistoryForm.action="com.primeton.workflow.manager.tranhistory.startTranHistory.flow";
		document.tranhistoryForm._eosFlowAction.value="action0";
		document.tranhistoryForm.submit();
	}
</script>


</HEAD>
<body>
<form method="post" name="tranhistoryForm">
<input type="hidden" name="_eosFlowAction">
<input type="hidden" name="type">
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
									width="15%"><b:message key="last_tran_info_jsp.last_tran_status"/></td>
								<td height="26" nowrap="nowrap"><l:equal targetValue="NO" 
									property="result/status"><b:message key="last_tran_info_jsp.none"/></l:equal> <l:notEqual
									targetValue="NO" property="result/status">
									<b:write property="result/status" />
								</l:notEqual></td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="last_tran_info_jsp.last_start_time"/></td>
								<td height="26" nowrap="nowrap"><l:equal targetValue="NO"
									property="result/status"><b:message key="last_tran_info_jsp.none"/></l:equal> <l:notEqual
									targetValue="NO" property="result/status">
									<b:write property="result/beginTime" />
								</l:notEqual></td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="last_tran_info_jsp.last_comp_time"/></td>
								<td height="26" nowrap="nowrap"><l:equal targetValue="NO"
									property="result/status"><b:message key="last_tran_info_jsp.none"/></l:equal> <l:notEqual
									targetValue="NO" property="result/status">
									<b:write property="result/endTime" />
								</l:notEqual></td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="last_tran_info_jsp.last_tran_success_num"/></td>
								<td height="26" nowrap="nowrap"><l:equal targetValue="NO"
									property="result/status"><b:message key="last_tran_info_jsp.none"/></l:equal> <l:notEqual
									targetValue="NO" property="result/status">
									<b:write property="result/successNumber" />
								</l:notEqual></td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="last_tran_info_jsp.last_tran_total_num"/></td>
								<td height="26" nowrap="nowrap"><l:equal targetValue="NO"
									property="result/status"><b:message key="last_tran_info_jsp.none"/></l:equal> <l:notEqual
									targetValue="NO" property="result/status">
									<b:write property="result/totalNumber" />
								</l:notEqual></td>
							</tr>

							<tr>
								<td colspan="2" class="form_bottom">
								<input type="hidden" name="clientID" value='<b:write property="clientID" />' />
								<l:notEmpty property="clientID" >
								<input type="button"
									class="button" value='<b:message key="last_tran_info_jsp.execute_transfer"/>' onclick="promtForm()"></td>
								</l:notEmpty>
								<l:empty property="clientID" >
								<input type="button"
									class="button" disabled="disabled" value='<b:message key="last_tran_info_jsp.execute_transfer"/>' onclick="promtForm()"></td>
								</l:empty>
							</tr>
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
