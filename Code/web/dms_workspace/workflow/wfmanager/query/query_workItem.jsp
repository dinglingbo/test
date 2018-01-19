<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/wfmanager/query/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("query_workItem_jsp.select");
 %>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%">
		<h:form name="queryForm" action="com.primeton.workflow.manager.query.queryWorkItemList.flow?_eosFlowAction=queryListByCond" method="post" target="workItemQueryResult">
		<table class="workarea" width="100%">
			<tr>
				<td class="EOS_panel_head"><b:message key="query_workItem_jsp.query_condition"/></td><%-- 查询条件 --%>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="form_table" width="100%">
					<h:hidden name="queryCondition/_entity"
						value="com.eos.workflow.data.WFWorkItem" />
					<h:hidden property="pageCond/begin"/>
					<h:hidden property="pageCond/length"/>
					<h:hidden property="pageCond/isCount"/>
					<h:hidden property="pageCond/count"/>
					<tr>
						<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="query_workItem_jsp.item_id"/></td><%-- 工作项ID: --%>
						<td nowrap="nowrap" width="35%" style="padding-left:15px"><h:text
							name="queryCondition/_expr[1]/workItemID"
							property="queryCondition/_expr[1]/workItemID"  onblur="checkInput(this);" 
							styleClass="textbox" size="34" validateAttr="type=naturalNumber;allowNull=true"  maxlength="18" /></td>
						<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="query_workItem_jsp.item_name"/></td><%-- 工作项名称: --%>
						<td nowrap="nowrap" width="35%" style="padding-left:15px"><h:text
							name="queryCondition/_expr[2]/workItemName"
							property="queryCondition/_expr[2]/workItemName"
							styleClass="textbox" size="34"  maxlength="200" />						
						<input type="hidden" name="queryCondition/_expr[2]/_op" size="34" value="like"/>
						<input type="hidden" name="queryCondition/_expr[2]/_likeRule" value="all"/>
						</td>
					</tr>
					<tr>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.process_inst_id"/></td><%-- 流程实例ID: --%>
						<td nowrap="nowrap" style="padding-left:15px"><h:text name="queryCondition/_expr[3]/processInstID"   onblur="checkInput(this);" 
							property="queryCondition/_expr[3]/processInstID"
							styleClass="textbox" size="34"  validateAttr="type=naturalNumber;maxLength=18;allowNull=true"  maxlength="18"/></td>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.process_inst_name"/></td><%-- 流程实例名称: --%>
						<td nowrap="nowrap" style="padding-left:15px"><h:text name="queryCondition/_expr[4]/processInstName"
							property="queryCondition/_expr[4]/processInstName"
							styleClass="textbox" size="34"  maxlength="200"/>
						<input type="hidden" name="queryCondition/_expr[4]/_op" size="34" value="like"/></td>
					</tr>
					<tr>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.process_def_name"/></td><%-- 流程定义名称: --%>
						<td nowrap="nowrap" style="padding-left:15px"><h:text name="queryCondition/_expr[5]/processDefName"
							property="queryCondition/_expr[5]/processDefName"
							styleClass="textbox" size="34"  maxlength="200" />
						<input type="hidden" name="queryCondition/_expr[5]/_op" size="34" value="like"/></td>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.time_out"/></td><%-- 超时: --%>
						<td nowrap="nowrap" style="padding-left:12px">
							<d:radio name="queryCondition/_expr[6]/isTimeOut" property="queryCondition/_expr[6]/isTimeOut" dictTypeId="WFDICT_ProcessTimeoutType" value="" />
							<!--<h:switchCheckbox name="queryCondition/_expr[6]/isTimeOut" checkedValue="Y" uncheckedValue="N"/>-->
						</td>
					</tr>
					<tr>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.biz_catalog"/></td><%-- 业务目录: --%>
						<td nowrap="nowrap" style="padding-left:12px">
							<input type="text" name="showCatalogName" value="" readonly="true" size="32">&nbsp;
	                 		<wf:selectBizCatalog name="select" value="<%=select %>" maxNum="1" hiddenType="ID" hidden="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID" form="queryForm" output="showCatalogName" styleClass="button"/><%-- 选择... --%>
							<h:hidden name="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID"/>
						</td>
						<td nowrap="nowrap" class="EOS_table_row" ><b:message key="query_workItem_jsp.include_sub_catalog"/></td><%-- 包含子目录: --%>
						<td nowrap="nowrap" style="padding-left:12px">
							<h:switchCheckbox name="isIncludeSubCatalog" checkedValue="true" uncheckedValue="false"/>
						</td>
					</tr>
					<tr>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.parter_name"/></td><%-- 参与者名称: --%>
						<td nowrap="nowrap" style="padding-left:15px"><h:text name="queryCondition/_expr[7]/partiName"
							property="queryCondition/_expr[7]/partiName"
							styleClass="textbox" size="34"  maxlength="200"/></td>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.create_time"/></td><%-- 创建时间: --%>   
						<td nowrap="nowrap" valign="top">
						<table border="0" cellpadding="0" cellspacing="0" style='border:0px;background-color:transparent'>
						<tr style='border:0px;background-color:transparent'> 
						<td style='border:0px;background-color:transparent'>
						<w:date  allowNull="true"  defaultNull="true" format="yyyy-MM-dd HH:mm:ss"  name="createTime_min" size="20" readonly="true"/>
						</td><td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
						<td style='border:0px;background-color:transparent'>
						<w:date  allowNull="true" defaultNull="true" format="yyyy-MM-dd HH:mm:ss" name="createTime_max" size="20" readonly="true" />
						</td></tr></table>
						<input type="hidden" name="queryCondition/_expr[8]/createTime">
						<input type="hidden" name="queryCondition/_expr[9]/createTime">
						<input type="hidden" name="queryCondition/_expr[8]/_pattern" value="yyyy-MM-dd HH:mm:ss"> 
						<input type="hidden" name="queryCondition/_expr[9]/_pattern" value="yyyy-MM-dd HH:mm:ss"> 
						<input type="hidden" name="queryCondition/_expr[8]/_op" value=">=">
						<input type="hidden" name="queryCondition/_expr[9]/_op" value="<=">
						</td>
					</tr> 
					<tr>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.item_state"/></td><%-- 工作项状态: --%>
						<td nowrap="nowrap" >
						<d:checkbox property="queryCondition/_expr[10]/currentState" dictTypeId="WFDICT_WorkItemState" submitMethod="special"/>
						<input type="hidden" name="queryCondition/_expr[10]/_op" value="in" >							
						</td>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.start_time"/></td><%-- 启动时间: --%>
						<td nowrap="nowrap">
						<table border="0" cellpadding="0" cellspacing="0" style='border:0px;background-color:transparent'>
						<tr style='border:0px;background-color:transparent'> 
						<td style='border:0px;background-color:transparent'>
							<w:date allowNull="true"  defaultNull="true" format="yyyy-MM-dd HH:mm:ss" name="startTime_min" size="20"  readonly="true" />
						</td><td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
						<td style='border:0px;background-color:transparent'> 
							<w:date  allowNull="true"  defaultNull="true" format="yyyy-MM-dd HH:mm:ss" name="startTime_max" size="20"  readonly="true" /> 
						</td></tr></table>
							<input type="hidden" name="queryCondition/_expr[11]/startTime"> 
							<input type="hidden" name="queryCondition/_expr[12]/startTime"> 
							<input type="hidden" name="queryCondition/_expr[11]/_pattern" value="yyyy-MM-dd HH:mm:ss"> 
							<input type="hidden" name="queryCondition/_expr[12]/_pattern" value="yyyy-MM-dd HH:mm:ss"> 
							<input type="hidden" name="queryCondition/_expr[11]/_op" value=">=">
							<input type="hidden" name="queryCondition/_expr[12]/_op" value="<=">
						</td>
					</tr>
					<tr>
			  			<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.item_biz_state"/></td><%-- 工作项业务状态: --%>
						<td nowrap="nowrap">			           
					   <d:checkbox  property="queryCondition/_expr[13]/bizState" dictTypeId="WFDICT_WorkItemBizState"   submitMethod="special"/>
					   	<input type="hidden" 	name="queryCondition/_expr[13]/_op" value="in" >						
						</td>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_workItem_jsp.end_time"/></td><%-- 结束时间: --%>
						<td nowrap="nowrap">
						<table border="0" cellpadding="0" cellspacing="0" style='border:0px;background-color:transparent'>
						<tr style='border:0px;background-color:transparent'> 
						<td style='border:0px;background-color:transparent'>
							<w:date  allowNull="true"  defaultNull="true" format="yyyy-MM-dd HH:mm:ss" name="endTime_min" size="20"  readonly="true" />
						</td><td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
						<td style='border:0px;background-color:transparent'> 
							<w:date allowNull="true" defaultNull="true" format="yyyy-MM-dd HH:mm:ss" name="endTime_max" size="20"  readonly="true" /> 
						</td></tr></table>
							<input type="hidden" name="queryCondition/_expr[14]/endTime"> 
							<input type="hidden" name="queryCondition/_expr[15]/endTime"> 
							<input type="hidden" name="queryCondition/_expr[14]/_pattern" value="yyyy-MM-dd HH:mm:ss"> 
							<input type="hidden" name="queryCondition/_expr[15]/_pattern" value="yyyy-MM-dd HH:mm:ss"> 
							<input type="hidden" name="queryCondition/_expr[14]/_op" value=">=">
							<input type="hidden" name="queryCondition/_expr[15]/_op" value="<=">
						</td> 
					</tr>
					<tr>
						<td nowrap="nowrap" colspan="5" class="form_bottom">
						<input type="submit" id="querybtn" name="Submit2" value="<b:message key="query_workItem_jsp.query"/>" class="button" onclick="setSubmitItem()" ><%-- 查询 --%> <input
							type="reset" id="clearbtn" name="Reset" value="<b:message key="query_workItem_jsp.clear"/>" class="button" onclick="clearQueryForm()"></td><%-- 清空 --%>
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
		<iframe  width="100%" height="100%" marginHeight="0" scrolling="auto" frameBorder="0" marginWidth="0" name="workItemQueryResult"  ></iframe>      
		</td>
	</tr>
