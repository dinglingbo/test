var forgetPass;
$(function () {

	//显示登录框
	$("#login").click(openLogin);
	//显示注册框
	$("#register").click(openRegister);
	
	//登录
	$("#loginJump").click(loginTest);
	
	//发送验证码
	$("#sentCode").click(sentCode);
	
	//放大APP二维码
	$(".imgbox").mousemove(maxImg).mouseout(function (){
		$(".max_img").hide();
	});
	$(".weixinbox").mousemove(function() {
		$(".weixin_max_img").show();
	}).mouseout(function (){
		$(".weixin_max_img").hide();
	});

});
//显示登录框
function openLogin() {
	$("#registerBox").hide();
	$("#loginBox").show();
}
//显示注册框
function openRegister() {
	$("#registerBox").show();
	$("#loginBox").hide();
}
function maxImg() {
	console.log(2314);
	$(".max_img").show();
}
function weixiMmaxImg() {
	console.log(2314);
	$(".weixin_max_img").show();
}

//登录验证
function loginTest() {
	var loginData = {
			clientId: 'e7402717-528f-4179-a1b2-a7d52ddff9e4',
			serialNumber: '6f4ae8f5586d43ed99ee1457e5ca41c7',
			clientSecret: "9bb02289-3cbc-46b3-90f0-a6b8f89db2ba",
			phoneType: 'pc',
			platform: 25
		},
		memory = $("#memory").prop("checked");
		
		loginData.loginName = $(".accountNo").val().trim();
		loginData.password = $(".password_val").val().trim();
		
	if (!loginData.loginName) {
		//Dialog.popup('请输入帐号！');
		$("#error").html('请输入帐号！');
		$(".accountNo").focus();
		return false;
	}
	if (!loginData.password) {
		//Dialog.popup('请输入密码！');
		$("#error").html('请输入密码！');
		$(".password_val").focus();
		return false;
	}

	
	document.loginForm.submit();
	
	 
}

//改更密码验证
function changeTest() {
	var $target = $(this),
		changePass = {},
		$val = $target.parents(".login_box"),
		$phone = $val.find(".phone"),
		$code = $val.find(".code"),
		$password = $val.find(".password");
		
		changePass.tel = $("#senderTel").val().trim();
		changePass.valiCode = $(".valiCode").val().trim();
		changePass.newPassword = $(".newPassword").val().trim();
	if(!(PHONE_NUMBER.test(changePass.tel))){ 
		$phone.next(".error").remove();
		$phone.addClass("red_label").after('<div class="error">请输入正确的手机号码!</div>');
		return false;
	} else {
		$phone.next(".error").remove();
		$phone.removeClass("red_label");
	}
		
	if (changePass.valiCode == "") {
		$code.next(".error").remove();
		$code.addClass("red_label").after('<div class="error">请输入验证码!</div>');
		return false;
	} else {
		$code.next(".error").remove();
		$code.removeClass("red_label");
	}
	
	if (changePass.newPassword == "" || changePass.newPassword.length < 6) {
		$password.next(".error").remove();
		$password.addClass("red_label").after('<div class="error">请输入大于6位字符的密码!</div>');
		return false;
	} else {
		$password.next(".error").remove();
		$password.removeClass("red_label");
	}
	
	sendRequest({
		token: false,
		action: 'ar/member/updatePassward',
		data: changePass,
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				Dialog.popup('密码改更成功！', closeForgetPass);
				//forgetPass.close();
			} 
		}
	});
	
}
function closeForgetPass() {
	forgetPass.close();
}

//发送验证码
function sentCode() {
	var $target = $(this),
		phone = $target.parents(".login").find("#senderTel").val().trim();
		
	if(!(PHONE_NUMBER.test(phone))){ 
		Dialog.popup('请输入有效的手机号码！');
		return false;
	}

	sendRequest({
		token: false,
        action: 'common/sendAuthcode',
        data: {mobile: phone},
		lock: true,
        onSuccess: function(obj) {
            if (obj.status == 'success') {
				settime($target);
			}
        }
    });
}

