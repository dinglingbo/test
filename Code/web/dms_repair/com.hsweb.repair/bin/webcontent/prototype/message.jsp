<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-04 18:35:20
  - Description:
-->
<head>
<title>短信触达</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    	<style>
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
    		.m{
				width: 60px;
				height: 23px;
				font-size: 10px;
				background: #C0C0C0;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
			}
			.am{
				width: 190px;
				height: 190px;
				font-size: 10px;
				background: #F4A460;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
			}
		.n{
				width: 60px;
				height: 23px;
				font-size: 10px;
				background: #F4A460;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
			}
			span.xiao{
				margin-top: 40px;
				font-size: 15px;
				font-weight:bold;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.da{
				margin-top: 20px;
				font-size: 35px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}
			a {
					margin-top: 50px;
					cursor: pointer;
				}
			font{
				color: #8B4513;
			}
		</style>
</head>
<body>
	<div>
		<span class="xiao">Individualization 个性化标签筛选</span></br>
		<span class="da">在此创建个性化的短信推送计划</span></br>
		<span class="xiao">通过标签筛选和短信内容的筛选，批量选定客户向手机号进行推送，点击推送前，我们将为你估算本次的推</br>
				送成本，点击推送后短信立即发送，客户将受到来自 958798 的号码推送的消息内容。</br>
		</span>
			<table align="center">
				<tr>
					<td>
						<a id="one"  class="m" onclick="settleOK(1)">普通</a>
					</td>
					<td>
						<a id="two" class="m"  onclick="settleOK(2)">圆心5K</a>
					</td>
				</tr>
			</table>
			<table align="center">
				<tr>
					<td>
						<a id="one"  class="am" onclick="activity()">
							<span class="fa fa-rebel fa-4x" style="margin-top: 50px;"></span></br>
							<span ><font>近期活动</font></span></br>
							<span >含总部和门店自己创建的标准模板</span></br>
						</a>
					</td>
					<td>
						<a id="two" class="am"  onclick="" style="margin-left:50px;">
							<span class="fa fa-edit fa-4x " style="margin-top: 50px;"></span></br>
							<span ><font >个性编辑</font></span></br>
							<span >自己创建个性化内容</span></br>
						</a>
					</td>
				</tr>
			</table>
	</div>



	<script type="text/javascript">
		var color = "one";//全点触控 变色
		$(document).ready(function(){
			settleOK(1)
		});
    	nui.parse();
    	function settleOK(e){
					if(e==1){
						document.getElementById(color).setAttribute("class", "m");
						color = "one";
						document.getElementById("one").setAttribute("class", "n");
						
					}else if(e==2){
						
						document.getElementById(color).setAttribute("class", "m");
						color = "two";
						document.getElementById("two").setAttribute("class", "n");
				nui.open({
			         url: webPath + contextPath + "/com.hsweb.RepairBusiness.round5K.flow?token="+token,
			         title: '圆心5K',
			         width: "100%", height: "100%",
			         onload: function () {

			         },
			         ondestroy: function (action)
			         {

			         }
     });
					}
				}
		function activity(){
				 nui.open({
			         url: webPath + contextPath + "/com.hsweb.RepairBusiness.activity.flow?token="+token,
			         title: '近期活动',
			         width: "100%", height: "100%",
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