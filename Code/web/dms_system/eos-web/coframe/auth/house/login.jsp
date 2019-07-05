<%@page import="com.eos.system.utility.StringUtil"%>
<%@page import="com.eos.access.http.security.config.HttpSecurityConfig"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="com.primeton.cap.AppUserManager"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>仓先生</title>
<script  src="<%= request.getContextPath() %>/common/nui/nui.js?v=2.1.50" type="text/javascript" ></script>
<script src="<%= request.getContextPath() %>/common/js/qrcode.js" type="text/javascript"></script>
<meta charset="utf-8">
<meta name="keywords" content="仓先生"/>
<meta name="description" content="仓先生"/>
<meta name="author" content="shenzhi"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="apple-mobile-web-app-title" content="仓先生"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta name="format-detection" content="telephone=no, address=no, email=no" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand"/>

 <%
   String contextPath=request.getContextPath();
   String url = null;
    String sweepCodeUrl = null;
   String loginUrl = "org.gocom.components.coframe.auth.login.loginHouse.flow";
   String sweepCodeFlow = "com.hsapi.system.auth.login.qrLogin.flow";
   loginUrl = "com.hsapi.system.auth.login.loginHouse.flow";
   String regUrl = "com.hsapi.system.auth.login.houseRegister.flow";
   
   HttpSecurityConfig securityConfig = new HttpSecurityConfig();
   boolean isOpenSecurity = securityConfig.isOpenSecurity();

   String ip = securityConfig.getHost();
   String https_port = securityConfig.getHttps_port();
 		 
   if(isOpenSecurity){
   		boolean isAllInHttps = securityConfig.isAllInHttps();
   		if(!isAllInHttps){
   			url = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/login/" + loginUrl;
   			sweepCodeUrl = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/login/" + sweepCodeFlow;
   			regUrl = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/login/" + regUrl;

   		}else{
   			url = loginUrl;
   			sweepCodeUrl = sweepCodeFlow;
   		}
   }else{
   		url = loginUrl;
   		sweepCodeUrl = sweepCodeFlow;
   }

   	//api地址
//	String apiPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort(); 
	String apiPath = "";
	String sysApi = Env.getContributionConfig("system", "url", "apiDomain", "SYS");
	String sendUrl = apiPath + sysApi + "/com.hsapi.system.tenant.register.sendRegisterMsg.biz.ext";
	String privacyUrl = request.getContextPath() + "/coframe/auth/login/privacyUrl.jsp";
	String protocolUrl = request.getContextPath() + "/coframe/auth/login/protocolUrl.jsp";
 %> 
<style type="text/css">
html{
	height:100% !important;
}

body { 
    margin:0px;
    padding:0px;
    text-align:center;
}

.main_content{
	width:1024px;
	height:520px;
    margin: 0 auto;
    position: relative;
	background-image: url(images/bg.png);
	background-repeat: no-repeat;
	background-position:center center;
	background-size: 100% 100%;	
}
.login_box .login {
	position: absolute;
	display: block;
	width: 362px;
    /* height:362px; */
	background-color: #FFF;
	top: 79px;
	right: 39px;
    border-radius: 4px;
    padding-bottom: 30px;
}


.login_box .login .title {
	padding: 20px 0 15px;
	font-size: 18px;
	text-align: center;
	height: 40px;
	color: #26C789;
}
.login_box .login .loginTitle {
	padding-left: 20px;
	height: 60px;
}
.login_box .login .loginTitle .log {
	float: left;
	font-size: 20px;
	text-align: left;
	padding-top: 10px;
	color:#26C789;

    height:28px;
    font-family:PingFang-SC-Medium;
    font-weight:500;
    line-height:28px;
}
.login_box .login .loginTitle .log span {
	display: block;
	font-size: 12px;
    font-family:PingFang-SC-Regular;
	color: #A5A5A5;
    line-height:17px;
    font-weight:400;
}
.login_box .login .loginTitle .weixinbox {
	float: right;
}
.login_box .login label {
	padding: 0 20px;
	width: 80%;
	margin: 0;
	float: left;
}
.login_box .login label ~ label {
	margin-top: 16px;
}
.login_box .login input.yzm {
	/* background-color: #F0F0F0;
    float:left;
	border: 0;
	width: 40%;
	border-radius: 0;
	height: 34px; */
    float: left;
    width:160px;
    height:40px;
    background:rgba(255,255,255,1);
    border-radius:4px;
    border:1px solid rgba(0,0,0,0.15);
}