//验证码倒计时
var rewireTime=300;
function settime(target) {
	if (rewireTime == 0) {
		target.removeClass("disabled").text("重发验证码");
		rewireTime = 300;
	} else {
		target.addClass("disabled").text(rewireTime +"秒后重发");
		rewireTime--;
		setTimeout(function() {
			settime(target)
		},1000);
	}
}


function showError(msg){
 	 //$("#error").html(msg);
 	 if(msg){
     	$("#error").addClass("errorC");
     	$("#error").html(msg);
 	 }else{
 	 	$("#error").addClass("error");
     	$("#error").html("");
 	 }
 }

$("#userId").focus(function(){
	$("#error").removeClass("errorC");
	$("#error").html("");
});
$("#password").focus(function(){
	$("#error").removeClass("errorC");
	$("#error").html("");
});
 
 //获取键盘 Enter 键事件并响应登录
function keyboardLogin(e){
  login();
}
function login(){
	//var form = new nui.Form("#form1");
   //form.validate();
   //if (form.isValid() == false) 
   	//return false;

   if($(".pwdBtnShow").attr("isshow")=="false")
	{
		$("#password").val($("#password1").val());
	}
   
   document.loginForm.submit();
}
function register(){
	var phone = $("#phone").val();
	var registername = $("#registername").val();
	var registercompname = $("#registercompname").val();
	var code = $("#authcode").val();
	if(!phone){
		$("#errorP").addClass("errorC");
     	$("#errorP").html("请输入手机号");
     	return false;
	}
	if(!registername){
		$("#errorP").addClass("errorC");
     	$("#errorP").html("请输入用户名");
     	return false;
	}
	if(!registercompname){
		$("#errorP").addClass("errorC");
     	$("#errorP").html("请输入公司名");
     	return false;
	}
	if(code != msgCode){
		$("#errorP").addClass("errorC");
     	$("#errorP").html("验证码输入错误");
     	return false;
	}


	document.registerForm.action="<%=regUrl%>"
   document.registerForm.submit();        
   
}

$("#phone").focus(function(){
	$("#errorP").removeClass("errorC");
	$("#errorP").html("");
});
$("#authcode").focus(function(){
	$("#errorP").removeClass("errorC");
	$("#errorP").html("");
});
$("#registername").focus(function(){
	$("#errorP").removeClass("errorC");
	$("#errorP").html("");
});
$("#registercompname").focus(function(){
	$("#errorP").removeClass("errorC");
	$("#errorP").html("");
});

function showRegisterError(msg){
 	 alert(msg);
 }

 function sendMsg(){
	var params={};
	params.phone=$("#phone").val();
   $.ajax({
       url : "<%=sendUrl%>",
       contentType: "application/json;charset=utf-8",
       data : JSON.stringify({params:params}),
       type : "post",
       success : function(data) {
       	if(data.data.Code=="OK")
       		{
       		msgCode=data.data.msgCode;
       		settime(60);
       		}
       	else {
       		alert(data.data.Message);
       	}
       	
       },
       error : function(jqXHR, textStatus, errorThrown) {
          console.log(jqXHR.responseText);
       }
   });
 }

 function settime(time) {
	  if (time == 0) {
		  $("#getKeyWorld").attr("disabled", true);
		  $("#getKeyWorld").attr("href","javascript:sendMsg();");
		  $("#getKeyWorld").text("获取验证码"); 
		  msgCode = null;
	    return;
	  } else {
		  $("#getKeyWorld").attr("href","javascript:void(0);");
		  $("#getKeyWorld").attr("disabled", false);
		  $("#getKeyWorld").text("重新发送(" + time + ")");
		
	    time--;
	  }
	  setTimeout(function () { settime(time); }, 1000);
	}

$(function(){
	var validateResult = "<%=result %>";
	$("#userId").val("<%=userName %>");
	$("#password").val("<%=password %>");
	$("#password1").val("<%=password %>");
 });

