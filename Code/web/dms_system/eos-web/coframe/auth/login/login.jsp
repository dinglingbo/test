<%@page import="com.eos.system.utility.StringUtil"%>
<%@page import="com.eos.access.http.security.config.HttpSecurityConfig"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="com.primeton.cap.AppUserManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>汽车后市场云服务</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
<link href="css/style_n.css" rel='stylesheet' type='text/css' />
<link href="css/index.css" rel='stylesheet' type='text/css' />
<%
   String contextPath=request.getContextPath();
   String url = null;
   String loginUrl = "org.gocom.components.coframe.auth.login.login.flow";
   loginUrl = "com.hsapi.system.auth.login.login.flow";
   
   HttpSecurityConfig securityConfig = new HttpSecurityConfig();
   boolean isOpenSecurity = securityConfig.isOpenSecurity();
   if(isOpenSecurity){
   		boolean isAllInHttps = securityConfig.isAllInHttps();
   		if(!isAllInHttps){
   			String ip = securityConfig.getHost();
   			String https_port = securityConfig.getHttps_port();
   			url = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/login/" + loginUrl;
   		}else{
   			url = loginUrl;
   		}
   }else{
   		url = loginUrl;
   }
 %>
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/index.js?v=1.0.0"></script>
<style type="text/css">
html,body {
	height: 100%;
	width: 100%;
	min-width:1200px;
	min-height:530px;
}

.pic { /* 页面logo图片 */
	background-image: url(images/sign-inbg_01.png);
	background-repeat: no-repeat;
	background-size: 100% 100%;
}

.rmenu {
	font-size: 14px;
	/* font-weight: bold; */
	text-align: left;
	margin: 0;
	padding-left: 25px;
	height: 18px;
	color: #fff;
	width: auto;
	margin-left: 20px;
	margin-top: 20px;
	background-size: 50%;
	float: left;
}

.lmenu {
	font-size: 18px;
	font-weight: bold;
	text-align: left;
	margin: 0;
	padding-left: 25px;
	height: 40px;
	color: #fff;
	width: auto;
	margin-left: 20px;
	margin-top: 20px;
	background-size: 50%;
	float: left;
}

#getKeyWorld {
	width: 80px;
	border: none;
	outline: none;
	height: 50px;
	line-height: 50px;
	font-size: 16px;
	/* position: absolute; */
	right: 10px;
	top: 0px;
}

.title {

		font-size: 1.5em;
height:50px;
	color: #0091e6;
	text-align: center;
    line-height: 50px;
    	border-radius: 4px;
	-webkit-border-radius: 4px;
	-o-border-radius: 4px;
	-moz-border-radius: 4px;
}
.title  a{
font-size: 18px;;
color: #0091e6;

    	border-radius: 4px;
	-webkit-border-radius: 4px;
	-o-border-radius: 4px;
	-moz-border-radius: 4px;
    display: inline-block;
    float: left;
width:50%;
text-align:center;
}


