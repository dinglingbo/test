<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/frame/common/common.jsp"%>
<script>

	function check(){
		if (!checkForm($id("form1"))){
			return;
		}	
	
		if($id("password1").value!=$id("password2").value){
			f_alert_show_message($id("password2"),"<b:message key="change_password_jsp.pwdDifference"/>");
			return;
		}
		if(checkOldPwd($id("oldPassword"))){
			$id("form1").submit();
		}
		
	}
	function checkOldPwd(obj){
		if(obj.value=="") return;
		var ajax = new HideSubmit("com.primeton.bps.workspace.frame.permission.WSPermissionManage.validateOldPwd.biz");
		var username = "<b:write property='userObject/userId' scope='session' />";
		ajax.addParam("username",username);
		ajax.addParam("password",obj.value);
		ajax.submit();
		var result = ajax.getProperty("result");
		if(result < 0){
			f_alert_show_message($id("oldPassword"),"<b:message key="change_password_jsp.oldPwdError"/>");
			return false;
		}
		return true;
	}
	function clearpwd(){
		$id("oldPassword").value = "";
		$id("password1").value = "";
		$id("password2").value = "";
	}
	
</script>
<form id="form1" method="post" action="com.primeton.bps.workspace.frame.permission.ChangePassword.flow?_eosFlowAction=change">
<table border="0" cellpadding="1" cellspacing="1" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="change_password_jsp.title"/></h3></td>
  </tr>
  <tr> 
    <td width="100%" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	<tr>
		<td class="form_label" width="10%">
		<b:message key="change_password_jsp.oldPassword"/>
		</td>
		<td>
		<h:password id="oldPassword" property="oldPassword" onblur="checkInput(this);" validateAttr="allowNull=false;maxLength=20;minLength=6" filter="true" />
		</td>
	</tr>
	<tr>
		<td class="form_label">
		<b:message key="change_password_jsp.newPassword"/>
		</td>
		<td>
		<h:password id="password1" property="password1"  onblur="checkInput(this);" validateAttr="allowNull=false;maxLength=20;minLength=6" filter="true" />
		</td>
	</tr>
	<tr>
		<td class="form_label"><b:message key="change_password_jsp.confirmPwd"/></td>
		<td><h:password property="password2"  id="password2" onblur="checkInput(this);" validateAttr="allowNull=false;maxLength=20;minLength=6" filter="true" /></td>
	</tr>
	<tr>
		<td colspan="2">
		<input id="btnOK" name="btnOK" type="button" value="<b:message key="change_password_jsp.btnOK"/>" class="button" onclick="check()"/>
		<input id="btnReset" name="btnReset" type="button" value="<b:message key="change_password_jsp.btnReset"/>" class="button" onclick="clearpwd()"/>
		</td>
	</tr>
	</table>
	</td>
   </tr>
</table>
</form>
<l:present property="result">
<l:equal property="result" targetValue="true">
	<script>
		function alertmsg(){
			f_alert_show_message($id("password2"),"<b:message key="change_password_jsp.changeSuccess"/>");
		}
		eventManager.add(window,'load',alertmsg);
		//alert("密码修改成功");
	</script>
</l:equal>
</l:present> 
