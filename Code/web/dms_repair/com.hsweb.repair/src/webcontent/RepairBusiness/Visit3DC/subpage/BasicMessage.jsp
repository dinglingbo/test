<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 14:51:11
  - Description:
-->
<head>
<title>基本信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-panel" title="基本信息" id="div_1"
		style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
		<table style="width: 100%; margin: 0">
			<tr>
				<td width="60px">
					<div style="margin: 10px 0 0 0">客户名称：</div>
					<div style="margin: 10px 0 0 0">联系人：</div>
					<div style="margin: 10px 0 0 0">车牌号：</div>
					<div style="margin: 10px 0 0 0">发动机号：</div>
				</td>
				<td>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
				</td>
				<td width="60px">
					<div style="margin: 10px 0 0 0">客户电话：</div>
					<div style="margin: 10px 0 0 0">联系电话：</div>
					<div style="margin: 10px 0 0 0">品牌：</div>
					<div style="margin: 10px 0 0 0">底盘号：</div>
				</td>
				<td>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-combobox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
				</td>
				<td width="60px">
					<div style="margin: 10px 0 0 0">来厂次数：</div>
					<div style="margin: 10px 0 0 0">身份：</div>
					<div style="margin: 10px 0 0 0">车型：</div>
					<div style="margin: 10px 0 0 0">是否出单：</div>
				</td>
				<td>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-combobox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-combobox"
							style="width: 150px; margin: 10px 10px 0 0" allowInput="true" />
					</div>
				</td>
			</tr>
		</table>


		<div
			style="height: 0; width: 100%; border: 0.6px solid #AAAAAA; margin: 7px 0 -5px 0;"></div>



		<!-- 2 -->
		<table style="width: 100%">
			<tr>
				<td width="60px">
					<div style="margin: 10px 0 0 0">业务类型：</div>
					<div style="margin: 10px 0 0 0">里程数：</div>
				</td>
				<td>
					<div>
						<input class="nui-combobox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input class="nui-textbox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
				</td>
				<td width="60px">
					<div style="margin: 10px 0 0 0">维修类型：</div>
					<div style="margin: 10px 0 0 0">进厂日期：</div>
				</td>
				<td>
					<div>
						<input class="nui-combobox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input id="data" class="nui-datepicker" value="" nullValue="null"
							format="yyyy-MM-dd " timeFormat="HH:mm:ss" showTime="true"
							showOkButton="true" showClearButton="false"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
				</td>
				<td width="60px">
					<div style="margin: 10px 0 0 0">维修顾问：</div>
					<div style="margin: 10px 0 0 0">离厂日期：</div>
				</td>
				<td>
					<div>
						<input class="nui-combobox"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
					<div>
						<input id="data" class="nui-datepicker" value="" nullValue="null"
							format="yyyy-MM-dd " timeFormat="HH:mm:ss" showTime="true"
							showOkButton="true" showClearButton="false"
							style="width: 150px; margin: 10px 10px 0 0" />
					</div>
				</td>
			</tr>
		</table>





		<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>