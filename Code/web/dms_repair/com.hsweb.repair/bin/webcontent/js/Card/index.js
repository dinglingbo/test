$(function () {

	//弹出登录框
	$("#login").click(openLogin);
	

});

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