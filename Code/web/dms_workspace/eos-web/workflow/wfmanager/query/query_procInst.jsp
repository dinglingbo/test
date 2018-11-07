<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/wfmanager/query/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("query_procInst_jsp.select");
String pleaseSelect = ResourcesMessageUtil.getI18nResourceMessage("query_procInst_jsp.please_select");
String length = ResourcesMessageUtil.getI18nResourceMessage("query_procInst_jsp.length_lessthan_nineteen");
 %>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%">
		<h:form name="queryForm" action="com.primeton.workflow.manager.query.queryProcessInstance.flow?_eosFlowAction=queryListByCond"
			method="post" target="processInstQueryResult">
			<table class="workarea" width="100%">
				<tr>
					<td class="EOS_panel_head"><b:message key="query_procInst_jsp.query_condition"/></td><%-- 查询条件 --%>
				</tr>
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table" width="100%">
						<h:hidden name="queryCondition/_entity" value="com.eos.workflow.data.WFProcessInst" />
						<h:hidden name="pageCond/begin" property="pageCond/begin" />
						<h:hidden name="pageCond/length" property="pageCond/length" />
						<h:hidden name="pageCond/isCount" property="pageCond/isCount" />
						<tr>
							<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="query_procInst_jsp.proc_inst_id"/></td><%-- 流程实例ID: --%>
							<td nowrap="nowrap" width="35%" style="padding-left:15px"><h:text
								property="queryCondition/_expr[1]/processInstID"
								styleClass="textbox" size="34"
								validateAttr="type=integer;maxLength=18;allowNull=true"
								onblur="checkInput(this);"  maxlength="18" /></td><%-- ID只能填写长度小于19的整数 --%>
							<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="query_procInst_jsp.proc_inst_name"/></td><%-- 流程实例名称: --%>
							<td nowrap="nowrap" width="35%" style="padding-left:15px"><h:text
								property="queryCondition/_expr[2]/processInstName"
								styleClass="textbox" size="34" maxlength="200"/> 
								<input type="hidden"
								name="queryCondition/_expr[2]/_op" size="34" value="like" />
								<input type="hidden" name="queryCondition/_expr[2]/_likeRule" value="all"/>
								
								</td>
						</tr>
						<tr>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.proc_def_id"/></td><%-- 流程定义ID: --%>
							<td nowrap="nowrap" style="padding-left:15px"><h:text
								property="queryCondition/_expr[3]/processDefID"
								onblur="checkInput(this);" styleClass="textbox" size="34"
								validateAttr="type=naturalNumber;maxLength=18;allowNull=true"  maxlength="18"/></td><%-- ID只能填写长度小于19的整数 --%>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.proc_def_name"/></td><%-- 流程定义名称: --%>
							<td nowrap="nowrap" style="padding-left:15px">
							<h:text
								property="queryCondition/_expr[4]/processDefName"  styleClass="textbox" size="34"  maxlength="200"/>
							<input type="hidden"
								name="queryCondition/_expr[4]/_op" size="34" value="like" />
								<input type="hidden" name="queryCondition/_expr[4]/_likeRule" value="all"/>
							</td>
						</tr>
						<tr>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.biz_catalog"/></td><%-- 业务目录: --%>
							<td nowrap="nowrap" style="padding-left:12px">
								<input type="text" name="showCatalogName" value="" readonly="true" size="32">&nbsp;
	                  	 		<wf:selectBizCatalog name="select" value="<%=select %>" maxNum="1" hiddenType="ID" hidden="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID" form="queryForm" output="showCatalogName" styleClass="button"/><%-- 选择... --%>
								<h:hidden name="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID"/>
							</td>
							<td nowrap="nowrap" class="EOS_table_row" ><b:message key="query_procInst_jsp.include_subcatalog"/></td><%-- 包含子目录: --%>
							<td nowrap="nowrap" style="padding-left:12px">
								<h:switchCheckbox name="isIncludeSubCatalog" checkedValue="true" uncheckedValue="false"/>
							</td>
						</tr>
						<tr>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.creator"/></td><%-- 创建者: --%>
							<td nowrap="nowrap" style="padding-left:15px"><h:text
								name="queryCondition/_expr[5]/creator" 
								property="queryCondition/_expr[5]/creator" styleClass="textbox"
								size="34" maxlength="500"/></td>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.create_time"/></td><%-- 创建时间: --%>
							<td nowrap="nowrap">
							<table border="0" cellpadding="0" cellspacing="0"
								style='border:0px;background-color:transparent'>
								<tr style='border:0px;background-color:transparent'>
									<td style='border:0px;background-color:transparent'><w:date
										 allowNull="true"  defaultNull="true" format="yyyy-MM-dd hh:MM"
										name="createTime_min" size="20" readonly="true" /></td>
									<td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
									<td style='border:0px;background-color:transparent'><w:date
										 allowNull="true"  defaultNull="true" format="yyyy-MM-dd hh:MM"
										name="createTime_max" size="20" readonly="true"/></td>
								</tr>
							</table>
							<input type="hidden" name="queryCondition/_expr[6]/createTime">
							<input type="hidden" name="queryCondition/_expr[6]/_pattern"
								value="yyyy-MM-dd hh:MM"> <input type="hidden"
								name="queryCondition/_expr[6]/_op" value=">="> <input
								type="hidden" name="queryCondition/_expr[7]/createTime">
							<input type="hidden" name="queryCondition/_expr[7]/_pattern"
								value="yyyy-MM-dd hh:MM"> <input type="hidden"
								name="queryCondition/_expr[7]/_op" value="<="></td>
						</tr>
						<tr>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.priority"/></td><%-- 优先级: --%>
							<td nowrap="nowrap" style="padding-left:15px">
						    <d:select property="queryCondition/_expr[11]/priority"	 dictTypeId="WFDICT_Priority" styleClass="select"	nullLabel="<%=pleaseSelect %>" /><%-- --请选择-- --%>
							</td>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.start_time"/></td><%-- 启动时间: --%>
							<td nowrap="nowrap">
							<table border="0" cellpadding="0" cellspacing="0"
								style='border:0px;background-color:transparent'>
								<tr style='border:0px;background-color:transparent'>
									<td style='border:0px;background-color:transparent'><w:date
										 allowNull="true"  defaultNull="true" format="yyyy-MM-dd hh:MM"
										name="startTime_min" size="20" readonly="true"/></td>
									<td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
									<td style='border:0px;background-color:transparent'><w:date
										  allowNull="true" defaultNull="true" format="yyyy-MM-dd hh:MM"
										name="startTime_max" size="20" readonly="true"/></td>
								</tr>
							</table>
							<input type="hidden" name="queryCondition/_expr[9]/startTime">
							<input type="hidden" name="queryCondition/_expr[10]/startTime">
							<input type="hidden" name="queryCondition/_expr[9]/_pattern"
								value="yyyy-MM-dd hh:MM"> <input type="hidden"
								name="queryCondition/_expr[10]/_pattern"
								value="yyyy-MM-dd hh:MM"> <input type="hidden"
								name="queryCondition/_expr[9]/_op" value=">="> <input
								type="hidden" name="queryCondition/_expr[10]/_op" value="<=">
							</td>
						</tr>
						<tr>
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.proc_state"/></td><%-- 流程状态: --%>
							<td nowrap="nowrap" ><!--		<h:select property="queryCondition/_expr[8]/currentState"  styleClass="select">
							<h:option label="--请选择--" value="" />
							<h:option label="运行" value="2" />
							<h:option label="挂起" value="3" />
							<h:option label="完成" value="7" />
							<h:option label="终止" value="8" />
						</h:select>-->
						 <d:checkbox 	property="queryCondition/_expr[8]/currentState"	dictTypeId="WFDICT_ProcessState" submitMethod="special"/>
								<input type="hidden" 	name="queryCondition/_expr[8]/_op" value="in" >
							</td>							
							<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_procInst_jsp.end_time"/></td><%-- 结束时间: --%>
							<td nowrap="nowrap">
							<table border="0" cellpadding="0" cellspacing="0"
								style='border:0px;background-color:transparent'>
								<tr style='border:0px;background-color:transparent'>
									<td style='border:0px;background-color:transparent'><w:date
										  allowNull="true" defaultNull="true" format="yyyy-MM-dd hh:MM"
										name="endTime_min" size="20" readonly="true"/></td>
									<td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
									<td style='border:0px;background-color:transparent'><w:date
										 allowNull="true" defaultNull="true" format="yyyy-MM-dd hh:MM"
										name="endTime_max" size="20" readonly="true"/></td>
								</tr>
							</table>
							<input type="hidden" name="queryCondition/_expr[12]/endTime">
							<input type="hidden" name="queryCondition/_expr[13]/endTime">
							<input type="hidden" name="queryCondition/_expr[12]/_pattern"
								value="yyyy-MM-dd hh:MM"> <input type="hidden"
								name="queryCondition/_expr[13]/_pattern"
								value="yyyy-MM-dd hh:MM"> <input type="hidden"
								name="queryCondition/_expr[12]/_op" value=">="> <input
								type="hidden" name="queryCondition/_expr[13]/_op" value="<="></td>
						</tr>
						<tr>
						<td nowrap="nowrap" class="EOS_table_row" ><b:message key="query_procInst_jsp.out_time"/></td><%-- 超时: --%>
						<td nowrap="nowrap" style="padding-left:12px">
							<d:radio name="queryCondition/_expr[14]/isTimeOut" property="queryCondition/_expr[14]/isTimeOut" dictTypeId="WFDICT_ProcessTimeoutType" value="" />
							<!--<h:switchCheckbox name="queryCondition/_expr[14]/isTimeOut" checkedValue="Y" uncheckedValue="N"/>-->
						</td>
						<td nowrap="nowrap" class="EOS_table_row"></td>
						</tr>
						<tr>
							<td nowrap="nowrap" colspan="5" class="form_bottom">
							<input type="submit" id="submitbtn" name="Submit0" value="<b:message key="query_procInst_jsp.query"/>" class="button" onclick="setSubmitItem()"><%-- 查询 --%>
							<input type="reset" id="resetbtn" name="reset" value="<b:message key="query_procInst_jsp.clear"/>" class="button" onclick="clearQueryForm()"></td><%-- 清空 --%>
						</tr>
					</table>
					</td>
				</tr>			
			</table>
		</h:form>
		</td>
	</tr> 
	</table>
	</td>
	</tr>
	<tr height="370px">
		<td valign="top" align="center" style="padding-top:10px">
		<iframe width="100%" marginHeight="0" scrolling="auto" frameBorder="0" marginWidth="0"	name="processInstQueryResult" align="top"></iframe>
		</td>
	</tr>
	<tr height="20px"><td>&nbsp;</td></tr>
