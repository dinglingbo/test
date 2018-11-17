<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<body style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:scroll; overflow-y:hidden; overflow-x: auto;">
<table class="workarea" width="100%">
		<tr>
  			<td class="EOS_panel_head" valign="middle"><b:message key="delegate_query_list_jsp.task_list"/></td><%-- 任务列表  --%>
		</tr>
		<tr>
  			<td>
  			<form action="#" name="form1" method="post">                
  				<input type="hidden" name="workitemID">
  				<input type="hidden" name="from" value='<b:write property="from"/>'>
  				<input type="hidden" name="fromName" value='<b:write property="fromName"/>'>
  				<input type="hidden" id="to/id" name="to/id" value='<b:write property="to/id"/>'> 
			    <input type="hidden" id="to/name" name="to/name" value='<b:write property="to/name"/>'>
				<input type="hidden" id="to/typeCode" name="to/typeCode" value='<b:write property="to/typeCode"/>'>
  				<input type="hidden" id="delegType" name="delegType" value='<b:write property="delegType"/>'>
    			<table border="0" cellpadding="0" cellspacing="0" width="100%">
      				<tr>
       	 				<td>
        				
          					<table border="0" class="EOS_table" width="100%">
            					<tr class="EOS_table_head" align="center">
            					   <th height="25" width="9%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.item_id"/></th><%-- 工作项ID --%>
			                       <th height="25" width="13%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.item_name"/></th><%-- 工作项名称 --%>
			                       <th height="25" width="14%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.biz_process_name"/></th><%-- 业务流程名称 --%>
			                       <th height="25" width="14%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.process_instance_name"/></th><%-- 流程实例名称 --%>
			                       <th height="25" width="10%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.current_state"/></th><%-- 当前状态 --%>
			                       <th height="25" width="13%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.parter"/></th><%-- 参与者 --%>
			                       <th height="25" width="13%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.start_time"/></th><%-- 启动时间 --%>
			                       <th height="25" width="13%" nowrap="nowrap"><b:message key="delegate_query_list_jsp.time_limit"/></th><%-- 时间限制 --%>
			                    </tr>
			                    <% int flag =0;%>
			                    <l:present property="workitems">
			                    <l:iterate id="workitem" property="workitems">
			                    <tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
			                      <td><b:write property="workItemID" iterateId="workitem"/></td>
			                      <td><b:write property="workItemName" iterateId="workitem"/></td>
			                      <td><b:write property="processDefName" iterateId="workitem"/></td>
			                      <td><b:write property="processInstName" iterateId="workitem" maxLength="50"/></td>
			                      <td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
			                      <td><a href='javascript:void(editParticipant(<b:write iterateId="workitem" property="workItemID"/>))'><b:write property="partiName" iterateId="workitem"/></a></td>
			                      <td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyy-MM-dd HH:mm.0"/></td>
			                      <td><b:write property="limitNumDesc" iterateId="workitem"/></td>
			                    </tr>
			                    <%flag++; %>
			                    </l:iterate>
			                    </l:present>
			                    <%for(int i = flag; i < 10;i++){ %>
								<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
								<%} %>
			                  </table>
		               	</td>
		           	</tr>
		           	<tr>
		                <td class="result_bottom" align="right">
							<b:set name="action" value="com.primeton.workflow.manager.delegate.queryDelegate.flow?_eosFlowAction=action4"/>
							<b:set name="target" value="_self"/>
  							<%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
        				</td>
	              	</tr>
	          	</table>
	          	</form>
          	</td>
        </tr>
  	</table>
  	<script type="text/javascript">
  	function editParticipant(workItemID){
		var action = 'com.primeton.workflow.manager.instance.findParticipantDetail.flow?_eosFlowAction=action0&workItemID='+workItemID;
			showModalCenter(action,null,function(returnValue){			
				if(returnValue){
					
				}
			},'550','270','<b:message key="delegate_query_list_jsp.parter_detail"/>');//参与者详细信息
	}
  	</script>
</body>
</html>