<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><b:message key="handover_worklist_jsp.handover_worklist"/></title><%-- 交接任务列表 --%>
</head>

<body style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden; overflow-y:auto; overflow-x: auto;" >
<form action="com.primeton.workflow.manager.handover.executeHandover.flow" method="post" name="query" onsubmit="return confirm('<b:message key="handover_worklist_jsp.sure_handover"/>');"><%-- 您确定要进行工作交接吗？ --%>
		<input type="hidden" name="from" value='<b:write property="from" />'/> 
		<input type="hidden" name="to" value='<b:write property="to" />'/> 
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td valign="top">
					<table class="workarea" width="100%">
							<tr>
								<td class="EOS_panel_head" valign="middle"><b:message key="handover_worklist_jsp.handover_workitem"/></td><%-- 需要交接的工作项 --%>
							</tr>
							<tr>
							  <td valign="top">
								<table class="workarea" width="100%"">
								  <tr>
								      <td class="blockInfo_title"><b:message key="handover_worklist_jsp.to_be_exec_workitem"/></td><%-- 待执行的工作项 --%>
								  </tr>
								  <tr>
								  		<% int flag = 0; %>
								      <td width="100%">
								          <table border="0" class="EOS_table" width="100%">
								               <tr class="EOS_table_head">
                                                    <th nowrap><b:message key="handover_worklist_jsp.workitem_name"/></th><%-- 工作项名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.biz_process_name"/></th><%-- 业务流程名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.process_instance_name"/></th><%-- 流程实例名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.current_state"/></th><%-- 当前状态 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.start_time"/></th><%-- 启动时间 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.time_limit"/></th><%-- 时间限制 --%>                                          
                                                </tr>
                                        	<% int flag1 =0;%>
                                              <l:iterate id="workitem" property="exeWIList">
                                                <tr class="EOS_table_row">
                                                    <td><b:write property="workItemName" iterateId="workitem"/></td>
                      								<td><b:write property="processDefName" iterateId="workitem"/></td>
                      								<td><b:write property="processInstName" iterateId="workitem"/></td>
                      								<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
                      								<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyy-MM-dd HH:mm.S"/></td>
                      								<td><b:write property="limitNumDesc" iterateId="workitem"/></td>						
                    							</tr>
                							<% 	flag1++;  %>
                							<% 	flag++;  %>
                                              </l:iterate>
                                          	<%for(int i = flag1; i < 5;i++){ %>
												<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
										  	<%} %>
								          </table>
								      </td>
								    </tr>
								  </table>
								</td>
							</tr>
							<tr>
							    <td valign="top">
							      <table class="workarea" width="100%">
								  <tr>
								      <td class="blockInfo_title"><b:message key="handover_worklist_jsp.delegate_other_item"/></td><%-- 代办他人的工作项 --%>
								  </tr>
								  <tr>
								      <td width="100%">
								          <table border="0" class="EOS_table" width="100%">
								               <tr class="EOS_table_head">
                                                    <th nowrap><b:message key="handover_worklist_jsp.workitem_name"/></th><%-- 工作项名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.biz_process_name"/></th><%-- 业务流程名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.process_instance_name"/></th><%-- 流程实例名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.current_state"/></th><%-- 当前状态 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.start_time"/></th><%-- 启动时间 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.time_limit"/></th><%-- 时间限制 --%>                                          
                                                </tr>
                                            <% int flag2 =0;%>
                                              <l:iterate id="workitem" property="delegWIList">
                                                <tr class="EOS_table_row">
                                                    <td><b:write property="workItemName" iterateId="workitem"/></td>
                      								<td><b:write property="processDefName" iterateId="workitem"/></td>
                      								<td><b:write property="processInstName" iterateId="workitem"/></td>
                      								<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
                      								<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyy-MM-dd HH:mm.S"/></td>
                      								<td><b:write property="limitNumDesc" iterateId="workitem"/></td>						
                    							</tr>
                                            <% 	flag2++;  %>
                                            <% 	flag++;  %>
                                              </l:iterate>
                                          	<%for(int i = flag2; i < 5;i++){ %>
												<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
										  	<%} %>
								          </table>
								      </td>
								    </tr>
								  </table>
							    </td>
							</tr>
							<tr>
							    <td>
							      <table class="workarea" width="100%">
								  <tr>
								      <td class="blockInfo_title"><b:message key="handover_worklist_jsp.delegate_to_other_item"/></td><%-- 委托他人代办的工作项 --%>
								  </tr>
								  <tr>
								      <td width="100%" valign="top">
								          <table border="0" class="EOS_table" width="100%">
								               <tr class="EOS_table_head">
                                                    <th nowrap><b:message key="handover_worklist_jsp.workitem_name"/></th><%-- 工作项名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.biz_process_name"/></th><%-- 业务流程名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.process_instance_name"/></th><%-- 流程实例名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.current_state"/></th><%-- 当前状态 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.start_time"/></th><%-- 启动时间 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.time_limit"/></th><%-- 时间限制 --%>                                                  
                                                </tr>
                                            <% int flag3 = 0; %>
                                              <l:iterate id="workitem" property="entrWIList">
                                                <tr class="EOS_table_row">
                                                    <td><b:write property="workItemName" iterateId="workitem"/></td>
                      								<td><b:write property="processDefName" iterateId="workitem"/></td>
                      								<td><b:write property="processInstName" iterateId="workitem"/></td>
                      								<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
                      								<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyy-MM-dd HH:mm.S"/></td>
                      								<td><b:write property="limitNumDesc" iterateId="workitem"/></td>						
                    							</tr>
                							<% flag3++; %>
                							<% 	flag++;  %>
                                              </l:iterate>
                                            <%for(int i = flag3; i < 5;i++){ %>
												<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
										  	<%} %>  
								          </table>
								      </td>
								    </tr>
								  </table>
							    </td>
							</tr>
							<tr>
							    <td>
							      <table class="workarea" width="100%">
								  <tr>
								      <td class="blockInfo_title"><b:message key="handover_worklist_jsp.handover_receive_item"/></td><%-- 需要交接的待领取的工作项 --%>
								  </tr>
								  <tr>
								      <td width="100%" valign="top">
								          <table border="0" class="EOS_table" width="100%">
								               <tr class="EOS_table_head">
                                                    <th nowrap><b:message key="handover_worklist_jsp.workitem_name"/></th><%-- 工作项名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.biz_process_name"/></th><%-- 业务流程名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.process_instance_name"/></th><%-- 流程实例名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.current_state"/></th><%-- 当前状态 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.start_time"/></th><%-- 启动时间 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.time_limit"/></th><%-- 时间限制 --%>                                                    
                                                </tr>
                                            <% int flag4 = 0; %>
                                              <l:iterate id="workitem" property="pubWIList">
                                                <tr class="EOS_table_row">
                                                    <td><b:write property="workItemName" iterateId="workitem"/></td>
                      								<td><b:write property="processDefName" iterateId="workitem"/></td>
                      								<td><b:write property="processInstName" iterateId="workitem"/></td>
                      								<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
                      								<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyy-MM-dd HH:mm.S"/></td>
                      								<td><b:write property="limitNumDesc" iterateId="workitem"/></td>						
                    							</tr>
                                          	<% flag4++; %>
                                          	<% 	flag++;  %>
                                              </l:iterate>
                                            <%for(int i = flag4; i < 5;i++){ %>
												<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
										  	<%} %>
								          </table>
								      </td>
								    </tr>
								  </table>						
						</td>
					</tr>
					<tr>
					    <td>
					        <table class="workarea" width="100%">
							  <tr>
								<td class="blockInfo_title"><b:message key="handover_worklist_jsp.modify_process_define"/></td><%-- 需要修改的流程定义 --%>
							  </tr>
							  <tr>
								  <td width="100%" valign="top">
								      <table border="0" class="EOS_table" width="100%">
								               <tr class="EOS_table_head">
                                                    <th nowrap><b:message key="handover_worklist_jsp.process_name"/></th><%-- 流程名称 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.process_version"/></th><%-- 流程版本 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.process_owner"/></th><%-- 流程所有者 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.create_time"/></th><%-- 创建时间 --%>                                                                                                                                                          
                                                </tr>
                                            <% int flag5 = 0; %>
                                              <l:iterate id="processDef" property="defList">
                                                <tr class="EOS_table_row">
                      								<td><b:write property="processDefName" iterateId="processDef"/></td>
                      								<td><b:write property="versionSign" iterateId="processDef"/></td>
                      								<td><b:write property="processDefOwner" iterateId="processDef"/></td>
                      								<td><b:write property="createTime" iterateId="processDef" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyyMMddHHmmss"/></td>
                    							</tr>
                                          	<% flag5++; %>
                                          	<% 	flag++;  %>
                                              </l:iterate>
                                            <%for(int i = flag5; i < 5;i++){ %>
												<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
										  	<%} %>
								        </table>
								   </td>
							   </tr>
							</table>
					    </td>
					</tr>
					<tr>
					    <td>
					        <table class="workarea" width="100%">
							  <tr>
								<td class="blockInfo_title"><b:message key="handover_worklist_jsp.delete_agent_relation"/></td><%-- 需要删除的代理关系 --%>
							  </tr>
							  <tr>
								  <td width="100%" valign="top">
								      <table border="0" class="EOS_table" width="100%">
								               <tr class="EOS_table_head">
                                                    <th nowrap><b:message key="handover_worklist_jsp.client"/></th><%-- 委托人 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.delegate"/></th><%-- 代理人 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.delegate_style"/></th><%-- 代理方式 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.start_time1"/></th><%-- 生效时间 --%>
                                                    <th nowrap><b:message key="handover_worklist_jsp.end_time"/></th><%-- 终止时间 --%>                                                                                                      
                                                </tr>
                                          	<% int flag6 = 0; %>  
                                              <l:iterate id="agent" property="agentList">
                                                <tr class="EOS_table_row">
                                                    <td><b:write property="agentFrom" iterateId="agent"/></td>
                      								<td><b:write property="agentTo" iterateId="agent"/></td>
                      								<td><d:write property="agentType" dictTypeId="WFDICT_AgentType"  iterateId="agent"/></td>
                      								<td><b:write property="startTime" iterateId="agent" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyyMMddHHmmss"/></td>
                      								<td><b:write property="endTime" iterateId="agent" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyyMMddHHmmss"/></td>						
                    							</tr>
                							<% flag6++; %>
                							<% 	flag++;  %>
                                              </l:iterate>
                                            <%for(int i = flag6; i < 5;i++){ %>
												<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
										  	<%} %>
								        </table>
								   </td>
							   </tr>
							</table>
					    </td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<% if(flag > 0 ){ %>
				<center>		
				<input type="submit" id="handoverBtn" class="button" name="submit" value="<b:message key="handover_worklist_jsp.handover"/>"/><%-- 交接 --%> 
				</center>
				<%} %>
				</td>
			</tr>
			<tr height="20">
				<td>
				&nbsp;
				</td>
			</tr>
		</table><br>
</form>
</body>
</html>
