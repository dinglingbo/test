<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-04 19:35:16
  - Description:
-->
<head>
<title>活动</title>
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

			span.xiao{
				margin-top: 20px;
				font-size: 15px;
				font-weight:bold;
				margin-left: 40px;
				float: left;
				width: 100%;
			}
			span{	
					color:D3D3D3;
					margin-top: 20px;
					margin-left: 25px;
					position: relative;
				}
			span{	
					color:D3D3D3;
					margin-left: 210px;
				}
			a{
				cursor: pointer;
			}
			font{
				color: #8B4513;
			}
			div.gun{
					display: block;
					width: 250px;
					height: 130px;
					background-color: #FFF;
					padding-bottom: 20px;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
				}
				img{
					margin-top: 20px;
					margin-left: 25px;
					position: relative;
					width: 150px;
					height: 100px;
				}
		</style>
</head>
<html>
<head><title>test</title>
		<script type="text/javascript">
				
		</script>
</head>
	<body>
		<span class="xiao">华胜官方活动</span></br>
		<table>
			<tr>
				<td>
					<div class="gun">
						<a class="zuo" href="javascript:hideForecastBox();"  >
							<span class="fa fa-angle-left fa-4x "></span>
						</a>
						<a><img id="img" src="images/9.jpg" onclick="changeImg(this.id)"></img></a>
						<a class="you" href="javascript:hideForecastBox();" >
							<span class="fa fa-angle-right fa-4x "></span>
						</a>
						<span class="guns">轮胎无忧卡</span>
					</div>
				</td>

				<td>
					<div class="gun">
						<a class="zuo" href="javascript:hideForecastBox();" style="" >
							<span class="fa fa-angle-left fa-4x " ></span>
						</a>
						<a><img id="img" src="images/9.jpg" onclick="changeImg(this.id)"></img></a>
						<a class="you" href="javascript:hideForecastBox();" >
							<span class="fa fa-angle-right fa-4x "></span>
						</a>
						<span class="guns">轮胎无忧卡</span>
					</div>
				</td>

				<td>
					<div class="gun">
						<a class="zuo" href="javascript:hideForecastBox();" style="" >
							<span class="fa fa-angle-left fa-4x "></span>
						</a>
						<a><img id="img" src="images/9.jpg" onclick="changeImg(this.id)"></img></a>
						<a class="you" href="javascript:hideForecastBox();" >
							<span class="fa fa-angle-right fa-4x "></span>
						</a>
						<span class="guns">轮胎无忧卡</span>
					</div>
				</td>

				<td>
					<div class="gun">
						<a class="zuo" href="javascript:hideForecastBox();" style="" >
							<span class="fa fa-angle-left fa-4x "></span>
						</a>
						<a><img id="img" src="images/9.jpg" onclick="changeImg(this.id)"></img></a>
						<a class="you" href="javascript:hideForecastBox();" >
							<span class="fa fa-angle-right fa-4x "></span>
						</a>
						<span class="guns">轮胎无忧卡</span>
					</div>
				</td>
			</tr>
		</table>

		
		
		
	</body>
</html>