</table>
<script type="text/javascript">
	/*点击查询按钮需要设置的内容*/
	function setSubmitItem(){
		setCreateTime();
		setStartTime();
		setEndTime();
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
	
	function setStartTime(){
		var minTime=document.queryForm.elements["queryCondition/_expr[9]/startTime"];
		var maxTime=document.queryForm.elements["queryCondition/_expr[10]/startTime"];
		var min=document.queryForm.elements["startTime_min"];
		var max=document.queryForm.elements["startTime_max"];
		minTime.value = min.value;
		maxTime.value = max.value;
		//alert(minTime.value+"\n"+maxTime.value);
	} 
	
	function setEndTime(){
		var minTime=document.queryForm.elements["queryCondition/_expr[12]/endTime"];
		var maxTime=document.queryForm.elements["queryCondition/_expr[13]/endTime"];
		var min=document.queryForm.elements["endTime_min"];
		var max=document.queryForm.elements["endTime_max"];
		minTime.value = min.value;
		maxTime.value = max.value;
		//alert(minTime.value+"\n"+maxTime.value);
	}
	
	function clearQueryForm(){
		$name("createTime_min").value='';
		$name("createTime_max").value='';
		$name("startTime_min").value='';
		$name("startTime_max").value='';
		$name("endTime_min").value='';
		$name("endTime_max").value='';
		$name("queryCondition/_expr[8]/currentState").value='';
		dataCatchPool = [];
	}
	
	window.onload = function (){
		setSubmitItem();
		$name("queryForm").submit();
	}
</script>
<%@include file="/workflow/wfmanager/query/tail.jsp"%>
