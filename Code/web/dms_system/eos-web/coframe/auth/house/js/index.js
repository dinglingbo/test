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
		Dialog.popup('请输入帐号！');
		$(".accountNo").focus();
		return false;
	}
	if (!loginData.password) {
		Dialog.popup('请输入密码！');
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
