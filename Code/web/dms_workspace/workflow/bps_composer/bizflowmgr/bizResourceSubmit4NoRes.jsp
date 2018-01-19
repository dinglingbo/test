<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-04 13:41:09
  - Description:
-->
<head>
<title><b:message key="permission_common.biz_resource_submit"/></title>
</head>
<body>
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="permission_common.biz_resource_submit"/></h3></td>
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
          <td colspan="2">  
            <input id="btnPrevStep" name="btnPrevStep" type="button" value='<b:message key="permission_common.btn_prev_step"/>' class="button" onclick="backStep()">
            <input id="btnDone" name="btnDone" type="button" value='<b:message key="permission_common.btn_done"/>' class="button" onclick="resSubmit()">
            <input id="btnCancel" name="btnCancel" type="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancle()" class="button">
          </td>
        </tr>
    </table>
<form name="viewlist1" id="viewlist1" action="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomSubmit.flow" method="post">
<h:hidden property="submitType" />
<h:hidden property="version" />
<h:hidden property="deploy" />
<h:hidden property="processDefName" />
<h:hidden property="processDefCHName" />
<h:hidden property="tempProcessDefID" />
<h:hidden property="pathName" />
<h:hidden property="versionDesc" />
<input type="hidden" name="_eosFlowAction" value="saveSubmit"/>
</form>	
<form name="refForm" action="com.primeton.bps.web.composer.bizflowmgr.resourceReference.flow" method="post" target="tab">
	<input type="hidden" name="_eosFlowAction" value="init"/>	
	<input type="hidden" name="resouceName" id="ref_resouceName" value="<b:write property='resource/result/name'/>"/>
	<input type="hidden" name="resouceType" id="ref_resouceType" value="<b:write property='resource/result/type'/>"/>
	<input type="hidden" name="resouceDesc" id="ref_resouceDesc" value="<b:write property='resource/result/desc'/>"/>
	<input type="hidden" name="resouceID" id="ref_resouceID" value="<b:write property='resource/result/id'/>"/>
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
    
    function resSubmit() {
    	var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.submitProcessbiz.biz");
    	//alert($id("viewlist1").innerHTML);
      	myAjax.submitForm("viewlist1"); 
      	var isSuc =myAjax.getValue("root/data/result/code");
      	//alert(isSuc);
      	if(isSuc==1){
	      	ret[0]="Y";
	      	//ret[1]="业务流程提交";
	      	ret[1]='<b:message key="permission_common.biz_proc_submit_tip"/>';
	        window['returnValue'] = ret;
	        window.close();
      	}else{
      	 	showMessage($id("ResponseMessage"),myAjax.getValue("root/data/result/name"));
      	}
    }
</script>