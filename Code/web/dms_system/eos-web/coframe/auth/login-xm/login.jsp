<%@page import="com.eos.system.utility.StringUtil"%>
<%@page import="com.eos.access.http.security.config.HttpSecurityConfig"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="com.primeton.cap.AppUserManager"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>汽修达人管理平台</title>
<meta charset="utf-8">
<meta name="keywords" content="汽修达人管理平台"/>
<meta name="description" content="汽修达人管理平台"/>
<meta name="author" content="shenzhi"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="apple-mobile-web-app-title" content="汽修达人管理平台"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta name="format-detection" content="telephone=no, address=no, email=no" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

 <%
   String contextPath=request.getContextPath();
   String url = null;
   String loginUrl = "org.gocom.components.coframe.auth.login.login.flow";
   loginUrl = "com.hsapi.system.auth.login.mlogin.flow";
   String regUrl = "com.hsapi.system.auth.login.registerOfm.flow";
   
   HttpSecurityConfig securityConfig = new HttpSecurityConfig();
   boolean isOpenSecurity = securityConfig.isOpenSecurity();
   if(isOpenSecurity){
   		boolean isAllInHttps = securityConfig.isAllInHttps();
   		if(!isAllInHttps){
   			String ip = securityConfig.getHost();
   			String https_port = securityConfig.getHttps_port();
   			url = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/login/" + loginUrl;
   			regUrl = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/login/" + regUrl;
   		}else{
   			url = loginUrl;
   		}
   }else{
   		url = loginUrl;
   }

   	//api地址
	String apiPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort(); 
	String sysApi = Env.getContributionConfig("system", "url", "apiDomain", "SYS");
	String sendUrl = apiPath + sysApi + "/com.hsapi.system.tenant.register.sendMsg.biz.ext";
 %> 
