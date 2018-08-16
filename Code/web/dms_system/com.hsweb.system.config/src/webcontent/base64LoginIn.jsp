<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-14 16:15:21
  - Description:
-->
<head>
<title>TextBase64</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
<form id="11" method="post">
		<div align="center" id="">
			<table>
				<tr>
					<td class="td1">登录账号：</td>
					<td><input class="nui-textbox" id="loginName" name="loginName"  /></td>
				</tr>
				<tr>
					<td class="td1">密码：</td>
					<td><input class="nui-password" id="passWord" name="passWord" /></td>
				</tr>

			</table>
		</div>
		<div style="text-align: center; padding: 10px;">
			<a class="nui-button" onclick="start()"style="width: 60px; margin-right: 20px;">确定</a> 
			<a class="nui-button" onclick="onCancel()" style="width: 60px;">取消</a>
		</div>
</form>

	<script type="text/javascript">
		nui.parse();
		function start() {
			//获取账号密码字符串，传入后台加密
			var params = {};
			params.loginName = nui.get('loginName').getValue();
			params.passWord = nui.get('passWord').getValue();
			var i = nui.get('loginName').getValue();
			var o = nui.get('passWord').getValue();
			var b = i + ":" + o.toLowerCase();
			params.c = b;
			nui.ajax({
				url : "com.hsapi.system.dict.textbase.textbase.biz.ext",
				type : 'post',
				data : {
					params : params
				},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					nui.alert("加入成功,请刷新页面查看", "!", window.CloseOwnerWindow);
				}
			});

		}
		function onCancel() {
			window.CloseOwnerWindow();
		}
	</script>
</body>
</html>