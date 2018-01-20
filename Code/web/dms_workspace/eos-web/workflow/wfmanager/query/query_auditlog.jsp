<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/wfmanager/query/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String selectOpLevel = ResourcesMessageUtil.getI18nResourceMessage("query_auditlog_jsp.select_operation_level");
String selectLogOccasion = ResourcesMessageUtil.getI18nResourceMessage("query_auditlog_jsp.select_log_occasion");
String selectFunctionType = ResourcesMessageUtil.getI18nResourceMessage("query_auditlog_jsp.select_function_type");
String idCondition = ResourcesMessageUtil.getI18nResourceMessage("query_auditlog_jsp.id_condition");
 %>
<h:form name="queryForm"
	action="com.primeton.workflow.manager.query.queryAuditLog.flow?_eosFlowAction=queryListByCond"
	method="post" target="list">
	<table border="0" cellpadding="1" cellspacing="0" width="100%" class="workarea">
		<tr>
			<td class="workarea_title"><b:message key="query_auditlog_jsp.audit_log_query"/></td><%-- 审计日志查询 --%>
		</tr>
		<tr>
			<td>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
				
				<tr>
					<td width="100%">
					<table class="workarea" width="100%">
						<h:hidden name="queryCondition/_entity" value="com.eos.workflow.data.WFAuditRecord" />
						<tr>
							<td class="EOS_panel_head"><b:message key="query_auditlog_jsp.query_condition"/></td><%-- 查询条件 --%>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0"
								class="form_table" width="100%">
								<tr>
									<td class="EOS_table_row" nowrap="nowrap"><b:message key="query_auditlog_jsp.log_id"/></td><%-- 日志编号: --%>
									<td nowrap="nowrap" style="padding-left:15px"><h:text
										property="queryCondition/_expr[1]/auditRecordID"
										onblur="checkInput(this);" styleClass="textbox" size="34"
										validateAttr="type=naturalNumber;maxLength=18;allowNull=true"  /></td><%-- 日志编号 只能填写长度小于19的正整数 --%>
									<td class="EOS_table_row" nowrap="nowrap"><b:message key="query_auditlog_jsp.operator"/></td><%-- 操作员: --%>
									<td nowrap="nowrap" style="padding-left:15px"><h:text
										property="queryCondition/_expr[2]/userName"
										styleClass="textbox" size="34"  maxlength="200"/></td>
								</tr>
								<tr>
									<td class="EOS_table_row"><b:message key="query_auditlog_jsp.function_type"/></td><%-- 功能类型: --%>
									<td style="padding-left:15px"><!--	<h:select property="queryCondition/_expr[3]/actionType"  styleClass="select">
									<h:option label="--请选择功能类型--" value="" />
									<h:option label="引擎查询" value="ENGQRY" />
									<h:option label="引擎操作" value="ENGOPT" />
									<h:option label="应用调用" value="APP" />
									<h:option label="触发事件" value="TRIGGER" />
									<h:option label="定时器类型" value="TIMER" />
									<h:option label="获取参与者" value="FETCHPARTI" />
								</h:select>--> <d:select
										property="queryCondition/_expr[3]/actionType"
										styleClass="select" dictTypeId="WFDICT_AuditLogActionType"
										nullLabel="<%=selectFunctionType %>" /></td><%-- --请选择功能类型-- --%>
									<td class="EOS_table_row"><b:message key="query_auditlog_jsp.function_name"/></td><%-- 功能名称: --%>
									<td style="padding-left:15px"><h:text property="queryCondition/_expr[4]/actionName"
										styleClass="textbox" size="34"  maxlength="200"/></td>
								</tr>
								<tr>
									<td class="EOS_table_row"><b:message key="query_auditlog_jsp.log_occasion"/></td><%-- 记录时机: --%>
									<td style="padding-left:15px"><!--	<h:select property="queryCondition/_expr[5]/logOccasion"  styleClass="select">
									<h:option label="--选择记录时机--" value="" />
									<h:option label="开始" value="B" />
									<h:option label="结束" value="E" />
									<h:option label="异常" value="EX" />
								</h:select>--> <d:select
										property="queryCondition/_expr[5]/logOccasion"
										styleClass="select" dictTypeId="WFDICT_AuditLogOccasion"
										nullLabel="<%=selectLogOccasion %>" /></td><%-- --选择记录时机-- --%>
									<td class="EOS_table_row"><b:message key="query_auditlog_jsp.log_time"/></td><%-- 记录时间: --%>
									<td nowrap="nowrap">
									<table border="0" cellpadding="0" cellspacing="0"
										style='border:0px;background-color:transparent'>
										<tr style='border:0px;background-color:transparent'>
											<td style='border:0px;background-color:transparent'>
											<w:date  allowNull="true"  defaultNull="true" format="yyyy-MM-dd HH:mm:ss"
												name="createTime_min" size="20" readonly="true" /></td>
											<td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
											<td style='border:0px;background-color:transparent'><w:date
												 allowNull="true"  defaultNull="true" format="yyyy-MM-dd HH:mm:ss"
												name="createTime_max" size="20" readonly="true" /></td>
										</tr>
									</table>
									<input type="hidden" name="queryCondition/_expr[6]/createTime">
									<input type="hidden" name="queryCondition/_expr[6]/_pattern"
										value="yyyy-MM-dd HH:mm:ss"> <input type="hidden"
										name="queryCondition/_expr[6]/_op" value=">="> <input
										type="hidden" name="queryCondition/_expr[7]/createTime">
									<input type="hidden" name="queryCondition/_expr[7]/_pattern"
										value="yyyy-MM-dd HH:mm:ss"> <input type="hidden"
										name="queryCondition/_expr[7]/_op" value="<="></td>
								</tr>
								<tr>
									<td class="EOS_table_row"><b:message key="query_auditlog_jsp.operation_level"/></td><%-- 操作级别: --%>
									<td style="padding-left:15px"> <d:select
										property="queryCondition/_expr[8]/optionLevel"
										styleClass="select" dictTypeId="WFDICT_AuditOpt"
										nullLabel="<%=selectOpLevel %>" /></td><%-- --选择操作级别-- --%>
									<td class="EOS_table_row"></td>
									<td>									
									</td>
								</tr>

							</table>
							</td>
						</tr>
						<tr>
							<td colspan="5" class="form_bottom">
							<input type="submit" id="queryBtn" name="Submit2" value="<b:message key="query_auditlog_jsp.query"/>" class="button" onclick="setSubmitItem()"><%-- 查询 --%>
							<input type="reset"id="clearBtn" name="Submit" value="<b:message key="query_auditlog_jsp.clear"/>" class="button" onclick="clearQueryForm()"></td><%-- 清空 --%>
						</tr>
					</table>
					</td>
				</tr>

			</table>
			</td>
		</tr>
		<tr>
			<td valign="center" style="padding-top:10px">
				<iframe name="list" id="list" width="100%" height="200%" onload="dyniframesize('list');" marginHeight="0" scrolling="no" frameBorder="0" marginWidth="0" src="auditLog_result.jsp"></iframe>
			</td>
		</tr>
	</table>
