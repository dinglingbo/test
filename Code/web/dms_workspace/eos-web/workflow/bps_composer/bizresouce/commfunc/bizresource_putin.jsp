<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html style="overflow:hidden">
<!-- 
  - Author(s): Administrator
  - Date: 2009-08-05 16:10:26
  - Description:
-->
<head>
<title><b:message key="bizresource_putin_jsp.submit_biz_res"/></title><!-- 提交业务资源 -->
<%request.setAttribute("checked","true");%>
<script>
	var ret = new Array(2);
	function save(){
		hiddenResponseMessage($id("ResponseMessage"));
      	var myAjax= new Ajax("com.primeton.bps.web.composer.bizresource.bizrescommoperation.putinResource.biz");
		myAjax.submitForm("saveform"); 
		var isSuc =myAjax.getValue("root/data/RtnMsg/code")
		//alert(isSuc);
		if(isSuc!=1){
			showMessage($id("ResponseMessage"),myAjax.getValue("root/data/RtnMsg/name"));
			return;
		}
		ret[0]="Y";
        window['returnValue'] = ret;
        window.close();
	}
	
	function cancel(){
		ret[0]="N";
		// 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
	}
	
	function showDetail(uuid,type){
		$id("tab").src="com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow?_eosFlowAction=putin_detail&resUUID="+uuid+"&resType="+type;
	}
</script>
</head>
<body style="overflow:hidden">
<form name="saveform" id="saveform" action="com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow" method="post">
	<input type="hidden" value="putin_save" name="_eosFlowAction"/>
	<h:hidden property="resType" name="unitType"/>
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="bizresource_putin_jsp.submit_biz_res"/></h3></td><!-- 提交业务资源 -->
	</tr>
  <tr valign="top"> 
	<td width="100%" height="250px">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr height="100%">
				<td width="30%">
					<div style="border:1px solid #dddddd;width:100%;height:100%;overflow: auto;overflow-x: auto;overflow-y: auto;float: left;" >
					<table>
					<w:checkGroup id="group1">
						<l:iterate property="resList" id="id1">
		            	<tr class="<l:output evenOutput='EOS_table_row' />">
		              		<td>
		            			<w:rowCheckbox>
		            				<w:rowSelect property="checked" checkedValue="true"/>
		                			<h:param name='unitArray/id' iterateId='id1' property='id' indexed='true' />
		                		</w:rowCheckbox>
		              		</td>
		              		<td onclick="eventManager.stopPropagation()">
		              			<a onclick="eventManager.stopPropagation();showDetail('<b:write iterateId="id1" property="id"/>','<b:write property="resType"/>')" href="#"><b:write iterateId="id1" property="name"/></a>
		              		</td>
		            	</tr>
		          		</l:iterate>
		          	</w:checkGroup>
		          	</table>
					</div>
				</td>
				<td>
					<div style="border:1px solid #dddddd;width:100%;height:100%" >
				   		<iframe id="tab" style="width:100%;height:100%" frameBorder="0" scrolling="no" src="com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow?_eosFlowAction=putin_detail&resUUID=<b:write property='resList[1]/id'/>&resType=<b:write property='resType'/>"></iframe>
					</div>
				</td>
			</tr>
		</table>
	</td>
  </tr>
  <tr>
  	<td align="center">
  		<input id="btnOK" name="btnOK" type="button" class="button" value='<b:message key="permission_common.btn_ok"/>' onclick="save()"><!-- 确定 -->
		<input id="btnCancel" name="btnCancel" type="button" class="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancel()"><!-- 取消 -->
  	</td>
  </tr>
</table>
</form>
</body>
</html>