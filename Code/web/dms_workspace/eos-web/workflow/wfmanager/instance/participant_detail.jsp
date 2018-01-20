<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/instance/common.jsp"%>
</head>
<body  leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
<table border="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th><b:message key="participant_detail_jsp.number"/></th><%-- 编号 --%>
				  <th><b:message key="participant_detail_jsp.participator_id"/></th><%-- 参与者ID --%>
				  <th><b:message key="participant_detail_jsp.participator_name"/></th><%-- 参与者名称 --%>
				  <th><b:message key="participant_detail_jsp.participator_type"/></th><%-- 参与者类型 --%>				  
				  <th><b:message key="participant_detail_jsp.participant_type"/></th><%-- 参与类型 --%>			 
				  <th><b:message key="participant_detail_jsp.item_resource"/></th><%-- 工作项来源 --%>
				</tr>
			<l:present property="participantInfo">
				<% int flag =0; String cls = "";%>
					<l:iterate id="info" property="participantInfo">
					<%if(flag%2==0){cls="";}else{cls="EOS_table_row";}
					%>
						<tr class="<%=cls %>"  onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
						  <td>
							  <b:write iterateId="info" property="participantIndex"/>
							  <l:equal iterateId="info" property="isCurrParticipant" targetValue="true">
							  *
							  </l:equal>						  
						  </td>
						  <td>														
							  <b:write iterateId="info" property="id"/>					
						  </td>
						  <td>														
							  <b:write iterateId="info" property="name"/>					
						  </td>
					      <td>
					      	 <d:write iterateId="info" property="typeCode" dictTypeId="WFDICT_OMParticipantType" />
						  </td>
						  <td>
							 <d:write iterateId="info" dictTypeId="WFDICT_PartiInType" property="permission"/>						   
						  </td>
						   <td>
						 	  <d:write iterateId="info" dictTypeId="WFDICT_DelegateType" property="participantInfoType"/>
						  </td>					
						</tr>
						<%flag++;  %>
					</l:iterate>
		      </l:present>
									
					
</table>
</body>
</html>
