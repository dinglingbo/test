var forgetPass;
$(function () {

	//弹出登录框
	$("#login").click(openLogin);
	
	//滑动图片
	$('.flexslider').flexslider({
		directionNav: true,
		pauseOnAction: false,
		slideshowSpeed: 3000
	});

	$("#toTop").click(function() {  
            $('body,html').animate({  
                scrollTop: 0  
            },  
            500);  
            return false;  
    });
});
//弹出登录框
function openLogin() {
	var $target = $(this),
		$content = $('#login-box-tmpl').tmpl();
	$target.hide();	
	$content.find("#loginJump").click(loginTest);
	var pass = GetCookie("qixioudr", "password"),
		user = GetCookie("qixioudr", "username")
	$content.find('.password_val').val(pass);
	$content.find('.accountNo').val(user);
	console.log(pass, user)
	var dialog = new Dialog({
		title: null,
		content: $content,
		onClose: function() {
        	$("#login").show();
       	}
	}).show();
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
/*	var d = {
			userId:loginData.loginName,
			password:loginData.password
	}*/
//	var saveDataUrl = "com.hsapi.system.auth.login.login.flow";
//	$.ajax({
//		url : saveDataUrl,
//		type : 'POST',
//		data : d,
//		cache : false,
//		contentType : 'text/json',
//		success : function(text) {
//			var returnjson=text;
//			var returnjson1=text.retCode;
//		}
//	});
	
	document.loginForm.submit();


	 
}




