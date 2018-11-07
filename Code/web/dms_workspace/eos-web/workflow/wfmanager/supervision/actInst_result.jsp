<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title></title>
<script type="text/javascript">
	function initiFrame(){
		var height = frameElement.parentNode.offsetHeight;
		if (isFF) {
			height += 70;
		}
		else {
			height -= 40;
		}
		frameElement.height = height;
	}
</script>
</head>
<body onLoad="initiFrame()" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
<form name="resultForm" action="#" method="post">
<l:present property="queryCondition">
	<h:hiddendata property="queryCondition" />
	<h:hidden property="isIncludeSubCatalog" />
	<h:hidden property="catalogUUID" />
</l:present>
<table class="workarea" width="100%">
		<% int flag =0; String cls = "";%>
			<tr>
				<td class="EOS_panel_head"><b:message key="act_inst_result_jsp.exp_auto_act_list"/></td>
			</tr>
			<tr>
				<td>
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td>
						<table border="0" class="EOS_table" width="100%">
							<tr class="EOS_table_head">
								<th><b:message key="act_inst_result_jsp.select"/></th>
								<th><b:message key="act_inst_result_jsp.biz_catalog"/></th>
								<th><b:message key="act_inst_result_jsp.act_inst_id"/></th>
								<th><b:message key="act_inst_result_jsp.act_def_id"/></th>
								<th><b:message key="act_inst_result_jsp.act_inst_name"/></th>
								<th><b:message key="act_inst_result_jsp.act_type"/></th>
								<th><b:message key="act_inst_result_jsp.act_status"/></th>
								<th><b:message key="act_inst_result_jsp.proc_inst_id"/></th>
								<th><b:message key="act_inst_result_jsp.start_time"/></th>
							</tr>
							<l:present property="activityInstList">
								<l:iterate id="list" property="activityInstList">
								<%if(flag%2==0){cls="EOS_table_row";}else{cls="";}%>
									<tr  class="<%=cls %>"  onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
										<td nowrap="nowrap">
											<A href="javascript:void(0);" onclick='openManualActivityDialog(<b:write iterateId="list" property="activityInstID" />,<b:write iterateId="list" property="processInstID" />)'><b:message key="act_inst_result_jsp.handle_exception"/></A>
										</td>
										<td nowrap="nowrap">
											<l:present iterateId="list" property="catalogName" >
												<b:write iterateId="list" property="catalogName" />
											</l:present>
											<l:notPresent iterateId="list" property="catalogName" >
												<b:message key="act_inst_result_jsp.default_biz_catalog"/>
											</l:notPresent>
										</td>
										<td nowrap="nowrap"><b:write iterateId="list" property="activityInstID" />
										</td>
										<td nowrap="nowrap"><b:write iterateId="list"
											property="activityDefID" /></td>
										<td nowrap="nowrap"><b:write iterateId="list"
											property="activityInstName" /></td>
										<td nowrap="nowrap">
										<!--<b:write iterateId="list"
											property="activityType" />-->
										<d:write iterateId="list"
											property="activityType"  dictTypeId="WFDICT_ActivityType" />
										</td>
										<td nowrap="nowrap">										
										<!--<b:write iterateId="list"
											property="currentState" />-->
										<d:write iterateId="list"
											property="currentState" dictTypeId="WFDICT_ActivityState" />											
										</td>
										<td nowrap="nowrap">
										<b:write iterateId="list" property="processInstID" /></td>
										<td nowrap="nowrap">
										<b:write iterateId="list" property="startTime" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
									</tr>
									   
								<%flag++;  %>
								</l:iterate>
							</l:present>
							<%for(;flag<10;flag++){ 
								if(flag%2==0){cls="EOS_table_row";}else{cls="";}
							%>					
							<tr  class="<%=cls %>"   onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
							<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
							</tr>
							 <%}%>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color: #e7f5fe;" >
							<tr>
								<td align="right" nowrap="nowrap">
									<!-- <b:set name="action" value="com.primeton.workflow.manager.supervision.queryAutoActInEx.flow?_eosFlowAction=queryWithPage"/> -->
									<b:set name="action" value="com.primeton.workflow.manager.supervision.queryAutoActivityInException.flow?_eosFlowAction=queryActivityInstWithPage"/>
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
		</td>
	</tr>
</table>    
</form>
<script language="javascript">
	function openManualActivityDialog(actInstID,processInstID){
		//alert(actInstID);
		var action = 'com.primeton.workflow.manager.instance.editActivityInst.flow?_eosFlowAction=editOneAutoActInst&actInstID='+actInstID+'&processInstID='+processInstID;
		//var returnValue = openWindow(action,'/eos-default','640','380','<b:message key="act_inst_result_jsp.act_inst_info"/>');
		showModalCenter(action,null,function(arg){if(!arg) return ;},'620','374','<b:message key="act_inst_result_jsp.app_exp_pro"/>');
		
	}
</script>
</body>
</html>