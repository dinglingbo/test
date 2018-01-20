<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://eos.primeton.com/tags/workflow" prefix="wf"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("handover_select_person_jsp.select");
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
 %>
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden; overflow-y:auto; overflow-x: auto;">
<table border="0" cellpadding="0" cellspacing="1" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="handover_select_person_jsp.handover_work"/></td><%-- 工作交接 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
	<form action="com.primeton.workflow.manager.handover.queryHandoverWorklist.flow"
		method="post" name="query" onsubmit="return doSubmit()" target="list">
		<input type="hidden" name="_eosFlowAction">
		<input type="hidden" name="type">
		<table class="workarea" width="100%" height="100%">
					<tr>
						<td class="EOS_panel_head" valign="middle"><b:message key="handover_select_person_jsp.select_handover_staff"/></td><%-- 选择交接人员 --%>
					</tr>
					<tr>
						<td width="100%">
						<table width="100%" height="20%" border="0" cellpadding="0"
							cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="handover_select_person_jsp.handover_style"/></td><%-- 交接方式: --%>
								<td height="26" nowrap="nowrap">
								    <input type="radio" name="aa" id="check" checked="true" value="typical"/><b:message key="handover_select_person_jsp.simple_handover"/>
								    <input type="radio" name="aa" value="customer"/><b:message key="handover_select_person_jsp.detail_handover"/>					    
								</td><%-- 简单交接/详细交接 --%>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"><b:message key="handover_select_person_jsp.giver"/></td><%-- 移交人: --%>
								<td height="26" nowrap="nowrap">
								    <input type="text" class="textbox" id="fromName" name="fromName" size="32" readonly="true"/>
								    <wf:selectParticipant form="query" selectTypes="<%=leafType %>" id="fromPerson" styleClass="button" maxNum="1" output="fromName" root="" value="<%=select %>" hidden="from" hiddenType="ID"><%-- 选择... --%> 
								    </wf:selectParticipant><font style="color:red">*</font>
								</td>
							</tr>
							<tr id="temp" style="display:table-row">
								<td height="26" nowrap="nowrap" class="EOS_table_row" colspan="1"><b:message key="handover_select_person_jsp.receiver"/></td><%-- 接管人: --%>
								<td height="26" nowrap="nowrap" colspan="1">
								    <input type="text" class="textbox" id="toName" name="toName" size="32" readonly="true"/> 
								    <wf:selectParticipant form="query" selectTypes="<%=leafType %>" id="toPerson" styleClass="button" maxNum="1" output="toName" root="" value="<%=select %>" hidden="to" hiddenType="ID"><%-- 选择... --%>
								    </wf:selectParticipant><font style="color:red">*</font>
								</td>
							</tr>
							<tr>
							  <td colspan="2" class="form_bottom"><input type="submit" id="queryBtn" name="submit" class="button" value="<b:message key="handover_select_person_jsp.query"/>" onclick="showIframe()"/>&nbsp;&nbsp;<input type="button" id="clearBtn" name="reset" class="button" value="<b:message key="handover_select_person_jsp.clear"/>" onclick="clearP();"/></td><%-- 查询/清空 --%>
							</tr>							
						</table>
						</td>
					</tr>
		</table>
		</form>
		</td>
	</tr>
	
	<tr>
		<td valign="top" style="padding-top:10px">
			<iframe name="list" id="list" width="100%" height="200%" onload="dyniframesize('list');" frameborder="0" marginheight="0" marginwidth="0" scrolling="auto" src="" style="display: none;"></iframe>
		</td>
	</tr>

</table>
<script>
   function clearP(){
   //FIXME: document.getElementById  --> $id
    $id("fromName").value="";
    $id("toName").value="";
    dataCatchPool = [];
   }
   function doSubmit(){
   	 if(trim($id("fromName").value)==""){
   	 	alert("<b:message key="handover_select_person_jsp.select_giver"/>");//请选择移交人！
   	 	return false;
   	 }
   	 if(trim($id("toName").value)==""){
   	 	alert("<b:message key="handover_select_person_jsp.select_receiver"/>");//请选择接管人！
   	 	return false;
   	 }
   	 	
   	 if(trim($id("fromName").value) == trim($id("toName").value)){
   	 	alert("<b:message key="handover_select_person_jsp.giver_receiver_different"/>");//移交人和接管人不能为同一个人！
   	 	return false;
   	 }
   	 	
     var check = $id("check");
     var obj = $id("temp");
     if( check.checked == true){
       document.query.action = "com.primeton.workflow.manager.handover.queryHandoverWorklist.flow";     
       document.query._eosFlowAction.value = "action0"; 
       document.query.type.value = "typical";
     }else{
       document.query.action = "com.primeton.workflow.manager.handover.queryHandoverWorklist.flow";
       document.query._eosFlowAction.value = "action0";  
       document.query.type.value = "customer";  
     }     
   }
   
   function showIframe(){
   	  $id("list").style.display="";
   }
   
   function dyniframesize(iframename){
   	var pTar = null;
	if ($id){
		pTar = $id(iframename);
	}else{
		eval('pTar = ' + iframename + ';');
	}
	if (pTar && !window.opera){
		//begin resizing iframe
		
		pTar.style.display="block";
		
		var pTarheight = 0;
		pTar.height = 0;
		
		if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){
			//ns6 syntax
			pTarheight = pTar.contentDocument.body.offsetHeight;
		}else if (pTar.Document && pTar.Document.body.scrollHeight){
			//ie5+ syntax
			pTarheight = pTar.Document.body.scrollHeight;
		}
		
		if (isFF){
			pTarheight += 50;
		} else if(isChrome()) {
			pTarheight += 60;
		}
		
		pTar.height = pTarheight;
	}
   }
   
   function isChrome() {
	return /chrome/i.test(navigator.userAgent.toLowerCase());
   }
</script>
</body>


