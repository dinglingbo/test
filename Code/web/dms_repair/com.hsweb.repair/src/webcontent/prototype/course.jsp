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
				font-size: 35px;
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

			.bei{
				width: 230px;
				height: 180px;
				background:url=('<%=webPath + contextPath%>/repair/prototype/images/12.jpg' );
				
			}

		</style>
</head>
<body>
	<div>
		
		<span class="da">晓鸟SR为专业在线服务培训</span></br>
		<span class="zhong">
			我们将不定期更新课程，请在线观看，同时我们提供专业认证。
		</span>
			<div class="tab">
			<table align="center" width="50%">
				<tr>
					<td>
						<a><span class="xiao">好评</span></a>
					</td>
					<td>
						<a><span class="xiao">畅销</span></a>
					</td>
					<td>
						<a><span class="xiao">全部</span></a>
					</td>
				</tr>

			</table>
			</div>
			<div>
				<table align="center">
					<tr>
						<td>
							<div class="bei" style="">
								<a></a>
							</div>
						</td>
						<td>
							<div class="bei" style="background:url(images/14.jpg) no-repeat 0px center;">
								
							</div>
						</td>
						<td>
							<div class="bei" style="background:url(images/14.jpg) no-repeat 0px center;">
								
							</div>
						</td>
						<td>
							<div class="bei" style="background:url(images/14.jpg) no-repeat 0px center;">
								
							</div>
						</td>

					</tr>
										<tr>
						<td>
							<div class="bei" style="background:url(images/13.jpg) no-repeat 0px center;">
								<a></a>
							</div>
						</td>
						<td>
							<div class="bei" style="background:url(images/14.jpg) no-repeat 0px center;">
								
							</div>
						</td>
						<td>
							<div class="bei" style="background:url(images/14.jpg) no-repeat 0px center;">
								
							</div>
						</td>
						<td>
							<div class="bei" style="background:url(images/14.jpg) no-repeat 0px center;">
								
							</div>
						</td>

					</tr>
				</table>
			</div>
	</div>



	<script type="text/javascript">

		$(document).ready(function(){
		
		});
    	nui.parse();

    </script>
</body>
</html>