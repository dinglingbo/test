<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 17:40:32
  - Description:
-->
<head>
<title>联系人信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
	<style type="text/css">
		#date1{
			width:142px
		}
	</style>

</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<div >
		<table class="nui-form-table" style="margin:0;height:100%;width:100%;">
			<tr style="display: block; margin: 5px 0 0 0">
				<td width="105px">
					<span style="color: #FF0000; margin-left: 10px;">姓名：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" width="100px" />
				</td>
				<td width="50px">
					<span style="margin-left: 10px;">性别：</span>
				</td>
				<td>
					<input class="nui-combobox" name="code" id="date1" />
				</td>
			</tr>
	
			<tr style="display: block; margin: 2px 0">
				<td width="105px">
					<span style="color: #FF0000; margin-left: 10px;">手机：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" width="100px" />
				</td>
				<td width="50px">
					<span style="color: #FF0000; margin-left: 10px;">身份：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" id="date1" />
				</td>
			</tr>
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="color: #FF0000;margin-left: 10px;">来源：</span>
				</td>
				<td>
					<input class="nui-combobox" name="code" width="300px" />
				</td>
			</tr>
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">生日类型：</span>
				</td>
				<td>
					<input class="nui-combobox" name="code" width="100px" />
				</td>
				<td width="50px">
					<span style="margin-left: 10px;">生日：</span>
				</td>
				<td>
					<input id="date1" class="nui-datepicker" 	 />
				</td>
			</tr>
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">身份证地址：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" width="300px" />
				</td>
			</tr>
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">身份证号码：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" width="300px" />
				</td>
			</tr>
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">备注：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" width="300px" />
				</td>
			</tr>
		</table>
		<div style="text-align:right;padding:10px;margin-top:0">
			<a class="nui-button" iconCls="icon-upgrade" onclick="onGo()" style="margin-right:10px;"></a>   
			<a class="nui-button" iconCls="icon-downgrade" onclick="onAdd()" style="margin-right:10px;"></a>  
			<a class="nui-button" iconCls="icon-add" onclick="onBack()" ></a>   
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>