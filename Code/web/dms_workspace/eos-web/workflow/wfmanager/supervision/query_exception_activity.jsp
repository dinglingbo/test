<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/wfmanager/query/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("query_exception_activity_jsp.select");
%>
<script language="javascript">
	function initiFrame(){
		setSubmitItem();
		$name("queryForm").submit();
	}
</script>
<body onLoad="initiFrame()" topmargin="0" bottommargin="0" rightmargin="0" leftmargin="0" style="background:#EAF0F1;overflow: auto;">
<table border="0" cellpadding="1" cellspacing="0" width="100%" class="workarea">
<tr>
	<td class="workarea_title"><b:message key="query_exception_activity_jsp.exception_act_query"/></td>
</tr>
<tr><td>
<table border="0" cellpadding="0" cellspacing="0" class="EOS_panel_body" width="100%">
	<tr>
		<td width="100%">
		<h:form name="queryForm"
			action="com.primeton.workflow.manager.supervision.queryAutoActivityInException.flow?_eosFlowAction=queryActivityInstWithPage"
			method="post" target="autoActQueryResult">
			<table class="workarea" width="100%">
			<tr>
				<td class="EOS_panel_head"><b:message key="query_exception_activity_jsp.query_condition"/></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="1" cellspacing="0"
					class="form_table" width="100%">
					<h:hidden name="queryCondition/_entity" value="com.eos.workflow.data.WFActivityInst"/>
					<h:hidden name="queryCondition/_orderby/_property" value="activityInstID"/>
   			  		<h:hidden name="queryCondition/_orderby/_sort" value="desc"/>
					<h:hidden name="queryCondition/_expr[1]/currentState" value="-1"/>
					<h:hidden name="queryCondition/_expr[2]/activityType" value="toolapp"/>
					<h:hidden name="pageCond/begin" property="pageCond/begin"/>
					<h:hidden name="pageCond/length" property="pageCond/length"/>
					<h:hidden name="pageCond/isCount" property="pageCond/isCount"/>
					<tr>
						<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="query_exception_activity_jsp.act_inst_id"/></td>
						<td nowrap="nowrap" width="35%">
							<h:text name="queryCondition/_expr[3]/activityInstID" property="queryCondition/_expr[3]/activityInstID" styleClass="textbox" size="34" onblur="checkInput(this);" validateAttr="type=integer;maxLength=18;allowNull=true" maxlength="18"/>
						</td>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_exception_activity_jsp.proc_inst_id"/></td>
						<td nowrap="nowrap">
							<h:text	name="queryCondition/_expr[4]/processInstID" property="queryCondition/_expr[4]/processInstID" styleClass="textbox" size="34" onblur="checkInput(this);" validateAttr="type=integer;maxLength=18;allowNull=true" maxlength="18"/>
						</td>
					</tr>
					<tr>
						<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="query_exception_activity_jsp.act_def_id"/></td>
						<td nowrap="nowrap" width="35%">
							<h:text name="queryCondition/_expr[5]/activityDefID" property="queryCondition/_expr[5]/activityDefID" styleClass="textbox" size="34" maxlength="200"/>
						</td>
						<td nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="query_exception_activity_jsp.act_inst_name"/></td>
						<td nowrap="nowrap" width="35%">
							<h:text name="queryCondition/_expr[6]/activityInstName" property="queryCondition/_expr[6]/activityInstName" styleClass="textbox" size="34"  maxlength="200" />
							<h:hidden name="queryCondition/_expr[6]/_op" value="like"/>
                  	 		<h:hidden name="queryCondition/_expr[6]/_likeRule" value="all"/>
						</td>
					</tr>
					<tr>
	                  <td nowrap="nowrap" width="15%" class="form_label"><b:message key="query_exception_activity_jsp.biz_catalog"/></td>
	                  <td nowrap="nowrap" width="35%">
	                  	 <input type="text" name="showCatalogName" value="" readonly="true" size="32">&nbsp;
	                  	 <wf:selectBizCatalog name="select" value="<%=select%>" maxNum="1" hiddenType="ID" hidden="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID" form="queryForm" output="showCatalogName" styleClass="button"/>
	                  	 <h:hidden name="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID"/>
	                  </td>
	                  <td nowrap="nowrap" width="15%" class="form_label"><b:message key="query_exception_activity_jsp.include_sub_catalog"/></td>
	                  <td nowrap="nowrap" width="35%">
	                     <h:switchCheckbox name="isIncludeSubCatalog" checkedValue="true" uncheckedValue="false"/>
	                  </td>
	                </tr>
					<tr>
						<td nowrap="nowrap" class="EOS_table_row"><b:message key="query_exception_activity_jsp.start_time"/></td>   
						<td nowrap="nowrap" valign="top">
						<table border="0" cellpadding="0" cellspacing="0" style='border:0px;background-color:transparent'>
						<tr style='border:0px;background-color:transparent'> 
						<td style='border:0px;background-color:transparent'>
						<w:date  allowNull="true"  defaultNull="true" format="yyyy-MM-dd HH:mm" name="startTime_min" size="20" readonly="true"/>
						</td><td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
						<td style='border:0px;background-color:transparent'>
						<w:date  allowNull="true" defaultNull="true" format="yyyy-MM-dd HH:mm" name="startTime_max" size="20" readonly="true" />
						</td></tr></table>
						<input type="hidden" name="queryCondition/_expr[7]/startTime">
						<input type="hidden" name="queryCondition/_expr[8]/startTime">
						<input type="hidden" name="queryCondition/_expr[7]/_pattern" value="yyyy-MM-dd HH:mm"> 
						<input type="hidden" name="queryCondition/_expr[8]/_pattern" value="yyyy-MM-dd HH:mm"> 
						<input type="hidden" name="queryCondition/_expr[7]/_op" value=">=">
						<input type="hidden" name="queryCondition/_expr[8]/_op" value="<=">
						</td>
						<td nowrap="nowrap" class="EOS_table_row"></td>
						<td nowrap="nowrap"></td>
					</tr>
					<tr>
						<td nowrap="nowrap" colspan="5" class="form_bottom">
						<input id="Submit0" type="submit" name="Submit0" value='<b:message key="query_exception_activity_jsp.btn_query"/>' class="button" onclick="setSubmitItem()" >
						<input id="reset" type="reset" name="reset" value='<b:message key="query_exception_activity_jsp.btn_clear"/>' class="button" onclick="clearQueryForm()"></td>
					</tr>
				</table>
				</td>
			</tr>
			</table>
		</h:form>
		</td>
	</tr>
	<tr height="310px">
		<td align="center" style="padding-top:10px">
		<iframe width="100%" style="height:310px" marginHeight="0"
				scrolling="auto" frameBorder="0" marginWidth="0" name="autoActQueryResult" src="actInst_result.jsp" ></iframe>      
		</td>
	</tr>
</table>
</td></tr>
</table>
</body>
<script type="text/javascript">
	function clearQueryForm(){
		$name("startTime_min").value='';
		$name("startTime_max").value='';
		dataCatchPool = [];
	}
	
	/*点击查询按钮需要设置的内容*/
	function setSubmitItem(){
		setStartTime();
	}
	
	function setStartTime(){
		var minTime=document.queryForm.elements["queryCondition/_expr[7]/startTime"];
		var maxTime=document.queryForm.elements["queryCondition/_expr[8]/startTime"];
		var min=document.queryForm.elements["startTime_min"];
		var max=document.queryForm.elements["startTime_max"];
		minTime.value = min.value;
		maxTime.value = max.value;
		//alert(minTime.value+"\n"+maxTime.value);
	} 
</script>
<%@include file="/workflow/wfmanager/supervision/tail.jsp"%>
