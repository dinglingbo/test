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
<title>智能短信</title>
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

			span.da{
				margin-top: 20px;
				font-size: 20px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
			}
			span.xiao{
				margin-top: 20px;
				font-size: 10px;
				font-weight:bolder;
				text-align:center;
				float: left;
				width: 100%;
				color: #6959CD;
			}
			span.zhong{
				margin-top: 30px;
				font-size: 14px;
				font-weight:bold;
				text-align:center;
				float: left;
				width: 100%;
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
			div.bei{
				width: 230px;
				height: 180px;
			}
			div.qian{
				width: 120px;
				height: 120px;
				background:#FFF;
				opacity:0.7;
				margin-left: 50px;
				text-align: center;
			}
		</style>
</head>
<body>
	<div>
		
		<span class="da">智能短信可根据不同场景设置自动化推送</span></br>
		<span class="zhong">
			根据不同的场景对短信内容和推送法则进行设置，保存后短信将自动发送，同时系统将自动为您计算费用
		</span>

			<table align="center">
				<tr>
					<td>
						<div class="bei" style="background:url(images/12.jpg) no-repeat 0px center;">
							<div class="qian" >
								<span class="da">在线预约</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
					<td>
						<div class="bei" style="background:url='<%=webPath + contextPath%>/repair/prototype/images/12.jpg' no-repeat 10px center;">
							<div class="qian" >
								<span class="da">客户到店</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
					<td>
						<div class="bei" style="background:url(<%=webPath + contextPath%>/repair/prototype/images/12.jpg) no-repeat 10px center;">
							<div class="qian" >
								<span class="da">报价成功</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
				</tr>
								<tr>
					<td>
						<div class="bei" style="background:url(<%=webPath + contextPath%>/repair/prototype/images/12.jpg) no-repeat 0px center;">
							<div class="qian" >
								<span class="da">维修等待</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
					<td>
						<div class="bei" style="background:url(<%=webPath + contextPath%>/repair/prototype/images/12.jpg) no-repeat 10px center;">
							<div class="qian" >
								<span class="da">结算点评</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
					<td>
						<div class="bei" style="background:url(<%=webPath + contextPath%>/repair/prototype/images/12.jpg) no-repeat 10px center;">
							<div class="qian" >
								<span class="da">离厂关怀</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
				</tr>
								<tr>
					<td>
						<div class="bei" style="background:url(<%=webPath + contextPath%>/repair/prototype/images/12.jpg) no-repeat 0px center;">
							<div class="qian" >
								<span class="da">修后提醒</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
					<td>
						<div class="bei" style="background:url(<%=webPath + contextPath%>/repair/prototype/images/12.jpg) no-repeat 10px center;">
							<div class="qian" >
								<span class="da">离厂90天</span></br>
								<a><span class="xiao">编辑</span></a>
							</div>
						</div>
					</td>
					<td>

					</td>
				</tr>


			</table>
	</div>



	<script type="text/javascript">

		$(document).ready(function(){
		
		});
    	nui.parse();

    </script>
</body>
</html>