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
<style type="text/css">
	#date1{
		width:93px
	}
</style>

</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<div >
		<table class="nui-form-table" style="margin:0;height:100%;width:100%;">
			<tr style="display: block; margin: 5px 0 0 0">
				<td width="105px">
					<span style="color: #FF0000; margin-left: 10px;">车牌号：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" width="300px	" />
				</td>
			</tr>
	
			<tr style="display: block; margin:0">
				<td width="105px">
					<span style="color: #FF0000; margin-left: 10px;">车架号（VIN）：</span>
				</td>
				<td>
					<input class="nui-textbox" name="code" width="254px" />
				</td>
				<td>
					<a class="nui-button"  onclick="onSearch(0)">解析</a>
				</td>
			</tr>
			<tr style="display: block; margin:0">
				<td width="105px">
					<span style="margin-left: 10px;">车型信息：</span>
				</td>
				<td>
					<input class="nui-textArea" name="code" width="300px" />
				</td>
			</tr>
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">车型：</span>
				</td>
				<td>
					<input class="nui-buttonedit" name="code" width="300px" />
				</td>
			</tr>
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">保险公司：</span>
				</td>
				<td>
					<input class="nui-combobox" name="code" width="300px" />
				</td>
			</tr>
	
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">交强险到期：</span>
				</td>
				<td>
					<input id="date1" class="nui-datepicker" 	 />
				</td>
				<td width="105px">
					<span style="margin-left: 10px;">商业险到期：</span>
				</td>
				<td>
					<input id="date1" class="nui-datepicker" 	 />
				</td>
			</tr>
	
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">发动机号：</span>
				</td>
				<td>
					<input id="date1" class="nui-textbox"   />
				</td>
				<td width="105px">
					<span style="margin-left: 10px;">保养到期：</span>
				</td>
				<td>
					<input id="date1" class="nui-datepicker" 	 />
				</td>
			</tr>
	
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">里程类型：</span>
				</td>
				<td>
					<input id="date1" class="nui-combobox"  />
				</td>
				<td width="105px">
					<span style="margin-left: 10px;">车型规格：</span>
				</td>
				<td>
					<input id="date1" class="nui-combobox"  />
				</td>
			</tr>
	
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">生产日期：</span>
				</td>
				<td>
				 	<input id="date1" class="nui-datepicker" />
				</td>
				<td width="105px">
				 	<span style="margin-left: 10px;">上牌日期：</span>
				</td>
				<td>
				 	<input id="date1" class="nui-datepicker"  />
				</td>
			</tr>
	
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">年审到期：</span>
				</td>
				<td>
					<input id="date1" class="nui-datepicker" 	 />
				</td>
				<td width="105px">
					<span style="margin-left: 10px;">驾审到期：</span>
				</td>
				<td>
					<input id="date1" class="nui-datepicker" 	 />
				</td>
			</tr>
	
			<tr style="display: block; margin: 0">
				<td width="105px">
					<span style="margin-left: 10px;">公司内部车：</span>
				</td>
				<td>
					<input id="date1" class="nui-combobox"  />
				</td>
				<td width="105px">
					<span style="margin-left: 10px;">本公司销售：</span>
				</td>
				<td>
					<input id="date1" class="nui-combobox"  />
				</td>
			</tr>
		</table>
	</div>
	
	

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>