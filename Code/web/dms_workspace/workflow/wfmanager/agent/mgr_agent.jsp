<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/workflow/wfmanager/agent/head.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("mgr_agent_jsp.select");
String all = ResourcesMessageUtil.getI18nResourceMessage("mgr_agent_jsp.all");
String efficient = ResourcesMessageUtil.getI18nResourceMessage("mgr_agent_jsp.efficient");
String inefficient = ResourcesMessageUtil.getI18nResourceMessage("mgr_agent_jsp.inefficient");
 %>
<form action="" method="post" name="agentform">
<h:hidden property="_eosFlowAction"/>
<table border="0" cellpadding="1" cellspacing="0" width="100%">
  <tr>
    <td width="100%" valign="top">
      <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
        <tr>
          <td>
            <table border="0" cellpadding="1" cellspacing="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head"><b:message key="mgr_agent_jsp.query_condition"/></td><%-- 查询条件 --%>
              </tr>
              <tr>
                <td width="100%">
                          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
                            <tr>
                              <td  nowrap class="EOS_table_row"><b:message key="mgr_agent_jsp.client"/></td><%-- 委托人: --%>
                              <td  nowrap>
								<h:text  property="Client" size="32" readonly="true"/>
							    <wf:selectParticipant  id="client" value="<%=select %>" form="agentform" output="Client" hidden="ClientID" hiddenType="ID" root="" maxNum="1" selectTypes='<%=(String)request.getAttribute("leafType")%>' styleClass="button"/><%-- 选择... --%>
							     <l:present property="ClientID">
							        		<h:hidden  name="ClientID"  property="ClientID" />
							        	    <script>
							        	             var selectedAgent1 = new Array() ;
									                 var partObj1 = {} ;
	  							               	     partObj1.id = '<b:write  property="ClientID"/>' ; 
	  							               	     partObj1.name = '<b:write  property="Client"/>' ; 
								               		 selectedAgent1.push(partObj1);
								               		 dcatchMgr1 = new DataCatchMgr() ;
				               				         dcatchMgr1.createDataCatch('client',selectedAgent1);	
							        	    </script>
							    </l:present>
                              </td>
                              <td nowrap class="EOS_table_row"><b:message key="mgr_agent_jsp.agent"/></td><%-- 代理人: --%>
                              <td nowrap>
								<h:text  property="Surrogate" size="32" readonly="true"/>
							    <wf:selectParticipant  id="surrogate" value="<%=select %>" form="agentform" output="Surrogate" hidden="SurrogateID" hiddenType="ID" root="" maxNum="1" styleClass="button"/><%-- 选择... --%>
							    <l:present property="SurrogateID">
							        		<h:hidden  name="SurrogateID"  property="SurrogateID" />
							        	    <script>
							        	             var selectedAgent2 = new Array() ;
									                 var partObj2 = {} ;
	  							               	     partObj2.id = '<b:write  property="SurrogateID"/>' ; 
	  							               	     partObj2.name = '<b:write  property="Surrogate"/>' ; 
								               		 selectedAgent2.push(partObj2);
								               		 dcatchMgr2 = new DataCatchMgr() ;
				               				         dcatchMgr2.createDataCatch('surrogate',selectedAgent2);	
							        	    </script>
							    </l:present>
                              </td>
                            </tr>
                            <tr>
                              <td class="EOS_table_row"><b:message key="mgr_agent_jsp.agent_relation_state"/></td><%-- 代理关系状态: --%>
                              <td>
					              <h:select property="Useful">
		                                <h:option value="ALL" label="<%=all %>"></h:option><%-- 全部 --%>
		                                <h:option value="Y" label="<%=efficient %>"></h:option><%-- 生效 --%>
		                                <h:option value="N" label="<%=inefficient %>"></h:option><%-- 不生效 --%>
		                           </h:select>
                              </td>
                              <td class="EOS_table_row"></td>
                              <td>
                              </td>
                            </tr>
							<tr>
                        	  <td colspan="4" class="form_bottom">
                         		 <input type="button" id="queryBtn" name="Button" value="<b:message key="mgr_agent_jsp.query"/>" class="button" onclick="doQuery();"><%-- 查询 --%>
                         		 <input type="button" id="clearBtn" name="Reset" value="<b:message key="mgr_agent_jsp.clear"/>" class="button" onclick="clearP();"><%-- 清空 --%>
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
  <tr>
  	<td>
   		<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
        <tr>
          <td>
            <table border="0" cellpadding="1" cellspacing="0" class="EOS_panel_body" width="100%">
              <tr>
                <td class="EOS_panel_head" valign="middle"><b:message key="mgr_agent_jsp.agent_info"/></td><%-- 代理信息 --%>
              </tr>
              <tr>
                <td width="100%" valign="top">
                  <table border="0" class="EOS_table" width="100%">
                    	<tr class="EOS_table_head">
		                      <th nowrap><input type="checkbox" name="Checkbox" value="checkbox" onclick="SelectAllCheck(this);">&nbsp;<b:message key="mgr_agent_jsp.select_"/></th><%-- 选择 --%>
		                      <th nowrap><b:message key="mgr_agent_jsp.client_id"/></th><%-- 委托人ID --%>
		                      <th nowrap><b:message key="mgr_agent_jsp.agent_id"/></th><%-- 代理人ID --%>
		                      <th nowrap><b:message key="mgr_agent_jsp.agent_type"/></th><%-- 代理人类型 --%>
		                      <th nowrap><b:message key="mgr_agent_jsp.agent_style"/></th><%-- 代理方式 --%>
		                      <th nowrap><b:message key="mgr_agent_jsp.efficient_time"/></th><%-- 生效时间 --%>
		                      <th nowrap><b:message key="mgr_agent_jsp.end_time"/></th><%-- 终止时间 --%>
		                      <th nowrap><b:message key="mgr_agent_jsp.agent_relation_state"/></th><%-- 代理关系状态 --%>
                   		</tr>
                      <% int flag =0;%>
                    <l:present property="agentList">
                	  <l:iterate id="list" property="agentList">
						<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
		                      <td> 
							      <h:checkbox iterateId="list" onclick="doSelect(this);" name="agentID" property="agentID"/>&nbsp;<a href='javascript:doQueryDetail(<b:write iterateId="list" property="agentID"/>);'><b:message key="mgr_agent_jsp.view"/></a><%-- 查看 --%>
		                      </td>
		                      <td>
		                          <b:write iterateId="list" property="agentFrom"/>
                              </td>
		                      <td>
		                          <b:write iterateId="list" property="agentTo"/>
                              </td> 
		                      <td>
		                          <b:set iterateId="list" name="agtoType" property="agentToType"/>
		                          <wf:convertPartiTypeCode typeCode='<%=(String)request.getAttribute("agtoType")%>'/>
		                      </td>
		                      <td>
		                          <l:equal iterateId="list" property="agentType" targetValue="ALL">
		                          <b:message key="mgr_agent_jsp.total_agent"/>
		                          </l:equal><%-- 完全代理 --%>
		                          <l:equal iterateId="list" property="agentType" targetValue="PART">
		                          <b:message key="mgr_agent_jsp.part_agent"/>
		                          </l:equal><%-- 部分代理 --%>
		                          
		                      </td>
		                      <td>
		                          <b:write iterateId="list" property="startTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>
		                      </td>
		                      <td>
		                          <b:write iterateId="list" property="endTime" formatPattern="yyyy-MM-dd HH:mm:ss"/>
                              </td>	
                              <td>
                                 <l:greaterThan     property="startTime"   targetValue="@CurrentTime" compareType="date" iterateId="list"><b:message key="mgr_agent_jsp.inefficient"/></l:greaterThan><%-- 不生效 --%>
                                 <l:lessThan     property="endTime"   targetValue="@CurrentTime" compareType="date" iterateId="list"><b:message key="mgr_agent_jsp.inefficient"/></l:lessThan><%-- 不生效 --%>
                                 <l:lessThan     property="startTime"   targetValue="@CurrentTime" compareType="date" iterateId="list">
                                 	<l:greaterThan     property="endTime"   targetValue="@CurrentTime" compareType="date" iterateId="list"><b:message key="mgr_agent_jsp.efficient"/></l:greaterThan><%-- 生效 --%>
                                 </l:lessThan>
                              </td>			
						 </tr>
						 <%flag++; %>
				      </l:iterate> 
				      <%
				            if(flag<10){
				              for(int i = flag; i < 10;i++){ %> 
				         <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
                    	 </tr>
				      <%      }
					        } %>
				    </l:present>
				    <l:notPresent  property="agentList"> 
                    	 <tr class="EOS_table_row">
		                      <td></td>
		                      <td></td>
		                      <td></td>
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
		                      <td></td>
		                      <td></td>
		                      <td></td>
                    	 </tr>
                    	 <tr class="EOS_table_row"f>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
		                      <td></td>
                    	 </tr>
                     </l:notPresent>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left" >
					      <input type="button" id="modifybtn" name="Button1" value="<b:message key="mgr_agent_jsp.modify"/>" class="button" onclick="doModifyAgent();"><%-- 修改 --%>
						  <input type="button" id="deletebtn" name="Button2" value="<b:message key="mgr_agent_jsp.delete"/>" class="button" onclick="doDeleteAgent();"><%-- 删除 --%>
						  <input type="button" id="addFullAgentbtn" name="Button3" value="<b:message key="mgr_agent_jsp.add_total_agent"/>" class="button" onClick="doAddFullAgent();"><%-- 添加完全代理 --%>
						  <input type="button" id="addPartAgentbtn" name="Button4" value="<b:message key="mgr_agent_jsp.add_part_agent"/>" class="button" onClick="doAddPartAgent();"><%-- 添加部分代理 --%>
                      </td>
                      <!--<td align="right" >2条记录 页次1/1 <a href="#">首页</a> | <a href="#">上一页</a> | <a href="#">下一页</a> | <a href="#">末页</a></td>-->
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
     //添加完全代理
     function doAddFullAgent(){
        document.forms['agentform'].action ='com.primeton.workflow.manager.agent.addFullAgent.flow';
	    document.forms['agentform']._eosFlowAction.value = "full";
	    document.forms['agentform'].submit();
     }
     //添加部分代理
     function doAddPartAgent(){
        document.forms['agentform'].action ='com.primeton.workflow.manager.agent.addPartAgent.flow';
	    document.forms['agentform']._eosFlowAction.value = "part";
	    document.forms['agentform'].submit();
     }
     //查询
     function  doQuery(){
     //FIXME:document.getElementById --> $id
        var clet=$name("Client").value;
        var surrg=$name("Surrogate").value;
        var use=$name("Useful").value;
        if(clet==""&&surrg==""&&use=="ALL"){
    	     document.forms['agentform'].action ='com.primeton.workflow.manager.agent.queryAgent.flow';
	         document.forms['agentform']._eosFlowAction.value = "initial";
	         document.forms['agentform'].submit();
    	 }else{
    	     document.forms['agentform'].action ='com.primeton.workflow.manager.agent.queryAgent.flow';
	         document.forms['agentform']._eosFlowAction.value = "query";
	         document.forms['agentform'].submit();
    	 }
	 }
	 //查询某代理详细信息
	 function  doQueryDetail(agID){
	    document.forms['agentform'].action ='com.primeton.workflow.manager.agent.queryAgentDetail.flow?agID='+agID;
	    document.forms['agentform']._eosFlowAction.value = "detail";
	    document.forms['agentform'].submit();
	 }
	 //检查agentID是否存在
	 function checkAgentID(){
	    var el = document.getElementsByName('agentID');
	    //alert(el.length);
	    //alert(el.value);
	    if(el.length==0)
			 return false;
	    else
	         return true;
	 }
	 
	 function clearP(){
	     $name("Client").value="";
	     $name("Surrogate").value="";
	     dataCatchPool = [];
    	 $name("Useful").options[0].selected=true;
	 }
	 
	 //删除代理
	 function doDeleteAgent(){
	    if(checkAgentID()){
	         var el = document.getElementsByName('agentID');
	      	 var len = el.length;
	       	 var temp=0;
	         for(var i=0; i<len; i++){  
	           if(el[i].checked == true){
	              temp=temp+1;
	           }
	         }
	         if(temp==0){
			    alert("<b:message key="mgr_agent_jsp.select_agent_relation"/>");//请至少选择一个要删除的代理关系.
			    return false;
		     }
		     if(confirm('<b:message key="mgr_agent_jsp.sure_delete"/>')){//您确定要删除所选项吗？
			    	document.forms['agentform'].action ='com.primeton.workflow.manager.agent.deleteAgent.flow';
	    	        document.forms['agentform']._eosFlowAction.value = "del";
	    	        document.forms['agentform'].submit();
			 }else
				return false;
	    }else
	        return false;
	 }
	 //复选框全选操作
	 function SelectAllCheck(obj){
	     if(checkAgentID()){
	        var el = document.getElementsByName('agentID');
	        //alert(el[0].value);
	        var len = el.length;
	        if(obj.checked==true){ 
	            for(var i=0; i<len; i++){  
	              el[i].checked = true; 
	            } 
	        } else { 
	            for(var i=0; i<len; i++){ 
	              el[i].checked = false; 
	            } 
	        }
	     }else
	        return false;
	 }
	 
	 function doSelect(chkObj){
	 	var chkAll = $name("Checkbox");
	 	if(chkAll.checked){
	        chkAll.checked=false;
	        chkObj.checked=false;
		}else{
			if(chkObj.checked){
				  chkObj.checked=true;
			}else{
				  chkObj.checked=false;
			}
			var el = document.getElementsByName('agentID');
	      	var len = el.length;
	       	var temp=0;
	        for(var i=0; i<len; i++){  
	          if(el[i].checked == true){
	             temp=temp+1;
	          }
	        }
	        if(temp==len)
	        	chkAll.checked=true;
		}
	 }
	 //修改某代理关系
	 function doModifyAgent(){
	     if(checkAgentID()){
	       	 var el = document.getElementsByName('agentID');
	      	 var len = el.length;
	       	 var temp=0;
	         for(var i=0; i<len; i++){  
	           if(el[i].checked == true){
	              temp=temp+1;
	           }
	         }
	         if(temp==0){
			    alert("<b:message key="mgr_agent_jsp.select_modify_agent"/>");//请先选择一个要修改的代理关系.
			    return false;
		     }
		     if(temp>1){
			    alert("<b:message key="mgr_agent_jsp.only_modify_one"/>");//对不起,每次只能修改一个,请重新选择.
			    return false;
		     }
		     document.forms['agentform'].action ='com.primeton.workflow.manager.agent.modAgent.flow';
	    	 document.forms['agentform']._eosFlowAction.value = "mod";
	    	 document.forms['agentform'].submit();
		     
	     }else
	        return false;
	 } 
window.onload = function (){

	 <%if(flag==0) {%>
		 $name("Button1").disabled=true;
		 $name("Button2").disabled=true;
	 <%} %>
}
//-->
</script>