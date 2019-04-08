<%@page import="com.eos.system.utility.StringUtil"%>
<%@page import="com.eos.access.http.security.config.HttpSecurityConfig"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="com.primeton.cap.AppUserManager"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>配思云汽配</title>
<script src="<%= request.getContextPath() %>/common/nui/nui.js?v=1.0.1" type="text/javascript"></script>
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
   loginUrl = "com.hsapi.system.auth.login.loginCloud.flow";
   String regUrl = "com.hsapi.system.auth.login.registerOfm.flow";
   
   HttpSecurityConfig securityConfig = new HttpSecurityConfig();
   boolean isOpenSecurity = securityConfig.isOpenSecurity();

   String ip = securityConfig.getHost();
   String https_port = securityConfig.getHttps_port();
 		 
   if(isOpenSecurity){
   		boolean isAllInHttps = securityConfig.isAllInHttps();
   		if(!isAllInHttps){
   			url = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/loginCloud/" + loginUrl;
   			regUrl = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/loginCloud/" + regUrl;

   		}else{
   			url = loginUrl;
   		}
   }else{
   		url = loginUrl;
   }

   	//api地址
	String apiPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort(); 
	String sysApi = Env.getContributionConfig("system", "url", "apiDomain", "SYS");
	String sendUrl = apiPath + sysApi + "/com.hsapi.system.tenant.register.sendRegisterMsg.biz.ext";
	String privacyUrl = request.getContextPath() + "/coframe/auth/loginCloud/privacyUrl.jsp";
	String protocolUrl = request.getContextPath() + "/coframe/auth/loginCloud/protocolUrl.jsp";
 %> 
<style type="text/css">
html{
	height:100% !important;
}

