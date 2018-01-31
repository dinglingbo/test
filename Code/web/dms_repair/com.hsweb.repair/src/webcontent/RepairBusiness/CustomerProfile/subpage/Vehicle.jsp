<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2018-01-31 17:37:29
  - Description:
-->
<head>
<title>车辆信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
	<table class="nui-form-table">
		<tr style="display: block; margin: 0 0 2px 0">
			<td width="70px"><span
				style="color: #FF0000; margin-left: 10px;">车牌号：</span></td>
			<td><input class="nui-textbox" name="code" width="350px" /></td>
		</tr>

		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span
				style="color: #FF0000; margin-left: 10px;">车架号（VIN）：</span></td>
			<td><input class="nui-textbox" name="code" width="300px" /></td>
			<td><a class="nui-button" plain="true" onclick="onSearch(0)">解析</a>
			</td>
		</tr>
		<tr>
			<td width="70px"><span style="margin-left: 10px;">车型信息：</span></td>
			<td><input class="nui-textArea" name="code" width="350px" /></td>
		</tr>
		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span style="margin-left: 10px;">车型：</span></td>
			<td><input class="nui-bottonedit" name="code" width="350px" /></td>
		</tr>
		<tr>
			<td width="70px"><span style="margin-left: 10px;">保险公司：</span></td>
			<td><input class="nui-textbox" name="code" width="350px" /></td>
		</tr>

		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span style="margin-left: 10px;">交强险到期：</span>
			</td>
			<td><input id="date1" class="nui-datepicker" value="2010-01-01"
				width="150px" /></td>
			<td width="70px"><span style="margin-left: 10px;">商业险到期：</span>
			</td>
			<td><input id="date1" class="nui-datepicker" value="2010-01-01"
				width="150px" /></td>
		</tr>

		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span style="margin-left: 10px;">发动机号：</span></td>
			<td><input id="date1" class="nui-textbox" value="2010-01-01"
				width="150px" /></td>
			<td width="70px"><span style="margin-left: 10px;">保养到期：</span></td>
			<td><input id="date1" class="nui-datepicker" value="2010-01-01"
				width="150px" /></td>
		</tr>

		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span style="margin-left: 10px;">发动机号：</span></td>
			<td><input id="date1" class="nui-combobox" width="150px" /></td>
			<td width="70px"><span style="margin-left: 10px;">保养到期：</span></td>
			<td><input id="date1" class="nui-combobox" width="150px" /></td>
		</tr>

		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span style="margin-left: 10px;">生产日期：</span></td>
			<td><input id="date1" class="nui-datepicker" value="2010-01-01"
				width="150px" /></td>
			<td width="70px"><span style="margin-left: 10px;">上牌日期：</span></td>
			<td><input id="date1" class="nui-datepicker" value="2010-01-01"
				width="150px" /></td>
		</tr>

		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span style="margin-left: 10px;">年审到期：</span></td>
			<td><input id="date1" class="nui-datepicker" value="2010-01-01"
				width="150px" /></td>
			<td width="70px"><span style="margin-left: 10px;">驾审到期：</span></td>
			<td><input id="date1" class="nui-datepicker" value="2010-01-01"
				width="150px" /></td>
		</tr>

		<tr style="display: block; margin: 2px 0">
			<td width="70px"><span style="margin-left: 10px;">公司内部车：</span>
			</td>
			<td><input id="date1" class="nui-combobox" value="2010-01-01"
				width="150px" /></td>
			<td width="70px"><span style="margin-left: 10px;">本公司销售：</span>
			</td>
			<td><input id="date1" class="nui-combobox" value="2010-01-01"
				width="150px" /></td>
		</tr>
	</table>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>