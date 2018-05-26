<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>零零汽注册</title>


<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + sysDomain%>/eos/css/register.css"
	rel="stylesheet" type="text/css" />

</head>
<body>
	<div style="width: 100%; height: 7%; border-bottom:1px solid black; box-shadow: 0px 0px 2px 0px rgba(0, 0, 0, 0.12), 0px 2px 2px 0px rgba(0, 0, 0, 0.24);"> 
 	<img alt="" src="<%=webPath + sysDomain%>/eos/img/llq_logo.png">
	<span style=" float: right; margin-right: 85%; margin-top: 1%;">注册零零汽账号</span>
	<span style="float: right; margin-right: 3%; margin-top: -2.2%; ">我已注册现在就   <a href="https://007vin.com/">登入</a> </span>
	</div>
	<div style="width: 100%; height: 30%;">
		<form style="margin-left: 36%; margin-top: 10%;margin-top: 3%;">
			<table style="border-spacing:0px 20px;">
				<tr>
					<td>
						<div class="nui-textbox width2"  emptyText="電話番号"></div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="width2">
						<input type="text" style="border:none; width: 65%; height: 100%;" placeholder="验证码"><a style="color: blue;  cursor: pointer; ">点击发送验证码</a>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="nui-textbox width2" emptyText="用户姓名" "></div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="nui-textbox width2" emptyText="公司名称""></div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="nui-combobox width2" emptyText="选择城市""></div>
					</td>
				</tr>
				<tr>
				<td><div class="nui-checkbox"></div>我已阅读并同意   <a href="#">《零零汽™EPC查询系统用户注册协议》</a> </td>
				</tr>
				<tr>
				<td>
				<div class="nui-button style1"><span style="margin-top: 20px;">注册</span></div>
				</td>
				</tr>
				<tr><td align="right">
					已有账号， <a href="https://007vin.com/">立即登录</a>
				</td></tr>
			</table>
		</form>
	</div>	
	<div>
	<center>
	<img alt="" src="<%=webPath + sysDomain%>/eos/img/img_logo2.png" style="height:300px;width: 250px; margin-top: 15%;">
	</center>
	</div>
	<div style="background-color:#3F424D; height: 7%; width: 100%;">
	<a href="#" style="color: white; text-decoration: none; cursor: pointer;    padding-left: 10px; ">关于我们</a>
	<a href="#" style="color: white; text-decoration: none; cursor: pointer;     padding-left: 20px;">用户协议</a>
	<br>
	<span  style="color: white;   padding-left: 10px;">© 2016-2017 007vin.com</span>
	<a href="#" style="color: white; text-decoration: none; cursor: pointer;">版权所有 ICP证：浙17026959号-2</a>
	</div>
</body>

</html>