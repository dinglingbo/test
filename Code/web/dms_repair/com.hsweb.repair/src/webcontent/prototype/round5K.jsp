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
<title>圆心5K</title>
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
				margin-top: 30px;
				font-size: 14px;
				font-weight:bold;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.da{
				margin-top: 20px;
				font-size: 30px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.zhong{
				margin-top: 20px;
				font-size: 20px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.texiao{
				margin-top: 20px;
				font-size: 10px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
				color: #836FFF;
			}
			a {
					margin-top: 25px;
					cursor: pointer;
				}
			font{
				color: #8B4513;
			}
			input{
				border:0.5px solid #FF4040;
				width: 300px;
				height: 35px;
				
			}
		</style>
</head>
<body>
	<div>
		<span class="xiao">Individualization 个性化标签筛选</span></br>
		<span class="da">圆心5K 为您精准匹配推送对象</span></br>
		<span class="xiao">通过距离自己门店周边5公里范围内的客户进行筛选，最后针对其他个性标签内容筛选，批量选定客户的手机</br>
							号进行推送，点击推送前，我们将为您估算本次推送的推送成本，点击推送后，短信立即发送，客户将收到来自</br>
							958796的号码推送的信息内容
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
					<td width="50%" align="center">上海</td>
					<td>
						<input type="text"  value="选择门店.." onfocus="if (value =='选择门店..'){value =''}"onblur="if (value ==''){value='选择门店..'}">
					</td>

				</tr>
				<tr>
					<td colspan="2" align="center">
						<img src="<%=webPath + contextPath%>/repair/prototype/images/11.jpg" width="620px" height="250px" text-align="center"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<span class="zhong">已为您搜索到9876名客户</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<a><span class="texiao">保存并添加其他标签筛选 <span class="fa fa-angle-right fa-2x" style="margin-left: 10px"></span></span></a>
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
						
					}
				}
    </script>
</body>
</html>