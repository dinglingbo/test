<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-05 19:01:05
  - Description:
-->
<head>
<title>活动详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
   <style type="text/css">


.banner {
	width: 50%;
	height: 250px;
	position: relative;
	overflow: hidden;
	cursor: pointer
}

.imgbox {
	width: 50%;
	height: 250px;
	position: relative;
	overflow: hidden
}

.img {
	width:150px;
	height:150px;
	position: absolute;
	display: none;
	left: 50%;
	
}

.im {
	display: block
}

.change {
	height: 50px;
	display: block;
	position: absolute;
	z-index: 20;
	opacity: .4;
	transition: .4s;
	top: 50%;
	margin-top: -50px
}

.change:hover {
	opacity: 1
}

.pre {
	left: 1%
}

.next {
	right: 1%
}

.cirbox {
	width: 88px;
	position: absolute;
	bottom: 15px;
	z-index: 10;
	left: 50%;
	margin-left: -44px;
	cursor: pointer
}

.cir {
	width: 12px;
	height: 12px;
	background-color: #7D26CD;
	opacity: .4;
	float: left;
	border-radius: 6px;
	margin: 0 5px;
	cursor: pointer
}

.cir:hover {
	background-color: cyan;
	transition: .8s
}

.cr {
	opacity: 1
}

.cr:hover {
	background-color: #fff
}
</style>
    
</head>
<body>
<div class="banner" align="center">
<img class="change pre" src="images/left.jpg">
<img class="change next" src="images/right.jpg">
<div class="cirbox">
<div class="cir cr"></div>
<div class="cir"></div>
<div class="cir"></div>
<div class="cir"></div>
</div>
<div class="imgbox">
<img class="img im" src="images/1.jpg">
<img class="img" src="images/2.jpg">
<img class="img" src="images/3.jpg">
<img class="img" src="images/4.jpg">

</div>
<span style="margin-bottom: 1px">可推送的客户资料</span>
</div>
<div>
</div>

	<script type="text/javascript">

		$(document).ready(function(){
		
		});
    	nui.parse();
		$(document).ready(function(){var t;var index=-1;var times=3000;t=setInterval(play,times);function play(){index++;if(index>3){index=0}
$('.img').eq(index).fadeIn(1000).siblings().fadeOut(1000)
$('.cir').eq(index).addClass('cr').siblings().removeClass('cr')}
$('.cir').click(function(){$(this).addClass('cr').siblings().removeClass('cr')
var index=$(this).index()
$('.img').eq(index).fadeIn(600).siblings().fadeOut(600)})
$('.pre').click(function(){index--
if(index<0){index=3}
$('.img').eq(index).fadeIn(1000).siblings().fadeOut(1000)
$('.cir').eq(index).addClass('cr').siblings().removeClass('cr')})
$('.next').click(function(){index++
if(index>3){index=0}
$('.img').eq(index).fadeIn(1000).siblings().fadeOut(1000)
$('.cir').eq(index).addClass('cr').siblings().removeClass('cr')})
$('.banner').hover(function(){clearInterval(t)},function(){t=setInterval(play,times)
function play(){index++
if(index>3){index=0}
$('.img').eq(index).fadeIn(1000).siblings().fadeOut(1000)
$('.cir').eq(index).addClass('cr').siblings().removeClass('cr')}});});
    </script>

</body>
</html>