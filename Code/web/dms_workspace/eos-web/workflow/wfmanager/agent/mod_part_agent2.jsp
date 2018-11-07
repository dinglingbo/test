<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/agent/head.jsp"%>
<form action="" method="post" name="partform2">
<h:hidden property="_eosFlowAction"/>
<h:hidden property="_eosFlowKey"/>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
    <td class="workarea_title" valign="middle"><b:message key="mod_part_agent1_jsp.mod_part_agent"/></td><%-- 修改部分代理 --%>
  </tr>
  <tr>
    <td width="100%" valign="top">
      <table cellpadding="0" width="100%" cellspacing="0" border="0">
        <tr>
          <td>
            <table border="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head"><b:message key="detail_full_agent_jsp.agent_relation"/></td><%-- 代理关系 --%>
              </tr>
              <tr>
                <td width="100%">
                 
                          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
                            <tr>
                              <td  nowrap class="EOS_table_row">
                                 <b:message key="detail_full_agent_jsp.client"/>
                              </td><%-- 委托人: --%>
                              <td  nowrap>
                                 <b:write  property="AgentFromName"/>
                                 <h:hidden property="AgentFromName"/><h:hidden property="AgentFromID"/>
                                 <h:hidden property="AgentID"/>
                              </td>
                              <td nowrap class="EOS_table_row">
                                 <b:message key="detail_full_agent_jsp.efficient_time"/>
                              </td><%-- 生效时间: --%>
                              <td nowrap>
                                 <b:write  property="StartTime" formatPattern="yyyy-MM-dd hh:MM"/>
                                 <input type="hidden" name="StartTime" value='<b:write  property="StartTime" formatPattern="yyyy-MM-dd hh:MM"/>'>
                              </td>
                            </tr>
                            <tr>
                              <td class="EOS_table_row">
                                  <b:message key="detail_full_agent_jsp.agent"/>
                              </td><%-- 代理人: --%>
                              <td>
                                  <b:write  property="AgentToName"/>
                                  <h:hidden property="AgentToName"/>
                                  <h:hidden   name="AgentTo/id"       property="AgentTo/id" />
                                  <h:hidden   name="AgentTo/typeCode" property="AgentTo/typeCode" />
                                  <h:hidden   name="AgentTo/name"     property="AgentTo/name" />
                              </td>
                              <td class="EOS_table_row">
                                  <b:message key="detail_full_agent_jsp.end_time"/>
                              </td><%-- 终止时间: --%>
                              <td>
                                  <b:write  property="EndTime" formatPattern="yyyy-MM-dd hh:MM"/>
                                  <input type="hidden" name="EndTime" value='<b:write  property="EndTime" formatPattern="yyyy-MM-dd hh:MM"/>'>
                              </td>
                            </tr>
							<tr>
							  <td class="EOS_table_row">
							      <b:message key="detail_full_agent_jsp.agent_style"/>
							  </td><%-- 代理方式: --%>
                              <td>
                                  <b:message key="mgr_agent_jsp.part_agent"/>
                              </td><%-- 部分代理 --%>
                              <td class="EOS_table_row"></td>
                              <td></td>
                            </tr>
							<tr>
							  <td class="EOS_table_row" nowrap="nowrap">
							      <b:message key="detail_full_agent_jsp.agent_reason"/>
							  </td><%-- 代理原因: --%>
                              <td colspan="3" style="table-layout:fixed;word-wrap: break-word">
                                  <div style="width: 800px"><b:write  property="AgentReason"/></div>
                                  <h:textarea style="display:none"  name="AgentReason" property="AgentReason" />
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
            <table border="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head" valign="middle"><b:message key="add_part_agent2_jsp.set_agent_proc_act"/></td><%-- 设置代理流程和活动 --%>
              </tr>
              <tr>
                <td width="100%"  height="440"  valign="top">
                  <table border="0" class="EOS_table" width="100%">
		                    <tr class="EOS_table_head">
							  <th nowrap><b:message key="add_part_agent2_jsp.proc_act_def_id"/></th><%-- 流程/活动定义ID --%>
							  <th nowrap><b:message key="add_part_agent2_jsp.type"/></th><%-- 类型 --%>
		                      <th nowrap><b:message key="add_part_agent2_jsp.proc_act_name"/></th><%-- 流程/活动名称 --%>
		                      <th nowrap><b:message key="add_part_agent2_jsp.proc_op_permission"/></th><%-- 流程操作权限 --%>
							  <th nowrap><b:message key="add_part_agent2_jsp.owner_pro_id"/></th><%-- 活动所属流程定义ID --%>
		                    </tr>
                	  <l:iterate id="list" property="AgentItemInfo">
						    <tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
			                      <td>
			                         <b:write iterateId="list" property="defID"/>
			                      </td>
			                      <td>
			                         <d:write  dictTypeId="WFDICT_AgentItemType"    iterateId="list"  property="itemType"/>
			                      </td>
								  <td>
								     <b:write iterateId="list" property="defCHName"/>
								  </td>
		                          <td>
			                          	<l:equal iterateId="list" property="itemType" targetValue="PROCESS">
								         	<d:select iterateId="list" property="accessType" dictTypeId="WFDICT_ProOperateType" name="AccessType"/>
			                          	</l:equal>
			                          	<l:equal iterateId="list" property="itemType" targetValue="ACTIVITY">
			                             <b:message key="add_part_agent2_jsp.none"/>
			                          	</l:equal>
		                      	  </td><%-- 无 --%>
		                          <td>
				                        <l:equal iterateId="list" property="itemType" targetValue="PROCESS">
				                         <b:message key="add_part_agent2_jsp.none"/>
				                        </l:equal>
				                        <l:equal iterateId="list" property="itemType" targetValue="ACTIVITY">
				                          <b:write iterateId="list" property="proDefID"/>
				                        </l:equal>
		                          </td><%-- 无 --%>
	                         </tr>
				       </l:iterate>
				       <!--<h:hidden property="AgentItemList"/>-->
				       <l:iterate id="list2" property="AgentItemList">
				               <h:hidden iterateId="list2" name="AgentItemList/agentID" property="agentID"  indexed="true"/>
				               <h:hidden iterateId="list2" name="AgentItemList/agentItemID" property="agentItemID"  indexed="true"/>
				               <h:hidden iterateId="list2" name="AgentItemList/itemID" property="itemID"  indexed="true"/>
				               <h:hidden iterateId="list2" name="AgentItemList/itemType" property="itemType"  indexed="true"/>
                       </l:iterate> 
                       <l:iterate id="list3" property="proAct">
				               <h:hidden iterateId="list3" name="proAct/id" property="id" indexed="true"/>
							   <h:hidden iterateId="list3" name="proAct/type" property="type" indexed="true"/>
                       </l:iterate>
				       <l:iterate id="list4" property="listSelect">
				               <h:hidden iterateId="list4" name="listSelect" property="/" indexed="true"/>
                       </l:iterate>
                       
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
                    <tr>
                      <td class="form_bottom">
						   <input type="button" id="backBtn" name="Button1" value="<b:message key="add_part_agent2_jsp.back"/>" class="button" onClick="doPartAgentBack();"><%-- 上一步 --%>
					       <input type="button" id="submitBtn" name="Button2" value="<b:message key="mod_full_agent_jsp.submit"/>" class="button" onClick="doModPartAgent();"><%-- 提交 --%>
					       <input type="button" id="cancelBtn" name="Button3" value="<b:message key="mod_full_agent_jsp.cancel"/>" class="button" onClick="doBack();"><%-- 取消 --%>
                      </td>
                      <!--<td align="right" >3条记录 页次1/1 <a href="#">首页</a> | <a href="#">上一页</a> | <a href="#">下一页</a> | <a href="#">末页</a></td>-->
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
<%@ include file="/workflow/wfmanager/common/tail.jsp"%>
<script  language="JavaScript"  type="text/javascript">
<!-- 
    function doPartAgentBack(){
	    document.forms['partform2'].action ='com.primeton.workflow.manager.agent.modPartAgent.flow';
	    document.forms['partform2']._eosFlowAction.value = "action6";
	    document.forms['partform2'].submit();
	}
	
    function doModPartAgent(){
	    $name("Button2").disabled = true;
	    document.forms['partform2'].action ='com.primeton.workflow.manager.agent.modPartAgent.flow';
	    document.forms['partform2']._eosFlowAction.value = "action2";
	    document.forms['partform2'].submit();
	}
	
	function doBack(){
        document.forms['partform2'].action ='com.primeton.workflow.manager.agent.modPartAgent.flow';
	    document.forms['partform2']._eosFlowAction.value = "cancel2";
	    document.forms['partform2'].submit();
     }
//-->
</script>