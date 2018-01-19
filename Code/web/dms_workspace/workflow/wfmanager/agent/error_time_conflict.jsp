<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/agent/head.jsp"%>
<form action="" method="post" name="errorform">
<h:hidden property="_eosFlowAction"/>
<h:hidden property="_eosFlowKey"/>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
    <td class="workarea_title" valign="middle"><b:message key="error_time_conflict_jsp.error_page"/></td><%-- 错误页面 --%>
  </tr>
  <tr>
    <td width="100%" valign="top">
      <table cellpadding="0" width="100%" cellspacing="0" border="0">
        <tr>
          <td>
            <table border="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head"><b:message key="error_time_conflict_jsp.agent_time_conflict"/></td><%-- 代理时间冲突 --%>
              </tr>
              <tr>
                <td width="100%">
                 
                          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
                            <tr>
                                <div align="center"><b:message key="error_time_conflict_jsp.cannot_agent_reason"/></div><%-- 您所设的委托给代理人的代理时间范围与已有的代理时间范围重叠，不能创建代理关系。 --%>
                                <l:present property="addfull">
	                                <h:hidden  property="AgentFromName"/>
	                                <h:hidden property="AgentFromID"/>
	                                <h:hidden property="AgentToName"/>
	                                <l:iterate id="list1" property="AgentTo">
	                                       <h:hidden  iterateId="list1" name="AgentTo/id" property="id" indexed="true"/>
	                                       <h:hidden  iterateId="list1" name="AgentTo/typeCode" property="typeCode" indexed="true"/>
	                                       <h:hidden  iterateId="list1" name="AgentTo/name" property="name" indexed="true"/>
	                                </l:iterate>
	                                <input type="hidden" name="StartTime" value='<b:write  property="StartTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <input type="hidden" name="EndTime" value='<b:write  property="EndTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <l:iterate id="list2" property="process">
					               			<h:hidden iterateId="list2" name="process/id"   property="id"   indexed="true"/>
								   			<h:hidden iterateId="list2" name="process/type" property="type" indexed="true"/>
	                       			</l:iterate> 
					       			<l:iterate id="list3" property="listSelect">
					               			<h:hidden iterateId="list3" name="listSelect" property="/" indexed="true"/>
	                       			</l:iterate>
	                                <h:hidden property="AgentReason"/>
	                                <h:hidden property="isSelectPro"/>
	                            </l:present>
	                            <l:present property="addpart">
	                                <h:hidden  property="AgentFromName"/>
	                                <h:hidden property="AgentFromID"/>
	                                <h:hidden property="AgentToName"/>
	                                <l:iterate id="list4" property="AgentTo">
	                                       <h:hidden  iterateId="list4" name="AgentTo/id" property="id" indexed="true"/>
	                                       <h:hidden  iterateId="list4" name="AgentTo/typeCode" property="typeCode" indexed="true"/>
	                                       <h:hidden  iterateId="list4" name="AgentTo/name" property="name" indexed="true"/>
	                                </l:iterate>
	                                <input type="hidden" name="StartTime" value='<b:write  property="StartTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <input type="hidden" name="EndTime" value='<b:write  property="EndTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <l:iterate id="list5" property="proAct">
					               			<h:hidden iterateId="list5" name="proAct/id"   property="id"   indexed="true"/>
								   			<h:hidden iterateId="list5" name="proAct/type" property="type" indexed="true"/>
	                       			</l:iterate> 
					       			<l:iterate id="list6" property="listSelect">
					               			<h:hidden iterateId="list6" name="listSelect" property="/" indexed="true"/>
	                       			</l:iterate>
	                                <h:hidden property="AgentReason"/>
	                            </l:present>
	                            <l:present property="modfull">
	                                <h:hidden property="AgentID"/>
	                                <h:hidden  property="AgentFromName"/>
	                                <h:hidden property="AgentFromID"/>
	                                <h:hidden property="AgentToName"/>
	                                <h:hidden   name="AgentTo/id"       property="AgentTo/id" />
                                    <h:hidden   name="AgentTo/typeCode" property="AgentTo/typeCode" />
                                    <h:hidden   name="AgentTo/name"     property="AgentTo/name" />
	                                <input type="hidden" name="StartTime" value='<b:write  property="StartTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <input type="hidden" name="EndTime" value='<b:write  property="EndTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <l:iterate id="list7" property="process">
					               			<h:hidden iterateId="list7" name="process/id"   property="id"   indexed="true"/>
								   			<h:hidden iterateId="list7" name="process/type" property="type" indexed="true"/>
	                       			</l:iterate> 
					       			<l:iterate id="list8" property="listSelect">
					               			<h:hidden iterateId="list8" name="listSelect" property="/" indexed="true"/>
	                       			</l:iterate>
	                                <h:hidden property="AgentReason"/>
	                                <h:hidden property="isSelectPro"/>
	                            </l:present>
	                             <l:present property="modpart">
	                                <h:hidden property="AgentID"/>
	                                <h:hidden  property="AgentFromName"/>
	                                <h:hidden property="AgentFromID"/>
	                                <h:hidden property="AgentToName"/>
	                                <h:hidden   name="AgentTo/id"       property="AgentTo/id" />
                                    <h:hidden   name="AgentTo/typeCode" property="AgentTo/typeCode" />
                                    <h:hidden   name="AgentTo/name"     property="AgentTo/name" />
	                                <input type="hidden" name="StartTime" value='<b:write  property="StartTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <input type="hidden" name="EndTime" value='<b:write  property="EndTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>'>
	                                <l:iterate id="list9" property="proAct">
					               			<h:hidden iterateId="list9" name="proAct/id"   property="id"   indexed="true"/>
								   			<h:hidden iterateId="list9" name="proAct/type" property="type" indexed="true"/>
	                       			</l:iterate> 
					       			<l:iterate id="list10" property="listSelect">
					               			<h:hidden iterateId="list10" name="listSelect" property="/" indexed="true"/>
	                       			</l:iterate>
	                                <h:hidden property="AgentReason"/>
	                            </l:present>
                            </tr>
							<tr>
                              <td colspan="4" class="form_bottom">
                                 <input  type="button" id="backBtn" name="Button1" value="<b:message key="error_time_conflict_jsp.back"/>" class="button" onclick="doAllAgentBack();"><%-- 返回 --%>
                                 <input  type="button" id="cancelBtn" name="Button2" value="<b:message key="error_time_conflict_jsp.cancel"/>" class="button" onClick="doBack();"><%-- 取消 --%>
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
<%@ include file="/workflow/wfmanager/common/tail.jsp"%>
<script language="JavaScript" type="text/javascript">
<!-- 
    function doAllAgentBack(){
        document.forms['errorform'].action ='<b:write  property="act"/>';
	    document.forms['errorform']._eosFlowAction.value = '<b:write  property="floact1"/>';
	    document.forms['errorform'].submit();
    }

    function doBack(){
        document.forms['errorform'].action ='<b:write  property="act"/>';
	    document.forms['errorform']._eosFlowAction.value = '<b:write  property="floact2"/>';
	    document.forms['errorform'].submit();
     }
//-->
</script>