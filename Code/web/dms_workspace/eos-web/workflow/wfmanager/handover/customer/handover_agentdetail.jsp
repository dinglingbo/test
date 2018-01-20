<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title><b:message key="handover_agentdetail_jsp.delete_agent_relation1"/></title><%-- 删除代理关系 --%>
<script>
function deleteAgent(){
	var query= $name('query');
	if(query.agentID == null){
		alert("<b:message key="handover_agentdetail_jsp.select_agent_relation"/>");//请选择代理关系！
		return;
	}
	if(query.agentID.length == undefined){
		if(!query.agentID.checked) {
			alert("<b:message key="handover_agentdetail_jsp.select_agent_relation"/>");//请选择代理关系！
			return;
		}
	}else{
		for(var i = 0; i<query.agentID.length;i++){
			if(query.agentID[i].checked)
				break;
			if(i==query.agentID.length-1){
				alert("<b:message key="handover_agentdetail_jsp.select_agent_relation"/>");//请选择代理关系！
				return;
			}
		}
	}
	query.action="com.primeton.workflow.manager.handover.executeHandover.flow";
	query._eosFlowAction.value="action3";
	query.submit();
}

function goBack(){
	query.action="com.primeton.workflow.manager.handover.queryHandoverWorklist.flow";
	query._eosFlowAction.value="action0";
	query.type.value="customer";
	query.submit();
}

function checkAll(){
	if(query.agentID != null){
		var isChecked = query.operation.checked;
		if(query.agentID.length == undefined)
			query.agentID.checked = isChecked;				
		else
			for(i = 0;i<query.agentID.length;i++)
				query.agentID[i].checked = isChecked;
	}
}

function doSelect(chkObj){
 	var chkAll = $name("operation");
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

</script>

</head>

<body style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden; overflow-y:auto; overflow-x: auto;">
<form action=""	method="post" name="query">
<input type="hidden" name="_eosFlowAction">
<input type="hidden" name="toName" value='<b:write property="toName"/>'>
<input type="hidden" name="type">
<input type="hidden" name="from" value='<b:write property="from"/>'>
<table cellpadding="0" width="100%" cellspacing="0" border="0">
	<tr>
		<td>
		<table class="workarea" width="100%">
			<tr>
				<td class="EOS_panel_head"><b:message key="handover_agentdetail_jsp.delete_agent_relation"/></td><%-- 需要删除的代理关系 --%>
			</tr>
			<tr>
				<td width="100%" height="100%" valign="top">
				<table border="0" class="EOS_table" width="100%">
					<tr class="EOS_table_head">
					    <th nowrap width="5%"><input type="checkbox"  name="operation"
									value="checkbox" onClick="checkAll();">&nbsp;<b:message key="handover_agentdetail_jsp.select"/></th><%-- 选择 --%>
						<th nowrap><b:message key="handover_agentdetail_jsp.client_id"/></th><%-- 委托人ID --%>
                      	<th nowrap><b:message key="handover_agentdetail_jsp.agent_id"/></th><%-- 代理人ID --%>
                      	<th nowrap><b:message key="handover_agentdetail_jsp.agent_style"/></th><%-- 代理方式 --%>
                      	<th nowrap><b:message key="handover_agentdetail_jsp.start_time"/></th><%-- 生效时间 --%>
                      	<th nowrap><b:message key="handover_agentdetail_jsp.end_time"/></th><%-- 终止时间 --%>
					</tr>
					<% int flag =0; %>
				<l:iterate id="agent" property="agentList">
					<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
					    <td nowrap><h:checkbox iterateId="agent" onclick="doSelect(this);" name="agentID" property="agentID"/></td>
						<td><b:write property="agentFrom" iterateId="agent"/></td>
						<td><b:write property="agentTo" iterateId="agent"/></td>
						<td><d:write property="agentType" dictTypeId="WFDICT_AgentType"  iterateId="agent"/></td>
						<td><b:write property="startTime" iterateId="agent" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyyMMddHHmmss"/></td>
						<td><b:write property="endTime" iterateId="agent" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyyMMddHHmmss"/></td>
					</tr>
					<% 	flag++;  %>
				</l:iterate>
				<%for(int i = flag; i < 10;i++){ %>
					<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
				<%} %>
				</table>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30" class="EOS_panel_body">
                           <tr>
                     		 <td>
                     		    <div align="center"><input type="button" id="finishBtn" name="Button3" value="<b:message key="handover_agentdetail_jsp.finish"/>" class="button" onclick="deleteAgent()"><%-- 完成 --%>
						  		<input type="button" id="backBtn" name="Button4" value="<b:message key="handover_agentdetail_jsp.back"/>" class="button" onClick="goBack()"></div><%-- 返回 --%>
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
</body>
</html>
