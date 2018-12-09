<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-06 15:15:08
  - Description:
-->
<head>
<title>即时消息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="http://kindeditor.net/ke4/kindeditor-all-min.js?t=20160331.js" type="text/javascript"></script>
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
   		body{
   			background-color: #CCC;
   		}
   		.guest{
					position: absolute;
					display: block;
					width: 20%;
					height: 100%;
					background-color: #FFF;
					top: 0px;
					left: 0px;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
   		}
   		   		.msg{
					position: absolute;
					display: block;
					width: 79%;
					height: 70%;
					background-color: #FFF;
					top: 0px;
					left: 20.5%;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
   		}
   		   		   .mymsg{
					position: absolute;
					display: block;
					width: 79%;
					height: 29%;
					background-color: #FFF;
					top: 70.5%;
					left: 20.5%;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
   		}
   		.tou{
   			
   		}
   		.zi{
   			font-size: 12px;
   			
   		}
   		.xiazi{
   			margin-left:30px;
   			font-size: 17px;
   		}
   		.detailsBox {
 
					width: 120px;
					height: 30px;
					background-color: #399cf136;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
				}
   </style>
</head>
<body>
	<div class="guest">
		<div class="tou" style="margin-top: 30px;">
			<table style="border-collapse:separate; border-spacing:0px 20px;">
				<tr >
					<td>
						<img src="<%=webPath + contextPath%>/repair/prototype/images/6.jpg" width="40px" height="40px"/>
					</td>
					<td>
						<span class="zi">张女士</br>你好在吗？</span>
					</td>
					<td>
						<span class="zi" style="margin-left: 50px;">现在</span>
					</td>
				</tr>
								<tr >
					<td>
						<img src="<%=webPath + contextPath%>/repair/prototype/images/7.jpg" width="40px" height="40px"/>
					</td>
					<td>
						<span class="zi">李先生</br>这个价格多少呢？？</span>
					</td>
					<td>
						<span class="zi" style="margin-left: 50px;">19:22</span>
					</td>
				</tr>
								<tr>
					<td>
						<img src="<%=webPath + contextPath%>/repair/prototype/images/8.jpg" width="40px" height="40px"/>
					</td>
					<td>
						<span class="zi">张绘</br>我知道啦</span>
					</td>
					<td>
						<span class="zi" style="margin-left: 50px;">19:04</span>
					</td>
				</tr>
								<tr>
					<td>
						<img src="<%=webPath + contextPath%>/repair/prototype/images/9.jpg" width="40px" height="40px"/>
					</td>
					<td>
						<span class="zi">钟意</br>谢谢您！</span>
					</td>
					<td>
						<span class="zi" style="margin-left: 50px;">18:23</span>
					</td>
				</tr>
								<tr>
					<td>
						<img src="<%=webPath + contextPath%>/repair/prototype/images/10.jpg" width="40px" height="40px"/>
					</td>
					<td>
						<span class="zi">张女士</br>确定吗？？</span>
					</td>
					<td>
						<span class="zi" style="margin-left: 50px;">18:23</span>
					</td>
				</tr>
								<tr>
					<td>
						<img src="<%=webPath + contextPath%>/repair/prototype/images/11.jpg" width="40px" height="40px"/>
					</td>
					<td>
						<span class="zi">刘女士</br>明白</span>
					</td>
					<td>
						<span class="zi" style="margin-left: 50px;">18:23</span>
					</td>
				</tr>
								<tr>
					<td>
						<img src="<%=webPath + contextPath%>/repair/prototype/images/12.jpg" width="40px" height="40px"/>
					</td>
					<td>
						<span class="zi">李老头</br>好的</span>
					</td>
					<td>
						<span class="zi" style="margin-left: 50px;">18:23</span>
					</td>
				</tr>
			</table>
			
			
		</div>
	</div>
	<div class="msg">
		<table style=" width:100%; border-spacing: 20px;">
			<tr>
				<td width="5%">
					<img src="<%=webPath + contextPath%>/repair/prototype/images/6.jpg" width="40px" height="40px" style="margin-left: 25px;" />
					
				</td width="5%">
				<td>
				<div class="detailsBox">你好，在吗？</div>
				</td>
				<td align="left" width="95%">
				</td>
			</tr>
			<tr>
				<td align="right" width="95%" colspan="2">
					<div >您好，在的！？</div>
				</td>
				<td   width="5%">
					<img src="<%=webPath + contextPath%>/repair/prototype/images/15.jpg" width="40px" height="40px" style="float: left;margin-right: 25px;" />
				</td>
			</tr>
		</table>
	</div>
	<div class="mymsg">
		<table style="width:100%">
			<tr>
				<td>
					<div name="editor" id="editor" rows="1000" cols="80" style="width:100%" oncelleditenter="enter()"> 
						<span class="xiazi">张女士，请问有什么需要帮助的？</span>
					</div>
				</td>
			</tr>
			<tr>

			</tr>
		</table>
		
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var editor = KindEditor.create('#editor');
    	function enter(){
    		alert("1111");
    	}
    </script>
</body>
</html>