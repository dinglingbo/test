<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("handover_worklist_jsp1.select");
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
 %>
<html>
<head>
<title><b:message key="handover_worklist_jsp.handover_worklist"/></title><%-- 交接任务列表 --%>
</head>

<body style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden; overflow-y:auto; overflow-x: auto;">
<form action="com.primeton.workflow.manager.handover.queryHandoverInfo.flow" method="post" name="query">
<input type="hidden" name="_eosFlowAction">
<input type="hidden" name="wiType">	
<input type="hidden" name="fromName" value='<b:write property="fromName"/>'>
<input type="hidden" name="from" value='<b:write property="from"/>'>
<input type="hidden" name="toName" value='<b:write property="toName"/>'>
<input type="hidden" name="to" value='<b:write property="to"/>'>
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table class="workarea" width="100%">
					<tr>
						<td class="EOS_panel_head"><b:message key="handover_worklist_jsp1.handover_worklist"/></td><%-- 交接工作任务列表 --%>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td class="EOS_table_row" width="15%"><b:message key="handover_worklist_jsp1.to_be_exec_workitem"/></td><%-- 待执行的工作项: --%>
								<td><b:write property="retExe"/><b:message key="handover_worklist_jsp1.piece"/>&nbsp;
								<l:notEqual property="retExe" targetValue="0" compareType="number">
								<input type="button" id="handoverBtn1" class="button" value="<b:message key="handover_worklist_jsp.handover"/>" onclick="doShowWI('exe')"></input>&nbsp;&nbsp;<b:message key="handover_worklist_jsp1.default_handover_staff"/><h3><span id="toExeName" name="toExeName"><b:write property="toName"/></span></h3>&nbsp;&nbsp;<wf:selectParticipant form="query" id="toExeName" styleClass="button" selectTypes="<%=leafType %>" output="toExeName" root="" value="<%=select %>" hidden="toExe" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 交接/默认的交接人:/选择... --%>
								</l:notEqual></td><%-- 个 --%>
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
									dCache.createDataCatch("toExeName",pValue);
								</script>
							</tr>
							<tr>
								<td class="EOS_table_row" width="15%"><b:message key="handover_worklist_jsp1.delegate_other_item"/></td><%-- 代办他人的工作项: --%>
								<td><b:write property="retDeleg"/><b:message key="handover_worklist_jsp1.piece"/>&nbsp;
								<l:notEqual property="retDeleg" targetValue="0" compareType="number">
								<input type="button" id="handoverBtn2" class="button" value="<b:message key="handover_worklist_jsp.handover"/>" onclick="doShowWI('deleg')"></input>&nbsp;&nbsp;<b:message key="handover_worklist_jsp1.default_handover_staff"/><h3><span id="toDelegName" name="toDelegName"><b:write property="toName"/></span></h3>&nbsp;&nbsp;<wf:selectParticipant form="query" id="toDelegName" styleClass="button" selectTypes="<%=leafType %>" output="toDelegName" root="" value="<%=select %>" hidden="toDeleg" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 交接/默认的交接人:/选择... --%>
								</l:notEqual></td><%-- 个 --%>
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
									dCache.createDataCatch("toDelegName",pValue);
								</script>
							</tr>
							<tr>
								<td class="EOS_table_row" width="15%"><b:message key="handover_worklist_jsp1.delegate_to_other_item"/></td><%-- 委托他人的工作项: --%>
								<td><b:write property="retEntr"/><b:message key="handover_worklist_jsp1.piece"/>&nbsp;
								<l:notEqual property="retEntr" targetValue="0" compareType="number">
								<input type="button" id="handoverBtn3" class="button" value="<b:message key="handover_worklist_jsp.handover"/>" onclick="doShowWI('entr')"></input>&nbsp;&nbsp;<b:message key="handover_worklist_jsp1.default_handover_staff"/><h3><span id="toEntrName" name="toEntrName"><b:write property="toName"/></span></h3>&nbsp;&nbsp;<wf:selectParticipant form="query" id="toEntrName" styleClass="button" output="toEntrName" selectTypes="<%=leafType %>" root="" value="<%=select %>" hidden="toEntr" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 交接/默认的交接人:/选择... --%>
								</l:notEqual></td><%-- 个 --%>
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
									dCache.createDataCatch("toEntrName",pValue);
								</script>
							</tr>
							<tr>
								<td class="EOS_table_row" width="15%"><b:message key="handover_worklist_jsp1.to_be_receive_item"/></td><%-- 待领取的工作项: --%>
								<td><b:write property="retPub"/><b:message key="handover_worklist_jsp1.piece"/>&nbsp;
								<l:notEqual property="retPub" targetValue="0" compareType="number">
								<input type="button" id="handoverBtn4"  class="button" value="<b:message key="handover_worklist_jsp.handover"/>" onclick="doShowWI('pub')"></input>&nbsp;&nbsp;<b:message key="handover_worklist_jsp1.default_handover_staff"/><h3><span id="toPubName" name="toPubName"><b:write property="toName"/></span></h3>&nbsp;&nbsp;<wf:selectParticipant form="query" id="toPubName" selectTypes="<%=leafType %>" styleClass="button" output="toPubName" root="" value="<%=select %>" hidden="toPub" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 交接/默认的交接人:/选择... --%>
								</l:notEqual>
								</td><%-- 个 --%>
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
									dCache.createDataCatch("toPubName",pValue);
								</script>
							</tr>
							<tr>
								<td class="EOS_table_row"><b:message key="handover_worklist_jsp1.handover_process_define"/></td><%-- 需要交接的流程定义: --%>
								<td><b:write property="retDef"/><b:message key="handover_worklist_jsp1.piece"/>&nbsp;
								<l:notEqual property="retDef" targetValue="0" compareType="number">
								<input type="button" id="handoverBtn5"  class="button" value="<b:message key="handover_worklist_jsp.handover"/>" onclick="doShowDef()"></input>&nbsp;&nbsp;<b:message key="handover_worklist_jsp1.default_handover_staff"/><h3><span id="toDefName" name="toDefName"><b:write property="toName"/></span></h3>&nbsp;&nbsp;<wf:selectParticipant form="query" id="toDefName" selectTypes="<%=leafType %>" styleClass="button" output="toDefName" root="" value="<%=select %>" hidden="toDef" hiddenType="ID" maxNum="1"></wf:selectParticipant><%-- 交接/默认的交接人:/选择... --%>
								</l:notEqual></td><%-- 个 --%>
							</tr>
							<tr>
								<td class="EOS_table_row"><b:message key="handover_worklist_jsp1.delete_agent_relation"/></td><%-- 需要删除的代理关系: --%>
								<td colspan="1"><b:write property="retAgent"/><b:message key="handover_worklist_jsp1.piece"/>&nbsp;  
								<l:notEqual property="retAgent" targetValue="0" compareType="number">
								<input type="button" id="deleteBtn" class="button" value="<b:message key="handover_worklist_jsp1.delete"/>" onclick="deleteAgent()"></input><%-- 删除 --%>
								</l:notEqual></td><%-- 个 --%>
							</tr>
						</table>  
					    </td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
