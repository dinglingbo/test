<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): shitf
  - Date: 2013-03-04 16:22:15
  - Description:
-->
<head>
<title>修改密码</title>
<%@include file="/coframe/tools/skins/common.jsp"%>
</head>
<body>
<div style="padding-top:5px;">
			 <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="cancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
		   
	<form method="post" id = "form1"	name="UpdateForm"   onsubmit="return checkFormSelf(this);">
		 <table class="nui-form-table" style="width:100%;">
	      <tr>
	        <th class="nui-form-label" style="width:110px;"><label for="user.userId$text">当前用户：</label></th>
	        <td>
	          <input id="currentUser" class="nui-textbox nui-form-input"  enabled="false" />
	        </td>
	      </tr>
	      <tr class="odd">
	        <th class="nui-form-label"><label for="password$text">输入旧密码：</label></th>
	        <td>
	          <input id="password" class="nui-password nui-form-input" name="password" required="true" onvalidation="onCheckRight"/>
	        </td>
	      </tr>
	      <tr>
	        <th class="nui-form-label"><label for="pwd1$text">输入新密码：</label></th>
	        <td>
	          <input class="nui-password nui-form-input" id="pwd1" required="true" vtype="minLength:6"/>
	        </td>
	      </tr>
	      <tr class="odd">
	        <th class="nui-form-label"><label for="pwd2$text">确定新密码：</label></th>
	        <td>
	          <input class="nui-password nui-form-input" id="pwd2" name="user/password" required="true" onvalidation="onCheckEqual"/>
	        </td>
	      </tr>
	    </table>

	</form>
</div>

<script type="text/javascript">    
    nui.parse();
    
    nui.get("currentUser").setValue(currLoginName);
    var form = new nui.Form("#form1");

    function save () {
      if(!checkFormSelf()) {
      	return;
      }
      //var form = document.getElementById("form1");
      //form.submit();
      updatePassword();
    }
    
    var passwordUrl=apiPath + sysApi + "/com.hsapi.system.auth.LoginManager.updatePassword.biz.ext";
	function updatePassword(){
    	nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存中...'
	    });
        nui.ajax({
            url: passwordUrl,
            type: 'post',
            data: nui.encode({
            	oldPassword: nui.get('password').getValue(),
            	password: nui.get('pwd2').getValue(),
            	loginName: nui.get('currentUser').getValue(),
            	token: token
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	showMsg("修改成功!","S");
                	grid.reload();
                }else {
                    nui.unmask(document.body);
                    showMsg(data.errMsg,"W");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
		});
    
	}

	function setError(){
    	//window.alert("原密码填写错误！");
    	showMsg("原密码填写错误!","W");
    }    
    function setSuccess(){
    //	window.alert("密码修改成功！");
    	//CloseWindow("SaveSuccess");
    	showMsg("密码修改成功!","S");
    }
    function cancel(){
      CloseWindow("cancel");
    }
    
    function onCheckRight(e){
      if(e.isValid){
       // if(retValue=="false"){
        //   e.errorText = "密码不正确";
        //   e.isValid = false;
       // }
      }
    }
  
    function onCheckEqual(e){
      if(e.isValid){
        var pwd = nui.get("pwd1").value;
        if(e.value!=pwd){
          e.errorText = "新密码不一致";
          e.isValid = false;
        }
      }
    }
    
    function checkFormSelf(form1){
 		form.validate();
      	if (form.isValid() == true) {
      		return true;
      	}
    	return false;
    }
    
    function CloseWindow(action){
      if(action=="close" && form.isChanged()){
        if(confirm("数据已改变,是否先保存?")){
          return false;
        }
      }else if(window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
      else
        return window.close();
    }
  </script>
</body>
</html>
