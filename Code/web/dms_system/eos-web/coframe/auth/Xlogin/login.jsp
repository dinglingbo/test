<%@page import="com.eos.system.utility.StringUtil"%>
<%@page import="com.eos.access.http.security.config.HttpSecurityConfig"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="com.primeton.cap.AppUserManager"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env"%>
<!doctype html>
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
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/coframe/auth/Xlogin/Xlogin.js?v=1.0.3">
	</script>
    
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />

	<%
   String contextPath=request.getContextPath();
   String url = null;
   String loginUrl = "org.gocom.components.coframe.auth.login.login.flow";
   loginUrl = "com.hsapi.system.auth.login.wlogin.flow";
   String regUrl = "com.hsapi.system.auth.login.register.flow";
   
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
    <style>
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
	width: 350px;
	background-color: #FFF;
	top: 150px;
	right: 140px;
	padding: 0 33px 30px;
}
.login_box .login .title {
	padding: 20px 0 15px;
	font-size: 18px;
	text-align: center;
}
.login_box .login label {
	width: 100%;
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
.login_box .login input.min { width: initial;}
.login_box .login .button {
	background-color: #95B93D;
	height: 34px;
	line-height: 34px;
	text-align: center;
	color: #FFF;
}
.blue { color: #0050FB; cursor: pointer;}
.you {
	text-align: center;	
	margin-top: 20px;
}
#registerBox {display: none;}
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
    width: 16px ;
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
</style>
    
</head>
<body>
<div class="login_box">
	<div class="login" id="registerBox">
		<div class="title">注册</div>
		<label>
			<input type="text" id="userName" value="" placeholder="请输入帐号名" maxlength="11" />
		</label>
		<label>
			<input type="password" id="password" value="" placeholder="请设置密码" maxlength="20" />
		</label>
		<label>
			<input type="text" class="number" id="senderTel" value="" placeholder="手机号" maxlength="11" />
		</label>
		
		<label>
			<input class="min" type="text" id="valiCode" value="" placeholder="请输入手机验证码" maxlength="11" />
			<span class="blue" id="sentCode">获取验证码</span>
		</label>
		
		<label>
			<div class="checkbox_box">
				<input type="checkbox" checked="checked" /><div class="show-box"></div>
			</div>
			我已阅读并接受<span class="blue">《云平台用户注册协议》</span>
		</label>
		<label>
			<div class="button">注册</div>
		</label>
		<div class="you">已经有帐号？  <span class="blue" id="login">登录</span></div>
	</div>
	<form method="post"	name="loginForm" onsubmit="return login();" action="<%=url%>">
	<div class="login" id="loginBox">
		<div class="title">登录</div>
		<label>
			<input type="text" id="loginUserName" value="" class="accountNo" placeholder="请输入账号" maxlength="11" />
		</label>
		<label>
			<input type="password" id="loginPassword" class="password_val" value="" placeholder="请输入密码" maxlength="20" />
		</label>
		<label>
			<div class="checkbox_box">
				<input type="checkbox" id="memory" checked="checked" /><div class="show-box"></div>
			</div>
			<span>记住密码</span>
		</label>
		<label>
			<div class="button" id="loginJump" type="submit">登录</div>
		</label>
		<div class="you">暂无帐号？  <span class="blue" id="register">注册</span></div>
	</div>
	</form>
</div>
<script type="text/javascript" src="<%= request.getContextPath() %>/coframe/auth/login/js/jquery-1.9.1.min.js"></script>
<!-- <script src="/basis_js/jquery.js?ver=1.01"></script>
<script src="/basis_js/plugin.js?ver=1.01"></script>
<script src="/basis_js/basic.js?ver=1.01"></script> -->
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
		      	//$("#error").html(msg);
		      	openLogin();
		      	Dialog.popup(msg);
	      	 }else{
	      	 	//$("#error").addClass("error");
		      	//$("#error").html("");
	      	 }
	      }

</script>

</body>
</html>