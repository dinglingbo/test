<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 10:02:38
  - Description:
-->
<head>
<title>基本信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
	<style type="text/css">
		#data{
			width:170px
		}
		#data1{
			width:146px
		}
		#data2{
			width:170px
		}
		#data3{
			width:170px
		}
		#td1{
			width:60px;
			padding-left: 5px;
		}
	</style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-panel" title="保险基本信息" style="border-bottom: 0; padding: 0; width: 100%; height: 38.4%;">
		<div class="nui-fit" style="margin: 0;">
			<table>
				<!-- 第一行 -->
				<tr style="margin: 5px 0 0 0;display: block;">
					<td id="td1">
						<label>保险单号：</label>
					</td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
					<td id="td1">
						<label>客户类型：</label>
					<td>
					<td>
						<input class="nui-combobox" id="data" />
					</td>
				</tr>
				<!-- 第二行 -->
				<tr style="margin: 8px 0 0 0;display: block;">
					<td id="td1">
						<label>客户名称：</label>
					</td>
					<td>
						<input class="nui-combobox" id="data" />
					</td>
					<td id="td1">
						<label>被保险人：</label>
					<td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
					<td id="td1">
						<label>联系电话：</label>
					<td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
				</tr>
				<!-- 第三行 -->
				<tr style="margin: 8px 0 0 0;display: block;">
					<td id="td1">
						<label>车牌号：</label>
					</td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
					<td id="td1">
						<label>品牌：</label>
					<td>
					<td>
						<input class="nui-combobox" id="data" />
					</td>
					<td id="td1">
						<label>车型：</label>
					<td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
				</tr>
				<!-- 第四行 -->
				<tr style="margin: 8px 0 0 0;display: block;">
					<td id="td1">
						<label>VIN：</label>
					</td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
					<td id="td1">
						<label>发动机号：</label>
					<td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
					<td id="td1">
						<label>购买日期：</label>
					<td>
					<td>
						<input id="data" class="nui-datepicker" viewDate="new Date()" nullValue="null" format="yyyy-MM-dd HH:mm:ss"
								timeFormat="HH:mm:ss" showTime="true" showOkButton="true" showClearButton="false"/>
					</td>
				</tr>
				<!-- 第五行 -->
				<tr style="margin: 8px 0 0 0;display: block;">
					<td id="td1">
						<label>车险专员：</label>
					</td>
					<td>
						<input class="nui-combobox" id="data" />
					</td>
					<td id="td1">
						<label>制单员：</label>
					<td>
					<td>
						<input class="nui-textbox" id="data" />
					</td>
					<td id="td1">
						<label>保险类型：</label>
					<td>
					<td>
						<input class="nui-combobox" id="data" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-panel" title="交强险信息" style="border-bottom: 0; padding: 0px; width: 100%; height: 30%;margin-top:5px">
		<div class="nui-fit">
			<table style="margin: 0; padding: 0;">
				<tr style="margin: 10px 0 0 0;display: block;">
					<td style="width: 90px">
						<label>交强险保单号：</label>
					</td>
					<td>
						<input class="nui-textbox" id="data1" />
					</td>
					<td style="width: 60px;padding-left:8px">
						<label>投保日期：</label>
					</td>
					<td>
						<input id="data2" class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd"
							showOkButton="true" showClearButton="false" nullValue="null" />
					</td>
					<td style="width: 60px;padding-left:8px">
						<label>到期日期：</label>
					</td>
					<td>
						<input id="data2" class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd"
							showOkButton="true" showClearButton="false" nullValue="null" />
					</td>
				</tr>
				<tr style="margin: 10px 0 0 0;display: block;">
					<td style="width: 90px;">
						<label>投保公司：</label>
					</td>
					<td>
						<input class="nui-combobox" style="width: 392px" allowInput="true" />
					</td>
				</tr>	
				<tr style="margin: 10px 0 0 0;display: block;">
					<td style="width: 90px;">
						<label>投保内容：</label>
					</td>
					<td>
						<input class="nui-textarea" style="width: 633px; height: 40px;"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
			
	<div class="nui-panel" title="商业险信息" style="border-bottom: 0; padding: 0px; width: 100%; height: 30%;margin-top:5px">
		<div class="nui-fit">
			<table style="margin: 0; padding: 0;">
				<tr style="margin: 10px 0 0 0;display: block;">
					<td style="width: 90px">
						<label>商业险保单号：</label>
					</td>
					<td>
						<input class="nui-textbox" id="data1" />
					</td>
					<td style="width: 60px;padding-left:5px">
						<label>投保日期：</label>
					</td>
					<td>
						<input id="data3" class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd"
							showOkButton="true" showClearButton="false" nullValue="null" />
					</td>
					<td style="width: 60px;padding-left:5px">
						<label>到期日期：</label>
					</td>
					<td>
						<input id="data3" class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd"
							showOkButton="true" showClearButton="false" nullValue="null" />
					</td>
				</tr>
				<tr style="margin: 10px 0 0 0;display: block;">
					<td style="width: 90px;">
						<label>投保公司：</label>
					</td>
					<td>
						<input class="nui-combobox" style="width: 392px" allowInput="true" />
					</td>
				</tr>	
				<tr style="margin: 10px 0 0 0;display: block;">
					<td style="width: 90px;">
						<label>投保内容：</label>
					</td>
					<td>
						<input class="nui-textarea" style="width: 633px; height: 40px;"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
				







	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>