</table>
<script type="text/javascript"> 
	function setSubmitItem(){
		setCreateTime();
		setStartTime();
		setEndTime();
	}
	function setCreateTime(){
		var minTime=document.queryForm.elements["queryCondition/_expr[8]/createTime"];
		var maxTime=document.queryForm.elements["queryCondition/_expr[9]/createTime"];
		var min=document.queryForm.elements["createTime_min"];
		var max=document.queryForm.elements["createTime_max"];
		minTime.value = min.value;
		maxTime.value = max.value;
	}
	function setStartTime(){
		var minTime=document.queryForm.elements["queryCondition/_expr[11]/startTime"];
		var maxTime=document.queryForm.elements["queryCondition/_expr[12]/startTime"];
		var min=document.queryForm.elements["startTime_min"];
		var max=document.queryForm.elements["startTime_max"];
		minTime.value = min.value;
		maxTime.value = max.value;
	}
	function setEndTime(){
		var minTime=document.queryForm.elements["queryCondition/_expr[14]/endTime"];
		var maxTime=document.queryForm.elements["queryCondition/_expr[15]/endTime"];
		var min=document.queryForm.elements["endTime_min"];
		var max=document.queryForm.elements["endTime_max"];
		minTime.value = min.value;
		maxTime.value = max.value;
	}
	
	function clearQueryForm(){
		$name("createTime_min").value='';
		$name("createTime_max").value='';
		$name("startTime_min").value='';
		$name("startTime_max").value='';
		$name("endTime_min").value='';
		$name("endTime_max").value='';
		$name("queryCondition/_expr[10]/currentState").value='';
		$name("queryCondition/_expr[13]/bizState").value='';
		dataCatchPool = [];
	}
	
	window.onload = function (){
		setSubmitItem();
		$name("queryForm").submit();
	}
	

</script>
<%@include file="/workflow/wfmanager/query/tail.jsp"%>
					