.login-error{margin-bottom:15px; padding-left:62px; color:#ff4107;}

</style>
</head>
<%
	String original_url=null;
	Object objAttr=request.getAttribute("original_url");
	if(objAttr != null){
		original_url=StringUtil.htmlFilter((String)objAttr);
	}
 %>
<body>
	<div id="t1" style="width: 100%; height: 100%;">
		<div id="t2" class="pic" style="float: left; width: 75%; height: 100%;">
			<div
				style="height: 25px; margin: 40px 0px 0px 60px; color: #1D92F1; background: url(images/sign-in0529-01_03.png) no-repeat left center; background-size: contain;"></div>
		</div>
		<div id="t3" style="float: left; width: 25%; height: 100%; background-color: #1D92F1">
			<div style="height: 18px;">
				<div class="rmenu"
					style="background: url(images/sign-in0529-01_09.png) no-repeat left center; background-size: contain;">
					<span> 
						<a id="t_a_favorite" href="" onclick="addFavorite()" >加入收藏</a> 
					</span>
				</div>
				<div class="rmenu"
					style="background: url(images/sign-in0529-01_11.png) no-repeat left center; background-size: contain;">
					<span>  
						<a id="t_a_favorite" href="" onclick="" >QQ群</a> 
					</span>
				</div>
				<div class="rmenu"
					style="background: url(images/sign-in0529-01_06.png) no-repeat left center; background-size: contain;">
					<span>  
						<a id="t_a_favorite" href="" onclick="" href="javascript:void(0)" onMouseOut="hideImg()"  onmouseover="showImg()">微信公众号</a> 
						<div id="wxImg" style="width:70px;height:70px;background: url(images/wepic.png) no-repeat center center;display:none;position:absolute;background-size: contain;"></div>
					</span>
				</div>
			</div>
		</div>
		<div style="clear: both"></div>
		<!-- 注释：清除float产生浮动 -->
	</div>
	<div id="actForm1" class="main" style="z-index: 999; left: 65%; position: absolute; top: 3em;">
		<div class="login">
					<div class="inset">
				<!--start-main-->
							<div class="title">
						<a id="t_a_login1" href="javascript:viod(0)" onclick="T_LoginType(1)" >
								登录
							</a>
							<a id="t_a_login2"  href="javascript:viod(0)" onclick="T_LoginType(2)" style="background-color:#f0f0f0;" > 微信认证登录
						</a> 
						</div>
<div id="div_login1"  class="con">
				<form method="post"	name="loginForm" onsubmit="return login();" action="<%=url%>">
						<p id="error"  ></p>
						<div>
						<!-- <span> <label> 账号/邮箱 </label> </span>  -->
						<span> <input id="userId" name="userId" type="text" class="textbox" placeholder="请输入账号/邮箱" />
						</span>
					</div>
					<div>
						<!-- <span> <label> 密码 </label> </span>  -->
						<span> <input id="password" name="password" type="password" class="text" placeholder="请输入密码" />
						<input id="password1" name="password1" type="text" class="textbox" placeholder="请输入密码" style="display:none"/>
							<a id="pwdBtn" href="##" class="pwdBtnShow" isshow="true" style="margin-top:-45px;">
						<i class="i_icon" style="background-position: -60px -93px;"></i>
					</a>
						</span>
					</div>
					<div class="rememberField" style="font-size: 8px; width: 100%; margin-top: 10px">
						<span class="checkboxPic check_chk" tabindex="-1" isshow="false"> <i class="i_icon"></i>
						</span> <label class="pointer"> 7天内自动登录 </label> <a href="##"
							style="color: red; float: right; text-decoration: underline;"> 忘记密码? </a>
					</div>
					<div class="sign" style="margin-top: 40px;">
						<input type="submit" value="登录" class="submit" />
					</div>
					<div style="margin: 20px 0px 10px 0px">
						<span style="margin-top: 10px; font-size: 10px;" align="center"> 还没有账号? <a
							id="a_registered" href="javascript:viod(0)" onclick="changeTab(1)"
							style="display: inline-block; text-decoration: underline;"> 注册 </a>
						</span>
					</div>
				</form>
				</div>
				<div id="div_login2"  class="con" style="display:none">
					<div id="inwxpic" style="margin: 60px 0px 50px 50px;width:200px;height:200px;background: url(images/wepic.png) no-repeat center center;position:absolute;background-size:contain;"></div>
				</div>
			</div>
		</div>
		<!--//end-main-->
	</div>
	<div id="actForm2" class="main"
		style="z-index: 999; left: 65%; position: absolute; top: 0; display: none;">
		<div class="login">
			<div class="inset" >
										<div class="title">
								<a style="width:100%;bottom:0">注册</a>
						</div>
<div class="con" style="padding-top:0px;">
				<form>
					<div>
						
						<span> <input type="text" class="textbox" placeholder="手机号码" />
						</span>
					</div>
					<div>
						<span> <input type="text" class="text" placeholder="请输入验证码" style="width: 200px;" /> <a
							href="##" id="getKeyWorld" class="linkABlue"> 获取验证码 </a>
						</span>
					</div>
					<div>
						<span> <input type="text" class="text" placeholder="请输入用户名" />
						</span>
					</div>
					<div>
						<span> <input type="text" class="text" placeholder="请输入公司名" />
						</span>
					</div>
					<div>
						<div class="select">
							<select name='make'>
								<option>请选省份</option>
								<option>111
								<option>2222</option>
								<option>333</option>
								</option>
							</select>
						</div>
					</div>
					<div>
						<div class="select">
							<select name='make'>
								<option>请选择区域</option>
							</select>
						</div>
					</div>
					<div class="rememberField" style="font-size: 8px">
						<span class="checkboxPic check_chk" tabindex="-1" isshow="false"> <i class="i_icon"></i>
						</span> <label class="pointer"> 我已阅读并接受 </label> <a href="https://www.baidu.com/" target="_blank"
							class="linkABlue"> 《思配TM云平台用户注册协议》 </a>
					</div>
					<div class="sign">
						<input type="submit" value="登录" class="submit" />
					</div>
					<div>
						<span style="margin-top: 10px; font-size: 10px;" align="center"> 已经有账号? <a id="a_login"
							href="javascript:viod(0)" onclick="changeTab(2)"
							style="display: inline-block; text-decoration: underline;"> 登录 </a>
						</span>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function T_LoginType(e){
			if (e == 1) {
				
				$("#t_a_login1").css("background-color","#fff");
				$("#t_a_login2").css("background-color","#f0f0f0");
				$("#div_login1").show();
				$("#div_login2").hide();
			}
			if (e == 2) {
				$("#t_a_login1").css("background-color","#f0f0f0");
				$("#t_a_login2").css("background-color","#fff");
				$("#div_login1").hide();
				$("#div_login2").show();
				$("#div_login2").css("height","340px");
			}
		}

	
		function changeTab(e) {
			if (e == 1) {
				$("#actForm1").hide();
				$("#actForm2").show();
			}
			if (e == 2) {
				$("#actForm1").show();
				$("#actForm2").hide();
			}

		}

		function  showImg(){
			document.getElementById("wxImg").style.display='block';
		}
		function hideImg(){
			document.getElementById("wxImg").style.display='none';
		}

		function addFavorite() {
			var url = window.location;
			var title = document.title;
			var ua = navigator.userAgent.toLowerCase();
			if (ua.indexOf("360se") > -1) {
				alert("由于360浏览器功能限制，请按 Ctrl+D 手动收藏！");
			}else if (ua.indexOf("msie 8") > -1) {
				window.external.AddToFavoritesBar(url, title); //IE8
			}else if (document.all) {
				try{
					window.external.addFavorite(url, title);
				}catch(e){
					alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
				}
			}else if (window.sidebar) {
				window.sidebar.addPanel(title, url, "");}else {alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
			}
		}


		if(window.top!=window){
			window.top.location = window.location;
		 }
	  
	     //var form = new nui.Form("#form1");
	     
	     $("#userId").focus();
	     
	     function onCheckUserId(e){
	       if (e.isValid) {
	         if(e.value==""){
	           e.errorText = "用户名不能为空";
	           e.isValid = false;
	         }
	       }
	     }
	     
	     function onCheckPassword(e){
	       if (e.isValid) {
	         if(e.value==""){
	           e.errorText = "密码不能为空";
	           e.isValid = false;
	         }
	       }
	     }
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
	     $(function(){
	 		var validateResult = "<%=result %>";
	 		$("#userId").val("<%=userName %>");
	 		$("#password").val("<%=password %>");
	 		$("#password1").val("<%=password %>");
	 	 });


	</script>

</body>
  <%
 	request.getSession().invalidate();
 	Cookie[] cookies = request.getCookies();
 	if(cookies != null){
 		for(int i=0;i<cookies.length;i++){
 			if(StringUtil.equals("jsessioinid", cookies[i].getName())){
 				cookies[i].setMaxAge(0);
 			}
 		}
 	
 	}
  %>
</html>
