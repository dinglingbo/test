<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<!doctype html>
<html>
<head>
<title>洗美工坊管理平台</title>
<meta charset="utf-8">
<meta name="keywords" content="洗美工坊管理平台"/>
<meta name="description" content="洗美工坊管理平台"/>
<meta name="author" content="shenzhi"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="apple-mobile-web-app-title" content="洗美工坊管理平台"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta name="format-detection" content="telephone=no, address=no, email=no" />

<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/content.css" />


<style>
body { min-width: 1200px;}
.grid.logo { padding: 40px; text-align: center;}
.banner { height: 700px; width: 1200px; margin: 0 auto; padding-top: 15px;}
.explain { width: 100%; margin: 0 auto;} 
.banner_bg{
	background-image: url(images/banner.jpg);
	background-position:center center;
}
dd{
	display:table-cell;
	vertical-align:middle;
	white-space:nowrap;}
dd a{ font-size:16px; color:#FFF; padding: 15px;}
dd:empty {
	width:9999px;
	padding:0;
}
.login {width: 335px; margin: 561px auto 0;}
.btn {
	padding: 17px 55px;
	font-size: 18px;
	}

.btn ~ .btn {	margin-left: 24px;}
.btn_white{
	color: #FFF;
	border: 1px solid #FFF;
	background-color: transparent;
	}
.btn_white:hover,
.btn_white:focus {
	color:#FFF;
	text-decoration:none;
}
.btn_yellow{background-color: #EFC94C; color: #323232}
.login_box .btn.btn_full { width: 100%;margin: 0;}

.flex_center {
	display: flex;
	display: -webkit-flex;
	justify-content: space-between;
	-webkit-justify-content: space-between;
	align-items: center;
	-webkit-align-items: center;
	padding: 50px 0;
}
.flex_center span{
	font-size: 36px;
	color: #979696;
}
.login_box{ padding: 32px; background-color: #121317;}
.login_box a.img_icon { background-color: #fff;}
.login_box a.img_icon:empty  { border-right: #ccc 1px solid;border-radius: 0;}
.yinhumen { background: url(images/tel.png) no-repeat; width: 23px; height:23px; margin-left: 10px;}
.mima { background: url(images/mima.png) no-repeat; width: 23px; height:23px; margin-left: 10px;}
.yanzhengma { background: url(images/yanzhengma.png) no-repeat; width: 23px; height:23px; margin-left: 10px; }

.login_box input{
	border: none;
	-webkit-box-shadow: 0 0 0px 1000px #323232 inset;
	        box-shadow: 0 0 0px 1000px #323232 inset;
	color: #979696;
	border-radius: 0;
 	width: 190px;
 	background-color: #323232;}

.login_box input[type=checkbox]{width: auto;}
.login_box label.username,
.login_box label.password {
	padding: 25px;
	display: flex;
	display: -webkit-flex;
	justify-content: space-between;
	-webkit-justify-content: space-between;
	align-items: center;
	-webkit-align-items: center;
	background-color: #323232;
	
}
.login_box label {
	margin: 0;
	font-size: 18px;
	margin-bottom:28px;
	color: #979696;
	
}
.login_box a { color: #828282;}
.login_box .red_label {border-color: #FD2749; }
.login_box .error{ color: #FD2749; margin-top: -25px;}
.login_box .btn_yellow{ margin: 15px 0 0;}
.login_box .separation { border-top: 1px dotted #828282; }
.login_box label.username:hover,
.login_box label.password:hover {
	border-color:#66afe9;
	outline:0;	
	box-shadow:0 0 8px #FFE200;
	-webkit-box-shadow:0 0 8px #FFE200;
}
.login_box .red_label:hover {
	border-color:#FD2749;
	outline:0;
	box-shadow:0 0 8px #FFE200;
	-webkit-box-shadow:0 0 8px #FFE200;
}
#sentCode.disabled {
	pointer-events:none;
	cursor:not-allowed;
	opacity:0.35;
	filter:alpha(opacity=35);
	-webkit-box-shadow:none;
	box-shadow:none;
}

#memory{
	height: auto;
}
.logo_mark { padding-top: 50px;}
.explain.foot { padding: 50px 0 90px; color: #fff; width: 430px;}
.explain.foot > li{ color: #D6D6D6;padding: 10px 0; text-align: left;}
.explain.foot > li > span{ color: #F2AB05; }


/* flexslider */
	.flexslider{position:relative;overflow:hidden;background:url(images/loader.gif) 50% no-repeat;}
	.slides{position:relative;z-index:1;}
	.slides li{height:100%;}
	.flex-control-nav{position:absolute;bottom:10px;z-index:2;width:100%;text-align:center;}
	.flex-control-nav li{display:inline-block;width:14px;height:14px;margin:0 5px;*display:inline;zoom:1;}
	.flex-control-nav a{display:inline-block;width:14px;height:14px;line-height:40px;overflow:hidden;background:url(images/dot.png) right 0 no-repeat;cursor:pointer;}
	.flex-control-nav .flex-active{background-position:0 0;}

	.flex-direction-nav{position:absolute;z-index:3;width:100%;top:45%;}
	.flex-direction-nav li a{display:block;width:50px;height:50px;overflow:hidden;cursor:pointer;position:absolute;}
	.flex-direction-nav li a.flex-prev{left:40px;background:url(images/prev.png) center center no-repeat;}
	.flex-direction-nav li a.flex-next{right:40px;background:url(images/next.png) center center no-repeat;}
</style>
</head>

<body>
<div class="grid logo" style="background-color: #EEEEEE;">
	<img src="images/logo1.png" />
</div>
<div class="grid banner_bg">
	<div class="banner">
        
        <div class="login">
        	<p  class="errorC"><span id="error" style="font-size:25px;color:red"></span></p>
        	<button class="btn btn_yellow" id="login" style="width: 100%;">登录</button>
		</div>
    </div>



    
</div>

<!--<div class="grid" style="background-color: #EEEEEE;">
	<div class="explain flexslider">
		<ul class="slides">
			<li style="background:url(images/explain1.jpg) 50% 0 no-repeat;"><img src="images/explain1.jpg" /></li>
			<li style="background:url(images/explain2.jpg) 50% 0 no-repeat;"><img src="images/explain2.jpg" /></li>
			<li style="background:url(images/explain3.jpg) 50% 0 no-repeat;"><img src="images/explain3.jpg" /></li>
			<li style="background:url(images/explain4.jpg) 50% 0 no-repeat;"><img src="images/explain4.jpg" /></li>
		</ul>
	</div>
</div>-->

<div class="grid logo" style="background-color: #323232;">
	<img src="images/logo_mark.png" class="logo_mark">
	<ul class="explain foot">
    	<li>公司地址： 广州市天河区荷光路大凼西工业区1号（东城学校旁边）</li>
    	<li>公司名称： 广州华胜企业管理服务有限公司     </li>
    	<li>全国热线： <span>400-803-3707</span></li>
    </ul>
</div>


<!-- 登录框模版 -->
<script type="text/x-jquery-tmpl" id="login-box-tmpl">


<form method="post"	name="loginForm" onsubmit="return login();" action="com.hsapi.system.auth.login.loginTest.flow">
<div class="login_box">
	<div class="flex_center">
		<span>登陆</span>
		<img src="images/logo_mark.png">
	</div>

	<label class="username">
		用户名：
		<input type="text" id="userId" name="userId" class="accountNo" value="" autocomplete="userId" placeholder="帐号" maxlength="11" />
		<span class="yinhumen"></span>
	</label>
	
	<label class="password">
		密　码：
		<input class="password_val" id="password" name="password" type="password" type="password" value="" autocomplete="password" placeholder="密码" maxlength="20" />
		<span class="mima"></span>
	</label>
	<label>
		<input type="checkbox" id="memory" checked="checked" /><span style="width: 150px">记住密码</span>
	</label>
	<button class="btn btn_yellow btn_full" id="loginJump" style=" margin-bottom:28px;" type="submit" >登录</button>
	
</div>	
</form>




</script>
<script type="text/javascript" src="<%= request.getContextPath() %>/coframe/auth/login/js/jquery-1.9.1.min.js"></script>

<script src="indexjs/flexslider-min.js?ver=2.01"></script>
<script src="indexjs/plugin.js?ver=2.01"></script>
<script src="indexjs/basic.js?ver=2.01"></script>
<script src="indexjs/index.js?ver=2.10"></script>
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


	      
</script>



</body>
</html>