</form>
<script type="text/javascript">
  parent.window.scroll(0,0);
  
  function doShowWI(wiType){
  	query.action="com.primeton.workflow.manager.handover.queryHandoverInfo.flow";
  	query._eosFlowAction.value="action2";
  	
  	query.wiType.value=wiType;
  	var temp;
  	var tempName;
  	//FIXME: document.getElementById  --> $id
  	if(wiType == 'exe'){
  	   temp = $id("toExe");
  	   tempName = $id("toExeName");
  	}
  	
  	if(wiType == 'deleg'){
  		temp = $id("toDeleg");
  	   	tempName = $id("toDelegName");
  	}
  	   
  	if(wiType == 'entr'){
  		temp = $id("toEntr");
  	   	tempName = $id("toEntrName");
  	}
  	   
  	if(wiType == 'pub'){
  		temp = $id("toPub");
  	   	tempName = $id("toPubName");
  	}
  	   
  	if(temp){
  		query.to.value=temp.value;
  		query.toName.value = tempName.innerText;
  	}
  	
  	query.submit();
  }
  
  function doShowDef(){
  	query.action="com.primeton.workflow.manager.handover.queryHandoverInfo.flow";
  	query._eosFlowAction.value="action1";
  	
  	var temp = $id("toDef");
  	var tempName = $id("toDefName");
  	
  	if(temp){
  		query.to.value=temp.value;
  		query.toName.value=tempName.innerText;
  	}
  		
  	query.submit();
  }
  
  function deleteAgent(){
  	query.action="com.primeton.workflow.manager.handover.queryHandoverInfo.flow";
  	query._eosFlowAction.value="action0";
  	
  	query.submit();
  }
  
</script>
</body>
</html>
