<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp"%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-07-30 14:47:03
  - Description:
-->
<head>
<title><b:message key="permission_common.biz_resource_extract"/></title>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" class="workarea"
	width="100%">
	<tr>
		<td class="workarea_title" valign="middle">
		<h3><b:message key="permission_common.biz_resource_extract"/></h3>
		</td>
	</tr>
	<tr>
		<td width="100%">
	    	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr height="330px">
					<td width="100%" valign="top"><b:message key="permission_common.no_res_info"/></td>
				</tr>
			</table>  
		</td>
	</tr>
	<tr class="form_bottom">
		<td>
			<input id="btnPrevStep" name="btnPrevStep" type="button" value='<b:message key="permission_common.btn_prev_step"/>' class="button" onclick="backStep()">
			<input id="btnSubmit" name="btnSubmit" type="button" value='<b:message key="permission_common.btn_done"/>' class="button" onclick="saveSubmit();">
			<input id="btnCancel" name="btnCancel" type="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancle()" class="button">
		</td>
	</tr>
</table>
<form name="viewlist1" action="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomDeal.flow" method="post">
	<input type="hidden" name="_eosFlowAction" value="saveSubmit" />
	<h:hidden property="processDefID" />
	<h:hidden property="tempProcessDefID" />
	<h:hidden property="processDefName" />
	<h:hidden property="processDefCHName" />
	<h:hidden property="pathName" />
</form>


</body>
</html>
<script>
	var ret = new Array(2);
    function cancle() {
		ret[0]="N";
		// 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
    }
    
    function backStep() {
    	var frm = $name("viewlist1");
  		frm.elements["_eosFlowAction"].value = "backStep";
  		frm.submit();
    }
    
    function saveSubmit() {
    	var frm = $name("viewlist1");
  		frm.elements["_eosFlowAction"].value = "saveSubmit";
  		frm.submit();
    }
    
    function showResourceInfo(resouceName,resouceDesc) {
      var frm = $name("viewlist1");
      $id("tab").src="com.primeton.bps.web.composer.bizflowmgr.showRescourceInfo.flow?resouceName="+resouceName+"&resouceDesc="+resouceDesc;
    }
</script>
