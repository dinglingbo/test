<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/agent/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("mod_full_agent_jsp.select");
 %>
<form action="" method="post" name="fullform">
<h:hidden property="_eosFlowAction"/>
<h:hidden property="_eosFlowKey"/>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
    <td class="workarea_title" valign="middle"><b:message key="mod_full_agent_jsp.modify_total_agent"/></td><%-- 修改完全代理 --%>
  </tr>
  <tr>
    <td width="100%" valign="top">
      <table cellpadding="0" width="100%" cellspacing="0" border="0">
        <tr>
          <td>
            <table border="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head"><b:message key="mod_full_agent_jsp.modify_agent_relation"/></td><%-- 修改代理关系 --%>
              </tr>
              <tr>
                <td width="100%">
                 
                          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
                            <tr>
                              <td  nowrap class="EOS_table_row"><b:message key="mod_full_agent_jsp.client"/></td><%-- 委托人: --%>
                              <td  nowrap>
                                <h:hidden property="AgentID"/>
                                <h:text property="AgentFromName" size="32" readonly="true"/>
							    <wf:selectParticipant  id="AgentFrom" value="<%=select %>" form="fullform" output="AgentFromName" hidden="AgentFromID" hiddenType="ID" root="" maxNum="1" selectTypes='<%=(String)request.getAttribute("leafType")%>' styleClass="button"/><%-- 选择... --%>
							     <l:present property="AgentFromID">
							        		<h:hidden  name="AgentFromID"  property="AgentFromID" />
							        	    <script>
							        	             var selectedAgent3 = new Array() ;
									                 var partObj3 = {} ;
	  							               	     partObj3.id = '<b:write  property="AgentFromID"/>' ; 
	  							               	     partObj3.name = '<b:write  property="AgentFromName"/>' ; 
								               		 selectedAgent3.push(partObj3);
								               		 dcatchMgr3 = new DataCatchMgr() ;
				               				         dcatchMgr3.createDataCatch('AgentFrom',selectedAgent3);	
							        	    </script>
							    </l:present>
                              <font style="color:red">*</font></td>
                              <td nowrap class="EOS_table_row"><b:message key="mod_full_agent_jsp.agent_style"/></td><%-- 代理方式: --%>
                              <td nowrap><b:message key="mod_full_agent_jsp.total_agent"/>
                                <h:hidden property="AgentType" value="ALL"/>
                              </td><%-- 完全代理 --%>
                            </tr>
                            <tr>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.agent"/></td><%-- 代理人: --%>
                              <td>
								<h:text property="AgentToName" size="32" readonly="true"/>
						        <wf:selectParticipant id="AgentTo" value="<%=select %>" form="fullform" output="AgentToName" hidden="AgentTo" hiddenType="PARTICIPANT" root="" maxNum="1" styleClass="button"/><%-- 选择... --%>
						          <l:present property="AgentTo">
							        		<h:hidden  name="AgentTo/id"       property="AgentTo/id" />
	                                        <h:hidden  name="AgentTo/typeCode" property="AgentTo/typeCode" />
	                                        <h:hidden  name="AgentTo/name"     property="AgentTo/name" />
							        	    <script>
							        	             var selectedAgents = new Array() ;
									                 var partObj1 = {} ;
	  							               	    partObj1.id = '<b:write  property="AgentTo/id"/>' ;   
	 								               	 partObj1.type = '<b:write  property="AgentTo/typeCode"/>' ;   
									               	 partObj1.name = '<b:write  property="AgentTo/name"/>' ;	 
								               		 selectedAgents.push(partObj1);
								               		 dcatchMgr1 = new DataCatchMgr() ;
				               				         dcatchMgr1.createDataCatch('AgentTo',selectedAgents);	
							        	    </script>
							      </l:present>
							  <font style="color:red">*</font></td>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.efficient_time"/></td><%-- 生效时间: --%>
                              <td>
                                <w:date format="yyyy-MM-dd HH:mm:ss" name="StartTime" size="32" property="StartTime"  readonly="true" defaultNull="true"/>
                              <font style="color:red">*</font></td>
                            </tr>
							<tr>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.add_exception_process"/></td><%-- 增加例外流程: --%>
                              <td>
							      <input id="chb" type="checkbox" onclick="setCheckbox()" />&nbsp;
		   			              <input type="button"  class="button" id="proSelect" name="proSelect" value="<%=select %>" onclick="<wf:selectProcessAndActivity id='selectppanddact' genScript='true' name='select' output='listSelect' form='fullform' isShowActivity='false'  hiddenType='PROCESS' hidden='process'/>"><%-- 选择... --%>
							      <h:hidden property="isSelectPro"/>
							  </td>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.end_time"/></td><%-- 终止时间: --%>
                              <td>
							    <w:date format="yyyy-MM-dd HH:mm:ss" name="EndTime" size="32" property="EndTime"  readonly="true" defaultNull="true"/>
                              <font style="color:red">*</font></td>
                            </tr>
							<tr>
							  <td class="EOS_table_row"></td>
							  <td>
							     <select id="listSelect" size="6" style=""  class="select" name="listSelect"  multiple="multiple"  >
								    <script>var selectedParts = new Array() ;</script>
							     	<l:present property="listSelect">
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
				                   </select>
				                   <l:present property="process">
							     		<l:iterate id="list4" property="process">
							      			<h:hidden iterateId="list4" name="process/id" property="id" indexed="true"/>
							   				<h:hidden iterateId="list4" name="process/type" property="type" indexed="true"/>
							      		</l:iterate>
							       </l:present>
							  </td>
                              <td class="EOS_table_row"><b:message key="mod_full_agent_jsp.agent_reason"/></td><%-- 代理原因: --%>
                              <td>
                                 <h:textarea style="width: 206px;height: 90px"  name="AgentReason" property="AgentReason"/>
						     <font style="color:red">*</font></td>
							</tr>
							<tr>
                              <td colspan="4" class="form_bottom">
                                 <input  type="button" id="submitBtn" name="Button1" value="<b:message key="mod_full_agent_jsp.submit"/>" class="button" onclick="doModFullAgent();"><%-- 提交 --%>
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
//FIXME:document.getElementById --> $id
    isselpro=$name("isSelectPro");
   if(isselpro.value==""){
   		isselpro.value = "true";
   		$id("chb").checked = true;
   		$name("proSelect").disabled = false;
        $id("listSelect").disabled = false;
   } 
    
   issel='<b:write  property="isSelectPro"/>';
   if(issel=="true"){
   		$id("chb").checked = true;
        $name("proSelect").disabled = false;
        $id("listSelect").disabled = false;  
   } 
   if(issel=="false"){
   		$id("chb").checked = false;
   		$name("proSelect").disabled = true;
        $id("listSelect").disabled = true;
   }
		
    function checkForm(){
        var agfromname=document.forms['fullform'].AgentFromName.value;
        var agtoname=document.forms['fullform'].AgentToName.value;
        var stime=document.forms['fullform'].StartTime.value;
        var etime=document.forms['fullform'].EndTime.value;
        var agrea=document.forms['fullform'].AgentReason.value;
        
        if(agfromname==""||agtoname==""||trim(agrea)==""||stime==""||etime==""){
			alert("<b:message key="mod_full_agent_jsp.input_complete"/>");//请将带*的内容填写完整.
			return false;
		}
		
		var agfromid=document.forms['fullform'].AgentFromID.value;
		var agfromtc='<b:write  property="leafType"/>';
	    var t=document.forms['fullform'].elements['AgentTo/id'].value;
	    var tc=document.forms['fullform'].elements['AgentTo/typeCode'].value;
	    if(t==agfromid&&tc==agfromtc){
	           alert("<b:message key="mod_full_agent_jsp.cannot_agent_to_client"/>");//不能代理给委托人.
			   return false;
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
    
	function doModFullAgent(){
		$name("Button1").disabled = true;
	    if(!checkForm()) {
	    	$name("Button1").disabled = false;
          	return false;
	    }
	    document.forms['fullform'].action ='com.primeton.workflow.manager.agent.modFullAgent.flow';
	    document.forms['fullform']._eosFlowAction.value = "action1";
	    var legth = document.forms['fullform'].listSelect.options.length; 
	    for(var i=0;i<legth;++i) {
	    	//var spat = document.forms['fullform'].listSelect.options[i].value ;
	    	document.forms['fullform'].listSelect.options[i].selected ="true" ;
	    }
	    document.forms['fullform'].submit();
	}
	
	function doBack(){
        document.forms['fullform'].action ='com.primeton.workflow.manager.agent.modFullAgent.flow';
	    document.forms['fullform']._eosFlowAction.value = "cancel";
	    document.forms['fullform'].submit();
     }

	/**
    *设置按钮是否可用
	*/
	function setCheckbox(){ 
        if($id("chb").checked == true){
             $name("proSelect").disabled = false;
             $id("listSelect").disabled = false;
             $name("isSelectPro").value = "true";            
           }else{
             $name("proSelect").disabled = true;
             $id("listSelect").disabled = true;
             $name("isSelectPro").value = "false";
           }
	}
	
//-->
</script>