.yzm_pic{
    height:20px;
    margin-left:10px;
}

.change_btn{
    margin-left:10px;
    font-size:14px;
    font-family:PingFangSC-Regular;
    font-weight:400;
    color:rgba(38,199,137,1);
    line-height:20px;
}
.login_box .login input {
	/* background-color: #F0F0F0;
	border: 0;
	width: 100%;
	border-radius: 0;
	height: 34px; */
    width:320px;
    height:40px;
    background:rgba(255,255,255,1);
    border-radius:4px;
    border:1px solid rgba(0,0,0,0.15);
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
	margin-top: 5px;
	width: 100%;
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
	background-color: #26C789;
	height: 40px;
	/* line-height: 34px; */
	text-align: center;
	color: #FFF;
	cursor: pointer;
}
.login_box .blue { color: #26C789;cursor: pointer;font-size: 14px;}
.login_box .blue1 { color: #26C789;cursor: pointer;font-size: 18px;}
.login_box .wu {
	text-align: center;	
	margin-top: 20px;
	font-size:14px;
    font-family:PingFangSC-Regular;
    font-weight:400;
    line-height:20px;
}
.login_box .you {
	text-align: center;	
	margin-top: 20px;
	width: 100%;
	
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
     color:#26C789;
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
  
  .com_rcode {
  	position: absolute;
    left:40px;
  	bottom: 40px;
  	width:50%;
  }
  
  .qr_imgbox {
    float: left;
  	margin-left: 20px;
  }
  
  .ios-max {
  	bottom: 100px;
  	margin-left: 40px;
  	position:absolute;
  	z-index:1;
  }
  
  .android-max {
  	bottom: 100px;
  	margin-left: 240px;
  	position:absolute;
  	z-index:1;
  }
  
  #qrcode{
  	margin-left: 55px;
  	margin-top: 20px;
  }


    .login_box .login input{
        padding-left:10px; /*placeholder文字距左10px*/
    }    /* 使用webkit内核的浏览器 */
    .login_box .login input{
        padding-left:10px; /*placeholder文字距左10px*/
    }                  /* Firefox版本4-18 */
    .login_box .login input{
        padding-left:10px; /*placeholder文字距左10px*/;
    }                  /* Firefox版本19+ */
    .login_box .login input{
        padding-left:10px; /*placeholder文字距左10px*/
    }           /* IE浏览器 */

    .tip_text{
        font-size:20px;
        font-family:PingFangSC-Regular;
        font-weight:400;
        color:rgba(110,121,145,1);
        line-height:28px;
    }

    .group_box{
        width:50%;
        float:left;
    }

   .img_group{
    width:420px;
        height:259px;
        background:linear-gradient(270deg,rgba(221,244,229,1) 0%,rgba(247,244,229,1) 100%);
   }

    .pic_margin_top{
        margin-top:40px;
    }

    .bottom_text{
        width:100%;
        height:160px;
        max-width:1920px;
        margin-top:120px;
        background-color:#3D3E49;
        text-align: center;
        padding-top:32px;
    }
    .about{
        font-family:PingFang-SC-Medium;
        font-weight:500;
        color:rgba(255,255,255,1);
        line-height:28px;
    }
    .copyright{
        font-size:14px;
        font-family:PingFang-SC-Regular;
        font-weight:400;
        color:rgba(255,255,255,1);
        line-height:20px;
    }
</style>

</head>
<body>
<div style="width:1024px;margin: 0 auto;">
    <div class="main_content">
        <div class="login_box">
            <form method="post" name="registerForm" onsubmit="return register();" action="">
                <div class="login" id="registerBox">
                    <div class="title">欢迎注册</div>
                    <label style="width:100%">
                        <p><span id="errorP" style="font-size:15px;color:red"></span>
                        </p>
                        <input type="text" id="registercompname" name="registercompname" value="" placeholder="请输入公司名" maxlength="50" />
                    </label>
                    <label style="width:100%;display:none;">
                        <input type="text" id="registername" name="registername" value="" placeholder="请输入用户名" maxlength="50" />
                    </label>
                    <label style="width:100%">
                        <input type="text" class="number" id="phone" name="phone" value="" placeholder="手机号码" maxlength="50" />
                    </label>
                    <label style="width:100%;text-align: left;">
                        <input class="min" type="text" id="authcode" name="authcode" value="" placeholder="请输入验证码" maxlength="11" /> <a href="javascript:sendMsg();" id="getKeyWorld" text-decoration="none" ;><span class="blue" >获取验证码</span></a>

                    </label>
                    <label style="width:100%;text-align:left;"> <font size="2">注册即同意</font><span class="blue">
                        <a target="_blank" href="<%=privacyUrl%>"><span class="blue" id="privacy"  >隐私政策</span>
                        </a> <span style="color:#999">/</span>
                        <a target="_blank" href="<%=protocolUrl%>"><span class="blue"  id="protocol" >用户协议</span></a>

                        </span>
                    </label>
                    <label style="width:100%;margin-top: 5px !important;">
                        <div class="sing">
                            <input id="registered" type="submit" value="注册" class="button" />
                        </div>
                    </label>
                    <div class="app">
                        <div class="you">已经有帐号？ <span class="blue" id="login">登录</span>
                        </div>
                    </div>
                </div>
            </form>
            <form method="post" name="sweepCodeForm" onsubmit="return sweepCode();" action="<%=sweepCodeFlow%>">
                <div class="login" id="sweepCodeBox">
                    <div class="title"><font color="#0050fb9e">扫码登录</font> | <span class="blue1" id="login1">账号登录</span>
                    </div>
                    <div id="qrcode"></div>
                    <div class="you">打开车道手机APP扫描二维码</div>
                </div>
            </form>
            <form method="post" name="ysweepCodeForm" onsubmit="" action="">
                <div class="login" id="ysweepCodeBox">
                    <div class="title"><font color="#0050fb9e">扫码登录| <span class="blue1" id="login2">账号登录</span></font>
                    </div>
                    <div style="margin-left: 85px;">
                        <img src="images/xiongying.jpg" />
                    </div>
                    <div style="margin-left: 120px;">已扫码，请在手机上确认！</div>
                </div>
            </form>
            <!--<form method="post" name="loginForm" action="login.jsp">-->
            <form method="post" name="loginForm" onsubmit="return login();" action="<%=url%>">
                <div class="login" id="loginBox">
                    <div class="loginTitle">
                        <!-- <div class="weixinbox">
                    <img src="images/weixin-min-img.png" />
                    <div class="weixin_max_img">
                        <img src="images/xiongying.jpg"  />
                    </div>
                </div> -->
                        <div class="log">欢迎登录仓先生 <span>为了保障您顺畅的使用，建议使用谷歌/火孤/360浏览器</span>

                        </div>
                    </div>
                    <label style="width:100%">
                        <p class="errorC"><span id="error" style="font-size:15px;color:red"></span>
                        </p>
                        <input type="text" id="userId" name="userId" value="" class="accountNo" placeholder="用户名" maxlength="50" />
                    </label>
                    <label style="width:100%">
                        <input type="password" id="password" name="password" value="" class="password_val" placeholder="密码" maxlength="50" />
                    </label>
                    <label style="width:100%; display: flex;align-items: center">
                        <input type="text" class="yzm" name="code" id="code" placeholder="验证码" maxlength="9" /> <span class="yzm_pic"><img id="loginImgVeri" src="../img.jsp" ></span><a href="javascript:reload();" class="change_btn"> 换一张</a>

                    </label>
                    <label style="width:100%;margin-top:20px !important;">
                        <div class="sing" id="loginJump">
                            <input type="submit" value="登录" class="button" />
                        </div>
                    </label>
                    <!-- <label>
                <div class="checkbox_box">
                    <input type="checkbox" id="memory" checked="checked" /><div class="show-box"></div>
                </div>
                登录即同意 <span class="blue">隐私政策/用户协议</span>
            </label> -->
                    <div class="app">
                        <!-- <div class="imgbox">
                    <img src="images/app-min-img.png" onclick="changeShow();"  />
                    <div class="max_img">
                        <img src="images/xiongying.jpg"  onclick="changeHide();"  />
                    </div>
                </div> -->
                        <div class="wu"><span id="sweepCode1" style="color:#A5A5A5">还没账号？</span>  <span class="blue" id="register">立即注册</span>
                        </div>
                    </div>
                </div>
            </form>
            <div class="com_rcode">
                <div style="float: left;" onmouseout="hiddenPic()" onmousemove="showPic(event, 'images/ios-max.png', 'ios-max')" id="iosEl">
                    <img src="images/ios.png" />
                </div>
                <div class="qr_imgbox" onmouseout="hiddenPic()" onmousemove="showPic(event, 'images/android-max.png', 'android-max')" id="androidEl">
                    <img src="images/android.png" />
                </div>
            </div>
            <div id="Layer1" style="display:none;position:absolute;z-index:1;"></div>
            <div class="com_text"></div>
        </div>
    </div>
    <div style="width:100%;margin-top:80px;">
        <div class="group_box">
            <div style="display: flex;align-items: center">
                <img src="images/ele1.png"></img><span class="tip_text" style="display: inline-block;">一物一码系统，让库存管理变得更精准</span>

            </div>
            <div class="pic_margin_top">
                <img class="img_group" src="images/Group1.png"></img>
            </div>
        </div>
        <div class="group_box">
            <div style="text-align: center;"> <span class="tip_text">专门给仓库用的移动端，让库存变得更高效</span>

            </div>
            <div class="pic_margin_top">
                <img class="img_group" src="images/Group2.png"></img>
            </div>
        </div>
        <div style="clear: both"></div>
    </div>
    <div style="width:100%;margin-top:80px;">
        <div class="group_box">
            <div style="text-align: center;"> <span class="tip_text">精确的零件追溯，让回溯变得更简单</span>

            </div>
            <div class="pic_margin_top">
                <img class="img_group" src="images/Group3.png"></img>
            </div>
        </div>
        <div class="group_box">
            <div style="text-align: center;"> <span class="tip_text">实时计算销售分成，让销售人员更有干劲</span>
            </div>
            <div class="pic_margin_top">
                <img class="img_group" src="images/Group4.png"></img>
            </div>
        </div>
        <div style="clear: both"></div>
    </div>
</div>
<div class="bottom_text">
    <div> <span class="about">关于我们</span>
    </div>
    <div style="margin-top:40px;"> <span class="copyright">@2018-2019 xxxxxx.com 版权所有  浙公网安备 33010202001324  浙ICP备17026959号-6</span>
    </div>
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
		 var  kaiguan = 0//0发请求，1取消请求
$(function () {
	//显示登录框
	$("#login").click(openLogin);
	$("#login1").click(openLogin);
	$("#login2").click(openLogin);
	//显示注册框
	$("#register").click(openRegister);
	
	//登录
	$("#sweepCode").click(openSweepCode);
	
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
	
function changeShow(){
	$(".max_img").show();
}

function changeHide(){
	$(".max_img").hide();
}

    function showPic(e, sUrl, eclass){ 
        //var x,y; 
        //x = e.clientX; 
        //y = e.clientY; 
        //document.getElementById("Layer1").style.left = x+2+'px'; 
        //document.getElementById("Layer1").style.top = y+2+'px'; 
        document.getElementById("Layer1").setAttribute("class", eclass);
        document.getElementById("Layer1").innerHTML = "<img border='0' src=\"" + sUrl + "\">"; 
        document.getElementById("Layer1").style.display = ""; 
    } 
    function hiddenPic(){ 
        document.getElementById("Layer1").innerHTML = ""; 
        document.getElementById("Layer1").style.display = "none"; 
    }  
 
//显示登录框
function openLogin() {
	$("#registerBox").hide();
	$("#loginBox").show();
	$("#sweepCodeBox").hide();
	$("#ysweepCodeBox").hide();
	kaiguan = 1;
}
//显示注册框
function openRegister() {
	$("#registerBox").show();
	$("#loginBox").hide();
	$("#sweepCodeBox").hide();
	$("#ysweepCodeBox").hide();
}
//显示二维码已扫
function openYSweepCode() {
	$("#registerBox").hide();
	$("#loginBox").hide();
	$("#sweepCodeBox").hide();
	$("#ysweepCodeBox").show();
}

//显示扫码框
function openSweepCode() {
	$("#registerBox").hide();
	$("#loginBox").hide();
	$("#sweepCodeBox").show();
	$("#ysweepCodeBox").hide();
	sweepCode();
	setCode(60);
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
 	var registername = $("#phone").val();
 	var usern = /^[a-zA-Z0-9_]{1,}$/;
/*  	if (!registername.match(usern)) { 
 		$("#errorP").html("用户名只能由字母数字下划线组成");
	    return false;
 	} */
 	
 	var registercompname = $("#registercompname").val();
 	var code = $("#authcode").val();
     	if(!registercompname){
	      	$("#errorP").html("请输入公司名");
	      	return false;
     	}
/*      	if(!registername){
	      	$("#errorP").html("请输入用户名");
	      	return false;
     	} */
     	if(!phone){
	      	$("#errorP").html("请输入手机号");
	      	return false;
     	}else{
     		document.getElementById('registername').value=phone;
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
 
 //获取键盘 Enter 键事件并响应登录
function keyboardLogin(e){
  login();
}
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
	 
	 
	  function guid() {
		    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
		        return v.toString(16);
		    });
		}
	var code = "";	
		function sweepCode() {
				kaiguan = 0;
				$("#qrcode").empty();
				 code = guid();
				
				// 设置参数方式 
				var qrcode = new QRCode('qrcode', { 
				  text: code, 
				  width: 256, 
				  height: 256, 
				  colorDark : '#000000', 
				  colorLight : '#ffffff', 
				  correctLevel : QRCode.CorrectLevel.H 
				});
		}
		
	      function setCode(time) {
			  if (time == 0) {
				  $("#error").html("二维码已过期，返回登录页面！");
				  openLogin();
			    return;
			  } else { 
			  			var json = {
			  				webId : code,
			  				type : "check"
			  			}
				  		nui.ajax({
						url : "<%=apiPath%><%=sysApi%>/com.hsapi.system.auth.LoginManager.qrcodeCheck.biz.ext",
						type : 'POST',
						data : json,
						cache : false,
						contentType : 'text/json',
						success : function(text) {
							var record = text.record||{};
							if(record.status==0&&record.id){								
								if(kaiguan==0){
									openYSweepCode();
									setTimeout(function () { setCode(time); }, 1000);
								}
																
							}else if(record.status==1){
								//document.loginForm.submit();
								window.location.href="<%=sweepCodeUrl%>?webId="+code;
							}else if(record.status==2){
								$("#error").html("APP扫码已取消登录！");
								openLogin();
							}else{
								setTimeout(function () { setCode(time); }, 1000);
							}
						}
					});			
			    time--;
			  }
			  
			}



</script>




</body>
</html>