body { 

	min-width: 98%;
	min-height: 97%;
	background-color: #0B57AB;
	background-image:-webkit-linear-gradient( 90deg, #87F1F2, #0B57AB ); 
    background-image:linear-gradient( 90deg, #87F1F2, #0B57AB ); 	
}

.login_box{
	max-width: 100%;
	height: 97vh;
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
	top: 30%;
	right: 15%;
	padding-bottom: 30px;
	
	
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
	height: 80px;
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
.login_box .login input.yzm {
	background-color: #F0F0F0;
	border: 0;
	width: 40%;
	border-radius: 0;
	height: 34px;
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
	width: 300px;
	height: 270px;
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
	cursor: pointer;
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
	width: 250px;
	height: 250px;
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
.com_text {
  position: absolute;
  left: 0;
  width:100%;
  bottom: 20px;
  text-align: center;
  color: #FFF;
  font-size:13px;
  }
</style>

</head>
<body>



<div class="login_box">
	<form method="post"	name="registerForm" onsubmit="return register();" action="">
	<div class="login" id="registerBox">
		<div class="title">注册</div>	
		<label style="width:100%">
			<p ><span id="errorP" style="font-size:15px;color:red"></span></p>
			<input type="text" id="registercompname" name="registercompname" value="" placeholder="请输入公司名" maxlength="11" />
		</label>
		<label style="width:100%">
			<input type="text" id="registername" name="registername" value="" placeholder="请输入用户名" maxlength="20" />
		</label>
		<label style="width:100%">
			<input type="text" class="number" id="phone" name="phone" value="" placeholder="手机号码" maxlength="11" />
		</label>
		
		<label style="width:100%">
			<input class="min" type="text" id="authcode" name="authcode" value="" placeholder="请输入验证码" maxlength="11" />
			<a href="javascript:sendMsg();" id="getKeyWorld" text-decoration="none";><span class="blue" >获取验证码</span></a>
		</label>
		
		<label style="width:100%">
			<font size="2">注册即同意</font><span class="blue">
					<a target="_blank" href="<%=privacyUrl%>"><span class="blue" id="privacy"  >隐私政策</span></a>&nbsp;<span style="color:#999">/</span>
					<a  target="_blank" href="<%=protocolUrl%>"><span class="blue"  id="protocol" >用户协议</span></a>
			</span>
			
		</label>
		<label style="width:100%">
			<div class="sing"><input id="registered" type="submit" value="注册" class="button" /></div>
		</label>
		<div class="app">
			<div class="you" >已经有帐号？  <span class="blue" id="login">登录</span></div>
		</div>
	</div>
</form>	
<!--<form method="post"	name="loginForm"  action="login.jsp">-->
<form method="post"	name="loginForm" onsubmit="return login();"  action="<%=url%>">	
	<div class="login" id="loginBox">
		<div class="loginTitle">
			<div class="weixinbox">
				<img src="" />
				<div class="weixin_max_img">
					<img src=""  />
				</div>
			</div>		
			<div class="log">
				欢迎登录配思云汽配
				<span>为了保障您顺畅的使用，建议使用谷歌/火孤/360浏览器</span>
			</div>
		</div>
		<label style="width:100%">
		<p  class="errorC"><span id="error" style="font-size:15px;color:red"></span></p>
			<input type="text" id="userId" name="userId" value="" class="accountNo" placeholder="用户名" maxlength="11" />
		</label>
		<label style="width:100%">
			
			<input type="password" id="password" name="password" value="" class="password_val" placeholder="密码" maxlength="20" />
		</label>
		<label style="width:100%">
			
		   	 <input type="text" class="yzm" name="code"  id="code" style="width:60%" placeholder="验证码" maxlength="9" />
		  	 <span><img id="loginImgVeri" src="../img.jsp" style="vertical-align:middle;"></span><a href="javascript:reload();"> 换一张</a>
		</label>
		<label style="width:100%">
			<div  class="sing" id="loginJump"><input  type="submit" value="登录" class="button" /></div>
		</label>
<!-- 		<label>
			<div class="checkbox_box">
				<input type="checkbox" id="memory" checked="checked" /><div class="show-box"></div>
			</div>
			登录即同意 <span class="blue">隐私政策/用户协议</span>
		</label> -->

		<div class="app">
			<div class="imgbox">
				<img src="" onclick="changeShow();"  />
				<div class="max_img">
					<img src=""  onclick="changeHide();"  />
				</div>
			</div>
			<div class="wu">还没帐号？  <span class="blue" id="register">立即注册</span></div>
		</div>	
	</div>
</form>
<div class="com_text">Copyright © 2014-2018 广州尤耐汽车零部件有限公司  版权所有: <a style="color: #FFF;" onClick="jump()">粤ICP备18118602号-3 </a></div>
</div>
<script src="jquery-1.9.1.min.js?ver=1.01"></script>
<script type="text/javascript">
nui.parse();
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  
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
	     		 }else if(resultCode == -4){
	      			out.println("showError('验证码输入不正确，请重新输入！')");
	     		 }else{
	      			out.println("showError('未知的异常，请联系系统管理员！')");
	     		 }
	     	}else{
	     		out.println("showError('')");
	     	}
		  %>
		 var  msgCode = "";
$(function () {
	//显示登录框
	$("#login").click(openLogin);
	//显示注册框
	$("#register").click(openRegister);
	
	//登录
	//$("#loginJump").click(loginTest);
	
	//注册registered
	$("#registered").click(registered);
	
	//发送验证码
	$("#sentCode").click(sendMsg);
	
	//放大APP二维码
/* 	$(".imgbox").mousemove(maxImg).mouseout(function (){
		$(".max_img").hide();
	}); */
 	$(".weixinbox").mousemove(function(){
		$(".weixin_max_img").show();
	}).mouseout(function (){
		$(".weixin_max_img").hide();
	}); 
});

function jump(){
	window.open("http://www.miitbeian.gov.cn");
}
function changeShow(){
	$(".max_img").show();
}

function changeHide(){
	$(".max_img").hide();
}
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
	$(".max_img").show();
}
function weixiMmaxImg() {
	$(".weixin_max_img").show();
}
		  
  function showError(msg){
  	 if(msg){
      	$("#error").html(msg);
  	 }
  } 
  
 //注册    
function register(){
 	var phone = $("#phone").val();
 	var registername = $("#registername").val();
 	var usern = /^[a-zA-Z0-9_]{1,}$/;
 	if (!registername.match(usern)) { 
 		$("#errorP").html("用户名只能由字母数字下划线组成");
	    return false;
 	}
 	
 	var registercompname = $("#registercompname").val();
 	var code = $("#authcode").val();
     	if(!registercompname){
	      	$("#errorP").html("请输入公司名");
	      	return false;
     	}
     	if(!registername){
	      	$("#errorP").html("请输入用户名");
	      	return false;
     	}
     	if(!phone){
	      	$("#errorP").html("请输入手机号");
	      	return false;
     	}

     	if(!code){
	      	$("#errorP").html("请输入验证码");
	      	return false;
     	}

     	if(code != msgCode){
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
			$("#errorP").html("");
		 });
		 $("#authcode").focus(function(){
			$("#errorP").html("");
		 });
		 $("#registername").focus(function(){
			$("#errorP").html("");
		 });
		 $("#registercompname").focus(function(){
			$("#errorP").html("");
		 });

		 function showRegisterError(msg){
	      	 alert(msg);
	      }
	      
	       function sendMsg(){
			var params={};
			params.phone=$("#phone").val();
			if(!params.phone){
		      	$("#errorP").html("请输入手机号");
		      	return false;
	     	}
		    $.ajax({
		        url : "<%=sendUrl%>",
		        contentType: "application/json;charset=utf-8",
		        data : JSON.stringify({params:params}),
		        type : "post",
		        success : function(data) {
		           if(data.errCode=="S"){
		              if(data.data.Code=="OK")
		        		{
		        		msgCode=data.data.msgCode;
		        		settime(60);
		        		}
		        	  else {
		        		alert(data.data.Message);
		        	 }
		           }else{
		               alert(data.errMsg || "注册失败");
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
	 	 
 //登录验证
function loginTest(user,pass) {
	var loginData = {
			clientId: 'e7402717-528f-4179-a1b2-a7d52ddff9e4',
			serialNumber: '6f4ae8f5586d43ed99ee1457e5ca41c7',
			clientSecret: "9bb02289-3cbc-46b3-90f0-a6b8f89db2ba",
			phoneType: 'pc',
			platform: 25
		},
		memory = $("#memory").prop("checked");
		
/* 		loginData.loginName = $(".accountNo").val().trim();
		loginData.password = $(".password_val").val().trim(); */
		loginData.loginName = user;
		loginData.password = pass;
		
	if (!loginData.loginName) {
		//Dialog.popup('请输入帐号！');
		$("#error").html('请输入帐号！');
		showError('请输入帐号！');
		//$(".accountNo").focus();
		return false;
	}
	if (!loginData.password) {
		//Dialog.popup('请输入密码！');
		$("#error").html('请输入密码！');
		$(".password_val").focus();
		return false;
	}

	
	window.location.href="<%=url%>?userId="+loginData.loginName+"&password="+loginData.password;
	
	 
}


$("#userId").focus(function(){
	$("#error").html("");
});
$("#password").focus(function(){
	$("#error").html("");
});
 
$("#userId").bind("keydown", function (e) {
    if (e.keyCode == 13) {
        $("#password").focus();
    }
});
//Enter建响应
$("#password").bind("keydown", function (e) {
    if (e.keyCode == 13) {
        $("#code").focus();
    }
});
$("#code").bind("keydown", function (e) {
    if (e.keyCode == 13) {
        login();
    }
});
 //获取键盘 Enter 键事件并响应登录
// function keyboardLogin(e){
//   login();
// }
function login(){
	//var form = new nui.Form("#form1");
   //form.validate();
   //if (form.isValid() == false) 
   	//return false;
   	
   	var userId = $("#userId").val();
 	var password = $("#password").val();
 	var code = $("#code").val();
     	if(!userId){
	      	$("#error").html("请输入用户名");
	      	return false;
     	}
     	if(!password){
	      	$("#error").html("请输入密码");
	      	return false;
     	}
     	if(!code){
	      	$("#error").html("请输入验证码");
	      	return false;
     	}

   if($(".pwdBtnShow").attr("isshow")=="false")
	{
		$("#password").val($("#password1").val());
	}
  
    document.loginForm.submit();
}


	 function reload(){
	 	document.getElementById("loginImgVeri").src="../img.jsp?rnd=" + Math.random();
	 }



</script>




</body>
</html>