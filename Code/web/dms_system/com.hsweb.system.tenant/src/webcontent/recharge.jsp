<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-11-11 15:19:09
  - Description:
-->
<head>
<title>充值链车币</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <%@include file="/common/sysCommon.jsp"%>
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
  <div class="nui-toolbar" style="padding:0px;border-bottom:0;" id="showSave">
	<table style="width:99%;">
	    <tr>
	        <td style="width:99%;">
	            <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	            <a class="nui-button" onclick="onCancel" plain="true" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
	            </td>
	        </tr>
	 </table>
  </div>
  <div id="form1" class="nui-form" style="height:auto;left:0;right:0;margin:0 auto;">
     <table style="margin-top:15px;">
        <tr>
            <td class="tbtext" style="width:60px">链车币：</td>
            <td colspan="1"><input class="nui-textbox" style="width:100%" name="chargeCoin"  id="chargeCoin" /></td>
        <tr>
     </table>
  </div>

	<script type="text/javascript">
    	nui.parse();
    	var updateUrl = apiPath + sysApi + "/" + "com.hsapi.system.tenant.carCoin.updateTenantCoin.biz.ext";
    	var data = {};
    	
    	$(document).ready(function(v) {
			
		});
		function setData(e){
    	   data = e;
    	}
    	function onOk(){
    	  var chargeCoin = nui.get("chargeCoin").value;
    	  if(chargeCoin==0 || chargeCoin==""){
    	     showMsg("请输入链车币","W");
    	     return;
    	  }
    	 var json =  nui.encode({
			      "tenantId":data.tenantId,
			      "orgid":currOrgId,
			      "creatorId":currUserId,
			      "creator":currUserName,
			      "callParams":"",
			      "callStatus":1,
				  "callResult":1,
				  "chargeCoin":chargeCoin,
				  "giveCoin":0,
				  "costPrice":0,
				  "callUrl":"/com.hsapi.system.tenant.carCoin.weChatBCoin.biz.ext"});
    	  nui.ajax({
			    url: updateUrl,
			    type: 'post',
			    data: json,	    	
			    cache: false,
			    success: function (data) {
			        if (data.errCode == "S"){
			       	 closeWindow("ok");
			         }else {
			          showMsg("充值失败","E");
			        }
			    },
			    error: function (jqXHR, textStatus, errorThrown) {
			        nui.alert(jqXHR.responseText);
			    }
		   });
    	} 
    	function CloseWindow(action) {
            if (window.CloseOwnerWindow){
               return window.CloseOwnerWindow(action);
            }else window.close();
       }

      function onCancel() {
         CloseWindow("cancel");
      }
    	
    </script>
</body>
</html>