<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 16:54:14
  - Description:
-->
<head>
<title>描述信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table style="margin: 0 0 0 2px">
		<tr>
			<td>客户描述：
				<div style="margin-top: 5px">
					<input class="nui-textarea" name="isDisabled"
						style="height: 230px; width: 445px;" emptyText="请输入..." />
				</div>
			</td>
			<td>故障现象：
				<div style="margin-top: 5px">
					<input class="nui-textarea" name="isDisabled"
						style="height: 230px; width: 445px;" emptyText="请输入..." />
				</div>
			</td>
			<td>解决措施：
				<div style="margin-top: 5px">
					<input class="nui-textarea" name="isDisabled"
						style="height: 230px; width: 445px;" emptyText="请输入..." />
				</div>
			</td>
		</tr>

	</table>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>