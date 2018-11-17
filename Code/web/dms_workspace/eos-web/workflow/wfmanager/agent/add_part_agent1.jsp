<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/workflow/wfmanager/agent/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("mod_full_agent_jsp.select");
 %>
<form action="" method="post" name="partform">
<h:hidden property="_eosFlowAction"/>
<h:hidden property="_eosFlowKey"/>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
    <td class="workarea_title" valign="middle"><b:message key="add_part_agent1_jsp.add_part_agent"/></td><%-- 添加部分代理 --%>
  </tr>
  <tr>
    <td width="100%" valign="top">
      <table cellpadding="0" width="100%" cellspacing="0" border="0">
        <tr>
          <td>
            <table border="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head"><b:message key="add_full_agent_jsp.set_agent_relation"/></td><%-- 设置代理关系 --%>
              </tr>
              <tr>
                <td width="100%">
                 
                          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
                            <tr>
                              <td  nowrap class="EOS_table_row"><b:message key="mod_full_agent_jsp.client"/></td><%-- 委托人: --%>
                              <td  nowrap>
	                                <h:text  property="AgentFromName" size="32" readonly="true"/>
									<wf:selectParticipant  id="AgentFrom" value="<%=select %>" form="partform" output="AgentFromName" hidden="AgentFromID" hiddenType="ID" root="" maxNum="1" selectTypes='<%=(String)request.getAttribute("leafType")%>' styleClass="button"/><%-- 选择... --%>
								    <l:present property="AgentFromID">
								          <h:hidden property="AgentFromID"/>
								          <script>
								          	 var agentFromArray = new Array() ;
								          	 var partObj = {} ;
								          	 partObj.id = '<b:write property="AgentFromID"/>' ;
								          	 partObj.name = '<b:write property="AgentFromName"/>';
								          	 agentFromArray.push(partObj);
								          	 
								          	 dcatchMgr = new DataCatchMgr() ;
				               				 dcatchMgr.createDataCatch('AgentFrom',agentFromArray);				                      		
								          </script>
								    </l:present>
							  <font style="color:red">*</font></td>
                              <td nowrap class="EOS_table_row"><b:message key="mod_full_agent_jsp.agent_style"/></td><%-- 代理方式: --%>
                              <td nowrap><b:message key="add_part_agent1_jsp.part_agent"/>
                                <h:hidden property="AgentType" value="PART"/>
                              </td><%-- 部分代理 --%>
                            </tr>
                            <tr>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.agent"/></td><%-- 代理人: --%>
                              <td>
									<h:text  property="AgentToName" size="32" readonly="true"/>
							        <wf:selectParticipant  id="AgentTo" value="<%=select %>" form="partform" output="AgentToName" hidden="AgentTo" hiddenType="PARTICIPANT" root="" styleClass="button"/><%-- 选择... --%>
							          <l:present property="AgentTo">
		                                <script>var selectedAgents = new Array() ;</script>
							        	<l:iterate id="agentTo" property="AgentTo">
							        		<h:hidden  iterateId="agentTo" name="AgentTo/id" property="id" indexed="true"/>
	                                        <h:hidden  iterateId="agentTo" name="AgentTo/typeCode" property="typeCode" indexed="true"/>
	                                        <h:hidden  iterateId="agentTo" name="AgentTo/name" property="name" indexed="true"/>
							        	    <script>
									               				 var partObj1 = {} ;
	  							               				 	 partObj1.id = '<b:write iterateId="agentTo" property="id"/>' ;   
	 								               				 partObj1.type = '<b:write iterateId="agentTo" property="typeCode"/>' ;   
									               				 partObj1.name = '<b:write iterateId="agentTo" property="name"/>' ;	 
								               				 	 selectedAgents.push(partObj1);
							        	    </script>
							        	</l:iterate>
							        	<script>
							        		  dcatchMgr1 = new DataCatchMgr() ;
				               				  dcatchMgr1.createDataCatch('AgentTo',selectedAgents);				                      		
				               				  //create hidden field
							        	</script>
							        </l:present>
                              <font style="color:red">*</font></td>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.efficient_time"/></td><%-- 生效时间: --%>
                              <td>
                                <w:date format="yyyy-MM-dd HH:mm" name="StartTime" size="32" property="StartTime"  readonly="true" defaultNull="true"/>
                              <font style="color:red">*</font></td>
                            </tr>
							<tr>
                              <td class="EOS_table_row"><b:message key="add_part_agent1_jsp.agent_process_act"/></td><%-- 代理流程和活动: --%>
                              <td>
                                  <wf:selectProcessAndActivity id="selectppanddact"  name="proActSelect"  value="<%=select %>" output="listSelect" form="partform"  hiddenType="PROCESS" hidden="proAct" activityType="manual" styleClass="button"/><%-- 选择... --%>
							  </td>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.end_time"/></td><%-- 终止时间: --%>
                              <td>
							    <w:date format="yyyy-MM-dd HH:mm" name="EndTime" size="32" property="EndTime"  readonly="true" defaultNull="true"/>
                              <font style="color:red">*</font></td>
                            </tr>
							<tr>
							  <td class="EOS_table_row"></td>
							  <td>
							     <select id="listSelect" size="6" style=" " class="select" name="listSelect"  multiple="multiple"  >
							     	<l:present property="listSelect">
							     	    <script>var selectedParts = new Array() ;</script>
							     		<l:iterate id="list3" property="listSelect">
								               <option value='<b:write iterateId="list3" property="/"/>'>
								               			<script>
								               				 patici =  '<b:write iterateId="list3" property="/"/>';
							               				 	 var partAry = patici.split("&amp;");
								               				 var partObj2 = {} ;
  							               				 	
  							               				 	 partObj2.id = partAry[0] ;   
 								               				 partObj2.name = partAry[1] ;   
								               				 partObj2.type = partAry[2] ;	 
								               				 document.write(partAry[1]) ;
								               				 
							               				 	 selectedParts.push(partObj2);
								               			</script>
								               	</option>
								               	 
				                       </l:iterate>
				                       <script>
				                          dcatchMgr2 = new DataCatchMgr() ;
			               				  dcatchMgr2.createDataCatch('selectppanddact',selectedParts);				                      		
				                       </script>
				                    </l:present>
								 </select><font style="color:red">*</font>
								 <l:present property="proAct">
							     		<l:iterate id="list4" property="proAct">
							      			<h:hidden iterateId="list4" name="proAct/id" property="id" indexed="true"/>
							  				<h:hidden iterateId="list4" name="proAct/type" property="type" indexed="true"/>
							      		</l:iterate>
							     </l:present>
							  </td>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.agent_reason"/></td><%-- 代理原因: --%>
                              <td>
                                 <h:textarea style="width: 206px;height: 96px"  name="AgentReason" property="AgentReason"/>
						     <font style="color:red">*</font></td>
							</tr>
							<tr>
                              <td colspan="4" class="form_bottom">
                                 <input  type="button" id="nextBtn" name="Button1" value="<b:message key="add_part_agent1_jsp.next"/>" class="button" onclick="doPartAgentNext();"><%-- 下一步 --%>
                                 <input  type="button" id="cancelBtn" name="Button2" value="<b:message key="mod_full_agent_jsp.cancel"/>" class="button" onClick="doBack();"><%-- 取消 --%>
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
<script  language="JavaScript"  type="text/javascript">
<!--  

    function checkForm(){
        var agfromname=document.forms['partform'].AgentFromName.value;
        var agtoname=document.forms['partform'].AgentToName.value;
        var stime=document.forms['partform'].StartTime.value;
        var etime=document.forms['partform'].EndTime.value;
        var agrea=document.forms['partform'].AgentReason.value;
        var len=document.forms['partform'].listSelect.length;
        
        if(agfromname==""){
        	alert("<b:message key="add_full_agent_jsp.select_client"/>");//请选择委托人
			return false;
        }
        if(agtoname==""){
        	alert("<b:message key="add_full_agent_jsp.select_agent"/>");//请选择代理人
			return false;
        }
        if(len==0){
        	alert("<b:message key="add_part_agent1_jsp.select_agent_proc_act"/>");//请选择代理流程和活动
			return false;
        }
        if(stime==""){
        	alert("<b:message key="add_full_agent_jsp.select_efficient_time"/>");//请选择生效时间
			return false;
        }
        if(etime==""){
        	alert("<b:message key="add_full_agent_jsp.select_end_time"/>");//请选择终止时间
			return false;
        }
        if(trim(agrea)==""){
        	alert("<b:message key="add_full_agent_jsp.select_agent_reason"/>");//请填写代理原因
			return false;
        }
        
		var agfromid=document.forms['partform'].AgentFromID.value;
		var agfromtc='<b:write  property="leafType"/>';
		var n = agtoname.split(",").length;
	    for(var i=1;i<=n;i++){
	        var t=document.forms['partform'].elements['AgentTo['+i+']/id'].value;
	        var tc=document.forms['partform'].elements['AgentTo['+i+']/typeCode'].value;
	        if(t==agfromid&&tc==agfromtc){
	           alert("<b:message key="mod_full_agent_jsp.cannot_agent_to_client"/>");//不能代理给委托人.
			   return false;
	        }
	    }
	
		if(stime>=etime){//以后要改为>=
			alert("<b:message key="mod_full_agent_jsp.efficient_earlier"/>");//生效时间应该小于终止时间,请重新输入.
			return false;
		}
		
		if(getRealLength(trim(agrea))>=501){
			alert("<b:message key="mod_full_agent_jsp.reason_length"/>");//代理原因长度不能大于500个字符
			return false;
		}
		
		return true;
    }
    
	function doPartAgentNext(){
	    if(!checkForm()) 
	          return false;
	    document.forms['partform'].action ='com.primeton.workflow.manager.agent.addPartAgent.flow';
	    document.forms['partform']._eosFlowAction.value = "action1";
	    var legth = document.forms['partform'].listSelect.options.length; 
	    for(var i=0;i<legth;++i) {
	    	//var spat = document.forms['partform'].listSelect.options[i].value ;
	    	document.forms['partform'].listSelect.options[i].selected ="true" ;
	    }
	    document.forms['partform'].submit();
	}
	
	function doBack(){
        document.forms['partform'].action ='com.primeton.workflow.manager.agent.addPartAgent.flow';
	    document.forms['partform']._eosFlowAction.value = "cancel1";
	    document.forms['partform'].submit();
     }
	
//-->
</script>