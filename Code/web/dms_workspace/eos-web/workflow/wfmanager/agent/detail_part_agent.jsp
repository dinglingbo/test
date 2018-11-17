<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/workflow/wfmanager/agent/head.jsp"%>
<form action="" method="post" name="detailform">
<h:hidden  name="agentID" property="AgentDetail/agentID" />
<h:hidden property="_eosFlowAction"/>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
    <td class="workarea_title" valign="middle"><b:message key="detail_full_agent_jsp.agent_info"/></td><%-- 代理信息 --%>
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
                              <td  nowrap class="EOS_table_row"><b:message key="detail_full_agent_jsp.client"/></td><%-- 委托人: --%>
                              <td  nowrap><b:write  property="AgentDetail/agentFrom"/></td>
                              <td nowrap class="EOS_table_row"><b:message key="detail_full_agent_jsp.agent"/></td><%-- 代理人: --%>
                              <td nowrap><b:write  property="AgentDetail/agentTo"/></td>
                            </tr>
                            <tr>
                              <td class="EOS_table_row"><b:message key="detail_full_agent_jsp.efficient_time"/></td><%-- 生效时间: --%>
                              <td><b:write  property="AgentDetail/startTime" formatPattern="yyyy-MM-dd HH:mm"/></td>
                              <td class="EOS_table_row"><b:message key="detail_full_agent_jsp.end_time"/></td><%-- 终止时间: --%>
                              <td><b:write  property="AgentDetail/endTime" formatPattern="yyyy-MM-dd HH:mm"/></td>
                            </tr>
							<tr>
							  <td class="EOS_table_row"><b:message key="detail_full_agent_jsp.agent_style"/></td><%-- 代理方式: --%>
                              <td><b:message key="add_part_agent1_jsp.part_agent"/></td><%-- 部分代理 --%>
                              <td class="EOS_table_row"></td>
                              <td></td>
                            </tr>
							<tr>
							  <td class="EOS_table_row" nowrap="nowrap"><b:message key="detail_full_agent_jsp.agent_reason"/></td><%-- 代理原因: --%>
                              <td colspan="3" style="table-layout:fixed;word-wrap: break-word"><div style="width: 800px"><b:write  property="AgentDetail/agentReason"/></div></td>
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
                <td class="EOS_panel_head" valign="middle"><b:message key="detail_part_agent_jsp.pro_act_list"/></td><%-- 流程活动列表 --%>
              </tr>
              <tr>
                <td width="100%"  height="440"  valign="top">
                  <table border="0" class="EOS_table" width="100%">
                    <tr class="EOS_table_head">
                      <th nowrap><b:message key="detail_part_agent_jsp.pro_act_def_id"/></th><%-- 流程/活动定义ID --%>
					  <th nowrap><b:message key="detail_part_agent_jsp.type"/></th><%-- 类型 --%>
                      <th nowrap><b:message key="detail_part_agent_jsp.pro_act_name"/></th><%-- 流程/活动名称 --%>
                      <th nowrap><b:message key="detail_part_agent_jsp.pro_op_permission"/></th><%-- 流程操作权限 --%>
					  <th nowrap><b:message key="add_part_agent2_jsp.owner_pro_id"/></th><%-- 活动所属流程定义ID --%>
                    </tr>
                    <l:present property="AgentItemInfo">
                      <% int flag =0;%>
                	  <l:iterate id="list" property="AgentItemInfo">
                	        <tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
		                      <td><b:write iterateId="list" property="defID"/></td>
		                      <td><d:write  dictTypeId="WFDICT_AgentItemType"    iterateId="list"  property="itemType"/></td>
		                      <td><b:write iterateId="list" property="defCHName"/></td>
							  <td>	
							  			<l:equal iterateId="list" property="itemType" targetValue="PROCESS">
				                         	<d:write  dictTypeId="WFDICT_ProOperateType"    iterateId="list"  property="accessType"/>
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
		              <%flag++; %>
                	  </l:iterate> 
                	  <%
				            if(flag<5){
				              for(int i = flag; i < 5;i++){ %> 
				         <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
							  <td></td>
		                      <td></td>
		                 </tr>
				      <%      }
					        } %>
				    </l:present>
				    <l:notPresent  property="AgentItemInfo">
		                    <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
							  <td></td>
		                      <td></td>
		                    </tr>
		                    <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
							  <td></td>
		                      <td></td>
		                    </tr>
		                    <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
							  <td></td>
		                      <td></td>
		                    </tr>
		                    <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
							  <td></td>
		                      <td></td>
		                    </tr>
		                    <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
							  <td></td>
		                      <td></td>
		                    </tr>
                    </l:notPresent>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
                    <tr>
                      <td class="form_bottom">
                          <h:hidden    property="Client" />
                          <h:hidden    property="ClientID" />
                          <h:hidden    property="Surrogate" />
                          <h:hidden    property="SurrogateID" />
                          <h:hidden    property="Useful" />
					      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="modifyBtn" name="Button2" value="<b:message key="detail_full_agent_jsp.modify"/>" class="button"  onClick="doModifyAgent();"><%-- 修改 --%>
					      <input type="button" id="backBtn" name="Button1" value="<b:message key="detail_full_agent_jsp.back"/>" class="button" onClick="doBack();"><%-- 返回 --%>
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
<script type="text/javascript" language="javascript">
<!-- 
     function doBack(){
     //FIXME:document.getElementById --> $id
	    var clet=$name("Client").value;
        var surrg=$name("Surrogate").value;
        var use=$name("Useful").value;
        if(clet==""&&surrg==""&&use=="ALL"){
    	     document.forms['detailform'].action ='com.primeton.workflow.manager.agent.queryAgent.flow';
	         document.forms['detailform']._eosFlowAction.value = "initial";
	         document.forms['detailform'].submit();
    	 }else{
    	     document.forms['detailform'].action ='com.primeton.workflow.manager.agent.queryAgent.flow';
	         document.forms['detailform']._eosFlowAction.value = "query";
	         document.forms['detailform'].submit();
    	 }
     }
     
      //修改某代理关系
	 function doModifyAgent(){
       	 var el = $name('agentID').value;
      	 $name('detailform').action ='com.primeton.workflow.manager.agent.modAgent.flow';
   	     $name('detailform')._eosFlowAction.value = "mod";	    	 
    	 $name('detailform').submit();
	 } 
//-->
</script>
