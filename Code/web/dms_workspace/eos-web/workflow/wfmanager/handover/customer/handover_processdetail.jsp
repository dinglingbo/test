<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String modify = ResourcesMessageUtil.getI18nResourceMessage("handover_processdetail_jsp.modify");
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
 %>
<html>
<head>
<title><b:message key="handover_processdetail_jsp.modify_process_define"/></title><%-- 修改流程定义 --%>
<script>
function changeDef(){
	var query= $name('query');
	if(query.index == null){
		alert("<b:message key="handover_processdetail_jsp.select_process_define"/>");//请选择流程定义！
		return;
	}
	if(query.index.length == undefined){
		if(!query.index.checked){
			alert("<b:message key="handover_processdetail_jsp.select_process_define"/>");//请选择流程定义！
			return;
		}
	}else{
		for(var i = 0; i<query.index.length;i++){
			if(query.index[i].checked)
				break;
			if(i==query.index.length-1){
				alert("<b:message key="handover_processdetail_jsp.select_process_define"/>");//请选择流程定义！
				return;
			}
		}
	}
	query.action="com.primeton.workflow.manager.handover.executeHandover.flow";
	query._eosFlowAction.value="action6";
	query.submit();
}

function goBack(){
	form1.action="com.primeton.workflow.manager.handover.queryHandoverWorklist.flow";
	form1._eosFlowAction.value="action0";
	form1.type.value="customer";
	form1.submit();
}

function checkAll(){
	if(query.index != null){
		var isChecked = query.operation.checked;
		if(query.index.length == undefined)
			query.index.checked = isChecked;				
		else
			for(i = 0;i<query.index.length;i++)
				query.index[i].checked = isChecked;
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
		var el = document.getElementsByName('index');
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
<input type="hidden" name="from" value='<b:write property="from"/>'>
<input type="hidden" name="oTo" value='<b:write property="to"/>'>
<input type="hidden" name="oToName" value='<b:write property="toName"/>'>
<input type="hidden" name="type">
<table cellpadding="0" width="100%" cellspacing="0" border="0">
	<tr>
		<td>
		<table class="workarea" width="100%">
			<tr>
				<td class="EOS_panel_head"><b:message key="handover_worklist_jsp.modify_process_define"/></td><%-- 需要修改的流程定义 --%>
			</tr>
			<tr>
				<td width="100%" valign="top">
				<table border="0" class="EOS_table" width="100%">
					<tr class="EOS_table_head">
					    <th nowrap width="5%"><input type="checkbox"  name="operation"
									value="checkbox" onClick="checkAll();">&nbsp;<b:message key="handover_processdetail_jsp.select"/></th><%-- 选择 --%>
						<th nowrap><b:message key="handover_processdetail_jsp.process_name"/></th><%-- 流程名称 --%>
						<th nowrap><b:message key="handover_processdetail_jsp.process_version"/></th><%-- 流程版本 --%>
						<th nowrap><b:message key="handover_processdetail_jsp.process_owner"/></th><%-- 流程所有者 --%>
						<th nowrap><b:message key="handover_processdetail_jsp.create_time"/></th><%-- 创建时间 --%>
						<th nowrap><b:message key="handover_processdetail_jsp.receiver"/></th><%-- 接管人 --%>
					</tr>
				<% int flag =0; %>
				<l:iterate id="processDef" property="defList">
				<% String toNameStr = "toName[" + flag + "]"; String toStr = "to[" + flag + "]"; %>
					<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
					    <td nowrap><h:checkbox name="index" onclick="doSelect(this);"value='<%=""+flag %>'/><%=flag+1 %></td>
						<td><b:write property="processDefName" iterateId="processDef"/></td>
						<td><b:write property="versionSign" iterateId="processDef"/></td>
						<td><b:write property="processDefOwner" iterateId="processDef"/></td>
						<td><b:write property="createTime" iterateId="processDef" formatPattern="yyyy-MM-dd HH:mm" srcFormatPattern="yyyyMMddHHmmss"/></td>
						<td><span id="toName[<%=flag%>]" name="toName[<%=flag%>]"><b:write property="toName"/></span> <wf:selectParticipant selectTypes="<%=leafType >" form="query" id="<%=toNameStr%>" styleClass="button" output="<%=toNameStr%>" root="" value="<%=modify %>" hidden="<%=toStr%>" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 修改... --%>
						</td>
						<input type="hidden" id="to[<%=flag%>]" name="to[<%=flag%>]" value='<b:write property="to"/>'>
						<input type="hidden" name="defID" value='<b:write property="processDefID" iterateId="processDef"/>'>
					</tr>
					<script>
						var pValue = new Array();
						var participant = {
							id : "" ,
							name : "" ,
							typeCode : ""
						} ;
						participant.id = '<b:write property="to"/>' ;
						participant.name = '<b:write property="toName"/>' ;
						participant.typeCode = '<%=leafType >' ;
						pValue[0] = participant ;
						var dCache = new DataCatchMgr();
						dCache.createDataCatch("<%=toNameStr%>",pValue);
					</script>
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
                     		    <div align="center"><input type="button" id="finishBtn" name="Button3" value="<b:message key="handover_processdetail_jsp.finish"/>" class="button" onclick="changeDef()"><%-- 完成 --%>
						  		<input type="button" id="backBtn" name="Button4" value="<b:message key="handover_processdetail_jsp.back"/>" class="button" onClick="goBack()"></div><%-- 返回 --%>
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
<form action=""	method="post" name="form1">
<input type="hidden" name="_eosFlowAction">
<input type="hidden" name="from" value='<b:write property="from"/>'>
<input type="hidden" name="to" value='<b:write property="to"/>'>
<input type="hidden" name="toName" value='<b:write property="toName"/>'>
<input type="hidden" name="type">
</form>
</body>
</html>
