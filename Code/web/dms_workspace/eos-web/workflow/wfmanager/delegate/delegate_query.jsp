<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String all =  ResourcesMessageUtil.getI18nResourceMessage("delegate_query_jsp.all");
String help =  ResourcesMessageUtil.getI18nResourceMessage("delegate_workitem_jsp.help");
String delegate =  ResourcesMessageUtil.getI18nResourceMessage("delegate_workitem_jsp.delegate_");
String select =  ResourcesMessageUtil.getI18nResourceMessage("delegate_set_jsp.select");
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
 %>
<html>
<head>
<title><b:message key="delegate_query_jsp.query_delegate"/></title><%-- 查询代办 --%>
<script type="text/javascript">
function doSubmit(){
	query._eosFlowAction.value="action0";
}

function clearP(){
	//FIXME: document.getElementById  --> $id
    $id("fromName").value="";
    if($id("from"))
     $id("from").value="";
    $id("toName").value="";
    if($id("to"))
     $id("to").value="";
    dataCatchPool = [];
}

</script>
</head>
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden; ">
<table border="0" cellpadding="0" cellspacing="1" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="delegate_query_jsp.delegate_manage"/> &gt; <b:message key="delegate_query_jsp.query_delegate"/></h3></td><%-- 代办管理/查询代办 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
			<table class="workarea" width="100%" height="100%">
				<tr>
					<td class="EOS_panel_head" valign="middle"><b:message key="delegate_query_jsp.query_delegate_item"/></td><%-- 查询代办工作项 --%>
				</tr>
				<tr>
					<td width="100%">
					<form action="com.primeton.workflow.manager.delegate.queryDelegate.flow" method="post" name="query" onsubmit="doSubmit()" target="list">
						<input type="hidden" name="_eosFlowAction">
					<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
						<tr>
							<td height="26" nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="delegate_set_jsp.client"/></td><%-- 委托人: --%>
							<td height="26" nowrap="nowrap" width="35%">
							    <input type="text" class="textbox" id="fromName" name="fromName" size="32" readonly="true" value='<b:write property="fromName"/>'/>
							    <wf:selectParticipant form="query" selectTypes="<%=leafType %>" id="fromNameT" styleClass="button" maxNum="1" output="fromName" root="" value="<%=select %>" hidden="from" hiddenType="ID"> <%-- 选择... --%>
							    </wf:selectParticipant><font style="color:red"></font>
							    <!--<input type="hidden" id="from" name="from" value='<b:write property="from"/>'>-->
							</td>
							<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="delegate_workitem_jsp.delegate"/></td><%-- 代办人: --%>
							<td height="26" nowrap="nowrap">
							    <input type="text" class="textbox" id="toName" name="toName" size="32" readonly="true" value='<b:write property="to[1]/name"/>'/>
							    <wf:selectParticipant form="query" id="toNameT" styleClass="button" output="toName" maxNum="1" root="" value="<%=select %>" hidden="to" hiddenType="PARTICIPANT"> <%-- 选择... --%>
							    </wf:selectParticipant><font style="color:red"></font>
							    <!--<input type="hidden" id="to[1]/id" name="to[1]/id" value='<b:write property="to[1]/id"/>'> 
							    <input type="hidden" id="to[1]/name" name="to[1]/name" value='<b:write property="to[1]/name"/>'>
							    <input type="hidden" id="to[1]/typeCode" name="to[1]/typeCode" value='<b:write property="to[1]/typeCode"/>'>-->
							</td>
						</tr>
						<tr>
							<td height="26" nowrap="nowrap" width="15%" class="EOS_table_row"><b:message key="delegate_workitem_jsp.delegate_style"/></td><%-- 代办方式: --%>
							<td height="26" nowrap="nowrap" colspan="3">
								<h:select property="delegType">
									<h:option label="<%=all %>" value="ALL"></h:option><%-- 全部 --%>
									<h:option label="<%=help %>" value="HELP"></h:option><%-- 协办 --%>
									<h:option label="<%=delegate %>" value="DELEG"></h:option><%-- 代办 --%>
								</h:select>
							</td>
						</tr>
						<tr>
						  <td colspan="4" class="form_bottom"><input type="submit" id="queryBtn" name="submit" class="button" value="<b:message key="delegate_set_jsp.query"/>" />&nbsp;&nbsp;<input type="reset" id="clearBtn" name="submit" class="button" value="<b:message key="delegate_set_jsp.clear"/>" onclick="clearP();"/></td><%-- 查询/清空 --%>
						</tr>							
					</table>
					</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" style="padding-top:10px">
			<iframe name="list" id="list" width="100%" height="200%" frameborder="0" onload="dyniframesize('list');" marginheight="0" marginwidth="0" scrolling="no" src="delegate_queryList.jsp"></iframe>
		</td>
	</tr>
</table>

<script type="text/javascript">
function dyniframesize(iframename){
   	var pTar = null;
	if (document.getElementById){
		pTar = document.getElementById(iframename);
	}else{
		eval('pTar = ' + iframename + ';');
	}
	if (pTar && !window.opera){
		//begin resizing iframe
		
		pTar.style.display="block"
		
		if (pTar.contentDocument && pTar.contentDocument.body.scrollHeight){
			//ns6 syntax
			pTar.height = pTar.contentDocument.body.scrollHeight;
		}else if (pTar.Document && pTar.Document.body.scrollHeight){
			//ie5+ syntax
			pTar.height = pTar.Document.body.scrollHeight;
		}
	}
   }
</script>
</body>
</html>