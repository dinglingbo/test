<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("delegate_set_jsp.select");
String leafType = com.primeton.bps.workspace.frame.common.WSOMUtil.getLeafParticipantType();
 %>
<html>
<head>
<title><b:message key="delegate_set_jsp.delegate_set"/></title><%-- 代办设置 --%>
<script type="text/javascript">

function doSubmit(){
	//FIXME: document.getElementById  --> $id
	if(trim($id("fromName").value)==''){
		alert("<b:message key="delegate_set_jsp.select_delegate"/>");//请选择委托人！
		return false;
	}
		
	query._eosFlowAction.value="action0";
	return true;
}


function clearP(){
    $id("fromName").value="";
    dataCatchPool = [];
}

</script>
</head>
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden">

<table border="0" cellpadding="0" cellspacing="1" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="delegate_set_jsp.delegate_mgr"/> &gt; <b:message key="delegate_set_jsp.set_delegate"/></h3></td><%-- 代办管理 / 设置代办 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
			<table class="workarea" width="100%" height="100%">
				<tr>
					<td class="EOS_panel_head" valign="middle"><b:message key="delegate_set_jsp.set_delegate_item"/></td><%-- 设置代办工作项 --%>
				</tr>
				<tr>
					<td width="100%">
					<form action="com.primeton.workflow.manager.delegate.setDelegate.flow" method="post" id="query" name="query" onsubmit="return doSubmit()" target="list">
						<input type="hidden" name="_eosFlowAction">
					<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
						<tr>
							<td height="26" nowrap="nowrap" class="EOS_table_row"><b:message key="delegate_set_jsp.client"/></td><%-- 委托人: --%>
							<td height="26" nowrap="nowrap">
							    <input type="text" class="textbox" id="fromName" name="fromName" size="32" readonly="true" value='<b:write property="fromName"/>'/>
							    <wf:selectParticipant form="query" selectTypes="<%=leafType %>" styleClass="button" maxNum="1" output="fromName" root="" value="<%=select %>" hidden="from" hiddenType="ID"><%-- 选择... --%>
							    </wf:selectParticipant><font style="color:red">*</font>
							    <input type="hidden" id="from" name="from" value='<b:write property="from"/>'>
							</td>
						</tr>
						<tr>
						  <td colspan="2" class="form_bottom" ><input type="submit" id="queryBtn" name="submit" class="button" value="<b:message key="delegate_set_jsp.query"/>" />&nbsp;&nbsp;<input type="button" id="clearBtn" name="submit" class="button" value="<b:message key="delegate_set_jsp.clear"/>" onclick="clearP();"/></td><%-- 查询/清空 --%>
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
		<iframe name="list" id="list" width="100%" height="200%" onload="dyniframesize('list');" frameborder="0" marginheight="0" marginwidth="0" scrolling="auto" src="delegate_setList.jsp"></iframe>
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
			pTar.height = pTar.contentDocument.body.scrollHeight+25;
			
		}else if (pTar.Document && pTar.Document.body.scrollHeight){
			pTar.height = pTar.Document.body.scrollHeight+25;
		}
			
	}
   }
</script>
</body>
</html>