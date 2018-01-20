<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-08-05 16:10:26
  - Description:
-->
<head>
<title><b:message key="bizresource_catalog4copy_jsp.biz_res_copy"/></title><!-- 业务资源复制到 -->
<script>
	var ret = new Array(2);
	function save(){
		hiddenResponseMessage($id("ResponseMessage"));
		var inputelements = document.getElementsByTagName("input");
		for (var i=0;i<inputelements.length;i++){
		   var aname=inputelements[i].name; 
           var aTag=inputelements[i].checkTag;
           var aValue=inputelements[i].value;
      	   if(inputelements[i].type=="text" &&aTag=="Y"){ 
      	   		if(aValue==""){
	      	   		//inputelements[i].focus(); 
	      	   		showMessage($id("ResponseMessage"),'<b:message key="bizresource_catalog4copyrename_jsp.rename_tip1"/>');//名称不能为空！
	      	   		return;
      	   		}
      	   		
      	   		if(aValue.length > 64){
      	   			showMessage($id("ResponseMessage"),'<b:message key="bizresource_catalog4copyrename_jsp.rename_tip2"/>');//输入最大长度不能超过64！
	      	   		return;
      	   		}
      	   		
      	   		if(!isBPSNameFormat(aValue)){
      	   			//格式错误，应仅含中文、字母、数字、下划线、<br/>&nbsp;英文符号【-()[]{}.:】、中文符号【，。：‘’“”】
      	   			showMessage($id("ResponseMessage"),'<b:message key="bizresource_catalog4copyrename_jsp.rename_tip3"/>');
      	   			return;
      	   		}
      	   }
		}

		var myAjax= new Ajax("com.primeton.bps.web.composer.bizresource.bizrescommoperation.copyResource.biz");
		myAjax.submitForm("saveform"); 
		var isSuc =myAjax.getValue("root/data/ret/code")
		//alert(isSuc);
		if(isSuc!=1){
			showMessage($id("ResponseMessage"),myAjax.getValue("root/data/ret/name"));
			return;
		}
		ret[0]="Y";
        window['returnValue'] = ret;
        window.close();
	}
	
	function goBack(){
		var frm = document.getElementById("saveform");
		frm.elements["_eosFlowAction"].value = "copy_back";
      	frm.submit();
	}
	
	function cancel(){
		ret[0]="N";
		// 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
	}
	
</script>
</head>
<body>
<form name="saveform" id="saveform" action="com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow" method="post">
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td><b:message key="bizresource_catalog4copyrename_jsp.rename_res"/></td><!-- 重命名所要复制的资源名称 -->
	</tr>
  <tr valign="top"> 
	<td width="100%" height="265px" style="width:300px;border:1px solid #75B5C3;">
		<table class="EOS_TABLE" width="100%" >
   		<thead class="EOS_TABLE_HEAD">
    	<tr>
          <th><b:message key="bizresource_catalog4copyrename_jsp.old_name"/></th><!-- 原名称 -->
      	  <th><b:message key="bizresource_catalog4copyrename_jsp.new_name"/></th><!-- 新名称 -->
      	</tr>
      	</thead>
      <l:iterate property="resList" id="id1">
        <tr class="<l:output evenOutput='EOS_table_row' />">
          <td>
            <b:write iterateId="id1" property="name"/>
          </td>
          <td>
            <h:hidden iterateId="id1" property="id" name="resList/id" indexed='true'/>
            <input type="text" checkTag="Y" name="resList[<l:indexId start="1"/>]/name" value='<b:write iterateId="id1" property="name"/><b:message key="bizresource_catalog4copyrename_jsp.copy_str"/>' onfocus="hiddenResponseMessage($id('ResponseMessage'))"><!-- 副本 -->
          </td>
        </tr>
      </l:iterate>
       </table>
    </td>
  </tr>
  	<tr>
  		<td align="center">
  			<input type="hidden" value="copy_save" name="_eosFlowAction"/>
		    <h:hidden property="selCatalogID" name="catalogUUID"/>
		    <h:hidden property="selCatalogName" name="catalogName"/>
		    <h:hidden property="resType" name="resType"/>
		    <input id="btnSave" name="btnSave" type="button" class="button" value='<b:message key="permission_common.btn_save"/>' onclick="save()"><!-- 保存 -->
		    <input id="btnBack" name="btnBack" type="button" class="button" value='<b:message key="permission_common.btn_prev_step"/>' onclick="goBack()"><!-- 上一步 -->
			<input id="btnCancel" name="btnCancel" type="button" class="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancel()"><!-- 取消 -->
  		</td>
  	</tr>
</table>	 
</form>
</body>
</html>