</h:form>		

<script type="text/javascript">

	window.onload = function (){
		setSubmitItem();
		$name("queryForm").submit();
	}
	
	function setSubmitItem(){
		setCreateTime();
	}
	
	function setCreateTime(){
		var minTime=document.queryForm.elements["queryCondition/_expr[6]/createTime"];
		var maxTime=document.queryForm.elements["queryCondition/_expr[7]/createTime"];
		var min=document.queryForm.elements["createTime_min"];
		var max=document.queryForm.elements["createTime_max"];
		minTime.value = min.value;
		maxTime.value = max.value;
		//alert(minTime.value+"\n"+maxTime.value);
	}
	function clearQueryForm(){
		$name("createTime_min").value='';
		$name("createTime_max").value='';
		
	}

	function dyniframesize(iframename){
	   	var pTar = null;
		if (document.getElementById){
			pTar = document.getElementById(iframename);
		}else{
			eval('pTar = ' + iframename + ';');
		}
		if (pTar && !window.opera){
			//begin resizing iframe
			
			pTar.style.display="block"
			
			if (pTar.contentDocument && pTar.contentDocument.body.scrollHeight){
				//ns6 syntax
				pTar.height = pTar.contentDocument.body.scrollHeight;
			}else if (pTar.Document && pTar.Document.body.scrollHeight){
				//ie5+ syntax
				pTar.height = pTar.Document.body.scrollHeight;
			}
		}
	}
</script>
<%@include file="/workflow/wfmanager/query/tail.jsp"%>