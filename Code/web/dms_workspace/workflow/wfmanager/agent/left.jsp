<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String client = ResourcesMessageUtil.getI18nResourceMessage("left_jsp.client");
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
 %>
<html>
<head>
<title>Title</title>
<script type="text/javascript" language="JavaScript">
    /**
     function initParam () {
		return "<agentFrom>tiger</agentFrom><flatToLeaf>true</flatToLeaf>" ;
	}
   **/
	function initParam2(node) {
		var id = node.getProperty('id') ;
		var type = node.getProperty('typeCode') ;
		return "<type>"+type+"</type><id>"+id+"</id>";
	}
	
	function refreshNode(node) {
		var type = node.getProperty('typeCode') ;
		//node.setLeaf();
		setNodeIcon(node,type);

	}
	
	function queryAgentScope(node){
	   var id = node.getProperty('id') ;
	   var name = node.getProperty('name');
	   var type = node.getProperty('typeCode') ;
	   if(type=="<%=leafType %>" || type=="emp") {
		  document.forms['participantTree'].action="com.primeton.workflow.manager.agent.queryAgentScope.flow";
		  document.forms['participantTree']._eosFlowAction.value = "query";
		  document.forms['participantTree'].WFAgentID.value = id;
		  document.forms['participantTree'].WFAgentName.value = name;
		  document.forms['participantTree'].submit();
		}
	}
	
	function dealScroll(){
 		var treeHeight = $id("tr1").offsetHeight;
 		
 		if (isFF) {
 			treeHeight -= 80;
 		}
 		else {
 			treeHeight -= 10;
 		}
 		
		$id("treediv").style.height = treeHeight;
	}	
	window.onload = function(){
		dealScroll();
	}
	window.onresize = function(){
		dealScroll();
	}
	
</script>
</head>
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-right: 0px;margin-buttom:0px;width: 100%;height: 100%;">
<form  method="post" name="participantTree" target="middle" action="">
<table cellpadding="0" cellspacing="0" bgcolor="#EEF3F6" style="width: 100%; height: 100%; table-layout: fixed;">
	<tr>
        <td class="tree_head"><h2><b:message key="left_jsp.select_client"/></h2></td><%-- 选择委托人 --%>
    </tr>
	<tr id="tr1">
	   	<td valign="top" style="height:100%; border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
	   		<div id="treediv" style="width: 100%; height: 100%; overflow:auto; overflow-x:auto; overflow-y: auto; float: left; ">
	   		<nobr>
			<r:rtree id="tree" hasRoot="true">
			  <r:treeRoot display="<%=client %>" action="com.primeton.workflow.manager.agent.agentscope.findRootParticipants.biz" childEntities="participants"/><%-- 委托人 --%>
			  <r:treeNode   showField="name" action="com.primeton.workflow.manager.agent.agentscope.findChildParticipants.biz" initParamFunc="initParam2"  nodeType="participants" childEntities="participants" 
			  onRefreshFunc="refreshNode" onClickFunc="queryAgentScope"/>
			</r:rtree>
			</nobr>
			</div>
			<h:hidden property="_eosFlowAction"/>
			<h:hidden property="WFAgentID"/>
			<h:hidden property="WFAgentName"/>	
	   	<td>
	<tr>
</table>
</form>
</body>
</html>