<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): steven
  - Date: 2018-05-25 16:29:56
  - Description:
-->
<head>
<title>免费注册体验</title>
	<style type="text/css">
		.main{
			text-align: center; /*让div内部文字居中*/
			background-color: #fff;
			border-radius: 20px;
			width: 300px;
			height: 350px;
			margin: auto;
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
		}
	</style>
</head>
<body>
	<div class="main" id= "basicInfoForm">
	<h1>用户注册 </h1>
	<table class="form-table" border="0" cellpadding="1" cellspacing="2">
		<tr>
			<td style="width:100%">
				<input name="mobile" class="mini-textbox" emptyText="手机号" />
			</td>
		</tr>
		<tr >
			<td style="width:40%">
				<input name="identifyingCode" class="mini-textbox" emptyText="验证码" />
			</td>
			<td style="width:60%">
				<a class="mini-button">点击发送验证码</a>
			</td>
		</tr>
		<tr>
			<td style="width:100%">
				<input name="name" class="mini-textbox" emptyText="用户姓名" />
			</td>
		</tr>
		<tr>
			<td style="width:100%">
				<input name="公司名称" class="mini-textbox" emptyText="选择城市" />
			</td>
		</tr>
		<tr>
			<td style="width:150px">
				<div id="ck1" name="agreement" class="mini-checkbox" readOnly="false" text="选择"></div>
			</td>
		</tr>

	</table>
	</div>
</body>
</html>