<style type="text/css">
body { 
	min-width: 1200px;
	background-color: #0B57AB;
	background-image:-webkit-linear-gradient( 90deg, #87F1F2, #0B57AB ); 
    background-image:linear-gradient( 90deg, #87F1F2, #0B57AB ); 	
}

.login_box{
	max-width: 1200px;
	height: 675px;
	background-image: url(images/bg.png);
	background-repeat: no-repeat;
	background-position:center center;
	margin: 0 auto;
	position: relative;
}
.login_box .login {
	position: absolute;
	display: block;
	width: 380px;
	background-color: #FFF;
	top: 130px;
	right: 80px;
	padding-bottom: 20px;
	
}


.login_box .login .title {
	padding: 20px 0 15px;
	font-size: 18px;
	text-align: center;
	height: 40px;
}
.login_box .login .loginTitle {
	height: 10px;
	padding-left: 30px;
}
.login_box .login .loginTitle .log {
	float: left;
	font-size: 25px;
	text-align: left;
	padding-top: 10px;
}
.login_box .login .loginTitle .log span {
	display: block;
	font-size: 10px;
	color: #A5A5A5;
}
.login_box .login .loginTitle .weixinbox {
	float: right;
}
.login_box .login label {
	padding: 0 30px;
	width: 80%;
	margin: 0;
	float: left;
}
.login_box .login label ~ label {
	margin-top: 15px;
}
.login_box .login input {
	background-color: #F0F0F0;
	border: 0;
	width: 100%;
	border-radius: 0;
	height: 34px;
}
.login_box .login input[type="checkbox"] {
	background-color: #F0F0F0;
	border: 0;
	width: initial;
	border-radius: 0;
	height: 34px;
}
.login_box .login .app {
	float: left;
	display: block;
	margin-top: 10px;
	width: 80%;
	padding: 0 30px;
}
.imgbox{
	float: left;
	position: relative;
	cursor: pointer;
}
.imgbox .max_img{
	display: none;
	position: absolute;
	bottom: 0;
	left: 0;
	width: 250px;
	height: 250px;
}
.imgbox .max_img img{ 
	width: 100%;
	height: 100%;
}

.login_box .login .app > .you{
	float: right;
	color: #A5A5A5;
}
.login_box .login input.min { width: initial;}
.login_box .login .button {
	background-color: #95B93D;
	height: 34px;
	line-height: 34px;
	text-align: center;
	color: #FFF;
}
.login_box .blue { color: #0050FB;cursor: pointer;font-size: 14px;}
.login_box .wu {
	text-align: center;	
	margin-top: 20px;
	
}
.login_box .you {
	text-align: center;	
	margin-top: 20px;
	width: 350px;
	
}
#registerBox{display: none;
}
.weixin_img {
	display: block;
	width: 45px;
	height: 47px;
	position: absolute;
	top: 0;
	right: -33px;
	cursor: pointer;
}
.weixin_max_img {
	z-index: 9999;
	display: none;
	position: absolute;
	top: 0;
	right: 0px;
	width: 350px;
	height: 320px;
}
.weixin_max_img img {width: 100%; height: 100%;}
.checkbox_box {
	display: inline-block;
	position: relative;
  	cursor: pointer;
  	width: 16px;
    height: 16px;
}
.checkbox_box > input {
	cursor: pointer;
	display: none;
}
.checkbox_box > input:checked + .show-box {
	background: #94B83C;
}
.checkbox_box .show-box {
    position: absolute;
    top: 4px;
    left: 0;
    width: 16px;
    height: 16px;
    border-radius: 2px;
    border: 1px solid #E5E5E5;
    background: #FFF;
  }
.checkbox_box .show-box:before {
      content: ''; 
      position: absolute;
      top: 2px;
      left: 6px;
      width: 3px;
      height: 8px;
      border: solid #FFF;
      border-width: 0 2px 2px 0;
      transform: rotate(45deg);
}
a {
     text-decoration: none;
}
</style>

</head>
<body>
<div class="login_box">
	<form method="post"	name="registerForm" onsubmit="return register();" action="">
	<div class="login" id="registerBox">
		<div class="title">注册</div>
		
		<label>
			<p id="errorP"><span id="error" style="font-size:15px;color:red"></span></p>
			<input type="text" id="registercompname" name="registercompname" value="" placeholder="请输入公司名" maxlength="11" />
		</label>
		<label>
			<input type="text" id="registername" name="registername" value="" placeholder="请输入用户名" maxlength="20" />
		</label>
		<label>
			<input type="text" class="number" id="phone" name="phone" value="" placeholder="手机号码" maxlength="11" />
		</label>
		
		<label>
			<input class="min" type="text" id="authcode" name="authcode" value="" placeholder="请输入验证码" maxlength="11" />
			<a href="javascript:sendMsg();" id="getKeyWorld" text-decoration="none";><span class="blue" id="sentCode">获取验证码</span></a>
		</label>
		
		<label>
			<div class="checkbox_box">
				<input type="checkbox" checked="checked" /><div class="show-box"></div>
			</div>
			我已阅读并接受<span class="blue">《云平台用户注册协议》</span>
		</label>
		<label>
			<div class="button"><input type="submit" value="注册" class="button" /></div>
		</label>
		<div class="you" >已经有帐号？  <span class="blue" id="login">登录</span></div>
	</div>
</form>	
<form method="post"	name="loginForm" onsubmit="return login();" action="<%=url%>">	
	<div class="login" id="loginBox">
		<div class="loginTitle">
			<div class="weixinbox">
				<img src="images/weixin-min-img.png"  />
				<div class="weixin_max_img">
					<img src="images/app-min-img.png"  />
				</div>
			</div>		
			<div class="log">
				欢迎登录车道商户版
				<span>为了保障您顺畅的使用，建议使用谷歌/火孤/360浏览器</span>
			</div>
		</div>
		<label>
		<p  class="errorC"><span id="error" style="font-size:15px;color:red"></span></p>
			<input type="text" id="userId" name="userId" value="" class="accountNo" placeholder="用户名" maxlength="11" />
		</label>
		<label>
			<input type="password" d="password" name="password" value="" class="password_val" placeholder="密码" maxlength="20" />
		</label>
		<label>
			<div class="button" id="loginJump">登录</div>
		</label>
		<label>
			<div class="checkbox_box">
				<input type="checkbox" id="memory" checked="checked" /><div class="show-box"></div>
			</div>
			登录即同意 <span class="blue">隐私政策/用户协议</span>
		</label>

		<div class="app">
			<div class="imgbox">
				<img src="images/app-min-img.png"  />
				<div class="max_img">
					<img src="images/app-min-img.png"  />
				</div>
			</div>
			<div class="wu">还没帐号？  <span class="blue" id="register">立即注册</span></div>
		</div>	
	</div>
</form>
</div>
<script src="jquery-1.9.1.min.js?ver=1.01"></script>
<script src="login.js?ver=2.0.0"></script>
<script type="text/javascript">
	   <% 
	     	Object result = request.getAttribute("result");
	     	String userName = (String)request.getAttribute("userId");
	     	if (userName==null)userName="";
	     	String password = (String)request.getAttribute("password");
	     	if (password==null)password="";
	     	if(result != null){
	     		Integer resultCode = (Integer)result;
	     		 if(resultCode == 0){
			     	out.println("showError('密码错误！')");
			     }else if(resultCode == -1){
			     	out.println("showError('用户不存在！')");
			     }else if(resultCode == -2){
			     	out.println("showError('用户无权限登录，请联系系统管理员！')");
			     }else if(resultCode == 3){
			     	out.println("showError('用户已过期！')");
			     }else if(resultCode == 4){
			     	out.println("showError('用户未到开始使用时间！')");
			     }else if(resultCode == 5){
			     	out.println("showError('密码已过期！')");
			     }else if(resultCode == -3){
	      			out.println("showError('查询用户信息失败，请联系系统管理员检查数据库连接！')");
	     		 }else{
	      			out.println("showError('未知的异常，请联系系统管理员！')");
	     		 }
	     	}else{
	     		out.println("showError('')");
	     	}
		  %>
	      function showError(msg){
	      	 //$("#error").html(msg);
	      	 if(msg){
		      	//$("#error").addClass("errorC");
		      	$("#error").html(msg);
	      	 }else{
	      	 	//$("#error").addClass("error");
		      	//$("#error").html("");
	      	 }
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
	     	 <% 
	        	String errCode = (String)request.getAttribute("errCode");
	        	String errMsg = (String)request.getAttribute("errMsg");
	        	if(errCode=="E"){
	        		out.println("showRegisterError('"+errMsg+"')");
	        	}else if(errCode=="S"){
	        		out.println("showRegisterError('注册成功,请待审批')");
	        	}
	        	

	        %>

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
		        		settime(1);
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

</script>

</body>
</html>