<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String modify = ResourcesMessageUtil.getI18nResourceMessage("handover_workdetail_jsp.modify");
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
 %>
<html>
<head>
<title><b:message key="handover_workdetail_jsp.work_detail_list"/></title><%-- 任务详细列表 --%>
<script>
function handoverWI(){
	var query= $name('query');
	if(query.index == null){
		alert("<b:message key="handover_workdetail_jsp.select_item"/>");//请选择工作项！
		return;
	}
	if(query.index.length == undefined){
		if(!query.index.checked){
			alert("<b:message key="handover_workdetail_jsp.select_item"/>");//请选择工作项！
			return;
		}
	}else{
		for(var i = 0; i<query.index.length;i++){
			if(query.index[i].checked)
				break;
			if(i==query.index.length-1){
				alert("<b:message key="handover_workdetail_jsp.select_item"/>");//请选择工作项！
				return;
			}
		}
	}
	query.action="com.primeton.workflow.manager.handover.executeHandover.flow";
	query._eosFlowAction.value="action9";
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

function init(){
	var arg = '<b:write property="wiType"/>';
	//FIXME: document.getElementById  --> $id
	if(arg == 'exe'){
		$id('dexe').style.display='block';
		$id('dentr').style.display='none';
		$id('ddeleg').style.display='none';
		$id('dpub').style.display='none';
	}
	if(arg == 'entr'){
		$id('dexe').style.display='none';
		$id('dentr').style.display='block';
		$id('ddeleg').style.display='none';
		$id('dpub').style.display='none';
	}
	if(arg == 'deleg'){
		$id('dexe').style.display='none';
		$id('dentr').style.display='none';
		$id('ddeleg').style.display='block';
		$id('dpub').style.display='none';
	}
	if(arg == 'pub'){
		$id('dexe').style.display='none';
		$id('dentr').style.display='none';
		$id('ddeleg').style.display='none';
		$id('dpub').style.display='block';
	}

}


</script>
</head>

<body onload="init()" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden; overflow-y:auto; overflow-x: auto;">
<form action="" method="post" name="query">
<input type="hidden" name="_eosFlowAction">
<input type="hidden" name="wiType" value='<b:write property="wiType"/>'>	
<input type="hidden" name="from" value='<b:write property="from"/>'>
<input type="hidden" name="oTo" value='<b:write property="to"/>'>
<input type="hidden" name="oToName" value='<b:write property="toName"/>'>
<table cellpadding="0" width="100%" cellspacing="0" border="0">
	<tr>
		<td>
		<table class="workarea" width="100%">
			<tr>
				<td class="EOS_panel_head"><b:message key="handover_workdetail_jsp.handeover_item"/></td><%-- 需要交接的工作项 --%>
			</tr>
			<tr>
				<td>
				<table class="workarea" width="100%">
					<tr>
						<td class="blockInfo_title" colspan="2"><div id="dexe"><b:message key="handover_worklist_jsp.to_be_exec_workitem"/></div><div id="dentr"><b:message key="handover_worklist_jsp.delegate_to_other_item"/></div><div id="ddeleg"><b:message key="handover_worklist_jsp.delegate_other_item"/></div><div id="dpub"><b:message key="handover_workdetail_jsp.to_be_receive_item"/></div></td><%-- 待执行的工作项/委托他人代办的工作项/代办他人的工作项/待领取的工作项 --%>
					</tr>
					<tr>
						<td width="100%" colspan="2">
						<table border="0" class="EOS_table" width="100%">
							<tr class="EOS_table_head">
								<th nowrap width="5%"><input type="checkbox"  name="operation"
									value="checkbox" onClick="checkAll();">&nbsp;<b:message key="handover_workdetail_jsp.select"/></th><%-- 选择 --%>
								<th nowrap><b:message key="handover_workdetail_jsp.item_name"/></th><%-- 工作项名称 --%>
								<th nowrap><b:message key="handover_workdetail_jsp.biz_process_name"/></th><%-- 业务流程名称 --%>
								<th nowrap><b:message key="handover_workdetail_jsp.process_inst_name"/></th><%-- 流程实例名称 --%>
								<th nowrap><b:message key="handover_workdetail_jsp.current_state"/></th><%-- 当前状态 --%>
								<th nowrap><b:message key="handover_workdetail_jsp.start_time"/></th><%-- 启动时间 --%>
								<th nowrap><b:message key="handover_workdetail_jsp.time_limit"/></th><%-- 时间限制 --%>
								<th nowrap><b:message key="handover_workdetail_jsp.receiver"/></th><%-- 接管人 --%>
							</tr>
							<% int flag =0; String toNameStr = null; String toStr = null;%>
							<l:equal property="wiType" targetValue="exe" compareType="string">
							<l:iterate id="workitem" property="exeList">
							<% toNameStr = "toName[" + flag + "]"; toStr = "to[" + flag + "]"; %>
								<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
								    <td nowrap><h:checkbox name="index" onclick="doSelect(this);" value='<%=""+flag %>'/><%=flag+1 %></td>
									<td><b:write property="workItemName" iterateId="workitem"/></td>
									<td><b:write property="processDefName" iterateId="workitem"/></td>
									<td><b:write property="processInstName" iterateId="workitem"/></td>
									<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
									<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyy-MM-dd HH:mm:ss.0"/></td>
									<td><b:write property="limitNumDesc" iterateId="workitem"/></td>
									<td><span id="toName[<%=flag%>]" name="toName[<%=flag%>]"><b:write property="toName"/></span> <wf:selectParticipant id="<%=toNameStr%>" form="query" selectTypes="<%=leafType %>" output="<%=toNameStr%>" root="" value="<%=modify %>" hidden="<%=toStr%>" styleClass="button" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 修改... --%>
									<input type="hidden" id="to[<%=flag%>]" name="to[<%=flag%>]" value='<b:write property="to"/>'>
									<input type="hidden" name="workitemID" value='<b:write property="workItemID" iterateId="workitem"/>'>
									</td>
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
									participant.typeCode = '<%=leafType %>' ;
									pValue[0] = participant ;
									var dCache = new DataCatchMgr();
									dCache.createDataCatch("<%=toNameStr%>",pValue);
								</script>
							<% 	flag++;  %>
							</l:iterate>
							<%for(int i = flag; i < 10;i++){ %>
								<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
							<%} %>
							</l:equal>
							<l:equal property="wiType" targetValue="deleg" compareType="string">
							<l:iterate id="workitem" property="delegList">
							<% toNameStr = "toName[" + flag + "]"; toStr = "to[" + flag + "]"; %>
								<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
								    <td nowrap><h:checkbox name="index" onclick="doSelect(this);" value='<%=""+flag %>'/><%=flag+1 %></td>
									<td><b:write property="workItemName" iterateId="workitem"/></td>
									<td><b:write property="processDefName" iterateId="workitem"/></td>
									<td><b:write property="processInstName" iterateId="workitem"/></td>
									<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
									<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyy-MM-dd HH:mm:ss.0"/></td>
									<td><b:write property="limitNumDesc" iterateId="workitem"/></td>
									<td><span id="toName[<%=flag%>]" name="toName[<%=flag%>]"><b:write property="toName"/></span> <wf:selectParticipant selectTypes="<%=leafType %>" id="<%=toNameStr %>" form="query" styleClass="button" output="<%=toNameStr%>" root="" value="<%=modify %>" hidden="<%=toStr%>" hiddenType="ID" maxNum="1"></wf:selectParticipant><%--  --%>
									<input type="hidden" name="to[<%=flag%>]" value='<b:write property="to"/>'>
									<input type="hidden" name="workitemID" value='<b:write property="workItemID" iterateId="workitem"/>'>
									</td>
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
									participant.typeCode = '<%=leafType %>' ;
									pValue[0] = participant ;
									var dCache = new DataCatchMgr();
									dCache.createDataCatch("<%=toNameStr%>",pValue);
								</script>
							<% 	flag++;  %>
							</l:iterate>
							<%for(int i = flag; i < 10;i++){ %>
								<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
							<%} %>
							</l:equal>
							<l:equal property="wiType" targetValue="entr" compareType="string">
							<l:iterate id="workitem" property="entrList">
							<% toNameStr = "toName[" + flag + "]"; toStr = "to[" + flag + "]"; %>
								<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
								    <td nowrap><h:checkbox name="index" onclick="doSelect(this);" value='<%=""+flag %>'/><%=flag+1 %></td>
									<td><b:write property="workItemName" iterateId="workitem"/></td>
									<td><b:write property="processDefName" iterateId="workitem"/></td>
									<td><b:write property="processInstName" iterateId="workitem"/></td>
									<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
									<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyy-MM-dd HH:mm:ss.0"/></td>
									<td><b:write property="limitNumDesc" iterateId="workitem"/></td>
									<td><span id="toName[<%=flag%>]" name="toName[<%=flag%>]"><b:write property="toName"/></span> <wf:selectParticipant selectTypes="<%=leafType %>" id="<%=toNameStr %>" form="query" styleClass="button" output="<%=toNameStr%>" root="" value="<%=modify %>" hidden="<%=toStr%>" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 修改... --%>
									<input type="hidden" name="to[<%=flag%>]" value='<b:write property="to"/>'>
									<input type="hidden" name="workitemID" value='<b:write property="workItemID" iterateId="workitem"/>'>
									</td>
								<script>
									var pValue = new Array();
									var participant = {
										id : "" ,
										name : "" ,
										typeCode : ""
									} ;
									participant.id = '<b:write property="to"/>' ;
									participant.name = '<b:write property="toName"/>' ;
									participant.typeCode = '<%=leafType %>' ;
									pValue[0] = participant ;
									var dCache = new DataCatchMgr();
									dCache.createDataCatch("<%=toNameStr%>",pValue);
								</script>
								</tr>
							<% 	flag++;  %>
							</l:iterate>
							<%for(int i = flag; i < 10;i++){ %>
								<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
							<%} %>
							</l:equal>
							<l:equal property="wiType" targetValue="pub" compareType="string">
							<l:iterate id="workitem" property="pubList">
							<% toNameStr = "toName[" + flag + "]"; toStr = "to[" + flag + "]"; %>
								<tr class="EOS_table_row" onmouseover="this.className='EOS_table_selectRow'" onmouseout="this.className='EOS_table_row'">
								    <td nowrap><h:checkbox name="index" onclick="doSelect(this);" value='<%=""+flag %>'/><%=flag+1 %></td>
									<td><b:write property="workItemName" iterateId="workitem"/></td>
									<td><b:write property="processDefName" iterateId="workitem"/></td>
									<td><b:write property="processInstName" iterateId="workitem"/></td>
									<td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
									<td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyy-MM-dd HH:mm:ss.0"/></td>
									<td><b:write property="limitNumDesc" iterateId="workitem"/></td>
									<td><span id="toName[<%=flag%>]" name="toName[<%=flag%>]"><b:write property="toName"/></span> <wf:selectParticipant id="<%=toNameStr %>" selectTypes="<%=leafType %>" form="query" styleClass="button" output="<%=toNameStr %>" root="" value="<%=modify %>" hidden="<%=toStr%>" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 修改... --%>
									<input type="hidden" name="to[<%=flag%>]" value='<b:write property="to"/>'>
									<input type="hidden" name="workitemID" value='<b:write property="workItemID" iterateId="workitem"/>'>
									</td>
								<script>
									var pValue = new Array();
									var participant = {
										id : "" ,
										name : "" ,
										typeCode : ""
									} ;
									participant.id = '<b:write property="to"/>' ;
									participant.name = '<b:write property="toName"/>' ;
									participant.typeCode = '<%=leafType %>' ;
									pValue[0] = participant ;
									var dCache = new DataCatchMgr();
									dCache.createDataCatch("<%=toNameStr%>",pValue);
								</script>
								</tr>
								<% 	flag++;  %>
							</l:iterate>
							<%for(int i = flag; i < 10;i++){ %>
								<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
							<%} %>
							</l:equal>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
                           <tr>
                     		 <td>
                     		    <div align="center"><input type="button" id="finishBtn" name="Button3" value="<b:message key="handover_workdetail_jsp.finish"/>" class="button" onClick="handoverWI()"><%-- 完成 --%>
						  		<input type="button" id="backBtn" name="Button4" value="<b:message key="handover_workdetail_jsp.back"/>" class="button" onClick="goBack()"></div><%-- 返回 --%>
                      		 </td>
                    	   </tr>
                    	   <tr height="30">
								<td>
									&nbsp;
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
<form action="" method="post" name="form1">
<input type="hidden" name="_eosFlowAction">	
<input type="hidden" name="from" value='<b:write property="from"/>'>
<input type="hidden" name="to" value='<b:write property="to"/>'>
<input type="hidden" name="toName" value='<b:write property="toName"/>'>
<input type="hidden" name="type">
</form>
</body>
</html>
