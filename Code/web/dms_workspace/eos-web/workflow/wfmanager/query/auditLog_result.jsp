<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title>auditLogResult</title>
</head>
<body
	style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:scroll; overflow-y:hidden; overflow-x: auto;">
<h:form name="resultForm" action="" method="post">
<table class="workarea" width="100%">
		<% int flag =0; String cls = "";%>
			<tr>
				<td class="EOS_panel_head"><b:message key="auditLog_result_jsp.audit_log_info"/></td><%-- 审计日志信息 --%>
			</tr>
			<tr>
				<td>
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td>
						<table border="0" class="EOS_table" width="100%">
							<tr class="EOS_table_head">
								<th  nowrap="nowrap"><b:message key="auditLog_result_jsp.log_id"/></th><%-- 日志编号 --%>
								<th  nowrap="nowrap"><b:message key="auditLog_result_jsp.operator_id"/></th><%-- 操作员ID --%>
								<th  nowrap="nowrap"><b:message key="auditLog_result_jsp.function_type"/></th><%-- 功能类型 --%>
								<th  nowrap="nowrap"><b:message key="auditLog_result_jsp.function_name"/></th><%-- 功能名称 --%>
								<th   nowrap="nowrap"><b:message key="auditLog_result_jsp.log_occasion"/></th><%-- 记录时机 --%>
								<th   nowrap="nowrap"><b:message key="auditLog_result_jsp.operation_level"/></th><%-- 操作级别 --%>
								<th   nowrap="nowrap"><b:message key="auditLog_result_jsp.occur_time"/></th> <%-- 发生时间 --%>
								<th   nowrap="nowrap"><b:message key="auditLog_result_jsp.process_def_id"/></th><%-- 流程定义ID --%>
								<th  nowrap="nowrap"><b:message key="auditLog_result_jsp.process_instance_id"/></th><%-- 流程实例ID --%>
								<th   nowrap="nowrap"><b:message key="auditLog_result_jsp.act_instance_id"/></th><%-- 活动实例ID --%>
								<th  nowrap="nowrap"><b:message key="auditLog_result_jsp.workitem_id"/></th><%-- 工作项ID --%>
							</tr>
							<l:present property="auditLogList">
								<l:iterate id="list" property="auditLogList">
								<%if(flag%2==0){cls="EOS_table_row";}else{cls="";}%>
									<tr  class="<%=cls %>"  onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
										<td nowrap="nowrap"><b:write iterateId="list"
											property="auditRecordID" /></td>
										<td nowrap="nowrap"><b:write iterateId="list"
											property="userName" /></td>
										<td nowrap="nowrap">
									<!--	<b:write iterateId="list"
											property="actionType" />-->
											<d:write iterateId="list"
											property="actionType" dictTypeId="WFDICT_AuditLogActionType"/>
											</td>
										<td nowrap="nowrap"><b:write iterateId="list"
											property="actionName" /></td>
										<td nowrap="nowrap">
										<d:write iterateId="list" property="logOccasion" dictTypeId="WFDICT_AuditLogOccasion"/>
										</td>
										
										<td nowrap="nowrap">
										<d:write iterateId="list" property="optionLevel" dictTypeId="WFDICT_AuditOpt"/>
										</td>
										<td nowrap="nowrap">
										<b:write iterateId="list" property="createTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
										<td nowrap="nowrap"  width="6%">
										<b:write iterateId="list" property="processDefineID" />
										</td>
										<td nowrap="nowrap"  width="6%">
										<b:write iterateId="list" property="processInstID" />
										</td>
										<td nowrap="nowrap"  width="6%">
										<b:write iterateId="list" property="activityInstID" />
										</td>
										<td nowrap="nowrap"  width="6%">
										<b:write iterateId="list" property="workItemID" />
										</td>
									</tr>
									 
								<%flag++;  %>
								</l:iterate>
							</l:present>
							<%for(;flag<10;flag++){ 
								if(flag%2==0){cls="EOS_table_row";}else{cls="";}
							%>					
							<tr  class="<%=cls %>"   onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
							<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
							</tr>
							 <%}%>
						</table>
						</td>
					</tr>
					<tr>
						<td align="right" nowrap="nowrap">
							<b:set name="action" value="com.primeton.workflow.manager.query.queryAuditLog.flow?_eosFlowAction=queryWithPage"/>
							<b:set name="target" value="_self"/>
				      		<%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<h:hiddendata property="queryCondition"/>
				
</h:form>
</body>
</html>