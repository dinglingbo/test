<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
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

    body,
				div,
				dl,
				dt,
				dd,
				ul,
				ol,
				li,
				h1,
				h2,
				h3,
				h4,
				h5,
				h6,
				p ,
				select{
					margin: 0;
					padding: 0;
					font-family: "微软雅黑", "宋体", "黑体", Arial, simsun, Verdana, Lucida, Helvetica, sans-serif;
					font-size: 14px;
					font-style: normal;
					font-weight: normal;
					font-variant: normal;
					list-style-type: none;
				}
.banner {
	width: 100%;
	height: 250px;
	position: relative;	
	overflow: hidden;
	cursor: pointer
}

.imgbox {
	width: 50%;
	height: 250px;
	position: relative;
	overflow: hidden;
	background:#E3E3E3;
}
.card {
	width: 50%;
	height: 250px;
	position: relative;
	overflow: hidden;
	background:#c3a928;
}

.img {
	width:150px;
	height:150px;
	position: absolute;
	display: none;
	left: 40%;
	margin-top: 40px;
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
	left: 35%
}

.next {
	right: 35%
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
.cirbox1 {
	width: 50%;
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

		.xiao{
				margin-top: 20px;
				font-size: 35px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}

 .abiao {
 		float: left;
		margin-left:25%;
		margin-top: 25px;
		cursor: pointer;
	} 
	a{
		cursor: pointer;
	}
	.card{
		background:#919191;
		width: 20%;
		height: 30px;
		margin-right: 50px;
	}
	.da{
				margin-top: 20px;
				font-size: 20px;
				font-weight:bolder;
				text-align:center;
				float: left;
				margin-left:25%;
			}
	.tu{
		color: #CCC
	}
	.biao{
		margin-top:40px;
		color: #ee5a22;
		font-size: 15px;
		font-weight:bolder;
		 position: relative;
	}
</style>
    
</head>
<body>

		<div >
			<a class="abiao"><span class=" fa fa-angle-left fa-2x  " ><font size="5" style="margin-left: 15px;padding-bottom:10px;">华胜官方活动</font></span></a>
		</div>
<div class="banner" align="center">
		<img class="change pre" src="<%=webPath + contextPath%>/repair/prototype/images/left.jpg">
		<img class="change next" src="<%=webPath + contextPath%>/repair/prototype/images/right.jpg">
		<div class="cirbox">
			<div class="cir cr"></div>
			<div class="cir"></div>
			<div class="cir"></div>
			<div class="cir"></div>
			
			
		</div>
		<div class="cirbox1">
			<div class="card"><font color="#f9e70b" size="4" style="padding-bottom:10px;">机油卡</font></div>
		</div>
		<div class="imgbox">
			<img class="img im" src="<%=webPath + contextPath%>/repair/prototype/images/1.jpg">
			<img class="img" src="<%=webPath + contextPath%>/repair/prototype/images/2.jpg">
			<img class="img" src="<%=webPath + contextPath%>/repair/prototype/images/3.jpg">
			<img class="img" src="<%=webPath + contextPath%>/repair/prototype/images/4.jpg">
		</div>

			
</div>

		<div style="width: 100%;height: 70px" >
			<span class="da" >可推送的客户资料</span>
		</div>
		<div style="width: 100%;height: 80px" align="center" >
			<table>
				<tr>
					<td>
						<div style="background:#919191;width: 120px;height: 90px" align="center">
							<span class="tu">>100万</span></br>
							<span class="tu">平台</span></br>
							<a class="abiao" style="margin-left: 80px"><span class="fa fa-lock fa-2x tu"></span></a>
						</div>
					</td>
										<td>
						<div style="background:#919191;width: 120px;height: 90px" align="center">
							<span class="tu">>10万</span></br>
							<span class="tu">区域</span></br>
							<a class="abiao" style="margin-left: 80px"><span class="fa fa-lock fa-2x tu"></span></a>
						</div>
					</td>
										<td>
						<div style="background:#919191;width: 120px;height: 90px" align="center">
							<span class="tu">>0.5万</span></br>
							<span class="tu">门店</span></br>
							<a class="abiao" style="margin-left: 80px"><span class="fa fa-lock fa-2x tu"></span></a>
						</div>
					</td>
										<td>
						<div style="background:#ee5a22;width: 120px;height: 90px" align="center">
							<span class="tu"><font color="#000"><万</font></span></br>
							<span class="tu">平台</span></br>
							<a class="abiao" style="margin-left: 80px"><span class="fa fa-unlock fa-2x tu"></span></a>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div style="width: 100%;height: 70px" >
			<span class="da" >选择个性化推送标签</span>
		</div>
		<div style="width: 100%;height: 80px" align="center" >
			<table>
				<tr>
					<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao" style="width: 120px;height: 90px">会员类型</span></a>
						</div>
						
					</td>
										<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">厂牌车型</span></br></a>
							
						</div>
					</td>
										<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">客户类型</span></br></a>
						</div>
					</td>
										<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">保养到期</span></br></a>
						</div>
					</td>
					<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">报价未修</span></br></a>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">会员类型</span></br></a>
						</div>
					</td>
										<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">厂牌车型</span></br></a>
							
						</div>
					</td>
					<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">客户类型</span></br></a>
						</div>
					</td>
										<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">保养到期</span></br></a>
						</div>
					</td>
					<td>
						<div style="background:#EEEED1;width: 120px;height: 90px" align="center">
							<a onclick="memberType()"><span class="biao">报价未修</span></br></a>
						</div>
					</td>
				</tr>
			</table>
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


		function memberType(){
				 nui.open({
			         url: webPath + contextPath + "/com.hsweb.RepairBusiness.membersChoose.flow?token="+token,
			         title: '近期活动',
			         width: 800, height: 580,
			         onload: function () {

			         },
			         ondestroy: function (action)
			         {

			         }
     });
		}
    </script>

</body>
</html>