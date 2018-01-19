<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-09-23 16:34:12
  - Description:
-->
<head>
<title><b:message key="set_permission_batch_jsp.batch_set"/></title><!-- 批量设置 -->
<script>
	function go2View(){
		window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=view&WFBizCatalogInfo/catalogUuid=1";
	}
	
	function queryPermission(){
		hiddenResponseMessage($id("AlertMessage"));
		if($name("participantID").value!=""){
			  var frm = $name("queryForm");
		      frm.elements["_eosFlowAction"].value = "queryPerm";
		      frm.submit();		
		}else{
			 showMessage($id("AlertMessage"),"<b:message key="set_permission_batch_jsp.select_one_participant"/>");//请先选择一个参与者 
		}
	}
	
	function selectParti(){
		hiddenResponseMessage($id("AlertMessage"));
		var strUrl = "<%=request.getContextPath()%>/workflow/bps_catalog/selectParticipant.jsp";
		showModalCenter(encodeURI(strUrl),"",recallSelParti,300,350,"<b:message key="set_permission_batch_jsp.select_participant"/>");//选择参与者
	}
	
	function recallSelParti(value){
		if(value==""){
    		return;
    	}
    	if(value[0]=='Y'){
			var partiArray = value[1];
			$name("participantID").value=partiArray[0];
			$name("participantType").value=partiArray[1];
			$name("participantName").value=partiArray[2];
			$name("participantShowName").value=partiArray[2];
      	}
	}
	
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<form id="queryForm" target="permisssionFrame" name="queryForm" method="post" action="com.primeton.bps.web.bizcatalog.CatalogMgr.flow">
	<input type="hidden" name="_eosFlowAction" value="queryPerm" />
	<input type="hidden" name="participantID" value=""/>
	<input type="hidden" name="participantType" value=""/>
	<input type="hidden" name="participantName" value=""/>
</form>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="set_permission_batch_jsp.batch_set_catalog_permission"/></h3></td><!-- 批量设置目录权限 -->
  </tr>
  <tr> 
    <td width="100%">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	    <tr>
			<td class="form_label" width="20%"><b:message key="set_permission_batch_jsp.participant_name"/></td><!-- 参与者名称 -->
			<td>
				<input name="participantShowName" id="participantShowName" type="text" size="50" readonly="readonly" disabled="disabled">
				<input type="button" id="selectBtn"  value="<b:message key="set_permission_batch_jsp.select"/>" onclick="selectParti()" class="button"><!-- 选择 -->
			</td>
		</tr>
		</table>
	</td>
  </tr>
  <tr>
	<td class="form_table">
		<input type="button" name="btnquery" id="btnquery" value="<b:message key="set_permission_batch_jsp.query"/>" class="button" onclick="queryPermission()"><!-- 查询 -->
		<!--input type="button" name="btnsave" id="btnsave" value="  保存  " class="button" -->
		<input type="button" name="btnreturn" id="btnreturn" value="<b:message key="set_permission_batch_jsp.back"/>" class="button" onclick="go2View();"><!-- 返回 -->
	</td>
  </tr>
  <tr height="100%">
  	<td>
  		<iframe name="permisssionFrame" width="100%" height="400" src="" style="margin-top:0" align="top" scrolling="auto" frameborder="0"></iframe>
  	</td>
  </tr>
</table>
</body>
</html>